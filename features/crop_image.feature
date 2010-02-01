Feature: Crop image

  Scenario: Crop image with known aspect ratio
    When I upload an image

    And I ask for the 300x300 image cropped to 300x200

    Then I should get the 300x300 image cropped to 300x200
