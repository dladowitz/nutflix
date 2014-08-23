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

Then /^they can create a free account$/ do
  uri = URI.parse(current_url)
  uri.path.should == register_path

  within("#free") do
    fill_in "user_email_address",   with: "pepper@starklabs.com"
    fill_in "user_password",        with: "the_mandarin"
    fill_in "user_full_name",       with: "Tony Stark"
    click_button "Sign Up for Free Account"
  end

  uri = URI.parse(current_url)
  uri.path.should == signin_path
  page.should have_content "You have successfully created an account"
end

Then /^they can create a paid account$/ do
  uri = URI.parse(current_url)
  uri.path.should == register_path

  within("#premium") do
    fill_in "user_email_address", with: "pepper@starklabs.com"
    fill_in "user_password",      with: "beach house"
    fill_in "user_full_name",     with: "Pepper Potts"
    fill_in "card-number",        with: "4242 4242 4242 4242"
    fill_in "security-code",      with: "123"
    select "January",             from: "expiry-month"
    select "2017",                from: "expiry-year"
    click_button "Sign Up for Premium Account"
  end

  uri = URI.parse(current_url)
  uri.path.should == signin_path
  page.should have_content "You have successfully created an account"
end


Then /^they get errors on signup with missing user info$/ do
  uri = URI.parse(current_url)
  uri.path.should == register_path

  within("#premium") do
    fill_in "user_email_address", with: ""
    fill_in "user_password",      with: "beach house"
    fill_in "user_full_name",     with: "Pepper Potts"
    fill_in "card-number",        with: "4242 4242 4242 4242"
    fill_in "security-code",      with: "123"
    select "January",             from: "expiry-month"
    select "2017",                from: "expiry-year"
    click_button "Sign Up for Premium Account"
  end

  expect(page).to have_content "Missing Personal Info"
  expect(page).to have_content "can't be blank"

  within("#premium") do
    fill_in "user_email_address", with: "pepper@starklabs.com"
    fill_in "user_password",      with: ""
    fill_in "user_full_name",     with: "Pepper Potts"
    fill_in "card-number",        with: "4242 4242 4242 4242"
    fill_in "security-code",      with: "123"
    select "January",             from: "expiry-month"
    select "2017",                from: "expiry-year"
    click_button "Sign Up for Premium Account"
  end

  expect(page).to have_content "Missing Personal Info"
  expect(page).to have_content "can't be blank"

  within("#premium") do
    fill_in "user_email_address", with: "pepper@starklabs.com"
    fill_in "user_password",      with: "beach house"
    fill_in "user_full_name",     with: ""
    fill_in "card-number",        with: "4242 4242 4242 4242"
    fill_in "security-code",      with: "123"
    select "January",             from: "expiry-month"
    select "2017",                from: "expiry-year"
    click_button "Sign Up for Premium Account"
  end

  expect(page).to have_content "Missing Personal Info"
  expect(page).to have_content "can't be blank"
end

Then /^they get errors on signup with bad card info$/ do
  uri = URI.parse(current_url)
  uri.path.should == register_path
  within("#premium") do
    fill_in "user_email_address", with: "pepper@starklabs.com"
    fill_in "user_password",      with: "beach house"
    fill_in "user_full_name",     with: "Pepper Potts"
    fill_in "card-number",        with: "4000000000000119"
    fill_in "security-code",      with: "123"
    select "January",             from: "expiry-month"
    select "2017",                from: "expiry-year"
    click_button "Sign Up for Premium Account"
  end
  expect(page).to have_content "An error occurred while processing your card."

  within("#premium") do
    fill_in "user_email_address", with: "pepper@starklabs.com"
    fill_in "user_password",      with: "beach house"
    fill_in "user_full_name",     with: "Pepper Potts"
    fill_in "card-number",        with: "4000000000000002"
    fill_in "security-code",      with: "123"
    select "January",             from: "expiry-month"
    select "2017",                from: "expiry-year"
    click_button "Sign Up for Premium Account"
  end
  expect(page).to have_content "Your card was declined."

  within("#premium") do
    fill_in "user_email_address", with: "pepper@starklabs.com"
    fill_in "user_password",      with: "beach house"
    fill_in "user_full_name",     with: "Pepper Potts"
    fill_in "card-number",        with: "4242 4242 4242 4242"
    fill_in "security-code",      with: "123"
    select "January",             from: "expiry-month"
    select "2013",                from: "expiry-year"
    click_button "Sign Up for Premium Account"
  end
  expect(page).to have_content "Your card's expiration year is invalid."

  within("#premium") do
    fill_in "user_email_address", with: "pepper@starklabs.com"
    fill_in "user_password",      with: "beach house"
    fill_in "user_full_name",     with: "Pepper Potts"
    fill_in "card-number",        with: "4242 4242 4242 4242"
    fill_in "security-code",      with: ""
    select "January",             from: "expiry-month"
    select "2017",                from: "expiry-year"
    click_button "Sign Up for Premium Account"
  end

  expect(page).to have_content "Your card's security code is invalid."
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

Then /^they can choose the free account link$/ do
  # This test isn't really checking anything. Always passes as long as element are in the html
  find("#signup-free-subscription").visible?
  find("#signup-free-subscription").click
  find("#signup-premium-subscription").visible?
  find("#signup-premium-subscription").click
end

