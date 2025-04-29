require_relative "lib/file_to_data_uri"
require "base64"
require "tempfile"

Tempfile.create(["test", ".txt"]) do |file|
  file.write("Hello, world!")
  file.flush

  result = DataURI.convert(file.path)
  encoded = "data:text/plain;base64,#{Base64.strict_encode64("Hello, world!")}"

  puts "Actual:   #{result}"
  puts "Expected: #{encoded}"

  # Also verify legacy API
  legacy_result = DataURI.new(file.path).to_s
  puts "\nLegacy API:"
  puts "Actual:   #{legacy_result}"
  puts "Expected: #{encoded}"
end
