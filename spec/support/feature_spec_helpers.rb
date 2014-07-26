def signin_user(given_user = nil)
  user = given_user || users(:james_bond)

  visit signin_path
  fill_in "Email Address", with: user.email_address
  fill_in "Password", with: "asdfasdf"
  click_button "Sign In"
end
