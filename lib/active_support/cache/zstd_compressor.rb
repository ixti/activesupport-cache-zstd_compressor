# frozen_string_literal: true

require "active_support/cache"
require "zstd-ruby"

require_relative "./zstd_compressor/errors"
require_relative "./zstd_compressor/with_zlib_fallback"
require_relative "./zstd_compressor/version"

module ActiveSupport
  module Cache
    class ZstdCompressor
      # @return [Integer] Compression level
      attr_reader :level

      # @param level [Integer] Compression level
      def initialize(level: 3)
        raise ArgumentError, "Compression level must be an Integer" unless level.is_a?(Integer)

        @level = level
      end

      def deflate(inflated)
        Zstd.compress(inflated, level:)
      end

      def inflate(deflated)
        Zstd.decompress(deflated)
      rescue StandardError => e
        # v1.5
        raise NotZstdError, e.message if e.message.include?("not compressed by zstd")

        # v2.0
        raise NotZstdError, e.message if e.message.include?("zstd") && e.message.include?("magic not found")

        raise
      end
    end
  end
end
