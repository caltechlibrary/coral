@landing
Feature: CORAL Landing Page

  Scenario: Verify the landing page displays as expected.
    When I go to the homepage
    Then I should see "Resources"
    Then I should see "Licensing"
    Then I should see "Organizations"
    Then I should see "Usage Statistics"
    Then I should see "Management"
    And I should not see "Notice"
    And I should not see "Warning"
    And I should not see "Fatal"
