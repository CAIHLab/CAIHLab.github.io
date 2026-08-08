#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"
require "date"
require "net/http"
require "optparse"
require "time"
require "uri"
require "yaml"

options = { dry_run: false, output: "_data/publication_metrics.json" }
OptionParser.new do |parser|
  parser.on("--dry-run") { options[:dry_run] = true }
  parser.on("--output PATH") { |path| options[:output] = path }
end.parse!

def normalise_title(title)
  title.to_s.downcase.gsub(/[^a-z0-9\s]/, " ").split.uniq
end

def plausible_title?(expected, returned)
  expected_words = normalise_title(expected)
  returned_words = normalise_title(returned)
  return false if expected_words.empty? || returned_words.empty?

  overlap = (expected_words & returned_words).length.to_f
  overlap / [expected_words.length, returned_words.length].min >= 0.65
end

def fetch_json(uri, headers = {})
  3.times do |attempt|
    request = Net::HTTP::Get.new(uri, headers)
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true, open_timeout: 10, read_timeout: 20) do |http|
      http.request(request)
    end
    return JSON.parse(response.body) if response.is_a?(Net::HTTPSuccess)

    warn "HTTP #{response.code} for #{uri}"
    sleep(2**attempt) if attempt < 2
  rescue JSON::ParserError, Net::OpenTimeout, Net::ReadTimeout, SocketError, SystemCallError => e
    warn "#{e.class}: #{e.message} for #{uri}"
    sleep(2**attempt) if attempt < 2
  end
  nil
end

def provider_record(provider, id, count, url, previous)
  unchanged = previous && previous["id"] == id && previous["count"] == count && previous["url"] == url && previous["status"] == "ok"
  return previous if unchanged

  { "provider" => provider, "id" => id, "count" => count, "url" => url, "fetched_at" => Time.now.utc.iso8601, "status" => "ok" }
end

publications = YAML.safe_load(File.read("_data/publications.yml"), permitted_classes: [Date], aliases: true)
previous = File.exist?(options[:output]) ? JSON.parse(File.read(options[:output])) : { "refreshed_at" => nil, "publications" => {} }
updated = Marshal.load(Marshal.dump(previous))
updated["publications"] ||= {}
polite_email = ENV.fetch("OPENALEX_MAILTO", "vinod.chauhan@strath.ac.uk")
s2_key = ENV["SEMANTIC_SCHOLAR_API_KEY"]

publications.each do |publication|
  id = publication.fetch("id")
  old_record = previous.fetch("publications", {}).fetch(id, {})
  record = Marshal.load(Marshal.dump(old_record))
  doi = publication["doi"]

  openalex_lookup = doi ? "https://doi.org/#{doi}" : publication["openalex_id"]
  if openalex_lookup
    uri = URI("https://api.openalex.org/works/#{URI.encode_www_form_component(openalex_lookup)}?mailto=#{URI.encode_www_form_component(polite_email)}")
    data = fetch_json(uri)
    expected_title = publication["metrics_title"] || publication["title"]
    if data && plausible_title?(expected_title, data["title"])
      record["openalex"] = provider_record("OpenAlex", data["id"].to_s.split("/").last, data["cited_by_count"].to_i, data["id"], old_record["openalex"])
    else
      warn "OpenAlex title mismatch or lookup failure for #{id}; retaining cached value"
    end
  end

  semantic_lookup = doi ? "DOI:#{doi}" : publication["semantic_scholar_paper_id"]
  if semantic_lookup
    uri = URI("https://api.semanticscholar.org/graph/v1/paper/#{URI.encode_www_form_component(semantic_lookup)}?fields=title,citationCount,externalIds,url")
    headers = s2_key.to_s.empty? ? {} : { "x-api-key" => s2_key }
    data = fetch_json(uri, headers)
    expected_title = publication["metrics_title"] || publication["title"]
    if data && plausible_title?(expected_title, data["title"])
      record["semantic_scholar"] = provider_record("Semantic Scholar", data["paperId"], data["citationCount"].to_i, data["url"], old_record["semantic_scholar"])
    else
      warn "Semantic Scholar title mismatch or lookup failure for #{id}; retaining cached value"
    end
  end

  updated["publications"][id] = record unless record.empty?
  sleep 0.15
end

if updated["publications"] != previous.fetch("publications", {})
  updated["refreshed_at"] = Time.now.utc.strftime("%Y-%m-%d")
end

if options[:dry_run]
  puts JSON.pretty_generate(updated)
else
  File.write(options[:output], JSON.pretty_generate(updated) + "\n")
end
