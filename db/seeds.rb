# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
users =      User.create([
                  { email_address: "david@ladowitz.com", password: "asdfasdf", full_name: "David Ladowitz" },
                  { email_address: "dusy@cats.com",      password: "asdfasdf", full_name: "Dusty Huang" },
                  { email_address: "aiko@cats.com",      password: "asdfasdf", full_name: "Aiko Huang" }
                 ])

categories = Category.create([
                  { name: "Comedy" },
                  { name: "Drama" },
                  { name: "Reality" },
                  { name: "Action" },
                  { name: "Sci-Fi" },
                 ])

videos =     Video.create([
                  { title: "Family Guy",    description: "Peter does bad things",   category_id: 1, small_cover_url: "family_guy.jpg", large_cover_url: "monk_large.jpg" },
                  { title: "Futurama",      description: "Fry does bad things",     category_id: 1, small_cover_url: "futurama.jpg",   large_cover_url: "monk_large.jpg" },
                  { title: "Monk",          description: "Monk does bad things",    category_id: 1, small_cover_url: "monk.jpg",       large_cover_url: "monk_large.jpg" },
                  { title: "South Park",    description: "Cartman does bad things", category_id: 1, small_cover_url: "south_park.jpg", large_cover_url: "monk_large.jpg" },
                  { title: "South Park",    description: "Cartman does bad things", category_id: 1, small_cover_url: "south_park.jpg", large_cover_url: "monk_large.jpg" },
                  { title: "South Park",    description: "Cartman does bad things", category_id: 1, small_cover_url: "south_park.jpg", large_cover_url: "monk_large.jpg" },
                  { title: "South Park",    description: "Cartman does bad things", category_id: 1, small_cover_url: "south_park.jpg", large_cover_url: "monk_large.jpg" },

                  { title: "Zodiac",        description: "Murder",                  category_id: 2, small_cover_url: "family_guy.jpg", large_cover_url: "monk_large.jpg" },
                  { title: "Pulp Fiction",  description: "Drugs",                   category_id: 2, small_cover_url: "futurama.jpg",   large_cover_url: "monk_large.jpg" },
                  { title: "Flight",        description: "Drugs",                   category_id: 2, small_cover_url: "monk.jpg",       large_cover_url: "monk_large.jpg" },
                  { title: "Donnie Brasco", description: "Murder",                  category_id: 2, small_cover_url: "south_park.jpg", large_cover_url: "monk_large.jpg" },
                  { title: "Donnie Brasco", description: "Murder",                  category_id: 2, small_cover_url: "south_park.jpg", large_cover_url: "monk_large.jpg" },
                  { title: "Donnie Brasco", description: "Murder",                  category_id: 2, small_cover_url: "south_park.jpg", large_cover_url: "monk_large.jpg" },
                  { title: "Donnie Brasco", description: "Murder",                  category_id: 2, small_cover_url: "south_park.jpg", large_cover_url: "monk_large.jpg" },

                  { title: "Real World",    description: "Real stuff happens",      category_id: 3, small_cover_url: "family_guy.jpg", large_cover_url: "monk_large.jpg" },
                  { title: "Survivor",      description: "People compete",          category_id: 3, small_cover_url: "futurama.jpg",   large_cover_url: "monk_large.jpg" },
                  { title: "Road Rules",    description: "People drive around",     category_id: 3, small_cover_url: "monk.jpg",       large_cover_url: "monk_large.jpg" },
                  { title: "Big Brother",   description: "Cameras and stuff",       category_id: 3, small_cover_url: "south_park.jpg", large_cover_url: "monk_large.jpg" },
                  { title: "Big Brother",   description: "Cameras and stuff",       category_id: 3, small_cover_url: "south_park.jpg", large_cover_url: "monk_large.jpg" },
                  { title: "Big Brother",   description: "Cameras and stuff",       category_id: 3, small_cover_url: "south_park.jpg", large_cover_url: "monk_large.jpg" },
                  { title: "Big Brother",   description: "Cameras and stuff",       category_id: 3, small_cover_url: "south_park.jpg", large_cover_url: "monk_large.jpg" },

                  { title: "Skyfall",       description: "007",                     category_id: 4, small_cover_url: "family_guy.jpg", large_cover_url: "monk_large.jpg" },
                  { title: "Rambo",         description: "Guns",                    category_id: 4, small_cover_url: "futurama.jpg",   large_cover_url: "monk_large.jpg" },
                  { title: "Blade Runner",   description: "Replicants",              category_id: 4, small_cover_url: "monk.jpg",       large_cover_url: "monk_large.jpg" },
                  { title: "Jack Reacher",  description: "Punching",                category_id: 4, small_cover_url: "south_park.jpg", large_cover_url: "monk_large.jpg" },
                  { title: "Jack Reacher",  description: "Punching",                category_id: 4, small_cover_url: "south_park.jpg", large_cover_url: "monk_large.jpg" },
                  { title: "Jack Reacher",  description: "Punching",                category_id: 4, small_cover_url: "south_park.jpg", large_cover_url: "monk_large.jpg" },
                  { title: "Jack Reacher",  description: "Punching",                category_id: 4, small_cover_url: "south_park.jpg", large_cover_url: "monk_large.jpg" },

                  { title: "Iron Man",      description: "Flying",                  category_id: 5, small_cover_url: "family_guy.jpg", large_cover_url: "monk_large.jpg" },
                  { title: "Xmen",          description: "Magnets",                 category_id: 5, small_cover_url: "futurama.jpg",   large_cover_url: "monk_large.jpg" },
                  { title: "Star Trek",     description: "Time Travel",             category_id: 5, small_cover_url: "monk.jpg",       large_cover_url: "monk_large.jpg" },
                  { title: "Avengers",      description: "Save the world",          category_id: 5, small_cover_url: "south_park.jpg", large_cover_url: "monk_large.jpg" },
                  { title: "Avengers",      description: "Save the world",          category_id: 5, small_cover_url: "south_park.jpg", large_cover_url: "monk_large.jpg" },
                  { title: "Avengers",      description: "Save the world",          category_id: 5, small_cover_url: "south_park.jpg", large_cover_url: "monk_large.jpg" },
                  { title: "Avengers",      description: "Save the world",          category_id: 5, small_cover_url: "south_park.jpg", large_cover_url: "monk_large.jpg" },
                ])

queue_items = QueueItem.create([
                  { user: User.first, video: Video.first,  queue_rank: 4 },
                  { user: User.first, video: Video.second, queue_rank: 2 },
                  { user: User.first, video: Video.third,  queue_rank: 3 },
                  { user: User.first, video: Video.fourth, queue_rank: 1 },

                  { user: User.second, video: Video.fifth,  queue_rank: 1 },
                  { user: User.second, video: Video.second, queue_rank: 2 },


                ])
