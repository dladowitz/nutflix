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

videos =     Video.create([
                  { title: "Family Guy",    description: "Peter does bad things",   category_id: 1 },
                  { title: "Futurama",      description: "Fry does bad things",     category_id: 1 },
                  { title: "Monk",          description: "Monk does bad things",    category_id: 1 },
                  { title: "South Park",    description: "Cartman does bad things", category_id: 1 },
                  { title: "South Park",    description: "Cartman does bad things", category_id: 1 },
                  { title: "South Park",    description: "Cartman does bad things", category_id: 1 },
                  { title: "South Park",    description: "Cartman does bad things", category_id: 1 },

                  { title: "Zodiac",        description: "Murder",                  category_id: 2 },
                  { title: "Pulp Fiction",  description: "Drugs",                   category_id: 2 },
                  { title: "Flight",        description: "Drugs",                   category_id: 2 },
                  { title: "Donnie Brasco", description: "Murder",                  category_id: 2 },
                  { title: "Donnie Brasco", description: "Murder",                  category_id: 2 },
                  { title: "Donnie Brasco", description: "Murder",                  category_id: 2 },
                  { title: "Donnie Brasco", description: "Murder",                  category_id: 2 },

                  { title: "Real World",    description: "Real stuff happens",      category_id: 3 },
                  { title: "Survivor",      description: "People compete",          category_id: 3 },
                  { title: "Road Rules",    description: "People drive around",     category_id: 3 },
                  { title: "Big Brother",   description: "Cameras and stuff",       category_id: 3 },
                  { title: "Big Brother",   description: "Cameras and stuff",       category_id: 3 },
                  { title: "Big Brother",   description: "Cameras and stuff",       category_id: 3 },
                  { title: "Big Brother",   description: "Cameras and stuff",       category_id: 3 },

                  { title: "Skyfall",       description: "007",                     category_id: 4 },
                  { title: "Rambo",         description: "Guns",                    category_id: 4 },
                  { title: "Blade Runner",   description: "Replicants",             category_id: 4 },
                  { title: "Jack Reacher",  description: "Punching",                category_id: 4 },
                  { title: "Jack Reacher",  description: "Punching",                category_id: 4 },
                  { title: "Jack Reacher",  description: "Punching",                category_id: 4 },
                  { title: "Jack Reacher",  description: "Punching",                category_id: 4 },

                  { title: "Iron Man",      description: "Flying",                  category_id: 5 },
                  { title: "Xmen",          description: "Magnets",                 category_id: 5 },
                  { title: "Star Trek",     description: "Time Travel",             category_id: 5 },
                  { title: "Avengers",      description: "Save the world",          category_id: 5 },
                  { title: "Avengers",      description: "Save the world",          category_id: 5 },
                  { title: "Avengers",      description: "Save the world",          category_id: 5 },
                  { title: "Avengers",      description: "Save the world",          category_id: 5 },
                ])

queue_items = QueueItem.create([
                  { user: User.first, video: Video.first,  queue_rank: 4 },
                  { user: User.first, video: Video.second, queue_rank: 2 },
                  { user: User.first, video: Video.third,  queue_rank: 3 },
                  { user: User.first, video: Video.fourth, queue_rank: 1 },

                  { user: User.second, video: Video.fifth,  queue_rank: 1 },
                  { user: User.second, video: Video.second, queue_rank: 2 },


                ])
