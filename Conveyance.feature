@Regression
Feature: Automation SG - Conveyance Module
  
  * Verify shipment results in the grid after providing Conveyance date
  
  * Modify conveyance details and shipment should be updated with latest information

  Background: Flow till login page
    Given User is in Gemini application login page

  @CICD
  Scenario Outline: Conveyance_01_9477: Validate Edit button, Origin Port, Origin Departing Location, Modify AWB and Submit
    Given User clicks on "CONVEYANCE" competency
    And click Search icon
    When Disable the columns in the conveyance window
    Then Enable the required columns in the conveyance window
    And Validated the conveyace location
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Enter Conveyance Number "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Search button
    Then Select First Record from the Grid
    Then Click on Edit button
    And Select Origin Port
    And Modify MAWB as "<SheetName>", "<ColumnName1>", "<RowNumber>"
    And Modify the Flight Number "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Select Origin Departing Location    
    And Click on Submit button
    Then Verify Toaster Message
    And Click on Logout button

    Examples: 
      | SheetName  | ColumnName       | ColumnName1 | RowNumber |
      | Conveyance | ConveyanceNumber | MAWB        |         1 |

  @CICD
  Scenario Outline: Conveyance_02_9475: Verify Conveyance data and Date range in the grid
    Given User clicks on "CONVEYANCE" competency
    And click Search icon
    When Disable the columns in the conveyance window
    Then Enable the required columns in the conveyance window
    And Verify Date Type dropdown values
    And Select Date Type as "Route Arrival"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Enter Conveyance Number "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Search button
    And Verify Date Format
    Then Select First Record from the Grid
    Then Click on Edit button
    Then Select Origin Port
     And Modify the MAWB "<SheetName>", "<ColumnName1>", "<RowNumber>"
    And Modify the Flight Number "<SheetName>", "<ColumnName>", "<RowNumber>"
    Then Select Origin Departing Location   
    And Click on Submit button
    #Then Verify Toaster Message
    And Click on Logout button

    Examples: 
      | SheetName  | ColumnName   | ColumnName1 | RowNumber |
      | Conveyance | FlightNumber | MAWB        |         2 |

  @CICD
  Scenario Outline: Conveyance_03_9479: Verify Edit button in Conveyance competency
    Given User clicks on "CONVEYANCE" competency
    And click Search icon
    When Disable the columns in the conveyance window
    Then Enable the required columns in the conveyance window
    And Filter using Conveyance Status "OPEN"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Enter Conveyance Number "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Search button
    Then Select First Record from the Grid
    Then Click on Edit button
    Then Verify fields displayed in Modify Conveyance Details popup

    Examples: 
      | SheetName  | ColumnName   | RowNumber |
      | Conveyance | FlightNumber |         3 |
