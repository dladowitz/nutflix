# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl
require "faker"


FactoryGirl.define do
  factory :category do
    name { Faker::Company.catch_phrase }

    factory :category_action do
      name "Action"
    end

    factory :category_comedy do
      name "Comedy"
    end

    factory :category_horror do
      name "Horror"
    end

    factory :category_invalid do
      name nil
    end
  end
end
