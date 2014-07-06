require "#{Rails.root}/app/helpers/application_helper"
include ApplicationHelper

namespace :db do
  task randomize_video_creation_times: [:environment] do
    Video.all.each do |video|
      video.update_attributes created_at: rand_time(100.days.ago)
      puts "new creation time: #{video.created_at} -- #{video.title}"
    end
  end

  task drop_create_seed_randomize: [:drop, :migrate, :seed, :randomize_video_creation_times] do
    puts "db dropped"
    puts "db migrated"
    puts "db seeded"
    puts "video creation times randomized"
  end
end
