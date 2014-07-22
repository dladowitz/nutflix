# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email_address   :string(255)
#  password_digest :string(255)
#  full_name       :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  # Validations
  validates_presence_of   :email_address, :full_name, :password
  validates_uniqueness_of :email_address

  # Associations
  # has_many :queue_items
  has_many :queue_items, -> { order "queue_rank ASC" }
  has_many :reviews,     -> { order "updated_at DESC" }

  has_secure_password
end
