@organizations
Feature: Organizations

  Background:
    Given I am on the homepage
    When I follow "Organizations"
    Then I should see "eRM Authentication"
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    When I fill in "loginID" with "coral_admin"
    And I fill in "password" with "coral_password"
    And I press "loginbutton"
    Then I should see "Organizations" in the "#main-title-text" element
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"

  @browse @reset_organizations
  Scenario: Browse Organizations.
    Given I am on "organizations"
    Then I should see "Organizations" in the "#main-title-text" element
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    When I wait for 2 seconds
    Then I should see "Displaying 1 to 25 of 465 Organization Records"
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    #
    When I follow "Admin"
    Then I should see "Users"
    Then I should see "Organization Role"
    Then I should see "Contact Role"
    Then I should see "Alias Type"
    Then I should see "External Login Type"
    Then I should see "Issue Type"
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    When I wait for 2 seconds
    Then I should see "coral_admin" in the "#div_User" element
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    #
    When I follow "New Organization"
    And I wait for 2 seconds
    Then I should see "Add New Organization" in the "#org-title .headerText" element
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"

  @add
  Scenario: Add Organization.
    Given I am on "organizations"
    And I wait for 2 seconds
    #
    When I follow "New Organization"
    And I wait for 2 seconds
    When I fill in "organizationName" with "BEST ORGANIZATION EVER"
    When I press "submit"
    And I wait until I see "#span_orgName" element
    Then I should see "BEST ORGANIZATION EVER"
