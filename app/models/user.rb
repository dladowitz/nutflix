# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  email_address      :string(255)
#  password_digest    :string(255)
#  full_name          :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  follower_id        :integer
#  token              :string(255)
#  admin              :boolean
#  stripe_customer_id :string(255)
#

class User < ActiveRecord::Base
  include Tokenable

  # Validations
  validates_presence_of   :email_address, :full_name, :password
  validates_uniqueness_of :email_address

  # Associations
  # has_many :queue_items
  has_many :queue_items, -> { order "queue_rank ASC" }
  has_many :reviews,     -> { order "updated_at DESC" }
  has_many :invitations, foreign_key: :inviter_id
  has_many :charges

  has_many :follower_relationships, class_name: "Relationship", foreign_key: :followed_user_id
  has_many :followers,              through:    :follower_relationships,     source: :follower
  has_many :followed_user_relationships, class_name: "Relationship",   foreign_key: :follower_id
  has_many :followed_users, through:     :followed_user_relationships, source: :followed_user

  has_secure_password

  def first_name
    full_name.split(" ").first
  end

  def last_name
    full_name.split(" ").last
  end
end
