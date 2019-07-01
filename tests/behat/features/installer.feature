@installer
Feature: Installer

  # NOTE: The configuration.ini files and the databases must not exist before
  # this installer test can be run.
  @docker
  Scenario: Verify the installer process.
    When I go to the homepage
    And I wait until I see "Modules to use" in the ".section-title" element
    And I press "Continue Installing"
    And I wait until I see "Have database access" in the ".section-title" element
    And I fill in "dbusername" with "root"
    And I fill in "dbpassword" with "foobar"
    And I fill in "dbhost" with "db"
    And I press "Continue Installing"
    And I wait until I see "Configure Default Database User" in the ".section-title" element
    And I fill in "default_db_username" with "coral_dbuser"
    And I fill in "default_db_password" with "where-is-the-coral-reef"
    And I press "Continue Installing"
    And I wait until I see "Have default user" in the ".section-title" element
    And I fill in "loginID" with "coral_admin"
    And I press "Continue Installing"
    And I wait until I see "Auth Module Installation" in the ".section-title" element
    And I press "Continue Installing"
    And I wait until I see "Default Admin Password" in the "label" element
    And I fill in "coral_default_admin_password" with "coral_password"
    And I press "Continue Installing"
    And I wait until I see "Licensing Module" in the ".section-title" element
    And I press "Continue Installing"
    And I wait until I see "Usage Module" in the ".section-title" element
    And I press "Continue Installing"
    And I wait until I see "Resources Module" in the ".section-title" element
    And I press "Continue Installing"
    And I wait until I see "Congratulations" in the ".completion_title" element
    And I wait for 10 seconds
    Then I should see "eRM • eResource Management"
    Then I should see "Resources"
    Then I should see "Licensing"
    Then I should see "Organizations"
    Then I should see "Usage Statistics"
    Then I should see "Management"
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
