require 'rails_helper'

describe Quotation, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:buy) }
    it { should validate_presence_of(:sell) }
    it { should validate_presence_of(:variation) }
    it { should validate_presence_of(:currency_id) }
  end
end
