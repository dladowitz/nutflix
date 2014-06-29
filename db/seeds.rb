# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

videos = Video.create([
                        { title: "Family Guy", description: "Peter does bad things",   small_cover_url: "family_guy.jpg" },
                        { title: "Futurama",   description: "Fry does bad things",     small_cover_url: "futurama.jpg" },
                        { title: "Monk",       description: "Monk does bad things",    small_cover_url: "monk.jpg",        large_cover_url: "monk_large.jpg" },
                        { title: "South Park", description: "Cartman does bad things", small_cover_url: "southpark.jpg" },
                      ])
