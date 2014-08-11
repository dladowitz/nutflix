# == Schema Information
#
# Table name: charges
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  amount     :integer
#  fee        :integer
#  refunded   :boolean
#  paid       :boolean
#  created_at :datetime
#  updated_at :datetime
#

class Charge < ActiveRecord::Base
  belongs_to :user

  validates :user,     presence: true
  validates :fee,      presence: true, numericality: true
  validates :amount,   presence: true, numericality: true
  validates :paid,     :inclusion => {:in => [true, false]}
  validates :refunded, :inclusion => {:in => [true, false]}
end
