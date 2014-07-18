# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  rating     :integer
#  text       :string(255)
#  user_id    :integer
#  video_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

require "faker"

FactoryGirl.define do
  factory :review do
    association :user
    association :video

    rating Random.rand(6)
    text { Faker::Company.bs }
  end
end
