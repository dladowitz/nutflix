#Feature:
#  Background:
#    Given Try out this before block !!!!!!!!!!!!!


Feature: Users
  Users can create accounts and log in

  @javascript
  Scenario: User can log in
    Given user login

#### Probably have to switch off of database transactions. No users in the DB at this point.
  @javascript
  Scenario: User must sign in to see content
    Given an unauthenticated user visits videos path
    And   user login
    Then  they can see content

#### Commented out to speed up debugging. Need to uncomment
# Remember to delete cassettes after failed tests
  
#  @javascript
#  Scenario: A user can sign out
#    Given user login
#    Then  user signout
#
#  @javascript
#  Scenario:  User can choose between a free and premium account
#    Given a user visits the home_path
#    And   they click on the signup link
#    Then  they can choose the free account link
#
#  Scenario: User can create a free account
#    Given a user visits the home_path
#    And   they click on the signup link
#    Then  they can create a free account
#
#  @javascript @vcr
#  Scenario: User can create a paid account
#    Given a user visits the home_path
#    And   they click on the signup link
#    Then  they can create a paid account
#
## Sad Paths :(
#  @javascript @vcr
#  Scenario: User enters incorrect profile info on signup
#    Given a user visits the home_path
#    And   they click on the signup link
#    Then  they get errors on signup with missing user info
#
#  @javascript @vcr
#  Scenario: User enters incorrect credit card info on signup
#    Given a user visits the home_path
#    And   they click on the signup link
#    Then  they get errors on signup with bad card info

