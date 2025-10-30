# frozen_string_literal: true

require_relative "lib/csv_encoding_helper/version"

Gem::Specification.new do |spec|
  spec.name = "csv_encoding_helper"
  spec.version = CsvEncodingHelper::VERSION
  spec.authors = ["Aadesh Shrestha"]
  spec.email = ["aadeshere1@gmail.com"]

  spec.summary = "Smart CSV encoding normalizer for UTF-16, Shift_JIS, EUC-JP, and UTF-8"
  spec.description = "Automatically detects and converts various Japanese CSV encodings to UTF-8 safely."
  spec.homepage = "https://github.com/aadeshere1/csv_encoding_helper"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"
  spec.files = Dir["lib/**/*", "README.md", "LICENSE.txt"]
  spec.require_paths = ["lib"]

  spec.add_dependency "nkf", "~> 0.2.0"
end
