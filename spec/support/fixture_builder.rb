FixtureBuilder.configure do |fbuilder|
  # rebuild fixtures automatically when these files change:
  fbuilder.files_to_check += Dir["spec/factories/*.rb", "spec/support/fixture_builder.rb"]

  # Include Factory Girl syntax to simplify syntax from: FactoryGirl.create(:category, name: "Comedy")) to: create(:category, name: "Comedy"))
  include FactoryGirl::Syntax::Methods

  # now declare objects
  fbuilder.factory do
    # Not sure the difference between @james_bond and james_bond.
    # They seem to become named instances in the yml file, but not in a consistancy I can see

    # categories
    comedy  = create(:category, name: "Comedy")
    action  = create(:category, name: "Action")
    scifi   = create(:category, name: "SciFi")
    drama   = create(:category, name: "Drama")
    reality = create(:category, name: "Reality")

    # users
    @james_bond = create(:user, full_name: "James Bond")
    @dr_evil    = create(:user, full_name: "Dr Evil")


    # videos
    iron_man =                 create(:video, title: "Iron Man",   category: action, small_cover_url: "iron_man.jpg",   created_at: Time.now - 7.hour)
    fbuilder.name(:iron_man_2, create(:video, title: "Iron Man 2", category: action, small_cover_url: "iron_man_2.jpg", created_at: Time.now - 6.hour))
    fbuilder.name(:iron_man_3, create(:video, title: "Iron Man_3", category: action, small_cover_url: "iron_man_3.jpg", created_at: Time.now - 5.hour))
    fbuilder.name(:iron_man_4, create(:video, title: "Iron Man 4", category: action, small_cover_url: "iron_man_4.jpg", created_at: Time.now - 4.hour))
    fbuilder.name(:iron_man_5, create(:video, title: "Iron Man 5", category: action, small_cover_url: "iron_man_5.jpg", created_at: Time.now - 3.hour))
    fbuilder.name(:iron_man_6, create(:video, title: "Iron Man 6", category: action, small_cover_url: "iron_man_6.jpg", created_at: Time.now - 2.hour))
    fbuilder.name(:iron_man_7, create(:video, title: "Iron Man 7", category: action, small_cover_url: "iron_man_7.jpg", created_at: Time.now - 1.hour))

    thor =                     create(:video, title: "Thor",       category: action, small_cover_url: "thor.jpg",       created_at: Time.now - 8.hour)
    fbuilder.name(:thor_2,     create(:video, title: "Thor_2",     category: action, small_cover_url: "thor_2.jpg",     created_at: Time.now - 9.hour))

    fbuilder.name(:star_trek,  create(:video, title: "Star Trek",  category: scifi,  small_cover_url: "star_trek.jpg"))
    fbuilder.name(:flight,     create(:video, title: "Flight",     category: drama,  small_cover_url: "flight.jpg"))

    # reviews
    fbuilder.name(:iron_man_review, create(:review, video: iron_man, user: @james_bond, rating: 5))
    fbuilder.name(:iron_man_review, create(:review, video: iron_man, user: @james_bond, rating: 4))

    # queue_items
    fbuilder.name(:james_bond_first_qi,  create(:queue_item, user: @james_bond, video: iron_man, queue_rank: 1))
    fbuilder.name(:james_bond_second_qi, create(:queue_item, user: @james_bond, video: thor,     queue_rank: 2))
  end
end


# https://github.com/rdy/fixture_builder

# Examples:

# fbuilder.name(:davids_ipod, Factory(:purchase, :user => david, :product => ipod))
# @davids_ipod = Factory(:purchase, :user => david, :product => ipod)


# fbuilder.name_model_with(User) do |record|
#   [record['first_name'], record['last_name']].join('_')
# end
