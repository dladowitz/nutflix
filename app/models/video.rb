# == Schema Information
#
# Table name: videos
#
#  id                     :integer          not null, primary key
#  title                  :string(255)
#  description            :text
#  created_at             :datetime
#  updated_at             :datetime
#  category_id            :integer
#  large_cover            :string(255)
#  small_cover            :string(255)
#  small_cover_processing :boolean          default(FALSE), not null
#  large_cover_processing :boolean          default(FALSE), not null
#  small_cover_tmp        :string(255)
#  large_cover_tmp        :string(255)
#  video_url              :string(255)
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

  # Carrierwave
  mount_uploader :small_cover, VerticalPosterUploader
  # Store_in_background may not work on heroku. See Docs
  store_in_background :small_cover

  mount_uploader :large_cover, HorizontalPosterUploader
  # Store_in_background may not work on heroku. See Docs
  store_in_background :large_cover

  # Class Methods
  def self.search_by_title(search_term)
    Video.where("title LIKE '%#{search_term}%'").order("created_at ASC")
  end

  # Instance Methods
  def average_rating
    if reviews.any?
      @rating = reviews.average(:rating).to_f.round(1)
      @rating == 1.0 ? "#{@rating} Star" : "#{@rating } Stars"
    else
      "No Reviews Yet"
    end
  end

  def decorate
    VideoDecorator.new(self)
  end
end
