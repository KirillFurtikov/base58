# base58

Just Base58 encoder/decoder

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     base58:
       github: KirillFurtikov/base58
   ```

2. Run `shards install`

## Usage

```crystal
require "base58"

# String, different alphabets
Base58.encode("hello world")                                # => "rTu1dk6cWsRYjYu"
Base58.encode("hello world", Base58::ALPHABETS[:flickr])    # => "rTu1dk6cWsRYjYu"
Base58.encode("hello world", Base58::ALPHABETS[:bitcoin])   # => "StV1DL6CwTryKyV"
Base58.encode("hello world", Base58::ALPHABETS[:ripple])    # => "StVrDLaUATiyKyV"

# Different source types
source = "hello world"                                      # => "hello world"
source_bytes = source.bytes                                 # => [104, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100]
source_slice = source.to_slice                              # => Bytes[104, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100]

Base58.encode(source)                                       # => "rTu1dk6cWsRYjYu"
Base58.encode(source_bytes)                                 # => "rTu1dk6cWsRYjYu"
Base58.encode(source_slice)                                 # => "rTu1dk6cWsRYjYu"

Base58.encode(Bytes[])                                      # => "1"

int = Base58.encode(1234567890)                             # => "2T6u2h"
Base58.decode(int)                                          # => 1234567890
```


## Contributing

1. Fork it (<https://github.com/KirillFurtikov/base58/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Kirill Furtikov](https://github.com/KirillFurtikov) - creator and maintainer
