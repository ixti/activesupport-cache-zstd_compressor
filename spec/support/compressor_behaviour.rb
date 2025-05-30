# frozen_string_literal: true

RSpec.shared_examples "a compressor" do
  subject(:compressor) { described_class.new }

  describe ".new" do
    it "initializes compressor with default compression level=3" do
      expect(described_class.new.level).to eq 3
    end

    it "allows setting different compression level" do
      expect(described_class.new(level: 6).level).to eq(6)
    end

    it "requires level to be an Integer" do
      expect { described_class.new(level: "high") }
        .to raise_error(ArgumentError, "Compression level must be an Integer")
    end
  end

  describe "#deflate" do
    it "compresses data using Zstd" do
      compressed = compressor.deflate(FOOD_FOR_THOUGHT)

      expect(compressed).not_to eq(FOOD_FOR_THOUGHT)
      expect(compressed.bytesize).to be < FOOD_FOR_THOUGHT.bytesize
    end
  end

  describe "#inflate" do
    it "uncompresses data using Zstd" do
      uncompressed = compressor.inflate(compressor.deflate(FOOD_FOR_THOUGHT))

      expect(uncompressed).to eq(FOOD_FOR_THOUGHT)
    end
  end
end
