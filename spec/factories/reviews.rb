require "faker"

FactoryGirl.define do
  factory :review do
    association :user
    association :video

    rating Random.rand(6)
    text { Faker::Company.bs }
  end
end
