## Installation

Add this line to your application's Gemfile:

```ruby
gem 'regex_sample'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install regex_sample

## Usage

```ruby
require 'regex_sample'

RegexSample.generate(/(a|b)/)
#=> "b"

RegexSample.generate(/foo[0-9]{3,8}(bar|baz|qux)?/)
#=> "foo87065baz"

# For Japanese
RegexSample.generate(/foo-\p{katakana}{4}-\p{hiragana}{4}/)
#=> "foo-ゲホヅヱ-うゐつだ"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mochizukikotaro/regex_sample.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
