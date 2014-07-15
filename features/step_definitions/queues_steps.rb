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

Then /^they can reorder their queue$/ do

end
