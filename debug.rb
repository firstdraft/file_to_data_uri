require_relative "lib/file_to_data_uri"
require "base64"
require "tempfile"

Tempfile.create(["test", ".txt"]) do |file|
  file.write("Hello, world!")
  file.flush

  data_uri = DataURI.new(file.path)
  encoded = "data:text/plain;base64,#{Base64.strict_encode64('Hello, world\!')}"

  puts "Actual:   #{data_uri}"
  puts "Expected: #{encoded}"
end
