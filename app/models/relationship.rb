# == Schema Information
#
# Table name: relationships
#
#  id               :integer          not null, primary key
#  followed_user_id :integer
#  follower_id      :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class Relationship < ActiveRecord::Base
  belongs_to :follower,      class_name: "User"
  belongs_to :followed_user, class_name: "User"

  # belongs_to :followed_user, :class_name => "User", foreign_key: :followed_user_id
  # belongs_to :follower,      :class_name => "User", foreign_key: :follower_id
end
