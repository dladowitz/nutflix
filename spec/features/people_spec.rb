require "spec_helper"

feature "Followers" do
  scenario "User can follow people" do
    signin_user

    dr_evil = User.find_by_full_name "Dr Evil"

    follow dr_evil

    click_link "People"
    url_should_be people_path

    page.should have_content "Videos in Queue"
    page.should have_content "Followers"
    page.should have_content "Unfollow"

    expect_to_be_following(dr_evil)

    unfollow(dr_evil)
  end

  def follow(user)
    visit user_path(user)
    click_button "Follow"
    page.should have_content "You're now stalking #{user.full_name}"
  end

  def expect_to_be_following(user)
    video_count    = user.queue_items.count
    follower_count = user.followers.count

    expect(find(:xpath, "//a[text()='#{user.full_name}']"))
    page.should     have_content /#{user.full_name}.*#{video_count}.*#{follower_count}/
  end

  def unfollow(user)
    click_link("delete-#{user.full_name}")
    page.should_not have_content user.full_name
  end
end


