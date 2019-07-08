@reports
Feature: Usage Reports

  Background:
    Given I am on the homepage
    When I follow "Usage Statistics"
    Then I should see "eRM Authentication"
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    When I fill in "loginID" with "coral_admin"
    And I fill in "password" with "coral_password"
    And I press "loginbutton"
    Then I should see "Usage Statistics" in the "#main-title-text" element
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"

  @browse @reset_reports
  Scenario: Browse Usage Reports.
    Given I am on "reports"
    Then I should see "Usage Reports" in the "#main-title-text" element
    Then I should see "Select Report"
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
