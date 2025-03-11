Feature: HS Code Automatching

  Background: Flow till login page
    Given User is in Gemini application login page
    
	@CICD
  Scenario Outline: Scenario_01: HSCode Matching Multi Match
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And Select the HS Code with multiple match
    And HSCode predictable table should be displayed
    And Close the HSCode Predicable table
    And Cancel the Decalaration
    Then Unassign the Shipment

    Examples: 
      | SheetName | ColumnName | RowNumber |
      | HSCode  	| AWB Number  |         1 |
   
	@CICD
 Scenario Outline: Scenario_02: HSCode Matching NO Match
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "EDI Ready"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And Select the HS Code with no match
    And HSCode predictable table should not be displayed
    And select the HS code and verify commodity details
    And Cancel the Decalaration
    Then Unassign the Shipment
    
     Examples: 
      | SheetName | ColumnName | RowNumber |
      | HSCode  	| AWB Number  |         2 |
  
 
	@CICD
 Scenario Outline: Scenario_03: HSCode Prediction ScrollDown&Up
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
		And Enter valid HS code and verify filters
		And Verify scroll up and down
    And Close the HSCode Predicable table
    And Cancel the Decalaration
    Then Unassign the Shipment

    Examples: 
      | SheetName | ColumnName | RowNumber |
      | HSCode  	| AWB Number  |         3 |
   
	@CICD
  Scenario Outline: Scenario_04: HSCode Matching Exact Match
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And Select the HS Code with exact match
    And HSCode predictable table should not be displayed
    And Enter valid HS code and submit
    And Cancel the Decalaration
    Then Unassign the Shipment

    Examples: 
      | SheetName | ColumnName | RowNumber |
      | HSCode  	| AWB Number  |         4 |
      
      #//Data needs to input to this test case// Refer Tc in Entry Build #4
   @CICD
  Scenario Outline: Scenario_5_9395: Validate HS code icons under Commodity details in Declaration Information Screen
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    #And Disable Team "Default"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And Verify HS Code Multimatch Icon is displayed
    And Input the HS code and Select the HS code through Search Icon
    And Verify HS Code Match Icon
    Then Cancel the Decalaration
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |         5 |
   