Given /^multiple videos are created$/ do
  Category.create(name: "Comedy")
  Category.create(name: "Drama")
  Category.create(name: "Reality")

  Video.create(title: "Superbad",   description: "Kids and things",     category_id: 1, small_cover_url: "superbad.jpg")
  Video.create(title: "Superbad 2", description: "Kids and things",     category_id: 1, small_cover_url: "superbad_2.jpg")
  Video.create(title: "Flight",     description: "Drinking and things", category_id: 2, small_cover_url: "flight.jpg")
  Video.create(title: "Real World", description: "Things and things",   category_id: 3, small_cover_url: "real_world.jpg")
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

And /^they enter a term in the search bar$/ do
  fill_in "Search for videos here", with: "Super"
  click_button "Search"
end

Then /^they see videos matching their search term$/ do
  uri = URI.parse(current_url)
  uri.path.should == search_videos_path

  page.should     have_css("img[src$='tmp/superbad.jpg']")
  page.should     have_css("img[src$='tmp/superbad_2.jpg']")
  page.should_not have_css("img[src$='tmp/flight.jpg']")
end
