require "big"

module Base58
  extend self

  ALPHABETS = {
    :flickr  => "123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ", # Default
    :bitcoin => "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz", # Also used for IPFS
    :ripple  => "rpshnaf39wBUDNEGHJKLM4PQRST7VWXYZ2bcdeCg65jkm8oFqi1tuvAxyz",
  }

  # Converts base58 String -> base10 Integer.
  def decode(value : String, alphabet = ALPHABETS[:flickr]) : BigInt
    result = BigInt.zero
    base = alphabet.size

    value.each_char do |char|
      unless digit = alphabet.index(char)
        raise ArgumentError.new("Unexpected character: #{char.inspect}")
      end

      result = result * base + digit
    end

    result
  end

  # Converts base10 Integer -> base58 String.
  def encode(value : Int, alphabet = ALPHABETS[:flickr]) : String
    result = ""
    base = alphabet.size

    while (value >= base)
      mod = value % base
      result = alphabet[mod.to_i32] + result
      value = (value - mod).divmod(base).first
    end

    alphabet[value.to_i32] + result
  end

  # Converts String -> base58 String
  def encode(value : String | Bytes | Array(UInt8), alphabet = ALPHABETS[:flickr]) : String
    leading_zeroes = 0
    num = BigInt.new(0)
    base = BigInt.new(1)
    value = value.bytes if value.is_a?(String)

    value.reverse_each do |byte|
      if byte == 0
        leading_zeroes += 1
      else
        leading_zeroes = 0
        num += base * byte
      end

      base *= 256
    end

    (alphabet.byte_slice(0, 1) * leading_zeroes) + encode(num, alphabet)
  end
end
