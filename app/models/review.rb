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

class Review < ActiveRecord::Base
  # Validations
  validates_presence_of :rating, :user_id

  # Associations
  belongs_to :user
  belongs_to :video

end
