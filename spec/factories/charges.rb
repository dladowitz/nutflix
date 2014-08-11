# == Schema Information
#
# Table name: charges
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  amount     :integer
#  fee        :integer
#  refunded   :boolean
#  paid       :boolean
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :charge do
    association :user
    amount 1000
    fee 44
    paid true
    refunded false
  end
end
