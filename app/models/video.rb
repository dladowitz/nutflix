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
  validates :title,      presence: true
  validates :description, presence: true

  belongs_to :category

  scope :comedies,   -> { where(category_id: 1) }
  scope :dramas,     -> { where(category_id: 2) }
  scope :realities,  -> { where(category_id: 3) }
  scope :action,     -> { where(category_id: 4) }
  scope :scifi,      -> { where(category_id: 5) }


  def self.search_by_title(search_term)
    Video.where("title LIKE '%#{search_term}%'").order("created_at DESC")
  end
end
