require "#{Rails.root}/app/helpers/application_helper"
include ApplicationHelper

namespace :db do
  task randomize_video_creation_times: [:environment] do
    Video.all.each do |video|
      video.update_attributes created_at: rand_time(10.days.ago)
      puts "new creation time: #{video.created_at} -- #{video.title}"
    end
  end

  task drop_create_seed: [:drop, :migrate, :seed_with_sleep] do
    puts "db dropped"
    puts "db migrated"
    puts "db seeded over time"
  end

  task seed_with_sleep: [:environment] do
    category = Category.create name: "Comedy"
    puts "--- creating category: #{category.name} ---"

    video = Video.create title: "Family Guy",    description: "Peter does bad things",   category_id: 1, small_cover_url: "family_guy.jpg", large_cover_url: "monk_large.jpg"
    puts "creating video: #{video.title}"; sleep 1

    video = Video.create title: "Futurama",      description: "Fry does bad things",     category_id: 1, small_cover_url: "futurama.jpg",   large_cover_url: "monk_large.jpg"
    puts "creating video: #{video.title}"; sleep 1

    video = Video.create title: "Monk",          description: "Monk does bad things",    category_id: 1, small_cover_url: "monk.jpg",       large_cover_url: "monk_large.jpg"
    puts "creating video: #{video.title}"; sleep 1

    video = Video.create title: "South Park",    description: "Cartman does bad things", category_id: 1, small_cover_url: "south_park.jpg", large_cover_url: "monk_large.jpg"
    puts "creating video: #{video.title}"; sleep 1

    category = Category.create name: "Drama"
    puts "--- creating category: #{category.name} ---"

    video = Video.create title: "Zodiac",        description: "Murder",                  category_id: 2, small_cover_url: "family_guy.jpg", large_cover_url: "monk_large.jpg"
    puts "creating video: #{video.title}"; sleep 1

    video = Video.create title: "Pulp Fiction",  description: "Drugs",                   category_id: 2, small_cover_url: "futurama.jpg" ,  large_cover_url: "monk_large.jpg"
    puts "creating video: #{video.title}"; sleep 1

    video = Video.create title: "Flight",        description: "Drugs",                   category_id: 2, small_cover_url: "monk.jpg",       large_cover_url: "monk_large.jpg"
    puts "creating video: #{video.title}"; sleep 1

    video = Video.create title: "Donnie Brasco", description: "Murder",                  category_id: 2, small_cover_url: "south_park.jpg", large_cover_url: "monk_large.jpg"
    puts "creating video: #{video.title}"; sleep 1

    category = Category.create name: "Reality"
    puts "--- creating category: #{category.name} ---"

    video = Video.create title: "Real World",    description: "Real stuff happens",      category_id: 3, small_cover_url: "family_guy.jpg", large_cover_url: "monk_large.jpg"
    puts "creating video: #{video.title}"; sleep 1

    video = Video.create title: "Survivor",      description: "People compete",          category_id: 3, small_cover_url: "futurama.jpg",   large_cover_url: "monk_large.jpg"
    puts "creating video: #{video.title}"; sleep 1

    video = Video.create title: "Road Rules",    description: "People drive around",     category_id: 3, small_cover_url: "monk.jpg",       large_cover_url: "monk_large.jpg"
    puts "creating video: #{video.title}"; sleep 1

    video = Video.create title: "Big Brother",   description: "Cameras and stuff",       category_id: 3, small_cover_url: "south_park.jpg", large_cover_url: "monk_large.jpg"
    puts "creating video: #{video.title}"; sleep 1

    category = Category.create name: "Action"
    puts "--- creating category: #{category.name} ---"

    video = Video.create title: "Skyfall",       description: "007",                     category_id: 4, small_cover_url: "family_guy.jpg", large_cover_url: "monk_large.jpg"
    puts "creating video: #{video.title}"; sleep 1

    video = Video.create title: "Rambo",         description: "Guns",                    category_id: 4, small_cover_url: "futurama.jpg",   large_cover_url: "monk_large.jpg"
    puts "creating video: #{video.title}"; sleep 1

    video = Video.create title: "Blade Runner",   description: "Replicants",              category_id: 4, small_cover_url: "monk.jpg",       large_cover_url: "monk_large.jpg"
    puts "creating video: #{video.title}"; sleep 1

    video = Video.create title: "Jack Reacher",  description: "Punching",                category_id: 4, small_cover_url: "south_park.jpg", large_cover_url: "monk_large.jpg"
    puts "creating video: #{video.title}"; sleep 1

    category = Category.create name: "Sci-Fi"
    puts "--- creating category: #{category.name} ---"

    video = Video.create title: "Iron Man",      description: "Flying",                  category_id: 5, small_cover_url: "family_guy.jpg", large_cover_url: "monk_large.jpg"
    puts "creating video: #{video.title}"; sleep 1

    video = Video.create title: "Xmen",          description: "Magnets",                 category_id: 5, small_cover_url: "futurama.jpg",   large_cover_url: "monk_large.jpg"
    puts "creating video: #{video.title}"; sleep 1

    video = Video.create title: "Star Trek",     description: "Time Travel",             category_id: 5, small_cover_url: "monk.jpg",       large_cover_url: "monk_large.jpg"
    puts "creating video: #{video.title}"; sleep 1

    video = Video.create title: "Avengers",      description: "Save the world",          category_id: 5, small_cover_url: "south_park.jpg", large_cover_url: "monk_large.jpg"
    puts "creating video: #{video.title}"; sleep 1
  end
end
