require "spec_helper"

feature "Password Reset" do
  background do
    clear_emails
  end


  scenario "User can reset their password via email" do
    user = User.first
    request_password_reset_email(user)
    reset_password(user)
  end

  def request_password_reset_email(user)
    visit signin_path
    click_link "Reset Password"

    url_should_be password_reset_request_path

    page.should have_content "Forgot Password?"
    fill_in "email_address", with: user.email_address
    click_button "Send Email"

    page.should have_content "Word, we are sending you a reset link now"
    open_email(user.email_address)

    first_name = user.full_name.split(" ").first
    expect(current_email).to have_content "So #{first_name}, you forgot your password did you?"
    current_email.click_link "Take me to the reset password place"
    expect(page).to have_content "Reset Your Password"

    fill_in "password_reset_new_password", with: "12345678"
    click_button "Reset Password"

    expect(page).to have_content "You're password was reset. Maybe don't forget it again."

    click_link "Sign In"

    fill_in "email_address", with: user.email_address
    fill_in "passeord", with: "12345678"

    click_button "Sign In"

    expect(page).to have_content "Successfully logged in"
  end

  def reset_password(user)

  end
end
