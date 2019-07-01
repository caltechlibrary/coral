@resources
Feature: Resources

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

  @browse @reset_resources
  Scenario: Browse Resources.
    Given I am on "resources"
    Then I should see "Resources" in the "#main-title-text" element
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    When I wait for 2 seconds
    Then I should see "Sorry, no requests fit your query"
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    #
    When I follow "Admin"
    Then I should see "Administration" in the ".headerText" element
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    When I wait for 2 seconds
    Then I should see "coral_admin" in the "#div_AdminContent" element
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    #
    When I follow "File Import"
    Then I should see "Delimited File Import" in the "h1" element
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    #
    When I follow "Imports history"
    Then I should see "Import history" in the "h2" element
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    #
    When I follow "My Queue"
    Then I should see "My Queue" in the ".headerText" element
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    When I wait for 2 seconds
    Then I should see "No outstanding requests" in the "#div_QueueContent" element
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    #
    When I follow "New Resource"
    And I wait for 2 seconds
    Then I should see "Add New Resource" in the ".formTitle" element
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"

  @add
  Scenario: Add Resources.
    Given I am on "resources"
    And I wait for 2 seconds
    #
    When I follow "New Resource"
    And I wait for 2 seconds
    When I fill in "titleText" with "BEST RESOURCE EVER"
    When I press "submit"
    And I wait until I see "#span_resourceName" element
    Then I should see "BEST RESOURCE EVER"
