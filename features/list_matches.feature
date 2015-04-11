Feature: Listing matches
  As a Globo Esporte user
  I want to see all matches
  So I can choose which match I will see the details

Scenario: Choose one match
  Given I am on list matches screen
  When I touch list item number 1
  Then I wait to see "Cruzeiro x Fluminense"

Scenario: Show filters modal
  Given I am on list matches screen
  When I touch button number 1
  Then I wait to see "Times"


