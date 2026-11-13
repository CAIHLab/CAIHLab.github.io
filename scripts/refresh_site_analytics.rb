#!/usr/bin/env ruby
# frozen_string_literal: true

require "date"
require "json"
require "net/http"
require "uri"

API_URL = URI("https://api.cloudflare.com/client/v4/graphql")
DATA_PATH = "_data/site_analytics.json"
HOSTNAME = "caihlab.github.io"
MIN_PUBLIC_COUNTRY_VISITS = 5
MAX_PUBLIC_COUNTRIES = 10

QUERY = <<~GRAPHQL
  query SiteAnalytics($accountTag: string!, $start: Date!, $end: Date!, $host: string!) {
    viewer {
      accounts(filter: {accountTag: $accountTag}) {
        totals: rumPageloadEventsAdaptiveGroups(
          limit: 1
          filter: {date_geq: $start, date_leq: $end, requestHost: $host}
        ) {
          count
          sum { visits }
        }
        countries: rumPageloadEventsAdaptiveGroups(
          limit: 250
          filter: {date_geq: $start, date_leq: $end, requestHost: $host}
        ) {
          sum { visits }
          dimensions { countryName }
        }
      }
    }
  }
GRAPHQL

def cloudflare_query(token, account_id, start_date, end_date)
  request = Net::HTTP::Post.new(API_URL)
  request["Authorization"] = "Bearer #{token}"
  request["Content-Type"] = "application/json"
  request["User-Agent"] = "CAIHLab-site-analytics/1.0"
  request.body = JSON.generate(
    query: QUERY,
    variables: {
      accountTag: account_id,
      start: start_date.iso8601,
      end: end_date.iso8601,
      host: HOSTNAME
    }
  )

  response = Net::HTTP.start(API_URL.host, API_URL.port, use_ssl: true, read_timeout: 60) do |http|
    http.request(request)
  end
  raise "Cloudflare returned HTTP #{response.code}: #{response.body}" unless response.is_a?(Net::HTTPSuccess)

  result = JSON.parse(response.body)
  if result["errors"]
    messages = result["errors"].map { |error| error["message"] || "Unknown GraphQL error" }.join("; ")
    raise "Cloudflare GraphQL error: #{messages}"
  end

  accounts = result.dig("data", "viewer", "accounts") || []
  raise "Cloudflare returned no analytics account. Check the Account ID and token scope." if accounts.empty?

  accounts.first
end

def public_country_rows(country_totals)
  ranked = country_totals.sort_by { |name, visits| [-visits, name] }
  shown = ranked.select { |_name, visits| visits >= MIN_PUBLIC_COUNTRY_VISITS }.first(MAX_PUBLIC_COUNTRIES)
  shown_names = shown.map(&:first)
  other_visits = ranked.reject { |name, _visits| shown_names.include?(name) }.sum(&:last)
  shown << ["Other countries", other_visits] if other_visits.positive?

  largest = shown.map(&:last).max.to_i
  shown.map do |name, visits|
    {
      "name" => name,
      "visits" => visits,
      "percentage" => largest.positive? ? ((visits.to_f / largest) * 100).round(1) : 0
    }
  end
end

def compact_number(value)
  number = value.to_i
  return number.to_s if number < 1_000

  units = [[1_000_000_000, "B"], [1_000_000, "M"], [1_000, "K"]]
  divisor, suffix = units.find { |threshold, _unit| number >= threshold }
  scaled = number.to_f / divisor
  precision = scaled < 10 ? 2 : (scaled < 100 ? 1 : 0)
  formatted = format("%.#{precision}f", scaled).sub(/\.0+\z/, "").sub(/(\.\d*[1-9])0+\z/, '\\1')
  "#{formatted}#{suffix}"
end

token = ENV.fetch("CLOUDFLARE_API_TOKEN", "").strip
account_id = ENV.fetch("CLOUDFLARE_ACCOUNT_ID", "").strip
if token.empty? || account_id.empty?
  warn "Cloudflare credentials are unavailable; no analytics data was changed."
  exit 0
end

data = JSON.parse(File.read(DATA_PATH))
tracking_start = Date.iso8601(data.fetch("tracking_start"))
start_date = tracking_start
end_date = Time.now.utc.to_date

account = cloudflare_query(token, account_id, start_date, end_date)
totals = account["totals"] || []
period_page_views = totals.empty? ? 0 : totals.first["count"].to_i
period_visits = totals.empty? ? 0 : totals.first.dig("sum", "visits").to_i

country_totals = {}
(account["countries"] || []).each do |row|
  name = row.dig("dimensions", "countryName").to_s.strip
  name = "Unknown" if name.empty?
  visits = row.dig("sum", "visits").to_i
  country_totals[name] = country_totals.fetch(name, 0) + visits if visits.positive?
end

data["visits"] = period_visits
data["page_views"] = period_page_views
data["visits_display"] = compact_number(period_visits)
data["page_views_display"] = compact_number(period_page_views)
data["country_totals"] = country_totals.sort.to_h
data["countries_reached"] = country_totals.count { |name, visits| name != "Unknown" && visits.positive? }
data["countries"] = public_country_rows(country_totals)
data["period_end"] = end_date.iso8601
data["updated"] = Time.now.utc.strftime("%-d %B %Y")

File.write(DATA_PATH, JSON.pretty_generate(data) + "\n")
puts "Refreshed Cloudflare analytics for #{start_date.iso8601} through #{end_date.iso8601}."
