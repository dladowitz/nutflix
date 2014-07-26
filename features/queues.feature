Feature: Queues
  Users can view and edit their video queues

  Scenario: User can view their Queue
    Given user login
    Then  they can see their queue

  Scenario: User can manage their queue
    Given user login
    Then  they can add a video to their queue
    And   they can remove a video from their queue
    And   they can reorder their queue
    Then  they can see their review of a video
    And   they can change their review of a video

