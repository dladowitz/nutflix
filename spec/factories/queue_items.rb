# == Schema Information
#
# Table name: queue_items
#
#  id         :integer          not null, primary key
#  queue_rank :integer
#  video_id   :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :queue_item do
    association :video
    association :user

    queue_rank 1
  end
end
