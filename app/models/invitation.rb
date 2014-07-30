# == Schema Information
#
# Table name: invitations
#
#  id         :integer          not null, primary key
#  token      :string(255)
#  inviter_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Invitation < ActiveRecord::Base
  include Tokenable

  belongs_to :inviter, class_name: "User"

  validates_presence_of :inviter
end
