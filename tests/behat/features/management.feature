@management
Feature: Management

  Background:
    Given I am on the homepage
    When I follow "Management"
    Then I should see "eRM Authentication"
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    When I fill in "loginID" with "coral_admin"
    And I fill in "password" with "coral_password"
    And I press "loginbutton"
    Then I should see "Management" in the "#main-title-text" element
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"

  @browse @reset_management
  Scenario: Browse Management.
    Given I am on "management"
    Then I should see "Management" in the "#main-title-text" element
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    When I wait for 2 seconds
    Then I should see "Sorry, no documents fit your query"
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    #
    When I follow "Admin"
    Then I should see "Users"
    Then I should see "Document Types"
    Then I should see "Note Types"
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    When I wait for 2 seconds
    Then I should see "coral_admin" in the "#div_User" element
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
    #
    When I follow "New Document"
    And I wait for 2 seconds
    Then I should see "New Document" in the "#headerText" element
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"

  # Management Documents seem incomplete. The form fields have the same IDs as
  # the Licensing module. Categories must exist before one can save a new
  # document and there is no place to add a category.
  #@add
  #Scenario: Add Document.
  #  Given I am on "management"
