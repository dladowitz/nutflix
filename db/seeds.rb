# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
users =      User.create([
                  { email_address: "david@ladowitz.com", password: "asdfasdf", full_name: "David Ladowitz", admin: true },
                  { email_address: "dusty@cats.com",     password: "asdfasdf", full_name: "Dusty Huang" },
                  { email_address: "aiko@cats.com",      password: "asdfasdf", full_name: "Aiko Huang" }
                 ])

categories = Category.create([
                  { name: "Comedy" },
                  { name: "Drama" },
                  { name: "Reality" },
                  { name: "Action" },
                  { name: "Sci-Fi" },
                 ])

title_categorys = [["Family Guy",1], ["Futurama",1], ["Monk",1], ["South Park",1], ["South Park",1], ["South Park",1], ["South Park",1],
                  ["Zodiac",2], ["Pulp Fiction",2], ["Flight",2], ["Donnie Brasco",2], ["Donnie Brasco",2], ["Donnie Brasco",2], ["Donnie Brasco",2],
                  ["Real World",3], ["Survivor",3], ["Road Rules",3], ["Big Brother",3], ["Big Brother",3], ["Big Brother",3], ["Big Brother",3],
                  ["SkyFall",4], ["Rambo",4], ["Blade Runner",4], ["Jack Reacher",4], ["Jack Reacher",4], ["Jack Reacher",4], ["Jack Reacher",4],
                  ["Iron Man",5], ["Xmen",5], ["Star Trek",5], ["Avengers",5], ["Avengers",5], ["Avengers",5], ["Avengers",5]
                ]
small_posters = ["monk.jpg", "futurama.jpg", "family_guy.jpg", "south_park.jpg"]

title_categorys.each do |title_cat|
  video = Video.new({ title: title_cat[0], description: "things happen, then it ends", category_id: title_cat[1], large_cover: File.open("public/tmp/monk_large.jpg"), small_cover: File.open("public/tmp/#{small_posters.sample}") })
  video.process_large_cover_upload = true
  video.process_small_cover_upload = true
  video.save
end


queue_items = QueueItem.create([
                  { user: User.first, video: Video.first,  queue_rank: 4 },
                  { user: User.first, video: Video.second, queue_rank: 2 },
                  { user: User.first, video: Video.third,  queue_rank: 3 },
                  { user: User.first, video: Video.fourth, queue_rank: 1 },

                  { user: User.second, video: Video.fifth,  queue_rank: 1 },
                  { user: User.second, video: Video.second, queue_rank: 2 },
                ])
