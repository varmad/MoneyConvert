class MoneyConvert
  class ConversionRates
    attr_accessor :base_currency, :to_currencies

    def initialize(base_currency, to_currencies)
      @base_currency = base_currency
      @to_currencies = to_currencies
    end
  end
end
