Then /^they can see their queue$/ do
  user = users(:james_bond)

  visit queue_path

  page.should have_content user.queue_items.first.video.title
  page.should have_content user.queue_items.second.video.title

  page.should have_selector 'td input[type$="text"]', :count => 2
  page.should have_selector 'td input.form-control[value$="1"]'
  page.should have_selector 'td input.form-control[value$="2"]'

  ## need to find a way to check the order on the page ##
end

Then /^they can add a video to their queue$/ do
  video = videos(:star_trek)
  visit video_path(video)
  click_button "My Queue"

  URI.parse(current_url).path.should == queue_path
  page.should have_content video.title
  page.should have_selector 'td input[type$="text"]', :count => 3
end

And /^they can remove a video from their queue$/ do
  # video = videos(:star_trek)
  # visit queue_path

  ## Can't figure out how to get capybara to click on the remove (x) button
  # click_link "Remove #{video.title}"
end

Then /^they can reorder their queue$/ do

end
