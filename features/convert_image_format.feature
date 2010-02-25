Feature: Convert Image Format

  Scenario: Convert image to gif
    Given an image

    When I ask for it with format gif

    Then I should get it with format gif

  Scenario: Convert image to jpg
    Given an image

    When I ask for it with format jpg

    Then I should get it with format jpg

  Scenario: Convert image to png
    Given an image

    When I ask for it with format png

    Then I should get it with format png
