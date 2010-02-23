# -*- encoding: utf-8 -*-
Feature: Image name

  Scenario: I can give any name for image url
    When I upload an image
    And I ask for it with the name "any_name"
    And I ask for it with the name "42"
    Then all of them should be the same

