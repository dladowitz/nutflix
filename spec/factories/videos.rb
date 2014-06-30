FactoryGirl.define do
  factory :video do
    title "Super Troopers"
    description "Five Vermont state troopers, avid pranksters with a knack for screwing up, try to save their jobs and out-do the local police department by solving a crime"
    small_cover_url "super_troppers.jpg"
    large_cover_url "super_troppers_large.jpg"
    category_id "1"
  end
end
