# frozen_string_literal: true

require "support/compressor_behaviour"

RSpec.describe ActiveSupport::Cache::ZstdCompressor::WithZlibFallback do
  it_behaves_like "a compressor" do
    describe "#inflate" do
      it "is capable of inflating data compressed with Zlib" do
        uncompressed = compressor.inflate(Zlib.deflate(FOOD_FOR_THOUGHT))

        expect(uncompressed).to eq(FOOD_FOR_THOUGHT)
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

  it "works with with Zlib legacy compressor nicely" do
    compressor = described_class.new
    serializer = Marshal
    old_cache  = ActiveSupport::Cache.lookup_store(:memory_store, serializer:, compress: true)
    new_cache  = ActiveSupport::Cache.lookup_store(:memory_store, serializer:, compressor:, compress: true)

    old_cache.write("example", { food_for_thought: FOOD_FOR_THOUGHT })

    new_cache.instance_variable_set(:@data, old_cache.instance_variable_get(:@data))

    expect(new_cache.read("example")).to eq({ food_for_thought: FOOD_FOR_THOUGHT })
  end
end
