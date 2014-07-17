# == Schema Information
#
# Table name: videos
#
#  id              :integer          not null, primary key
#  title           :string(255)
#  description     :text
#  small_cover_url :string(255)
#  large_cover_url :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  category_id     :integer
#

class Video < ActiveRecord::Base
  # Validations
  validates_presence_of :description
  validates_presence_of :title

  # Associations
  belongs_to :category
  has_many   :reviews
  has_many   :queue_items

  # Scopes
  scope :action,     -> { where(category_id: 4) }
  scope :comedies,   -> { where(category_id: 1) }
  scope :dramas,     -> { where(category_id: 2) }
  scope :realities,  -> { where(category_id: 3) }
  scope :scifi,      -> { where(category_id: 5) }

  # Class Methods
  def self.search_by_title(search_term)
    Video.where("title LIKE '%#{search_term}%'").order("created_at ASC")
  end

  # Instance Methods
  def average_rating
    if reviews.count > 0
      Review.where(video_id: self.id).average(:rating).to_f
    else
      "No Reviews Yet"
    end
  end
end
