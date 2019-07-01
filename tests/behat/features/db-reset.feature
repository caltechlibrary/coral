@reset
Feature: Reset Databases

  Background:
    Given I am on the homepage
    When I follow "Resources"
    Then I should see "eRM Authentication"
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    When I fill in "loginID" with "coral_admin"
    And I fill in "password" with "coral_password"
    And I press "loginbutton"
    Then I should see "Resources" in the "#main-title-text" element
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"

  @reset_resources
  Scenario: Verify that the Resources database is empty.
    Given I am on "resources"
    Then I should see "Resources" in the "#main-title-text" element
    When I wait for 2 seconds
    Then I should see "Sorry, no requests fit your query"
