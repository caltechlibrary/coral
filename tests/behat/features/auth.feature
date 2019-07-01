@auth
Feature: Authentication

  Background:
    Given I am on "auth"
    Then I should see "eRM Authentication"
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    When I fill in "loginID" with "coral_admin"
    And I fill in "password" with "coral_password"
    And I press "loginbutton"
    Then I should see "Resources"
    Then I should see "Licensing"
    Then I should see "Organizations"
    Then I should see "Usage Statistics"
    Then I should see "Management"
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"

  @admin
  Scenario: Verify that Auth Admin page displays as expected.
    Given I am on "auth"
    Then I should see "You are already logged in as coral_admin."
    When I follow "Admin page"
    Then I should see "coral_admin" in the "#div_users" element
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
