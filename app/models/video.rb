class Video < ActiveRecord::Base
  validates :title, presence: true

  belongs_to :category

  # TODO create scope
  scope :comedies,   -> { where(category_id: 1) }
  scope :dramas,     -> { where(category_id: 2) }
  scope :realities,  -> { where(category_id: 3) }
  scope :action,     -> { where(category_id: 4) }
  scope :scifi,      -> { where(category_id: 5) }

end
