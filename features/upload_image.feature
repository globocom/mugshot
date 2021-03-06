Feature: Upload Image

  Scenario: Filesystem storage
    Given an FSStorage

    When I upload an image
    And I ask for it

    Then I should get it

  Scenario: HTTP storage
    Given an HTTPStorage

    When I upload an image

    Then I should get a 405 response

  Scenario: Image wasn't uploaded
    When I ask for an image that doesn't exist

    Then I should get a 404 response
