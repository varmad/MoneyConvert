# Money::Convert



## Installation

Add this line to your application's Gemfile:

```ruby
gem 'money-convert'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install money-convert

## Usage

```ruby
# Configure the currency rates with respect to a base currency (here EUR):
 
MoneyConvert.conversion_rates('EUR', {
  'USD'     => 1.11,
  'Bitcoin' => 0.0047
})
 
# Instantiate money convert objects:
 
fifty_eur = MoneyConvert.new(50, 'EUR')
 
# Get amount and currency:
 
fifty_eur.amount   # => 50
fifty_eur.currency # => "EUR"
fifty_eur.inspect  # => "50.00 EUR"
 
# Convert to a different currency (should return a Money
# instance, not a String):
 
fifty_eur.convert_to('USD') # => 55.50 USD
 
# Perform operations in different currencies:
 
twenty_dollars = MoneyConvert.new(20, 'USD')
 
# Arithmetics:
 
fifty_eur + twenty_dollars # => 68.02 EUR
fifty_eur - twenty_dollars # => 31.98 EUR
fifty_eur / 2              # => 25 EUR
twenty_dollars * 3         # => 60 USD
 
# Comparisons (also in different currencies):
 
twenty_dollars == MoneyConvert.new(20, 'USD') # => true
twenty_dollars == MoneyConvert.new(30, 'USD') # => false
 
fifty_eur_in_usd = fifty_eur.convert_to('USD')
fifty_eur_in_usd == fifty_eur          # => true
 
twenty_dollars > MoneyConvert.new(5, 'USD')   # => true
twenty_dollars < fifty_eur             # => true
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/varmad/money-convert. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/money-convert/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Money::Convert project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/money-convert/blob/master/CODE_OF_CONDUCT.md).
