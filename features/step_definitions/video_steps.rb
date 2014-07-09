Given /^multiple videos are created$/ do
  Category.create(name: "Comedy")
  Category.create(name: "Drama")
  Category.create(name: "Reality")

  Video.create(title: "Superbad",   description: "Kids and things",     category_id: 1, small_cover_url: "superbad.jpg")
  Video.create(title: "Superbad 2", description: "Kids and things",     category_id: 1, small_cover_url: "superbad_2.jpg")
  Video.create(title: "Superbad 3", description: "Kids and things",     category_id: 1, small_cover_url: "superbad_3.jpg")
  Video.create(title: "Superbad 4", description: "Kids and things",     category_id: 1, small_cover_url: "superbad_4.jpg")
  Video.create(title: "Superbad 5", description: "Kids and things",     category_id: 1, small_cover_url: "superbad_5.jpg")
  Video.create(title: "Superbad 6", description: "Kids and things",     category_id: 1, small_cover_url: "superbad_6.jpg")
  Video.create(title: "Superbad 7", description: "Kids and things",     category_id: 1, small_cover_url: "superbad_7.jpg")

  Video.create(title: "Flight",     description: "Drinking and things", category_id: 2, small_cover_url: "flight.jpg")
  Video.create(title: "Real World", description: "Things and things",   category_id: 3, small_cover_url: "real_world.jpg")
end

And /^a user visits the videos_path$/ do
  visit videos_path
end

Then /^they can see videos in the database$/ do
  page.should have_selector("img")
end

Then /^they can see each category section$/ do
  page.should have_content("Comedy")
  page.should have_content("Drama")
  page.should have_content("Reality")
end

And /^they can see the six most recent videos in each category$/ do
  page.should have_css(".comedy img[src$='tmp/superbad_2.jpg']")
  page.should have_css(".comedy img[src$='tmp/superbad_3.jpg']")
  page.should have_css(".comedy img[src$='tmp/superbad_4.jpg']")
  page.should have_css(".comedy img[src$='tmp/superbad_5.jpg']")
  page.should have_css(".comedy img[src$='tmp/superbad_6.jpg']")
  page.should have_css(".comedy img[src$='tmp/superbad_7.jpg']")

  page.should have_css(".drama img[src$='tmp/flight.jpg']")
  page.should have_css(".reality img[src$='tmp/real_world.jpg']")

  page.should_not have_css(".comedy img[src$='tmp/superbad.jpg']")
end

And /^they enter a term in the search bar$/ do
  fill_in "Search for videos here", with: "Super"
  click_button "search"
end

Then /^they see videos matching their search term$/ do
  uri = URI.parse(current_url)
  uri.path.should == search_videos_path

  page.should have_css("img[src$='tmp/superbad.jpg']")
  page.should have_css("img[src$='tmp/superbad_2.jpg']")

  page.should_not have_css("img[src$='tmp/flight.jpg']")
end

And /^a user clicks on a category link$/ do
  click_link "Comedy"
end

Then /^they should see only videos from that category$/ do
  page.should have_css("img[src$='tmp/superbad.jpg']")
  page.should have_css("img[src$='tmp/superbad_2.jpg']")
  page.should have_css("img[src$='tmp/superbad_3.jpg']")
  page.should have_css("img[src$='tmp/superbad_4.jpg']")
  page.should have_css("img[src$='tmp/superbad_5.jpg']")
  page.should have_css("img[src$='tmp/superbad_6.jpg']")
  page.should have_css("img[src$='tmp/superbad_7.jpg']")

  page.should_not have_css("img[src$='tmp/flight.jpg']")
  page.should_not have_css("img[src$='tmp/real_world.jpg']")
end

And /^user can review video$/ do
  @name = current_user.full_name
  @video = Video.first
  visit video_path(@video)
  fill_in "Write Review", with: "This is the most best movie I've ever scene"
  # choose "4 stars" from the select drop down - Not sure how to do this
  click_button "Submit"
end

Then /^user can see video reviews$/ do
  page.text.should match(/User Reviews \(\d*\)/)
  page.text.should match (/Rating: [1-4]\.[0-9] \/ 5/)
  page.should have_content "by #{@name}"
  page.should have_content "This is the most best movie I've ever scene"
end

