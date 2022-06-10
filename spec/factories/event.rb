FactoryBot.define do
  factory :event do
    association :user
    title { "SomeEvent" }
    address { "Valencia" }
    datetime { Time.now }
  end
end
