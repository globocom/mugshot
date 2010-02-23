Feature: Image Quality

  Scenario: Define the compression ratio
    When I upload an image
    And I ask for an image with 75% of compression
    Then I should get a image with 75% of compression
