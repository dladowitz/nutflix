Then /^they can see their queue$/ do
  user = users(:james_bond)

  visit queue_path

  # checks to make sure the queue items appear in the correct order
  page.should     have_content /Iron Man.*Thor.*Iron Man 2/
  page.should_not have_content /Thor.*Iron Man.*Iron Man 2/

  # checks for 4 items iin the queue
  page.should have_selector 'td input[type$="text"]', :count => 4
  page.should have_selector 'td input.form-control[value$="1"]'
  page.should have_selector 'td input.form-control[value$="2"]'
  page.should have_selector 'td input.form-control[value$="3"]'
  page.should have_selector 'td input.form-control[value$="4"]'
end

Then /^they can add a video to their queue$/ do
  @video = videos(:star_trek)
  visit video_path(@video)
  click_link "+ My Queue"

  URI.parse(current_url).path.should == queue_path
  page.should have_content @video.title
  page.should have_selector 'td input[type$="text"]', :count => 5
end

And /^they can remove a video from their queue$/ do

  page.should have_content /Iron Man 2/
  visit queue_path
  click_link "remove-3"
  page.should_not have_content /Iron Man 2/
  page.should     have_content /Iron Man.*Thor.*Iron Man 3/
end

Then /^they can reorder their queue$/ do
  fill_in "rank: 1", with: "2"
  fill_in "rank: 2", with: "1"

  click_button "Update Instant Queue"

  URI.parse(current_url).path.should == queue_path

  user = users(:james_bond)
  page.should     have_content /Thor.*Iron Man/
  page.should_not have_content /Iron Man.*Thor/
end

Then /they can see their review of a video/ do
  page.should have_select("rating-1", :options => ["none", "1 Star", "2 Stars", "3 Stars", "4 Stars", "5 Stars"], selected: "none")
  page.should have_select("rating-2", :options => ["none", "1 Star", "2 Stars", "3 Stars", "4 Stars", "5 Stars"], selected: "5 Stars")
  page.should have_select("rating-3", :options => ["none", "1 Star", "2 Stars", "3 Stars", "4 Stars", "5 Stars"], selected: "none")
  page.should have_select("rating-4", :options => ["none", "1 Star", "2 Stars", "3 Stars", "4 Stars", "5 Stars"], selected: "none")
end

And /they can change their review of a video/ do

  select("4 Stars", :from => "rating-1")
  URI.parse(current_url).path.should == queue_path

  page.should have_select("rating-1", :options => ["none", "1 Star", "2 Stars", "3 Stars", "4 Stars", "5 Stars"], selected: "4 Stars") # This is what we want

  video = Video.find_by_title "Thor"
  user = users(:james_bond)
  review = Review.where(video: video, user: user).last
  review.rating.should eq 4
end
