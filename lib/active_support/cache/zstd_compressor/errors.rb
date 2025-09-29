# frozen_string_literal: true

module ActiveSupport
  module Cache
    class ZstdCompressor
      class Error < StandardError; end
      class NotZstdError < Error; end
    end
  end
end
