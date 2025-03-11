Feature: Automation SG - GEMINI Capture Routes - EntryBuild Module

  Background: Flow till login page
    Given User is in Gemini application login page

  #@RoutesCapture
  @CICD
  Scenario Outline: RouteCapture_297391: Shipment has Invalid Clearance Status
    Given User clicks on "ENTRY_BUILD" competency
    When Select Team as "Company Audit"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    #Then Toaster message should be displayed as "Shipment Assigned to User List"
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click the Route Refresh Information
    #Then Toaster message should be displayed as "Shipment has Invalid Clearance Status"
    Then Unassign the Shipment

    Examples: 
      | SheetName     | ColumnName | RowNumber |
      | RoutesCapture | AWB Number |         1 |

  #@RoutesCapture1 // Need to input data manually before executing the script
  @CICD
  Scenario Outline: RouteCapture_297391: Ability to Retrieve Route Info having both Route and Arrival Date in Global Search
    Given User clicks on "ENTRY_BUILD" competency
    When Select Team as "ACCS Shipments"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    #Then Toaster message should be displayed as "Shipment Assigned to User List"
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click the Route Refresh Information
    Then Toaster message should be displayed as "Updated Shipment Route"
    And Click on User List
    And Click on Global search
    When Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Click the Route Refresh Information In GlobalSearch
    Then Toaster message should be displayed as "Updated Shipment Route"
    And Click Close Global search
    Then Unassign the Shipment

    Examples: 
      | SheetName     | ColumnName | RowNumber |
      | RoutesCapture | AWB Number |         2 |

  #@RoutesCapture
  @CICD
  Scenario Outline: EntryBuild_297391: Try to update more than 100 shipment
    Given User clicks on "ENTRY_BUILD" competency
    #And Click on User List
    #Then Get the total record count from the user list
    #And Click on team list
    #When Select ACCS Shipments toggle
    #And Assign Multiple Shipments to User List
    And Assign n shipment to user list
    #Then Toaster message should be displayed as "Shipments Assigned to User List"
    And Select all the shipments from the grid
    And Click the Route Refresh Information
    Then Toaster message should be displayed as "No Shipment in the request list or Shipment list has been exceed by 100"
    Then Unassign the Shipment
     
     
      #@RoutesCapture
   #	Scenario Outline: EntryBuild_297391: Updated Shipment Route and Description information saved successfully
   #	Given User is in Entry Build Module
    #When Select ACCS Shipments toggle
    #And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    #And Click on Assign to me
    #Then Toaster message should be displayed as "Shipment Assigned to User List"
   # Given update the shipment details
    #Given Update the Swagger details in RestAssured
    #And Refresh the application
    #Given User is in Entry Build Module
    #And Click on User List
    #And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    #And Click the Route Refresh Information
    #Then Toaster message should be displayed as "Updated Shipment Route And Description information saved successfully"
    #
     #Examples:
    #	| SheetName  | ColumnName | RowNumber |
      #| RoutesCapture | AWB Number  |        3 |
