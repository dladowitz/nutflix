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

FactoryGirl.define do
  factory :video do
    title "Super Troopers"
    description "Five Vermont state troopers, avid pranksters with a knack for screwing up, try to save their jobs and out-do the local police department by solving a crime"
    category_id "1"
  end
end
