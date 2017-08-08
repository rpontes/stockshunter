require 'rails_helper'

describe QuotationsController, type: :controller do
  before do
    Currency.where(acronym: %w(BTC EUR USD)).each do |currency|
      create(:quotation, currency: currency)
    end
  end

  context 'when request sets accept => application/json' do
    it 'should return successful response' do
      request.accept = 'application/json'

      get :index

      response.should be_success
      response_json = JSON.parse(response.body)
      expect(response_json['data'].length).to eq(3)
    end
  end
end
