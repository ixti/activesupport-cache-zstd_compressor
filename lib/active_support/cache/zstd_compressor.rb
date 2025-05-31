# frozen_string_literal: true

require "active_support/cache"
require "zstd-ruby"

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
      end
    end
  end
end
