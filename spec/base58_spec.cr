require "./spec_helper"

Spectator.describe Base58 do
  describe "encode" do
    let(source) { "hello world" }
    let(expected) { "StV1DL6CwTryKyV" }

    it "Integer" do
      SAMPLES.each do |alphabet, examples|
        examples.each do |expected, actual|
          expect(Base58.encode(actual, Base58::ALPHABETS[alphabet])).to eq(expected)
        end
      end
    end

    it "Bytes" do
      expect(Base58.encode(source.to_slice, Base58::ALPHABETS[:bitcoin])).to eq(expected)
    end

    it "String" do
      expect(Base58.encode(source, Base58::ALPHABETS[:bitcoin])).to eq(expected)
    end

    it "Array(UInt8)" do
      expect(Base58.encode(source.bytes, Base58::ALPHABETS[:bitcoin])).to eq(expected)
    end
  end

  describe "decode" do
    it "Integer" do
      SAMPLES.each do |alphabet, examples|
        examples.each do |actual, expected|
          expect(Base58.decode(actual, Base58::ALPHABETS[alphabet])).to eq(expected)
        end
      end
    end
  end
end
