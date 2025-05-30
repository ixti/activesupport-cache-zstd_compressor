# frozen_string_literal: true

require_relative "./lib/active_support/cache/zstd_compressor/version"

Gem::Specification.new do |spec|
  spec.name    = "activesupport-cache-zstd_compressor"
  spec.version = ActiveSupport::Cache::ZstdCompressor::VERSION
  spec.authors = ["Alexey Zapparov"]
  spec.email   = ["alexey@zapparov.com"]

  spec.summary     = "ZStandard compressor for ActiveSupport::Cache"
  spec.description = "Drop-in Zlib compressor replacement for ActiveSupport::Cache"
  spec.homepage    = "https://github.com/ixti/activesupport-cache-zstd_compressor"
  spec.license     = "MIT"

  spec.metadata["homepage_uri"]          = spec.homepage
  spec.metadata["source_code_uri"]       = "#{spec.homepage}/tree/v#{spec.version}"
  spec.metadata["bug_tracker_uri"]       = "#{spec.homepage}/issues"
  spec.metadata["changelog_uri"]         = "#{spec.homepage}/blob/v#{spec.version}/CHANGES.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    extras = %w[CHANGES.md LICENSE.txt README.adoc] << File.basename(__FILE__)

    ls.readlines("\x0", chomp: true).reject do |f|
      f.start_with?("lib/") || extras.include?(f)
    end
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 3.2"

  spec.add_dependency "activesupport", ">= 7.1"
  spec.add_dependency "zeitwerk",      "~> 2.6"
  spec.add_dependency "zstd-ruby",     "~> 1.5", ">= 1.5.6.6"
end
