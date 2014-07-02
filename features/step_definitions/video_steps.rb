Given /^a video is created$/ do
  Category.create(name: "Comedy")
  Category.create(name: "Drama")
  Category.create(name: "Reality")

  Video.create(title: "Superbad",   category_id: 1)
  Video.create(title: "Flight",     category_id: 2)
  Video.create(title: "Real World", category_id: 3)


end

And /^a user visits the home page$/ do
  visit home_path
end

Then /^they can see all the videos in the database$/ do
  page.should have_selector("img")
end

Then /^they can see each category section$/ do
  page.should have_content("Comedies")
  page.should have_content("Dramas")
  page.should have_content("Reality")
end

And /^they can see videos in each category$/ do
  page.should have_css(".comedies .video img")
  page.should have_css(".dramas .video img")
  page.should have_css(".realities .video img")
end
