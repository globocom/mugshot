Feature: Image Format

  Scenario: Image as gif
    When I upload an image
    And I ask for a gif image
    Then I should get a gif image

  Scenario: Image as jpg
    When I upload an image
    And I ask for a jpg image
    Then I should get a jpg image
