require "spec_helper"

feature "Password Reset" do
  scenario "User can reset their password via email" do
    user = User.first
    request_password_reset_email(user)
    reset_password
  end

  def request_password_reset_email(user)
    visit signin_path
    click_link "Reset Password"

    url_should_be password_reset_request_path

    page.should have_content "Forgot Password?"
    fill_in "email_address", with: user.email_address
    click_button "Send Email"

    page.should have_content "Word, we are sending you a reset link now"
  end

  def reset_password
    # hmmm, not sure how to find the email and click on the link
  end
end
