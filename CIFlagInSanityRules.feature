Feature: Automation SG - Enable CI Flag in Sanity Rule Module

  Background: Flow till login page
    Given User is in Gemini application login page
    
  @CICD
  Scenario: CIFlag_01: RITM4947241 CI Flag parameter availability in Sanity Rules
    Given Navigate to "SANITY_RULE_MAINTENANCE" Page
    And User clicks on Create Icon
    Then Select Rule Condition as "Any"
    Then "CI Flag" value should be present in Parameter List
    And Click on Cancel
    And Click on Edit Icon
    Then "CI Flag" value should be present in Parameter List
    Then Click on Cancel