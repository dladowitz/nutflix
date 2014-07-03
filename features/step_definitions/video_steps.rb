Given /^a video is created$/ do
  Category.create(name: "Comedy")
  Category.create(name: "Drama")
  Category.create(name: "Reality")

  Video.create(title: "Superbad",   description: "Kids and things",     category_id: 1)
  Video.create(title: "Flight",     description: "Drinking and things", category_id: 2)
  Video.create(title: "Real World", description: "Things and things",   category_id: 3)


end

And /^a user visits the home page$/ do
  visit home_path
end

Then /^they can see all the videos in the database$/ do
  page.should have_selector("img")
end

Then /^they can see each category section$/ do
  page.should have_content("Comedy")
  page.should have_content("Drama")
  page.should have_content("Reality")
end

And /^they can see videos in each category$/ do
  page.should have_css(".comedy .video img")
  page.should have_css(".drama .video img")
  page.should have_css(".reality .video img")
end
