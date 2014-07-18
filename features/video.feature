Feature: Video Pages
  Users can see videos and metadata

  Scenario: User can see all videos on the home page
    Given a user visits the videos_path
    And   user login
    Then  they can see videos in the database

  Scenario: User can see videos split up by category
    Given user login
    And   a user visits the videos_path
    Then  they can see each category section
    And   they can see the six most recent videos in each category

  Scenario: User can search for videos by title
    Given user login
    And   a user visits the videos_path
    And   they enter a term in the search bar
    Then  they see videos matching their search term

  Scenario: User can choose to see videos in only one category
    Given user login
    And   a user visits the videos_path
    And   a user clicks on a category link
    Then  they should see only videos from that category

  Scenario: User can write and read reviews of videos
    Given user login
    And   user can review a video
    Then  user can see video reviews

