# frozen_string_literal: true

require "spec_helper"
require "tempfile"
require "base64"

RSpec.describe DataURI do
  let(:test_image_path) { SPEC_ROOT.join("fixtures/images/test1.jpg") }
  let(:expected_data_uri) { File.read(SPEC_ROOT.join("fixtures/images/test1.txt")).strip }

  describe "#initialize" do
    it "accepts a file path as a string" do
      expect { DataURI.new(test_image_path.to_s) }.not_to raise_error
    end

    it "accepts a file path as a Pathname" do
      expect { DataURI.new(test_image_path) }.not_to raise_error
    end

    it "accepts a File object" do
      File.open(test_image_path, "rb") do |file|
        expect { DataURI.new(file) }.not_to raise_error
      end
    end

    it "accepts any object that responds to #read" do
      file_like_object = double("file-like")
      allow(file_like_object).to receive(:read).and_return("test content")
      expect { DataURI.new(file_like_object) }.not_to raise_error
    end
  end

  describe "#to_s" do
    context "with an image file path" do
      it "generates a correct data URI" do
        data_uri = DataURI.new(test_image_path.to_s)
        expect(data_uri.to_s).to eq(expected_data_uri)
      end
    end

    context "with a text file" do
      it "generates a correct data URI with text/plain MIME type" do
        Tempfile.create(["test", ".txt"]) do |file|
          content = "Hello, world!"
          file.write(content)
          file.flush

          data_uri = DataURI.new(file.path)
          # Let's compare just the MIME type part to avoid encoding issues with file reading
          expect(data_uri.to_s).to start_with("data:text/plain;base64,")

          # Manually read the file to ensure we're encoding the same content
          file.rewind
          actual_content = file.read
          encoded_content = Base64.strict_encode64(actual_content)
          expect(data_uri.to_s).to eq("data:text/plain;base64,#{encoded_content}")
        end
      end
    end

    context "with a File object" do
      it "generates a correct data URI" do
        File.open(test_image_path, "rb") do |file|
          data_uri = DataURI.new(file)
          expect(data_uri.to_s).to eq(expected_data_uri)
        end
      end
    end

    context "with a file-like object that has content_type" do
      it "uses the provided content_type" do
        content = "test content"
        file_like_object = double("file-like")
        allow(file_like_object).to receive(:read).and_return(content)
        allow(file_like_object).to receive(:rewind)
        allow(file_like_object).to receive(:content_type).and_return("application/custom")

        data_uri = DataURI.new(file_like_object)
        encoded_content = Base64.strict_encode64(content)
        expect(data_uri.to_s).to eq("data:application/custom;base64,#{encoded_content}")
      end
    end

    context "with a file-like object that has path" do
      it "determines MIME type from path" do
        content = "test content"
        file_like_object = double("file-like")
        allow(file_like_object).to receive(:read).and_return(content)
        allow(file_like_object).to receive(:rewind)
        allow(file_like_object).to receive(:path).and_return("test.html")

        data_uri = DataURI.new(file_like_object)
        encoded_content = Base64.strict_encode64(content)
        expect(data_uri.to_s).to eq("data:text/html;base64,#{encoded_content}")
      end
    end

    context "with a file without extension" do
      it "defaults to application/octet-stream when MIME type can't be determined" do
        content = "test content"
        file_like_object = double("file-like")
        allow(file_like_object).to receive(:read).and_return(content)

        data_uri = DataURI.new(file_like_object)
        encoded_content = Base64.strict_encode64(content)
        expect(data_uri.to_s).to eq("data:application/octet-stream;base64,#{encoded_content}")
      end
    end

    context "with a file with unknown extension" do
      it "defaults to application/octet-stream for unrecognized extensions" do
        Tempfile.create(["test", ".unknown_ext"]) do |file|
          content = "Test content"
          file.write(content)
          file.flush

          data_uri = DataURI.new(file.path)
          expect(data_uri.to_s).to start_with("data:application/octet-stream;base64,")

          file.rewind
          actual_content = file.read
          encoded_content = Base64.strict_encode64(actual_content)
          expect(data_uri.to_s).to eq("data:application/octet-stream;base64,#{encoded_content}")
        end
      end
    end
  end
end
