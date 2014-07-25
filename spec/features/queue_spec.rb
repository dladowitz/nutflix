require "spec_helper"

feature "User can manage a queue" do
  scenario "User adds videos and reorders a queue" do
    signin_user

    video = (Video.search_by_title "Iron Man 7").first
    find("a[href='/videos/#{video.id}']").click
    page.should have_content "Iron Man 7"
    click_link "+ My Queue"

    page.should have_content "My Queue"
    page.should have_content "Iron Man 7"

    click_link "Iron Man 7"
    page.should have_content "Iron Man 7"

    click_link "+ My Queue"
    page.should have_content "Chill, this video is already in your queue"

    click_link "My Queue"
    page.should have_content "My Queue"

    expect_video_position("Thor", 2)
    expect_video_position("Iron Man 3", 4)

    set_video_position("Thor", 1)
    set_video_position("Iron Man 3", 2)

    click_button "Update Instant Queue"

    expect_video_position("Thor", 1)
    expect_video_position("Iron Man 3", 2)
  end

  def expect_video_position(video_title, position)
    expect(find(:xpath, "//tr[contains(.,'#{video_title}')]//input[@type='text']").value).to eq "#{position}"
  end

  def set_video_position(video_title, position)
    within(:xpath, "//tr[contains(.,'#{video_title}')]") do
      fill_in "queue_items[][queue_rank]", with: position
    end
  end
end

