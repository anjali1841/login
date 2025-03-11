Feature: Automation SG - Entry Build Module
  * PST Review

  Background: Flow till login page
    Given User is in Gemini application login page

  @CICD
  Scenario Outline: PSTReview_01_9511: PSTCheck without High GST and Company Audit Team
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "EDI Ready"
    #And Disable Team "Default"
    And Filter using columnname "Clearance Status" as "EDI Ready"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    #Then Click on Sort Message on Floating Panel and select 'SEC'
    Then Click on Sort Message on Floating Panel and select 'GEM'
    And Click on Validate
    #Then Toaster message should be displayed as "Commodity validation request is successful"
    And Validate CIF and GST Value
    And Submit the Declaration
    #Then Toaster message should be displayed as "Shipment has been submitted successfully"
    #Then Verify Toaster Message "Shipment has been submitted successfully"
    #And Cancel the Decalaration
    Then Click on PST Check button
    Then Click on User List icon
    #Then Toaster message should be displayed as "0/1 PST Review Request is submitted successfully"
    And Double click on the first shipment
    Then Clearance Status in declaration screen should be "EDI READY"
    And Validate ADT sort code is not Added
    Then User clicks on "ENTRY_BUILD" competency
    And Click on User List icon
    Then Unassign the Shipment

    Examples: 
      | SheetName | ColumnName | RowNumber |
      | PSTReview | AWB Number |         1 |

  @CICD
  Scenario Outline: PSTReview_02_17294_PSTCheck with multiple High GST Team shipments
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "High GST"
    #And Disable Team "Default"
    And Filter using columnname "Clearance Status" as "GST Check"
    And Read 2 shipment AWB number "<SheetName>","<ColumnName>","<RowNumber>"
    And Filter using "AWB Number" as "In"
    And Search the Multiple shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click toggle to select all available shipment
    And Click on Assign to Me icon
    Then Click on User List icon
    And Filter using "AWB Number" as "In"
    And Search the Multiple shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    #//Then Click on Sort Message on Floating Panel and select 'NCR'
    Then Click on Sort Message on Floating Panel and select 'GEM'
    Then Validate the selection codes "DPIA","AGRI" not in Declaration Page
    And Verify if GST and CIF value is above
    And Validate CIF and GST Value
    And Click on Validate
    And Submit the Declaration
    #And Cancel the Decalaration
    Then Click on Sort Message on Floating Panel and select 'GEM'
    Then Validate the selection codes "DPIA","AGRI" not in Declaration Page
    And Verify if GST and CIF value is above
    And Validate CIF and GST Value
    And Click on Validate
    And Submit the Declaration
    And Click on User List
    And Click toggle to select all available shipment
    Then Click on PST Check button
    #Then Toaster message should be displayed as "2/2 PST Review Request is submitted successfully"
    And Click on User List
    And Click on Global search
    Then Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Assign the shipment in the GlobalSearch
    And Select only 1 user and submit
    And Click Close Global search
    And Click on User List
    And Search the Multiple shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    Then Clearance Status in declaration screen should be "EDI READY"
    And Verify Selection Code is equal to "ADT"
    #//And Click on Activity log in Declaration page
    #//Then Verify the activity log is displyed with sort code "ADT"
    #//And Close the activity log popup
    And Validate the selection codes "DPIA","AGRI" not in Declaration Page
    And Click next button of Declaration Page
    And Verify Selection Code is equal to "ADT"
    And Validate the selection codes "DPIA","AGRI" not in Declaration Page
    And Cancel the Decalaration
    And Unassign all the shipments in user list

    Examples: 
      | SheetName | ColumnName | RowNumber |
      | PSTReview | AWB Number |         2 |

  @CICD
  Scenario Outline: PSTReview_03_17295_PSTCheck with multiple Company Audit Team shipments
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "Company Audit"
    #And Disable Team "Default"
    And Filter using columnname "Clearance Status" as "Company Audit"
    And Read 2 shipment AWB number "<SheetName>","<ColumnName>","<RowNumber>"
    And Filter using "AWB Number" as "In"
    And Search the Multiple shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click toggle to select all available shipment
    And Click on Assign to Me icon
    Then Click on User List icon
    And Filter using "AWB Number" as "In"
    And Search the Multiple shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    #//Then Click on Sort Message on Floating Panel and select 'NCR'
    Then Click on Sort Message on Floating Panel and select 'GEM'
    Then Validate the selection codes "DPIA","AGRI" not in Declaration Page
    And Validate CIF and GST Value
    And Click on Validate
    And Submit the Declaration
    #And Cancel the Decalaration
    Then Click on Sort Message on Floating Panel and select 'GEM'
    Then Validate the selection codes "DPIA","AGRI" not in Declaration Page
    And Verify if GST and CIF value is above
    And Validate CIF and GST Value
    And Click on Validate
    And Submit the Declaration
    And Click on User List
    And Click toggle to select all available shipment
    Then Click on PST Check button
    #Then Toaster message should be displayed as "2/2 PST Review Request is submitted successfully"
    And Click on User List
    And Click on Global search
    Then Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Assign the shipment in the GlobalSearch
    And Select only 1 user and submit
    And Click Close Global search
    And Click on User List
     And Search the Multiple shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    Then Clearance Status in declaration screen should be "EDI READY"
    And Verify Selection Code is equal to "ADT"
    And Validate the selection codes "DPIA","AGRI" not in Declaration Page
    And Click next button of Declaration Page
    And Verify Selection Code is equal to "ADT"
    And Validate the selection codes "DPIA","AGRI" not in Declaration Page
    And Cancel the Decalaration
    And Unassign all the shipments in user list

    Examples: 
      | SheetName | ColumnName | RowNumber |
      | PSTReview | AWB Number |         3 |

  @CICD
  Scenario Outline: PSTReview_04_17296_PSTCheck with both High GST and Company Audit Team shipments
    Given User clicks on "ENTRY_BUILD" competency
    And Click on User List
    And Unassign all the shipments in user list
    And Click on team list
    And Select Team as "Company Audit"
    # And Disable Team "Default"
    And Filter using columnname "Clearance Status" as "Company Audit"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    And Click on team list
    And Select Team as "High GST"
    #And Disable Team "Company Audit"
    And Filter using columnname "Clearance Status" as "GST Check"
    And Fetch the AWBNo "<SheetName>","<ColumnName1>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName1>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Double click on the first shipment
    Then Click on Sort Message on Floating Panel and select 'GEM'
    And Validate CIF and GST Value
    And Click on Validate
    And Submit the Declaration
    #And Cancel the Decalaration
    Then Click on Sort Message on Floating Panel and select 'GEM'
    Then Validate the selection codes "DPIA","AGRI" not in Declaration Page
    And Verify if GST and CIF value is above
    And Validate CIF and GST Value
    And Click on Validate
    And Submit the Declaration
    And Click on User List
    And Click toggle to select all available shipment
    Then Click on PST Check button
    #Then Toaster message should be displayed as "2/2 PST Review Request is submitted successfully"
    And Click on User List
    #//    And Verify Team is equal to "EDI Ready"
    And Click on Global search
    Then Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Assign the shipment in the GlobalSearch
    And Select only 1 user and submit
    And Click Close Global search
    And Click on User List
    And Search the Multiple shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    Then Clearance Status in declaration screen should be "EDI READY"
    And Add the sort code "DPIA" and save it succesfully in Declaration Page
    And Add the sort code "RLS" and save it succesfully in Declaration Page
    And Select the Clearance Mode in Decalaration as "CAGED"
    And Verify Selection Code is equal to "ADT"
    And Click on Validate
    Then Clearance Status in declaration screen should be "EDI READY"
    And Submit the Declaration
    Then Clearance Status in declaration screen should be "EDI READY"
    And Add the sort code "DPIA" and save it succesfully in Declaration Page
    And Add the sort code "RLS" and save it succesfully in Declaration Page
    And Select the Clearance Mode in Decalaration as "CAGED"
    And Verify Selection Code is equal to "ADT"
    And Click on Validate
    Then Clearance Status in declaration screen should be "EDI READY"
    And Submit the Declaration
     And Click on User List
    And Click on Global search
    Then Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Assign the shipment in the GlobalSearch
    And Select only 1 user and submit
    And Click Close Global search
    And Click on User List
    And Verify Team is equal to "EDI Complete"
    And Double click on the first shipment
    Then Clearance Status in declaration screen should be "GST CHECK"
    Then Click next button of Declaration Page
    Then Clearance Status in declaration screen should be "COMPANY AUDIT CHECK"
    And Cancel the Decalaration
    And Unassign all the shipments in user list

    Examples: 
      | SheetName | ColumnName | RowNumber | ColumnName1       |
      | PSTReview | AWB Number |         4 | Addnl1_AWB Number |
