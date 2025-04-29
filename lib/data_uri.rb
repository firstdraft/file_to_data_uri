# frozen_string_literal: true

require "base64"
require "mime/types"

# DataURI class for generating data URIs from files or file-like objects
class DataURI
  # Initialize with a file path or file-like object
  #
  # @param source [String, #read] File path or file-like object
  def initialize(source)
    @source = source
  end

  # Convert to data URI string
  #
  # @return [String] A data URI representation of the file
  def to_s
    content = read_content
    mime_type = determine_mime_type
    encoded_content = Base64.strict_encode64(content)

    "data:#{mime_type};base64,#{encoded_content}"
  end

  private

  # Read content from file path or file-like object
  #
  # @return [String] Binary content of the file
  def read_content
    if @source.respond_to?(:read)
      # File-like object
      @source.rewind if @source.respond_to?(:rewind)
      content = @source.read
      @source.rewind if @source.respond_to?(:rewind)
      content
    else
      # File path
      File.binread(@source.to_s)
    end
  end

  # Determine the MIME type of the file
  #
  # @return [String] MIME type
  def determine_mime_type
    if @source.respond_to?(:content_type) && @source.content_type
      # For Rails uploaded files or similar objects that expose content_type
      @source.content_type
    elsif @source.respond_to?(:path) && @source.path
      # If it's a file object with a path
      mime_from_path(@source.path)
    elsif @source.is_a?(String)
      # If it's a file path as string
      mime_from_path(@source)
    else
      # Default to octet-stream if we can't determine
      "application/octet-stream"
    end
  end

  # Get MIME type from file path
  #
  # @param path [String] Path to file
  # @return [String] MIME type
  def mime_from_path(path)
    mime = MIME::Types.type_for(path.to_s).first
    mime ? mime.to_s : "application/octet-stream"
  end
end
