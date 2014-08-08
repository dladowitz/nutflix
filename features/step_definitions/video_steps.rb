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
  page.should have_css(".action img[src$='tmp/iron_man_2.jpg']")
  page.should have_css(".action img[src$='tmp/iron_man_3.jpg']")
  page.should have_css(".action img[src$='tmp/iron_man_4.jpg']")
  page.should have_css(".action img[src$='tmp/iron_man_5.jpg']")
  page.should have_css(".action img[src$='tmp/iron_man_6.jpg']")
  page.should have_css(".action img[src$='tmp/iron_man_7.jpg']")

  page.should_not have_css(".comedy img[src$='tmp/iron_man.jpg']")

  page.should have_css(".drama img[src$='tmp/flight.jpg']")
  page.should have_css(".scifi img[src$='tmp/star_trek.jpg']")

end

And /^they enter a term in the search bar$/ do
  fill_in "Search for videos here", with: "Thor"
  click_button "search"
end

Then /^they see videos matching their search term$/ do
  uri = URI.parse(current_url)
  uri.path.should == search_videos_path

  page.should have_css("img[src$='tmp/thor.jpg']")
  page.should have_css("img[src$='tmp/thor_2.jpg']")

  page.should_not have_css("img[src$='tmp/flight.jpg']")
end

And /^a user clicks on a category link$/ do
  click_link "Action"
end

Then /^they should see only videos from that category$/ do
  page.should have_css("img[src$='tmp/iron_man.jpg']")
  page.should have_css("img[src$='tmp/iron_man_2.jpg']")
  page.should have_css("img[src$='tmp/iron_man_3.jpg']")
  page.should have_css("img[src$='tmp/iron_man_4.jpg']")
  page.should have_css("img[src$='tmp/iron_man_5.jpg']")
  page.should have_css("img[src$='tmp/iron_man_6.jpg']")
  page.should have_css("img[src$='tmp/iron_man_7.jpg']")

  page.should_not have_css("img[src$='tmp/flight.jpg']")
  page.should_not have_css("img[src$='tmp/star_trek.jpg']")
end

And /^user can review a video$/ do
  user     = users(:james_bond)
  iron_man = videos(:iron_man)

  visit video_path(iron_man)
  fill_in "review_text", with: "This is the most best movie I've ever scene"
  # choose "4 stars" from the select drop down - Not sure how to do this
  click_button "Submit"
  URI.parse(current_url).path.should == video_path(iron_man)
end

Then /^user can see video reviews$/ do
  user = users(:james_bond)
  page.text.should match (/Average Rating: [1-5]\.[0-9]\b/)
  page.text.should match(/User Reviews \(\d*\)/)
  page.text.should match (/Rating: [1-5] \/ 5/)
  page.should have_content "by #{user.full_name}"
  page.should have_content "This is the most best movie I've ever scene"
end

Then  /^non-admin cannot add videos$/ do
  visit admin_video_path
  expect(page).to have_content "Permission Denied"
end

Then /^admin can add videos$/ do
  visit admin_video_path
  expect(page).to have_content "Add a New Video"
  fill_in "Title", with: "Dawn of Planet of the Apes"
  fill_in "Description", with: "Mokeys and guns"
  click_button "Add Video"

  expect(page).to have_content "Dawn of Planet of the Apes"

  #### TODO need to find capybara test to choose a file
end


