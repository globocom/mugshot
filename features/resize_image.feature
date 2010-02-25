Feature: Resize image

  Scenario: Resize image
    Given an image

    When I ask for it resized to 200x200

    Then I should get it resized to 200x200

  Scenario: Resize image giving only width
    Given an image

    When I ask for it resized to 200x

    Then I should get it resized to 200x

  Scenario: Resized image giving only height
    Given an image

    When I ask for it resized to x200

    Then I should get it resized to x200
