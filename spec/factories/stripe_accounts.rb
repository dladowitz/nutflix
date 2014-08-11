# == Schema Information
#
# Table name: stripe_accounts
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  stripe_token      :string(255)
#  stripe_token_type :string(255)
#  stripe_email      :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stripe_account do
    account_id 1
    stripe_token "MyString"
    stripe_token_type "MyString"
    stripe_email "MyString"
  end
end
