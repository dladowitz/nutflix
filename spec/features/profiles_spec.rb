require "spec_helper"

feature "I can view another users profile" do        #both feature and scenario descriptions seem too similar
  scenario "I can see info about another user" do
    signin_user
    dr_evil = User.find_by_full_name "Dr Evil"
    visit video_path(Video.first)

    page.should have_content "Iron Man"
    click_link dr_evil.full_name

    url_should_be user_path dr_evil

    page.should have_content "Video Title"
    page.should have_content "Genre"

    queue_items = dr_evil.queue_items
    reviews = dr_evil.reviews

    page.should have_content "#{dr_evil.full_name}'s video collections (#{queue_items.count})"
    page.should have_css("table#queue_items tr.queue_item", :count=>queue_items.count)
    page.should have_content "#{dr_evil.full_name}'s Reviews (#{reviews.count}"
    page.should have_content reviews.first.text
  end
end
