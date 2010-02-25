Feature: Crop image

  Scenario: Crop image
    Given an image
    
    When I ask for it cropped to 300x200

    Then I should get it cropped to 300x200
