Feature: Set Background

  Scenario: Set background for a png image with alpha channel
    Given a png image with alpha channel
    When I ask for it with a red background
    Then I should get it with a red background
    