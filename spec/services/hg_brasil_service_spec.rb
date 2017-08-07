require 'rails_helper'

describe HgBrasilService do
  describe '#quotations' do
    it 'get all quotations', vcr: true do
      response = described_class.new.quotations

      expect(response.length).to eq(3)
    end
  end
end
