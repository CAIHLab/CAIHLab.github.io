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
end_date = Time.now.utc.to_date - 1
daily = data["daily"].is_a?(Hash) ? data["daily"] : {}
added_dates = []

if tracking_start <= end_date
  (tracking_start..end_date).each do |date|
    date_key = date.iso8601
    next if daily.key?(date_key)

    account = cloudflare_query(token, account_id, date, date)
    totals = account["totals"] || []
    day_page_views = totals.empty? ? 0 : totals.first["count"].to_i
    day_visits = totals.empty? ? 0 : totals.first.dig("sum", "visits").to_i
    day_countries = {}

    (account["countries"] || []).each do |row|
      name = row.dig("dimensions", "countryName").to_s.strip
      name = "Unknown" if name.empty?
      visits = row.dig("sum", "visits").to_i
      day_countries[name] = day_countries.fetch(name, 0) + visits if visits.positive?
    end

    daily[date_key] = {
      "visits" => day_visits,
      "page_views" => day_page_views,
      "countries" => day_countries.sort.to_h
    }
    added_dates << date_key
  end
end

daily = daily.sort.to_h
total_visits = daily.values.sum { |day| day["visits"].to_i }
total_page_views = daily.values.sum { |day| day["page_views"].to_i }
country_totals = Hash.new(0)
daily.each_value do |day|
  (day["countries"] || {}).each do |name, visits|
    country_totals[name] += visits.to_i
  end
end
country_totals = country_totals.sort.to_h

data["daily"] = daily
data["visits"] = total_visits
data["page_views"] = total_page_views
data["visits_display"] = compact_number(total_visits)
data["page_views_display"] = compact_number(total_page_views)
data["country_totals"] = country_totals
data["countries_reached"] = country_totals.count { |name, visits| name != "Unknown" && visits.positive? }
data["countries"] = public_country_rows(country_totals)
data["period_end"] = daily.keys.max
data["updated"] = Time.now.utc.strftime("%-d %B %Y")

File.write(DATA_PATH, JSON.pretty_generate(data) + "\n")
if added_dates.empty?
  puts "No completed analytics days were missing."
else
  puts "Stored completed analytics days: #{added_dates.join(', ')}."
end
