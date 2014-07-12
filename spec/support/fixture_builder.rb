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
    comedy = create(:category, name: "Comedy")
    action = create(:category, name: "Action")
    scifi  = create(:category, name: "SciFi")

    # users
    @james_bond = create(:user, full_name: "James Bond")


    # videos
    iron_man = create(:video, title: "Iron Man", category: action)
    fbuilder.name(:iron_man_2, create(:video, title: "Iron Man 2", category: action))
    fbuilder.name(:thor,       create(:video, title: "Thor", category: action))
    fbuilder.name(:star_trek, create(:video, title: "Star Trek", category: scifi))

    # reviews
    fbuilder.name(:iron_man_review, create(:review, video: iron_man, user: @james_bond))
  end
end


# https://github.com/rdy/fixture_builder

# Examples:

# fbuilder.name(:davids_ipod, Factory(:purchase, :user => david, :product => ipod))
# @davids_ipod = Factory(:purchase, :user => david, :product => ipod)


# fbuilder.name_model_with(User) do |record|
#   [record['first_name'], record['last_name']].join('_')
# end
