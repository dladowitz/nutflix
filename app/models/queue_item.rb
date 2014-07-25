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

class QueueItem < ActiveRecord::Base
  # Validations
  validates_numericality_of :queue_rank, only_integer: true
  validates_presence_of     :queue_rank, :user, :video
  validates_uniqueness_of   :queue_rank, scope: :user_id
  validates_uniqueness_of   :video_id,   scope: :user_id

  # Associations
  belongs_to :user
  belongs_to :video

  # Delegations
  delegate :category, to: :video
  delegate :title,    to: :video, prefix: true

  def category_name
    category ? category.name : "none"
  end

  def review
    Review.where(user: user, video: video).last
  end

  def rating
    review = Review.where(user: user, video: video).last

    if review
      review.rating
    else
      "none"
    end
  end

  def rating=(review_rating)
    if rating == "none"
      Review.create user: user, video: video, rating: review_rating
    else
      review.update_attributes! rating: review_rating
    end
  end
end
