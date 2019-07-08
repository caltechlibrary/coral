@reset
Feature: Reset Databases

  Background:
    Given I am on "auth"
    Then I should see "eRM Authentication"
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    When I fill in "loginID" with "coral_admin"
    And I fill in "password" with "coral_password"
    And I press "loginbutton"
    Then I should see "eRM • eResource Management" in the ".title-main" element
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"

  @reset_licensing
  Scenario: Verify that the Licensing database is empty.
    Given I am on "licensing"
    Then I should see "Licensing" in the "#main-title-text" element
    When I wait for 2 seconds
    Then I should see "Sorry, no licenses fit your query"

  @reset_management
  Scenario: Verify that the Management database is empty.
    Given I am on "management"
    Then I should see "Management" in the "#main-title-text" element
    When I wait for 2 seconds
    Then I should see "Sorry, no documents fit your query"

  @reset_organizations
  Scenario: Verify that the Organizations database is empty.
    Given I am on "organizations"
    Then I should see "Organizations" in the "#main-title-text" element
    When I wait for 2 seconds
    Then I should see "Displaying 1 to 25 of 465 Organization Records"

  @reset_reports
  Scenario: Verify that the Usage Reports database is empty.
    Given I am on "reports"
    Then I should see "Usage Reports" in the "#main-title-text" element
    Then I should see "Select Report"

  @reset_resources
  Scenario: Verify that the Resources database is empty.
    Given I am on "resources"
    Then I should see "Resources" in the "#main-title-text" element
    When I wait for 2 seconds
    Then I should see "Sorry, no requests fit your query"

  @reset_usage
  Scenario: Verify that the Usage Statistics database is empty.
    Given I am on "usage"
    Then I should see "Usage Statistics" in the "#main-title-text" element
    When I wait for 2 seconds
    Then I should see "Sorry, no platforms or publishers fit your query"
