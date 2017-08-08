require 'rails_helper'

describe QuotationWorker, type: :worker do
  it 'create quotations to currencies' do
    described_class.new.perform

    expect(Currency.find_by(acronym: 'BTC').quotations.count).to eq(1)
    expect(Currency.find_by(acronym: 'USD').quotations.count).to eq(1)
    expect(Currency.find_by(acronym: 'EUR').quotations.count).to eq(1)
  end

  it 'not create when exists quotations hour' do
    
  end
end
