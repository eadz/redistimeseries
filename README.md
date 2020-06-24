# Redistimeseries

![Ruby Gem](https://github.com/eadz/redistimeseries/workflows/Ruby%20Gem/badge.svg)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'redistimeseries'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install redistimeseries

## Usage

RedisTimeSeries gem uses Ruby's refinement to add timeseries methods to the Redis gem.

You need to include the line

```ruby
require 'redistimeseries'
using Redistimeseries::RedisRefinement

client = Redis.new
client.ts_create(key: "mytimeseries")
client.ts_add(key: "mytimeseries", value: 141)
client.ts_get("mytimeseries")
```

# Methods - see redis_refinement.rb

```ruby
ts_create(key:, retention: nil, uncompressed: false, labels: [])
ts_add(key:, timestamp: "*", value:, retention: nil, labels: [])
ts_madd(key:, timestamp: "*", value:)
ts_range(key:, from: 0, to: nil, count: nil, aggtype: nil, timebucket: nil)
ts_info(key:)
```

### todo



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/eadz/redistimeseries.

## Code of Conduct

Everyone interacting in the Redistimeseries project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/eadz/redistimeseries/blob/master/CODE_OF_CONDUCT.md).
