Feature: Define image quality

  Scenario: Define compression ratio
    Given an image

    When I ask for it with 75% of compression

    Then I should get it with 75% of compression
