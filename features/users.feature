Feature: Users
  Users can create accounts and log in

  Scenario: User can create an account
    Given a user visits the home_path
    And   they click on the signup link
    Then  they can create an account

  Scenario: User can log in
    Given a user visits the home_path
    Then  they see a signin link
