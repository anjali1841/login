Feature: Automation SG - DashBoard or Reports Module

  Background: Flow till login page
    Given User is in Gemini application login page

  #@Sanity
  @CICD
  Scenario: Dashboard_01_9494: Validating G7 Billing Reports
    Given User clicks on "REPORTS" competency
    And Verify Report Links are displayed
    And Click on G7 Billing Report
    When Select Cycle Date range
    Then Verify Billing Report are displayed as Data Selected
    And Select Cycle Number
    And Click on Welcome Page

  #@Sanity
  @CICD
  Scenario: Dashboard_02_9489: Validating High GST Verification Reports
    Given User clicks on "REPORTS" competency
    And Verify Report Links are displayed
    And Click on High GST Verification Report
    When Select Cycle Date range
    Then Verify Billing Report are displayed as Data Selected
    And Select Cycle Number
    And Select GST Threshold Value
    And Click on Welcome Page
