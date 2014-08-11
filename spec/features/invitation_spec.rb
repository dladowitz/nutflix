require "spec_helper"

feature "Invitations" do
  background do
    clear_emails
  end
  scenario "User can invite a friend via email" do
    user = User.first
    signin_user user

    send_invite
    follow_email_link
    register
    verify_relationship
  end

  def send_invite
    visit invite_path
    fill_in "name",  with: "Mini Me"
    fill_in "email_address", with: "mini@me.com"
    fill_in "message",       with: "Join me, and together we can rule the galaxy as father and son"
    click_button "Send Invitation"
    signout_user
  end

  def follow_email_link
    open_email("mini@me.com")
    expect(current_email).to have_content "Mini"
    expect(current_email).to have_content "Join me, and together we can rule the galaxy as father and son"
    current_email.click_link "Do it, Do it now"
    expect(page).to have_content "Register"
  end

  def register
    within("#free") do
      find_field("user_email_address").value.should eq "mini@me.com"
      fill_in "user_password",   with: "asdfasdf"
      fill_in "user_full_name",  with: "Mini Me"

      click_button "Sign Up for Free Account"
    end
    expect(page).to have_content "You have successfully created an account"

    #### Not sure why user is not logged in at this point
    fill_in "email_address", with: "mini@me.com"
    fill_in "password",      with: "asdfasdf"
    click_button "Sign In"
  end

  def verify_relationship
    click_link "People"
    expect(page).to have_content "James Bond"

    signout_user

    user = User.find_by_email_address "james@007.com"
    signin_user user
    visit people_path
    expect(page).to have_content "Mini Me"
  end
end
