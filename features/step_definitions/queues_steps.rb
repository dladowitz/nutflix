Then /^they can see their queue$/ do
  user = users(:james_bond)

  visit queue_path

  # checks to make sure the queue items appear in the correct order
  page.should     have_content /#{user.queue_items.first.video.title}.*#{user.queue_items.second.video.title}.*#{user.queue_items.third.video.title}/
  page.should_not have_content /#{user.queue_items.second.video.title}.*#{user.queue_items.first.video.title}.*#{user.queue_items.third.video.title}/

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
  visit queue_path
  click_link "remove-3"
end

Then /^they can reorder their queue$/ do
  fill_in "rank: 1", with: "2"
  fill_in "rank: 2", with: "1"

  click_button "Update Instant Queue"

  URI.parse(current_url).path.should == queue_path

  user = users(:james_bond)
  page.should     have_content /#{user.queue_items.second.video.title}.*#{user.queue_items.first.video.title}/
  page.should_not have_content /#{user.queue_items.first.video.title}.*#{user.queue_items.second.video.title}/
end
