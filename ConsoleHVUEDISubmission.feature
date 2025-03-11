Feature: Console, EDI & HVU Submission
  * Validate the console submission process
  * Validate the HVU submission flow
  * Validate the EDI submission flow

  Background: Flow till login page
    Given User is in Gemini application login page

  @CICD
  Scenario Outline: Console_EDIHVU_Sub_01_9663: Validate team and clearance status as EDI ready and CycleDate_ with available shipments in team list
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "EDI Ready"
    #And Disable Team "ATFC Prioity"
    And Filter using columnname "Clearance Status" as "EDI Ready"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Cycle changes
    And Set the Cycle Date and select the Cycle number "13"
    Then Click on Save in Cycle Change
    And Cycle Date and Cycle Number should be generated for the record
    And Unassign all the shipments in user list

    Examples: 
      | SheetName     | ColumnName | RowNumber |
      | ConsoleEDIHVU | AWB Number |         1 |

  @CICD
  Scenario Outline: Console_EDIHVU_Sub_2_9662,4_9651,8_9673,9_9675,11_9677: Verfiy EDI ready team to EDI Sent From GEMINI after Console Sumission with cycle date and number
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "EDI Ready"
    #And Disable Team "ATFC Prioity"
    And Filter using columnname "Clearance Status" as "EDI Ready"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And Select the Clearance Mode in Decalaration as "G7"
    And Click on Validate
    Then No Alert should be displayed in Declaration screen
    And Submit the Declaration
    And Verify user is in userlist
    And Click on User List
    And Click on Global search
    Then Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Assign the shipment in the GlobalSearch
    And Select only 1 user and submit
    And Click Close Global search
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    Then Clearance Status in declaration screen should be "EDI READY"
    And Cancel the Decalaration
    And Verify Clearance Status as "EDI READY"
    And "EDI Ready" Team Toggle Should be "ON"
    And Click on Cycle changes
    And Set the Cycle Date and select the Cycle number "13"
    Then Click on Save in Cycle Change
    #And Toaster message should be displayed as "Updated Cycle changes successfully."
    And Click on the Console Submission
    And Select Cycle Date and select the record with cycle Date "13"
    And Verify the HAWB is greater than 0
    And Submit the Console Submission
    And Click Cancel on Console Submission
    And Unassign all the shipments in user list
    And Click on Global search
    And Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    Then Verify Clearance Status as "EDI SENT FROM GEMINI"

    Examples: 
      | SheetName     | ColumnName | RowNumber |
      | ConsoleEDIHVU | AWB Number |         2 |

  @CICD
  Scenario Outline: Console_EDIHVU_Sub_03_9674: Verfiy EDI ready team set on declaration submission when submitted with GST > 7000K and ADT sort added
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "High GST"
    #And Disable Team "Default"
    #And Disable Team "ATFC Prioity"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And Select the Clearance Mode in Decalaration as "G7"
    And Click on Validate
    Then No Alert should be displayed in Declaration screen
    And Submit the Declaration
    And Verify user is in userlist
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Add the sort code "ADT" and save it succesfully in Declaration Page
    And Double click on the first shipment
    And Check the GST is ">" than "7000"
    And Click on Validate
    Then No Alert should be displayed in Declaration screen
    And Submit the Declaration
    And Verify user is in userlist
    And Click on User List
    And Click on Global search
    Then Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Assign the shipment in the GlobalSearch
    And Select only 1 user and submit
    And Click Close Global search
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    Then Clearance Status in declaration screen should be "EDI READY"
    And Cancel the Decalaration
    And Verify Clearance Status as "EDI READY"
    And Cycle Date and Cycle Number should be generated for the record
    And Click on Cycle changes
    And Set the Cycle Date and select the Cycle number "2"
    Then Click on Save in Cycle Change
    And Unassign all the shipments in user list

    Examples: 
      | SheetName     | ColumnName | RowNumber |
      | ConsoleEDIHVU | AWB Number |         3 |

  @CICD
  Scenario Outline: Console_EDIHVU_Sub_04_9672: Verfiy EDI ready team set on declaration submission when submitted with GST < 7000K and ADT sort removed, no Company Audit
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "Company Audit"
    #And Disable Team "ATFC Prioity"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And Select the Clearance Mode in Decalaration as "G7"
    And Click on Validate
    Then No Alert should be displayed in Declaration screen
    And Submit the Declaration
    And Click on User List
    And Double click on the first shipment
    And Check the GST is "<" than "7000"
    And Select the consignee in declaration as "Health"
    And Click on Validate
    Then No Alert should be displayed in Declaration screen
    And Submit the Declaration
    #Then Toaster message should be displayed as "Shipment has been submitted successfully"
    And Verify user is in userlist
    And Click on User List
     And Click on Global search
    Then Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Assign the shipment in the GlobalSearch
    And Select only 1 user and submit
    And Click Close Global search
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    Then Clearance Status in declaration screen should be "EDI READY"
    And Cancel the Decalaration
    And Click on User List
    And Verify Clearance Status as "EDI READY"
    And "EDI Ready" Team Toggle Should be "ON"
    And Cycle Date and Cycle Number should be generated for the record
    And Unassign the Shipment

    Examples: 
      | SheetName     | ColumnName | RowNumber |
      | ConsoleEDIHVU | AWB Number |         4 |

  @CICD
  Scenario Outline: Console_EDIHVU_Sub_05_9670: Verfiy HVU sent from GEMINI clearance staus & HVU team when shipment is submitted for HVU
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ATFC ("
    #And Disable Team "ATFC Prioity"
    And Filter using columnname "Clearance Scheme" as "HV"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click sort message in floating panel
    And Unselect all sort codes
    And Add the sort code "GEM" and save it succesfully in Declaration Page
    And Double click on the first shipment
    And Clear HSCode required alert
    And Select the importer in declaration as "health"
    And Click on Validate
    And Select the Clearance Mode in Decalaration as "GF"
    And Click on Validate
    Then No Alert should be displayed in Declaration screen
    And Submit the Declaration
    And Verify user is in userlist
    And Double click on the first shipment
    Then Clearance Status in declaration screen should be "HVU READY"
    And Cancel the Decalaration
    And Verify Clearance Status as "HVU READY"
    And Click on Activity log in floating panel
    And Verify the activity log is displyed with "Teams Identified ATFC->HVU"
    And Close the activity log popup
    And Click on the Submit HVU Shipment
    And Toaster message should be displayed as "HVU Permit Request is submitted successfully"
    And Click on User List
    And Verify Clearance Status as "HVU SENT FROM GEMINI"
    And Click on Activity log in floating panel
    Then Verify the activity log is displyed with "Clearance Status HVU Ready->HVU Sent from GEMINI"
    And Close the activity log popup
    And Unassign the Shipment

    Examples: 
      | SheetName     | ColumnName | RowNumber |
      | ConsoleEDIHVU | AWB Number |         5 |

  @CICD
  Scenario Outline: Console_EDIHVU_Sub_6_9678: Enable Cycle Assignment in Team Leader list view for EDI Ready and Non EDI Ready team
    Given User clicks on "ENTRY_BUILD" competency
    When Select TeamLeader List
    And Select ACSS Shipments toggle in team leader list
    And Select the Shipment in team leader list
    And Cycle changes button should be disabled in the floating panel
    And Select EDI Ready toggle in team leader list
    And Select the Shipment in team leader list
    And Click on Cycle changes in the floating panel
    When Set the Cycle Date and select the Cycle number "13"
    Then Click on Save in Cycle Change
