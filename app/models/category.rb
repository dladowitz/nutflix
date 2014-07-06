# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Category < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :videos, -> { order "created_at DESC" }

  def recent_videos
    videos.limit(6)
  end
end
