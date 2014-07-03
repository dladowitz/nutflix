Feature: Video Pages
  Users can see videos and metadata

  Scenario: User can see all videos on the home page
    Given multiple videos are created
    And   a user visits the home page
    Then  they can see all the videos in the database

  Scenario: User can see videos split up by category
    Given multiple videos are created
    And   a user visits the home page
    Then  they can see each category section
    And   they can see videos in each category

  Scenario: User can search for videos by title
    Given multiple videos are created
    And   a user visits the home page
    And   they enter a term in the search bar
    Then  they see videos matching their search term

