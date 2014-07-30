def signin_user(given_user = nil)
  user = given_user || users(:james_bond)

  visit signin_path
  fill_in "Email Address", with: user.email_address
  fill_in "Password", with: "asdfasdf"
  click_button "Sign In"
end

def signout_user
  click_link "Sign Out"
end

def url_should_be(path)
  URI.parse(current_url).path.should == path
end

def click_on_video_on_videos_page(video)
  find("a[href='/videos/#{video.id}']").click
end
