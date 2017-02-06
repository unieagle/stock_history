# StockHistory

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/stock_history`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'stock_history'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install stock_history

## Usage

Daily history with splits:

```ruby
StockHistory.history('DRYS',  :start_date => '2017-01-20', :stop_date => '2017-01-25')
# => [{:date=>"20170125", :date_parsed=>#<Date: 2017-01-25 ((2457779j,0s,0n),+0s,2299161j)>, :open=>4.48, :high=>4.74, :low=>3.98, :close=>4.0, :volume=>12492400.0, :adjusted_close=>4.0, :split=>nil, :merge=>nil, :dividend=>nil}, {:date=>"20170124", :date_parsed=>#<Date: 2017-01-24 ((2457778j,0s,0n),+0s,2299161j)>, :open=>5.56, :high=>5.6, :low=>4.42, :close=>4.48, :volume=>20733100.0, :adjusted_close=>4.48, :split=>nil, :merge=>nil, :dividend=>nil}, {:date=>"20170123", :date_parsed=>#<Date: 2017-01-23 ((2457777j,0s,0n),+0s,2299161j)>, :open=>7.5, :high=>7.65, :low=>5.25, :close=>5.4, :volume=>13820800.0, :adjusted_close=>5.4, :split=>1.0, :merge=>8.0, :dividend=>nil}, {:date=>"20170120", :date_parsed=>#<Date: 2017-01-20 ((2457774j,0s,0n),+0s,2299161j)>, :open=>1.04, :high=>1.13, :low=>0.99, :close=>1.01, :volume=>6841800.0, :adjusted_close=>8.08, :split=>nil, :merge=>nil, :dividend=>nil}] 
```

Daily history with dividend:

```ruby
StockHistory.history('GDXJ',  :start_date => '2016-12-18', :stop_date => '2016-12-21')
# => [{:date=>"20161221", :date_parsed=>#<Date: 2016-12-21 ((2457744j,0s,0n),+0s,2299161j)>, :open=>28.62, :high=>28.75, :low=>28.13, :close=>28.18, :volume=>11546800.0, :adjusted_close=>28.18, :split=>nil, :merge=>nil, :dividend=>nil}, {:date=>"20161220", :date_parsed=>#<Date: 2016-12-20 ((2457743j,0s,0n),+0s,2299161j)>, :open=>27.71, :high=>28.63, :low=>27.37, :close=>28.51, :volume=>23996800.0, :adjusted_close=>28.51, :split=>nil, :merge=>nil, :dividend=>nil}, {:date=>"20161219", :date_parsed=>#<Date: 2016-12-19 ((2457742j,0s,0n),+0s,2299161j)>, :open=>28.89, :high=>28.92, :low=>28.12, :close=>28.43, :volume=>27938700.0, :adjusted_close=>28.43, :split=>nil, :merge=>nil, :dividend=>1.51}, {:date=>"20161216", :date_parsed=>#<Date: 2016-12-16 ((2457739j,0s,0n),+0s,2299161j)>, :open=>30.81, :high=>31.18, :low=>29.53, :close=>29.86, :volume=>23705400.0, :adjusted_close=>28.35, :split=>nil, :merge=>nil, :dividend=>nil}] 
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/stock_history. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

