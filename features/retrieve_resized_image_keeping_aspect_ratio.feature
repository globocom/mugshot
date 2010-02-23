Feature: Retrieve resized image keeping aspect ratio

  Scenario: Successful retrieval of resized image from given width
    When I upload an image
    And I ask for the 200x resized image

    Then I should get the 200x resized image keeping the aspect ratio

  Scenario: Successful retrieval of resized image from given height
    When I upload an image
    And I ask for the x200 resized image

    Then I should get the x200 resized image keeping the aspect ratio

  Scenario: Image doesn't exist
    When I ask for a 200x resized image that doesn't exist

    Then I should get a 404 response

    When I ask for a x200 resized image that doesn't exist

    Then I should get a 404 response
