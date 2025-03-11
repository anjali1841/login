@Regression
Feature: Automation SG - Maintenance Module
  * Validate API reponse for Sanity rule maintenance, Team rule maintenance, User rule maintenance
  * Validate Create, Edit & Delete for Sanity rule maintenance, Team rule maintenance

  Background: Flow till login page
    Given User is in Gemini application login page

  @CICD
  Scenario: Maintenance_01_8515: Validate Create Edit Delete for new sanity rule
    When Navigate to "SANITY_RULE_MAINTENANCE" Page
    And User clicks on Create Icon
    Then Select Clearance Scheme as "LV"
    Then Select Sanity Group as "SANITY"
    Then Select Valid To Date
    Then Select Status as "Active"
    Then Enter Sanity Rule Name as "QA_SanityRule"
    Then Enter Sanity Rule Description as "QA_SanityRule"
    Then Select Rule Condition as "Any"
    Then Select Parameter value as "CIF"
    Then Select Condition value as "is equal to"
    Then Select or Enter value as "10"
    Then Click on Submit
    Then Verify Toaster Message "Sanity Rule Created Successfully"
    Given Navigate to "TEAM_RULE_MAINTENANCE" Page
    Given Navigate to "SANITY_RULE_MAINTENANCE" Page
    Then Filter using Sanity Rule Name as "QA_SanityRule"
    Then Verify Sanity Rule Name is "QA_SanityRule"
    Then Click on Edit Icon
    Then Enter Sanity Rule Description as "QA_SanityRule_Updated"
    Then Click on Submit
    Then Verify Toaster Message "Sanity Rule Updated Successfully"
    Then Filter using Sanity Rule Name as "QA_SanityRule"
    Then Click on Delete button
    Then Verify Toaster Message "1 Sanity Rule Deleted Successfully"
    And Click on Logout button

  @CICD_API
  Scenario: Maintenance_02_8517: Validating the Sanity Rule Maintenance with All-maintenance-service and Response 200 Ok
    Given Sanity Rule API when GET request is submitted with Valid Data then verify Response Status Code is "200"

  @CICD
  Scenario: Maintenance_03_8516: Validate Create Edit Delete for new Team rule
    When Navigate to "TEAM_RULE_MAINTENANCE" Page
    And User clicks on Create Icon
    Then Select Valid To Date
    Then Enter Team Rule Name as "QA_TeamRule"
    Then Enter Team Rule Description as "QA_TeamRule"
    Then Select Rule Condition as "Any"
    Then Select Parameter value as "CIF"
    Then Select Condition value as "is equal to"
    Then Select or Enter value as "1234"
    Then Click on Submit
    Then Verify Toaster Message "Team Rule Created Successfully"
    Given Navigate to "SANITY_RULE_MAINTENANCE" Page
    Given Navigate to "TEAM_RULE_MAINTENANCE" Page
    Then Filter using Team Rule Name as "QA_TeamRule"
    Then Verify Team Rule Name is "QA_TeamRule"
    Then Click on Edit Icon
    Then Enter Team Rule Description as "QA_TeamRule_Updated"
    Then Click on Submit
    Then Verify Toaster Message "Team Rule Updated Successfully "
    Then Filter using Team Rule Name as "QA_TeamRule"
    Then Click on Delete button
    Then Verify Toaster Message "1 Rule Deleted Successfully"
    And Click on Logout button

  @CICD_API
  Scenario: Maintenance_04_8519: Validating the Team Rule Maintenance with All-maintenance-service and Response 200 Ok
    Given Team Rule API when GET request is submitted with Valid Data then verify Response Status Code is "200"

  @CICD
  Scenario Outline: Maintenance_05_8514: Verify that the team is displayed in all the competencies if User toggles on the User Maintaiance page
    When Navigate to "USER_ROLE_MAINTENANCE" Page
    Then Search for the User
    And Toggle Off "Phantom" in select teams
    Then Select Team as "ALL" and click on Assign button
    Then Verify Team as "Phantom" in Assigned Teams Panel
    Then Click Save in User Maintenance page
    Given User clicks on "MANIFEST_CHECK" competency
    And Select Team as "Phantom"
    And Click on Logout button

  @CICD_API
  Scenario: Maintenance_06_8521: Validating the User Maintenance with All-maintenance-service and Response 200 Ok
    Given User Maintenance API when GET request is submitted with Valid Data then verify Response Status Code is "200"

  @CICD
  Scenario Outline: Maintenance_07_17332_RecurringRuleMaintenance
    When Navigate to "SORTCODE_RULE_MAINTENANCE" Page
    And User clicks on Create Icon
    Then Select Valid To Date
    Then Select Sortcode value as "PAL"
    Then Select Rule Condition as "Any"
    Then Select Parameter value as "Consignee Company Name"
    Then Select Condition value as "is equal to"
    Then Select or Enter value as "10"
    And Verify Save button is Enabled
    Then Cancel the Decalaration
    Then Click on Edit Icon
    And Verify Save button is Enabled
    And Click on Logout button

  @CICD
  Scenario Outline: Maintenance_08_17340_CI Flag parameter availability in Sanity Rules
    When Navigate to "SANITY_RULE_MAINTENANCE" Page
    And User clicks on Create Icon
    Then Select Rule Condition as "Any"
    Then Select Parameter value as "CI Flag"
    And Cancel the Decalaration
    Then Click on Edit Icon
    Then Select Parameter value as "CI Flag"
    And Cancel the Decalaration
    And Click on Logout button

  @CICD
  Scenario Outline: Maintenance_09_17341_TCP007_Verify DTQ recurring rule is still active in Maintanence screen
    When Navigate to "SORTCODE_RULE_MAINTENANCE" Page
    Then Filter using sort code as "DTQ"
    Then Verify sort code Status is "Active"
