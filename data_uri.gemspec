# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "data_uri"
  spec.version = "0.0.0"
  spec.authors = ["Raghu Betina"]
  spec.email = ["raghu@firstdraft.com"]
  spec.homepage = "https://undefined.io/projects/data_uri"
  spec.summary = ""
  spec.license = "Hippocratic-2.1"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/undefined/data_uri/issues",
    "changelog_uri" => "https://undefined.io/projects/data_uri/versions",
    "homepage_uri" => "https://undefined.io/projects/data_uri",
    "funding_uri" => "https://github.com/sponsors/undefined",
    "label" => "Data Uri",
    "rubygems_mfa_required" => "true",
    "source_code_uri" => "https://github.com/undefined/data_uri"
  }

  spec.signing_key = Gem.default_key_path
  spec.cert_chain = [Gem.default_cert_path]

  spec.required_ruby_version = "~> 3.4"
  spec.add_dependency "refinements", "~> 13.0"
  spec.add_dependency "zeitwerk", "~> 2.7"

  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.files = Dir["*.gemspec", "lib/**/*"]
end
