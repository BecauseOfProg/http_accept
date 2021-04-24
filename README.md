# HTTP::Accept

Provides parser for dealing with HTTP `Accept-Language` headers.

Inspired by Ruby [http-accept gem](https://github.com/socketry/http-accept)

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     http_accept:
       github: BecauseOfProg/http_accept
   ```

2. Run `shards install`

## Usage

```crystal
require "http_accept"


# wanted_languages = HTTP::Accept::Language.parse("da, en-gb;q=0.8, en;q=0.7")

http_headers : HTTP::Headers
wanted_languages : Array(HTTP::Accept::Language::Value)? = nil
if http_headers["Accept-Language"]?
  wanted_languages = HTTP::Accept::Language.parse(http_headers["Accept-Language"])
end

HTTP::Accept::Language.best_locale(["en", "fr"], wanted_languages) # => "en"
HTTP::Accept::Language.best_locale(["fr", "nl"], wanted_languages, "fr") # => "fr"

HTTP::Accept::Language.best_locale(["en", "fr"], nil) # => "en"
```

TODO: Write usage instructions here

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/BecauseOfProg/http_accept/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Nicolas Martinussen](https://github.com/Whaxion) - creator and maintainer
