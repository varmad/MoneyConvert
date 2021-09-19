require_relative 'lib/money-convert.rb'

MoneyConvert.conversion_rates("EUR", { 
  'USD' => 1.11,
  'Bitcoin' => 0.0047
})

fifty_eur = MoneyConvert.new(50, 'EUR')
twenty_dollars = MoneyConvert.new(20, 'USD')

# puts fifty_eur + twenty_dollars
# puts fifty_eur - twenty_dollars
# puts fifty_eur / 2
# puts twenty_dollars * 3

puts twenty_dollars == MoneyConvert.new(20, 'USD') # => true
puts twenty_dollars == MoneyConvert.new(30, 'USD') # => false

puts fifty_eur_in_usd = fifty_eur.convert_to('USD')
puts fifty_eur_in_usd == fifty_eur

puts twenty_dollars > MoneyConvert.new(5, 'USD')   # => true

puts twenty_dollars < fifty_eur

# puts fifty_eur.amount
# puts fifty_eur.currency
# puts fifty_eur.inspect

# convertion = fifty_eur.convert_to('USD')
# puts convertion.amount
# puts convertion.currency