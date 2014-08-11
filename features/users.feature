Feature: Users
  Users can create accounts and log in

  Scenario:  User can choose between a free and premium account
    Given a user visits the home_path
    And   they click on the signup link
    Then  they can choose the free account link

  Scenario: User can create a free account
    Given a user visits the home_path
    And   they click on the signup link
    Then  they can create a free account

  Scenario: User can create a paid account
    Given a user visits the home_path
    And   they click on the signup link
    Then  they can create a paid account

  Scenario: User can log in
    Given user login

  Scenario: User must sign in to see content
    Given an unauthenticated user visits videos path
    And   user login
    Then  they can see content

  Scenario: A user can sign out
    Given user login
    Then  user signout



