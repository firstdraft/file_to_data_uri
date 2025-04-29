# frozen_string_literal: true

require_relative "lib/file_to_data_uri/version"

Gem::Specification.new do |spec|
  spec.name = "file_to_data_uri"
  spec.version = DataURI::VERSION
  spec.authors = ["Raghu Betina"]
  spec.email = ["raghu@firstdraft.com"]
  spec.homepage = "https://github.com/firstdraft/file_to_data_uri"
  spec.summary = "Convert files to data URI strings for use in HTML elements"
  spec.description = "A Ruby gem that converts files or file-like objects to data URI strings suitable for use in HTML elements like img tags."
  spec.license = "MIT"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/firstdraft/file_to_data_uri/issues",
    "changelog_uri" => "https://github.com/firstdraft/file_to_data_uri/blob/main/CHANGELOG.md",
    "homepage_uri" => "https://github.com/firstdraft/file_to_data_uri",
    "funding_uri" => "https://github.com/sponsors/firstdraft",
    "label" => "DataURI",
    "rubygems_mfa_required" => "true",
    "source_code_uri" => "https://github.com/firstdraft/file_to_data_uri"
  }

  spec.required_ruby_version = ">= 2.0.0"
  spec.add_runtime_dependency "mime-types", "~> 3.0"
  spec.add_runtime_dependency "base64", "~> 0.1", ">= 0.1.0"

  # All development dependencies are specified in the Gemfile

  spec.extra_rdoc_files = Dir["README*", "LICENSE*", "CHANGELOG*"]
  spec.files = Dir["*.gemspec", "lib/**/*"]
end