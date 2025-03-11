@Regression
Feature: Automation SG - E2E Scenarios flow
  
  * Validate E2E Sceanrios flow
  * Validate Manifest Check to Entry Build Competency

  Background: Flow till login page
    Given User is in Gemini application login page

  @e2eHV
   Scenario Outline: ManifestCheck_03_8548: Validate the Shipment for complete E2E flow
    Given User clicks on "MANIFEST_CHECK" competency
    Then Click on User List icon
    And Unassign the Shipment
    And Click on team list
    And Select Team as "ACCS Shipments"
    And Disable the columns in modal window
    Then Enable the required columns in modal window
    And Filter using columnname "Clearance Scheme" as "HV"
    And Filter using columnname "FedEx Account for D&T Charges" as "000000000"
    And Filter using columnname "Duty Bill" as "C"
    And Filter using columnname "Incoterm" as "CFR"
    And Filter using columnname "Clearance Mode" as "G7"
    And Filter using "Importer Company" as "Blank Cells"
    And Filter using "Consignee Company" as "Blank Cells"  
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Fetch the AWBNo "<SheetName>","<ColumnName1>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName1>", "<RowNumber>"
    And Click on Override button
    And On Demand - Click on User List Icon
    Then User clicks on "CUSTOMER_MATCHING" competency
    And Select Team as "ACCS Shipments"
    And Search the shipment "<SheetName>", "<ColumnName1>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName1>", "<RowNumber>"
    When Double click on the first shipment
    And User search for Importer and click on the Link Importer icon for all shipments
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName1>", "<RowNumber>"
    And On Demand - Click on User List Icon
    Then User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    And Search the shipment "<SheetName>", "<ColumnName1>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName1>", "<RowNumber>"
    And Double click on the first shipment
    And Input the HS code and Select the HS code through Search Icon
    And Enter the Quantity of commodity as "1"
    And Enter the total Value as "3000"
    Then Click on Sort Message on Floating Panel and select 'GEM'
    And Change Clearance Mode "G7"
    Then Update currency in declaration screen "SGD"
    And User link the importer icon name as "dops_test_profile"
    And Click on Validate
    And Submit the Declaration
    And On Demand - Click on User List Icon
    And Click on Global search
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"   
    And Verify Selection Code is equal to "DTQ"
    # If DOPS is not poinitng to executing environment --> These will fail  Then "Teams" name should be displayed as "DTQ Unassigned" Then "Payment Option" name should be displayed as "DOPS" Then "DOPS Status" name should be displayed as "MESSAGE SENT"  Then Write the AWB to file
    Then "Teams" name should be displayed as "DTQ Unassigned"
    Then "Payment Option" name should be displayed as "DOPS"
    Then "DOPS Status" name should be displayed as "MESSAGE SENT"  
    Then Write the AWB to file
 
    Examples: 
      | SheetName    | ColumnName | ColumnName1      | RowNumber |
      | E2EScenarios | AWB Number | Addnl_AWB Number |         1 |     
      
      
      
   @e2eXHV
    Scenario Outline: ManifestCheck_03_8548: Validate the Shipment for complete E2E flow with X-HIGH
    Given User clicks on "MANIFEST_CHECK" competency
    Then Click on User List icon
    And Unassign the Shipment
    And Click on team list
    And Select Team as "ACCS Shipments"
    And Disable the columns in modal window
    Then Enable the required columns in modal window
    And Filter using columnname "Clearance Scheme" as "X-HIGH"
    And Filter using columnname "FedEx Account for D&T Charges" as "000000000"
    And Filter using columnname "Duty Bill" as "C"
    And Filter using columnname "Incoterm" as "CFR"
    And Filter using columnname "Clearance Mode" as "G7"
    And Filter using "Importer Company" as "Blank Cells"
    And Filter using "Consignee Company" as "Blank Cells"  
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Fetch the AWBNo "<SheetName>","<ColumnName1>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName1>", "<RowNumber>"
    And Click on Override button
    And On Demand - Click on User List Icon
    Then User clicks on "CUSTOMER_MATCHING" competency
    And Select Team as "ACCS Shipments"
    And Search the shipment "<SheetName>", "<ColumnName1>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName1>", "<RowNumber>"
    When Double click on the first shipment
    And User search for Importer and click on the Link Importer icon for all shipments
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName1>", "<RowNumber>"
    And On Demand - Click on User List Icon
    Then User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    And Search the shipment "<SheetName>", "<ColumnName1>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName1>", "<RowNumber>"
    And Double click on the first shipment
    And Input the HS code and Select the HS code through Search Icon
    And Enter the Quantity of commodity as "1"
    And Enter the total Value as "93000"
    Then Click on Sort Message on Floating Panel and select 'GEM'
    And Change Clearance Mode "G7"
    Then Update currency in declaration screen "SGD"
    And User link the importer icon name as "dops_test_profile"
    And Click on Validate
    And Submit the Declaration
    And On Demand - Click on User List Icon
    And Click on Global search
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"   
    And Verify Selection Code is equal to "DTQ"
    # If DOPS is not poinitng to executing environment --> These will fail  Then "Teams" name should be displayed as "DTQ Unassigned" Then "Payment Option" name should be displayed as "DOPS" Then "DOPS Status" name should be displayed as "MESSAGE SENT"  Then Write the AWB to file
    Then "Teams" name should be displayed as "DTQ Unassigned"
    Then "Payment Option" name should be displayed as "DOPS"
    Then "DOPS Status" name should be displayed as "MESSAGE SENT"  
    Then Write the AWB to file
 
    Examples: 
      | SheetName    | ColumnName | ColumnName1      | RowNumber |
      | E2EScenarios | AWB Number | Addnl_AWB Number |         1 |    
      
      
