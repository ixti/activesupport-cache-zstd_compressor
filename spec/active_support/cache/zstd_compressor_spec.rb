# frozen_string_literal: true

require "support/compressor_behaviour"

RSpec.describe ActiveSupport::Cache::ZstdCompressor do
  it_behaves_like "a compressor" do
    describe "#inflate" do
      it "is uncapable of inflating data compressed with Zlib" do
        expect { compressor.inflate(Zlib.deflate(FOOD_FOR_THOUGHT)) }
          .to raise_error(%r{not compressed by zstd})
      end
    end
  end

  it "itegrates perfectly" do
    compressor = described_class.new
    serializer = Marshal
    cache      = ActiveSupport::Cache.lookup_store(:memory_store, serializer:, compressor:, compress: true)

    cache.write("example", { food_for_thought: FOOD_FOR_THOUGHT })

    expect(cache.read("example")).to eq({ food_for_thought: FOOD_FOR_THOUGHT })
  end
end
