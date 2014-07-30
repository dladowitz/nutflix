# == Schema Information
#
# Table name: invitations
#
#  id         :integer          not null, primary key
#  token      :string(255)
#  inviter_id :integer
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invitation do
    token "MyString"
    user_id 1
  end
end
