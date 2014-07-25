require "spec_helper"

feature "User signs in" do
  scenario "with username and password" do
    user = users(:james_bond)
    signin_user user

    URI.parse(current_url).path.should == videos_path
    page.should have_content "Successfully logged in"
  end
end

