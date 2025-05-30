# frozen_string_literal: true

require "zlib"

module ActiveSupport
  module Cache
    class ZstdCompressor
      class WithZlibFallback < self
        # ZStandard Magic Number (0xFD2FB528) in little-endian format.
        # See: https://datatracker.ietf.org/doc/html/rfc8878#name-zstandard-frames
        ZSTD_MAGIC_NUMBER = [0xFD2FB528].pack("L<")

        def inflate(deflated)
          return super if deflated.b.start_with?(ZSTD_MAGIC_NUMBER)

          Zlib.inflate(deflated)
        end
      end
    end
  end
end
