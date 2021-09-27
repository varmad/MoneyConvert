require_relative 'conversion_rates'

# Class for converting money from one currency to another
# and perform some arthimetic operations on two MoneyConvert objects.
class MoneyConvert
  attr_accessor :amount, :currency, :base_currency, :to_currencies

  def initialize(amount, currency)
    @amount = amount
    @currency = currency
  end

  def inspect
    "#{amount} #{currency}"
  end

  # Returns class object with converted currency values
  # For example:
  #   fifty_eur = MoneyConvert.new(50, 'EUR')
  #   fifty_eur_in_usd = fifty_eur.convert_to('USD')
  #     =>   fifty_eur_in_usd.currency
  #     =>   fifty_eur_in_usd.amount
  def convert_to(to_currency)
    return unless validate_currency(to_currency) && @@base_currency == currency

    toal_amount = convert(to_currency)
    self.class.new(toal_amount, to_currency)
  end

  # Return sum of two MoneyConvert object, if +other+ object has different currency
  # it will get converted into this object currency
  # For Example:
  #   MoneyConvert.new(50, 'EUR') + MoneyConvert.new(20, 'USD')
  #   MoneyConvert.new(50, 'EUR') - MoneyConvert.new(20, 'USD')
  #     => returns amount in EUR currency
  %i[+, -].each do |method|
    define_method(method) do |other|
      return unless currency == @@base_currency
      
      converted_amount = convert(other.currency)
      converted_amount - amount.to_i
    end
  end

  # Return division of two MoneyConvert object, if +other+ object has different currency
  # it will get converted into this object currency
  # For Example:
  #   MoneyConvert.new(50, 'EUR') / MoneyConvert.new(20, 'USD')
  #     => returns amount in EUR currency
  def /(other)
    return unless other.is_a?(Integer)

    amount.to_i / other
  end

  # Return multiplication of two MoneyConvert object, if +other+ object has different currency
  # it will get converted into this object currency
  # For Example:
  #   MoneyConvert.new(50, 'EUR') * MoneyConvert.new(20, 'USD')
  #     => returns amount in EUR currency
  def *(other)
    return unless other.is_a?(Integer)

    amount.to_i * other
  end

  # Return true if +other+ object and this object has same amount and currency
  # For Example:
  #   MoneyConvert.new(50, 'EUR') == MoneyConvert.new(50, 'EUR')
  #     => returns boolean
  def ==(other)
    if amount == other.amount && currency == other.currency
      true
    else
      false
    end
  end

  # Return true if +other+ object amount is gtater than this object amount,
  # and the currency should be same
  # For Example:
  #   MoneyConvert.new(50, 'EUR') > MoneyConvert.new(30, 'EUR')
  #     => returns boolean
  def >(other)
    if amount > other.amount && currency == other.currency
      true
    else
      false
    end
  end

  # Return true if +other+ object amount is less than this object amount,
  # and the currency should be same
  # For Example:
  #   MoneyConvert.new(20, 'EUR') < MoneyConvert.new(30, 'EUR')
  #     => returns boolean
  def <(other)
    if amount < other.amount && currency == other.currency
      true
    elsif currency != other.currency
      converted_amount = convert(currency)

      true if amount < converted_amount
    else
      false
    end
  end

  # Sets the +@@base_currency+ and +@@to_currencies+ class valiables
  def self.conversion_rates(base_currency, to_currencies)
    conversion_rates = MoneyConvert::ConversionRates.new(base_currency, to_currencies)
    @@base_currency = conversion_rates.base_currency
    @@to_currencies = conversion_rates.to_currencies
  end

  private

  # Returns converted currency
  def convert(to_currency)
    (amount.to_i * @@to_currencies.fetch(to_currency)).round(2)
  end

  # Checks wether the +to_currency+ is present in the given +@@to_curencies+ hash
  def validate_currency(to_currency)
    @@to_currencies&.keys&.include?(to_currency)
  end
end
