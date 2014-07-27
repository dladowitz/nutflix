# == Schema Information
#
# Table name: relationships
#
#  id               :integer          not null, primary key
#  followed_user_id :integer
#  follower_id      :integer
#  created_at       :datetime
#  updated_at       :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :relationship do
  end
end
