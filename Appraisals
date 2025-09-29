# frozen_string_literal: true

active_support_versions = %w[7.2 8.0]
zstd_versions           = %w[1.5 2.0]

active_support_versions.each do |active_support_version|
  zstd_versions.each do |zstd_version|
    appraise "activesupport-#{active_support_version}.x zstd-ruby-#{zstd_version}" do
      gem "activesupport", "~> #{active_support_version}.0"
      gem "zstd-ruby",     "~> #{zstd_version}"
    end
  end
end
