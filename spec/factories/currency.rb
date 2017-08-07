FactoryGirl.define do
  factory :currency do
    name { FFaker.currency.name }
    acronym { FFaker.currency.code }
  end
end
