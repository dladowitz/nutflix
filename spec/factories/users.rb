# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email_address   :string(255)
#  password_digest :string(255)
#  full_name       :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  follower_id     :integer
#  token           :string(255)
#

require "faker"

FactoryGirl.define do
  factory :user do
    email_address { Faker::Internet.email }
    password      "asdfasdf"
    full_name     { Faker::Name.name }
  end
end
