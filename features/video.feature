Feature: Video Pages
  Users can see videos and metadata

  Scenario: User can see all videos on the home page
    Given a video is created
    And a user visits the home page
    Then they can see all the videos in the database

  Scenario: User can see videos split up by category
    Given a video is created
    And a user visits the home page
    Then they can see each category section
    And they can see videos in each category
