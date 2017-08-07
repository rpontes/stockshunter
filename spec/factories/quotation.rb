FactoryGirl.define do
  factory :quotation do
    buy { rand(2.5...3.9).round(3) }
    sell { rand(2.5...3.9).round(3) }
    variation { rand(0.1...1.8).round(3) }
    quotation_at { Time.zone.now }
    currency
  end
end
