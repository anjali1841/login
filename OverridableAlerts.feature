@Regression
Feature: Automation SG - Overridable Alerts Module
  * Validate Alerts that can be Overridable
  * Validate High GST_High CIF, Zero CIF, LV Truck G7 Alerts

  Background: Flow till login page
    Given User is in Gemini application login page

  @CICD
  Scenario Outline: OverridableAlerts_01_9557: Validating High GST Alert
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    #And Disable Team "Default"
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Filter using columnname "Clearance Status" as "UNWORKED"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Verify Clearance Status as "IN PROGRESS"
    And Double click on the first shipment
    And Update the total value
    Then Update currency in declaration screen "SGD"
    And Double Click on Commodity details
    And Click on Validate
    And Click on Validate
    Then CIF and GIF Alerts should be displayed
    Then Cancel the Decalaration
    Then Unassign the Shipment

    Examples: 
      | SheetName         | ColumnName | RowNumber |
      | OverridableAlerts | AWB Number  |         2 |

  @CICD
  Scenario Outline: OverridableAlerts_03_9647: Validating LV Truck G7 Alert
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    #And Disable Team "Default"
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Filter using columnname "Route" as "KS666"
    And Filter using columnname "Clearance Scheme" as "LV"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And Modify the clearance mode as GF
    And Click on Validate
    Then LV Truck G7 overridable alert should be displayed
    Then Cancel the Decalaration
    Then Unassign the Shipment

    Examples: 
      | SheetName         | ColumnName | RowNumber |
      | OverridableAlerts | AWB Number  |         1 |
