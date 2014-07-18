Feature: Users
  Users can create accounts and log in

  Scenario: User can create an account
    Given a user visits the home_path
    And   they click on the signup link
    Then  they can create an account

  Scenario: User can log in
    Given user login

  Scenario: User must sign in to see content
    Given an unauthenticated user visits videos path
    And   user login
    Then  they can see content

  Scenario: A user can sign out
    Given user login
    Then  user signout



