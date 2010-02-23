Feature: Image name

  Scenario: I can give any name for image url
    When I upload an image
    Then I should get the same image no matter what name I use to get it

