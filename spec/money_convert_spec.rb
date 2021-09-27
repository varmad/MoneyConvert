RSpec.describe MoneyConvert do
  it 'has a version number' do
    expect(MoneyConvert::VERSION).not_to be nil
  end
  context 'Money Convert' do
    describe 'money convert class' do
      before(:each) do
        MoneyConvert.conversion_rates("EUR", {
          'USD' => 1.11,
          'Bitcoin' => 0.0047,
        })
      end

      subject(:fifty_eur) { MoneyConvert.new(50, 'EUR') }
      subject(:twenty_dollars) { MoneyConvert.new(20, 'USD') }

      it 'should expect EUR currency' do
        expect(fifty_eur.amount).to eq(50)
        expect(fifty_eur.currency).to eq('EUR')
      end

      it 'should expect USD currency' do
        expect(twenty_dollars.amount).to eq(20)
        expect(twenty_dollars.currency).to eq('USD')
      end

      it 'should convert to USD' do
        convertion = fifty_eur.convert_to('USD')

        expect(convertion.currency).to eq('USD')
        expect(convertion.amount).to eq(55.5)
      end

      it 'should expect base currency and amout if both currencies are same' do
        convertion = fifty_eur.convert_to('EUR')
        
        expect(convertion.currency).to eq('EUR')
        expect(convertion.amount).to eq(50)
      end


    end
  end  
end
