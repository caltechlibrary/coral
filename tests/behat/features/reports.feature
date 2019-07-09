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
    #
    When I go to "reports"
    When I select "Usage Statistics - Provider Rollup" from "reportID"
    And I press "Submit"
    Then I should see "Usage Statistics - Provider Rollup"
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    #
    When I go to "reports"
    When I select "Usage Statistics - Publisher Rollup" from "reportID"
    And I press "Submit"
    Then I should see "Usage Statistics - Publisher Rollup"
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    #
    When I go to "reports"
    When I select "Usage Statistics - Top Resource Requests" from "reportID"
    And I press "Submit"
    Then I should see "Usage Statistics - Top Resource Requests"
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    #
    When I go to "reports"
    When I select "Usage Statistics - Yearly Usage Statistics" from "reportID"
    And I press "Submit"
    Then I should see "Usage Statistics - Yearly Usage Statistics"
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    #
    When I go to "reports"
    When I select "Usage Statistics by Provider / Publisher" from "reportID"
    And I press "Submit"
    Then I should see "Usage Statistics by Provider / Publisher"
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    #
    When I go to "reports"
    When I select "Usage Statistics by Titles" from "reportID"
    And I press "Submit"
    Then I should see "Usage Statistics by Titles"
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
