Feature: Retrieve resized image

  Scenario: Successful retrieval of resized image
    When I upload an image
    And I ask for the 200x200 resized image
    Then I should get the 200x200 resized image

  Scenario: Image doesn't exist
    When I ask for a 200x200 resized image that doesn't exist
    Then I should get a 404 response
