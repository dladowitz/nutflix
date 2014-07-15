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
  validates_presence_of :queue_rank
  validates_presence_of :user
  validates_presence_of :video
  validates_uniqueness_of :queue_rank, scoped: :user
  validates_uniqueness_of :video, scope: :user

  # Associations
  belongs_to :user
  belongs_to :video

end
