@licensing
Feature: Licensing

  Background:
    Given I am on the homepage
    When I follow "Licensing"
    Then I should see "eRM Authentication"
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    When I fill in "loginID" with "coral_admin"
    And I fill in "password" with "coral_password"
    And I press "loginbutton"
    Then I should see "Licensing" in the "#main-title-text" element
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"

  @browse @reset_licensing
  Scenario: Browse Licenses.
    Given I am on "licensing"
    Then I should see "Licensing" in the "#main-title-text" element
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    When I wait for 2 seconds
    Then I should see "Sorry, no licenses fit your query"
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    #
    When I follow "Admin"
    Then I should see "Users"
    Then I should see "Document Types"
    Then I should see "Expression Types"
    Then I should see "Qualifiers"
    Then I should see "Signature Types"
    Then I should see "License Statuses"
    Then I should see "Calendar Settings"
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    When I wait for 2 seconds
    Then I should see "coral_admin" in the "#div_User" element
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    #
    When I follow "ONIX-PL File Import"
    Then I should see "ONIX-PL Import" in the "h1" element
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    #
    When I follow "Calendar"
    Then I should see "Upcoming License Renewals"
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    #
    When I follow "Expression Comparison"
    Then I should see "Limit by Expression Type:"
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    #
    When I follow "License In Progress"
    Then I should see "Licenses In Progress" in the ".headerText" element
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    When I wait for 2 seconds
    Then I should see a "#div_licenses" element
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    #
    When I follow "New License"
    And I wait for 2 seconds
    Then I should see "License" in the ".thickboxTable .headerText" element
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"

  @add
  Scenario: Add License.
    Given I am on "licensing"
    And I wait for 2 seconds
    #
    When I follow "New License"
    And I wait for 2 seconds
    When I fill in "licenseShortName" with "BEST LICENSE EVER"
    When I fill in "organizationName" with "BEST PUBLISHER EVER"
    When I press "submit"
    And I wait until I see "License Added Successfully."
    When I follow "Continue"
    And I wait for 2 seconds
    Then I should see "BEST LICENSE EVER"
