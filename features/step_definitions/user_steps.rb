Given /^a user account is in the db$/ do
  visit home_path
  click_link "Sign Up Now!"

  uri = URI.parse(current_url)
  uri.path.should == register_path

  fill_in "user_email_address",   with: "tony@stark_labs.com"
  fill_in "user_password",        with: "the_mandarin"
  fill_in "user_full_name",       with: "Tony Stark"
  click_button "Sign Up"

  uri = URI.parse(current_url)
  uri.path.should == signin_path
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
  # page.should have_content("You have successfully created an account")

end

And /^they click on the signin link$/ do
  click_link "Sign In"
end

And /^they log in$/ do
  uri = URI.parse(current_url)
  uri.path.should == signin_path

  fill_in "Email Address", with: "tony@stark_labs.com"
  fill_in "Password",      with: "the_mandarin"
  click_button "Sign In"

  uri = URI.parse(current_url)
  uri.path.should == videos_path
end
