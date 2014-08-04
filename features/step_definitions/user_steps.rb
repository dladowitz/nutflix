Given /^user login$/ do
  user = users(:james_bond)
  visit signin_path

  fill_in "Email Address", with: user.email_address
  fill_in "Password",      with: "asdfasdf"
  click_button "Sign In"

  URI.parse(current_url).path.should == videos_path
  page.should have_content "Successfully logged in"
end

Given /^admin user login$/ do
  admin = users(:admin)
  visit signin_path

  fill_in "Email Address", with: admin.email_address
  fill_in "Password",      with: "asdfasdf"
  click_button "Sign In"

  URI.parse(current_url).path.should == videos_path
  page.should have_content "Successfully logged in"
end

Then /^user signout$/ do
  visit home_path
  click_on "Sign Out"
  page.should_not have_content "Welcome"
  page.should_not have_content "Videos"
  page.should have_content "You have logged out"
end

Given /^a user visits the home_path$/ do
  visit home_path
end

And /^they click on the signup link$/ do
  click_link "Sign Up Now!"
end

Then /^they can create an account$/ do
  uri = URI.parse(current_url)
  uri.path.should == register_path

  fill_in "user_email_address",   with: "tony@stark_labs.com"
  fill_in "user_password",        with: "the_mandarin"
  fill_in "user_full_name",       with: "Tony Stark"
  click_button "Sign Up"

  uri = URI.parse(current_url)
  uri.path.should == signin_path
  page.should have_content "You have successfully created an account"

end

And /^they click on the signin link$/ do
  click_link "Sign In"
end

Given /^an unauthenticated user visits videos path$/ do
  visit videos_path
  user = users(:james_bond)

  page.should_not have_content user.full_name
  page.should_not have_content "Videos"
end

Then /^they can see content$/ do
  user = users(:james_bond)

  page.should have_content user.full_name
  page.should have_content "Videos"
end

