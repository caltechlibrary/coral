@usage
Feature: Usage Statistics

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

  @browse @reset_usage
  Scenario: Browse Usage Statistics.
    Given I am on "usage"
    Then I should see "Usage Statistics" in the "#main-title-text" element
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    When I wait for 2 seconds
    Then I should see "Sorry, no platforms or publishers fit your query"
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    #
    When I follow "Admin"
    Then I should see "Users"
    Then I should see "Email addresses for logs"
    Then I should see "Outlier Parameters"
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    When I wait for 2 seconds
    Then I should see "coral_admin" in the "#div_User" element
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    #
    When I follow "Report Options"
    Then I should see "Publisher / Platform Reporting Administrative Update" in the ".headerText" element
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    #
    When I follow "SUSHI"
    Then I should see "SUSHI Administration"
    Then I should see "Outstanding Import Queue"
    Then I should see "Last Failed SUSHI Imports"
    Then I should see "All SUSHI Services"
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    #
    When I follow "File Import"
    Then I should see "Usage Statistics Import"
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    When I wait for 2 seconds
    Then I should see "No imports found." in the "#div_recentImports" element
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
