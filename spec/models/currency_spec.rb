require 'rails_helper'

describe Currency, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:acronym) }
  end
end
