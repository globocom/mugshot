Feature: Retrieve image with any name

  Scenario: Retrieve image with any name
    Given an image

    When I ask for it with the name "any_name"
    And I ask for it with the name "42"

    Then all of them should be the same
