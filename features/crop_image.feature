Feature: Crop image

  Scenario: Crop image with known aspect ratio
    When I upload an image

    And I ask for the 256x256 image cropped to 140x105

    Then I should get the 256x256 image cropped to 140x105
