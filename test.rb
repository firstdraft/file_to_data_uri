require_relative "lib/data_uri"

# Test with the test1.jpg file
jpg_path = File.join(__dir__, "spec/fixtures/images/test1.jpg")
data_uri = DataURI.new(jpg_path)
expected = File.read(File.join(__dir__, "spec/fixtures/images/test1.txt")).strip
puts "JPG test: #{(data_uri.to_s == expected) ? "PASS" : "FAIL"}"

# Create and test with a text file
require "tempfile"
Tempfile.create(["test", ".txt"]) do |file|
  file.write("Hello, world!")
  file.flush

  data_uri = DataURI.new(file.path)
  encoded = "data:text/plain;base64,#{Base64.strict_encode64('Hello, world\!')}"
  puts "TXT test: #{(data_uri.to_s == encoded) ? "PASS" : "FAIL"}"
end

# Test with a file-like object with content_type
require "ostruct"
file_like = OpenStruct.new(
  read: "Custom content",
  content_type: "application/custom"
)
data_uri = DataURI.new(file_like)
encoded = "data:application/custom;base64,#{Base64.strict_encode64("Custom content")}"
puts "Custom content_type test: #{(data_uri.to_s == encoded) ? "PASS" : "FAIL"}"

# Test with unknown file type
Tempfile.create(["test", ".unknown"]) do |file|
  file.write("Unknown content")
  file.flush

  data_uri = DataURI.new(file.path)
  encoded = "data:application/octet-stream;base64,#{Base64.strict_encode64("Unknown content")}"
  puts "Unknown type test: #{(data_uri.to_s == encoded) ? "PASS" : "FAIL"}"
end
