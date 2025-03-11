Feature: Automation SG - Entry Build Module
  * Verify Alerts

  Background: Flow till login page
    Given User is in Gemini application login page

  @CICD
  Scenario Outline: NonOverridableAlerts__01_9558: Validation in Entry Build for CPMatch Alert HSCode Alert Commodity Description Required Alert UOM Alert
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    #And Disable Team "Default"
    And Filter using columnname "Clearance Scheme" as "LV"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    Then "UOM Required" Alert should be displayed
    And Clear the text in Commodity Description
    And Click on Validate
    Then "Commodity Description Required" Alert should be displayed
    And Change Clearance Scheme "HV"
    And Click on Validate
    Then "CPMatch Required" Alert should be displayed
    Then "HSCode Required" Alert should be displayed
    And Cancel the Decalaration
    Then Unassign the Shipment

    Examples: 
      | SheetName            | ColumnName | RowNumber |
      | NonOverridableAlerts | AWB Number  |         1 |

  @CICD
  Scenario Outline: NonOverridableAlerts_02_9558: Validation in Entry Build for Packages Alert Weight Alert Branded Alert
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    #And Disable Team "Default"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    Then Clear data of Package weight branded
    And Click on Validate
    Then "Packages Required" Alert should be displayed
    Then "Branded Required" Alert should be displayed
    Then "Weight Required" Alert should be displayed
    And Cancel the Decalaration
    Then Unassign the Shipment

    Examples: 
      | SheetName            | ColumnName | RowNumber |
      | NonOverridableAlerts | AWB Number  |         2 |

  @CICD
  Scenario Outline: NonOverridableAlerts_03_04_9558: Validation in Entry Build for DEMIN LV Alert Check Clearance Scheme Alert UEN Failed Alert
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    #And Disable Team "Default"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And Update the total value
    And Change Clearance Scheme "HV"
    And Change Clearance Mode "DEMIN"
    And Click on Validate
    Then "DEMIN LV Required" Alert should be displayed
    Then "Check Clearance Scheme" Alert should be displayed
    And User search for Importer and click on the Link Importer icon
    And Click on Validate
    Then "UEN Failed" Alert should be displayed
    And Cancel the Decalaration
    Then Unassign the Shipment

    Examples: 
      | SheetName            | ColumnName | RowNumber |
      | NonOverridableAlerts | AWB Number  |         3 |

  @CICD
  Scenario Outline: NonOverridableAlerts_05_9558: Validation in Entry Build for Check LV ROAD Clearance Mode Alert
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    And Filter using columnname "Clearance Scheme" as "LV"
    And Filter using route as "KS666"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And Click on Validate
    And Change Clearance Mode "ERROR"
    And Click on Validate
    Then "Check LV ROAD Clearance Mode" Alert should be displayed
    And Cancel the Decalaration
    Then Unassign the Shipment

    Examples: 
      | SheetName            | ColumnName | RowNumber |
      | NonOverridableAlerts | AWB Number  |         5 |

  @CICD
  Scenario Outline: NonOverridableAlerts_06_9558: Validation in Entry Build for Caged Mode Required Alert and Cage Code Required Alert
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    #And Disable Team "Default"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And Change Clearance Mode "CAGED"
    Then Click on Sort Message on Floating Panel and select "GEM"
    And Click on Validate
    Then "Cage Code Required" Alert should be displayed
    And Change Clearance Mode "DEMIN"
    Then Click on Sort Message in Floating Panel and select "AGRI"
    And Click on Validate
    Then "Caged Mode Required" Alert should be displayed
    And Cancel the Decalaration
    Then Unassign the Shipment

    Examples: 
      | SheetName            | ColumnName | RowNumber |
      | NonOverridableAlerts | AWB Number  |         6 |
