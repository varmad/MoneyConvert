require_relative "conversion_rates"

class MoneyConvert
  attr_accessor :amount, :currency, :base_currency, :to_currencies

  def initialize(amount, currency)
    @amount = amount
    @currency = currency
  end

  def inspect
    "#{@amount} #{@currency}"
  end

  def convert_to(to_currency)
    return unless validate_currency(to_currency) && @@base_currency == currency

    toal_amount = convert(to_currency)
    self.class.new(toal_amount, to_currency)
  end

  def convert(to_currency)
    (@amount.to_i * @@to_currencies.fetch(to_currency)).round(2)
  end

  def +(other)
    return unless currency == @@base_currency

    converted_amount = convert(other.currency)
    converted_amount + amount.to_i
  end

  def -(other)
    return unless currency == @@base_currency
    
    converted_amount = convert(other.currency)
    converted_amount - amount.to_i
  end

  def /(other)
    return unless other.is_a?(Integer)

    amount.to_i / other
  end

  def *(other)
    return unless other.is_a?(Integer)

    amount.to_i * other
  end

  def ==(other)
    if amount == other.amount && currency == other.currency
      true
    else
      false
    end
  end

  def >(other)
    if amount > other.amount && currency == other.currency
      true
    else
      false
    end
  end

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

  def validate_currency(to_currency)
    @@to_currencies&.keys&.include?(to_currency)
  end

  def self.conversion_rates(base_currency, to_currencies)
    conversion_rates = MoneyConvert::ConversionRates.new(base_currency, to_currencies)
    @@base_currency = conversion_rates.base_currency
    @@to_currencies = conversion_rates.to_currencies
  end
end
