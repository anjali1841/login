#@Regression
Feature: Automation SG - Team Rule Module
  
  * Verify Clearance Mode, Consignee Company, Selection Code, Clearance Status, Commodity Group for a selected shipment
  * Validate Shipments rules for all the Teams  in Entry Build

  Background: Flow till login page
    Given User is in Gemini application login page

  @CICD
  Scenario Outline: TeamRule_01_9710: Validating shipment rules for ATFC Team
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ATFC ("
    #And Disable Team "Default"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Verify Clearance Status as "IN PROGRESS"
    And Verify Consignee Company Name does not contain "HUAWEI"
    And Verify Consignee Company Name does not contain "IBM"
    And Verify Consignee Company Name does not contain "VELOCITY"
    And Verify Clearance Scheme is not equal to "DOC"
    And Verify Clearance Scheme is not equal to "BSO"
    And Verify Clearance Mode is not equal to "CAGED"
    And Verify Selection Code is equal to "GEM"
    And Verify Selection Code is not equal to "CDN"
    And Verify Selection Code is not equal to "SMOW"
    And Verify Commodity category is equal to "NON_CONTROLLED"
    Then Unassign the Shipment

    Examples: 
      | SheetName | ColumnName | RowNumber |
      | TeamRule  | AWB Number |         1 |

  @CICD
  Scenario Outline: TeamRule_02_9712: Validating shipment rules for ATFC Select Customers Team
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ATFC Select Customers"
    #And Disable Team "Default"
    And Filter using columnname "Consignee Company" as "HUAWEI"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Verify Clearance Status as "IN PROGRESS"
    And Verify Consignee Company Name contains "HUAWEI"
    And Verify Clearance Scheme is not equal to "DOC"
    And Verify Clearance Scheme is not equal to "BSO"
    And Verify Clearance Mode is not equal to "CAGED"
    And Verify Selection Code is equal to "GEM"
    And Verify Selection Code is not equal to "CDN"
    And Verify Commodity category is equal to "NON_CONTROLLED"
    Then Unassign the Shipment

    Examples: 
      | SheetName | ColumnName | RowNumber |
      | TeamRule  | AWB Number |         2 |

  @CICD
  Scenario Outline: TeamRule_03_9713: Validating shipment rules for CDN Team
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "CDN"
    #And Disable Team "Default"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Verify Clearance Scheme is not equal to "DOC"
    And Verify Selection Code is equal to "GEM"
    And Verify Selection Code is equal to "CDN"
    And Verify Selection Code is not equal to "SMOW"
    Then Unassign the Shipment

    Examples: 
      | SheetName | ColumnName | RowNumber |
      | TeamRule  | AWB Number |         3 |

  @CICD
  Scenario Outline: TeamRule_04_9714: Validating shipment rules for Company Audit Team
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "Company Audit"
    #And Disable Team "Default"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Verify Clearance Status as "COMPANY AUDIT CHECK"
    #And Verify Consignee Company Name contains "MAXLINEAR"
    And Verify Consignee Company Name contains "INGRAM MICRO ASIA"
    And Verify Clearance Scheme is not equal to "DOC"
    And Verify Selection Code is equal to "GEM"
    And Verify Selection Code is not equal to "SMOW"
    Then Unassign the Shipment

    Examples: 
      | SheetName | ColumnName | RowNumber |
      | TeamRule  | AWB Number |         4 |

  @CICD
  Scenario Outline: TeamRule_05_9715: Validating shipment rules for EDI Ready Team
    Given User clicks on "ENTRY_BUILD" competency
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Select Team as "EDI Ready"
    #And Disable Team "Default"
    And Filter using columnname "Clearance Status" as "EDI Ready"
    #And Filter using Clearance Status as "EDI Ready"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Verify Clearance Status as "EDI READY"
    And Verify Selection Code is equal to "GEM"
    And Verify Clearance Scheme is not equal to "DOC"
    And Verify Selection Code is not equal to "SMOW"
    Then Unassign the Shipment

    Examples: 
      | SheetName | ColumnName | RowNumber |
      | TeamRule  | AWB Number |         5 |

  @CICD
  Scenario Outline: TeamRule_06_9715: Validating shipment rules for EDI Reject Team
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "EDI Reject"
    #And Disable Team "Default"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Verify Clearance Status as "CUSTOMS REJECTED"
    And Verify Selection Code is equal to "GEM"
    And Verify Clearance Scheme is not equal to "DOC"
    And Verify Selection Code is not equal to "SMOW"
    Then Unassign the Shipment

    Examples: 
      | SheetName | ColumnName | RowNumber |
      | TeamRule  | AWB Number |         6 |

  @CICD
  Scenario Outline: TeamRule_07_9717: Validating shipment rules for EDI Complete Team
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "EDI Complete"
    And Filter using columnname "Clearance Status" as "Customs"
    #And Filter using Clearance Status as "Customs"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Verify Clearance Scheme is not equal to "DOC"
    And Verify Selection Code is not equal to "SMOW"
    Then Unassign the Shipment

    Examples: 
      | SheetName | ColumnName | RowNumber |
      | TeamRule  | AWB Number |         7 |

  @CICD
  Scenario Outline: TeamRule_08_9718: Validating shipment rules for High GST Team
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "High GST"
    #And Disable Team "Default"
    And Filter using columnname "Clearance Status" as "GST Check"
    #And Filter using Clearance Status as "GST Check"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Verify Clearance Status as "GST CHECK"
    And Verify Selection Code is equal to "GEM"
    And Verify Clearance Scheme is not equal to "DOC"
    And Verify Selection Code is not equal to "SMOW"
    Then Unassign the Shipment

    Examples: 
      | SheetName | ColumnName | RowNumber |
      | TeamRule  | AWB Number |         8 |

  @CICD
  Scenario Outline: TeamRule_09_9719: Validating shipment rules for HVU Ready Team
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "HVU"
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Filter using columnname "Clearance Status" as "HVU Ready"
    #And Filter using Clearance Status as "HVU Ready"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Verify Clearance Status as "HVU READY"
    And Verify Clearance Mode is equal to "GF"
    And Verify Selection Code is equal to "GEM"
    And Verify Clearance Scheme is not equal to "DOC"
    And Verify Selection Code is not equal to "SMOW"
    Then Unassign the Shipment

    Examples: 
      | SheetName | ColumnName | RowNumber |
      | TeamRule  | AWB Number |         9 |

  @CICD
  Scenario Outline: TeamRule_10_9720: Validating shipment rules for MOW Team
    #Given User clicks on "ENTRY_BUILD" competency
    Given User clicks on "MANIFEST_CHECK" competency
    And Select Team as "MOW"
    #And Disable Team "Default"
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Verify Commodity category is equal to "MOW"
    And Verify Clearance location is equal to "SIN"
    And Verify Selection Code is equal to "GEM"
    And Verify Selection Code is not equal to "SMOW"
    Then Unassign the Shipment

    Examples: 
      | SheetName | ColumnName | RowNumber |
      | TeamRule  | AWB Number |        10 |

  @CICD
  Scenario Outline: TeamRule_11_9721: Validating shipment rules for PHANTOM NOT ETD Team
    #Given User clicks on "ENTRY_BUILD" competency
    Given User clicks on "MANIFEST_CHECK" competency
    And Select Team as "Phantom"
    #And Disable Team "Default"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Verify Scans is equal to N
    And Verify Selection Code is equal to "GEM"
    And Verify Selection Code is not equal to "SMOW"
    #And Verify Selection Code is not equal to "GEM"
    Then Unassign the Shipment

    Examples: 
      | SheetName | ColumnName | RowNumber |
      | TeamRule  | AWB Number |        11 |

  @CICD
  Scenario Outline: TeamRule_12_9722: Validating shipment rules for SG Team
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "SG ("
    #And Disable Team "Default"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Verify Clearance Status as "IN PROGRESS"
    And Verify Commodity category is equal to "CONTROLLED"
    And Verify Clearance Scheme is not equal to "DOC"
    And Verify Selection Code is equal to "GEM"
    And Verify Selection Code is not equal to "CDN"
    And Verify Selection Code is not equal to "SMOW"
    #And Verify Selection Code is not equal to "GEM"
    And Verify Consignee Company Name does not contain "MEDTRONIC"
    And Verify Consignee Company Name does not contain "IBM M"
    And Verify Consignee Company Name does not contain "HITACHI V"
    And Verify Consignee Company Name does not contain "COVIDIEN"
    And Verify Consignee Company Name does not contain "ABBOTT"
    And Verify Clearance Scheme is not equal to "BSO"
    And Verify Clearance Mode is not equal to "CAGED"
    Then Unassign the Shipment

    Examples: 
      | SheetName | ColumnName | RowNumber |
      | TeamRule  | AWB Number |        12 |

  @CICD
  Scenario Outline: TeamRule_13_9723: Validating SG Select Customers Team
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "SG Select Customers"
    #And Disable Team "Default"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Verify Clearance Status as "IN PROGRESS"
    And Verify Commodity category is equal to "CONTROLLED"
    And Verify Clearance Scheme is not equal to "DOC"
    And Verify Selection Code is not equal to "CDN"
    And Verify Selection Code is not equal to "SMOW"
    And Verify Selection Code is equal to "GEM"
    And Verify Consignee Company Name
    And Verify Clearance Scheme is not equal to "BSO"
    And Verify Clearance Mode is not equal to "CAGED"
    Then Unassign the Shipment

    Examples: 
      | SheetName | ColumnName | RowNumber |
      | TeamRule  | AWB Number |        13 |

  @CICD
  Scenario Outline: TeamRule_14_9724: Validating shipment rules for TN CAGED Team
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "TN Cage"
    #And Disable Team "Default"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Verify Clearance Mode is equal to "CAGED"
    And Verify Clearance Scheme is not equal to "DOC"
    And Verify Selection Code is not equal to "RLS"
    And Verify Selection Code is not equal to "AAA"
    And Verify Selection Code is not equal to "CDN"
    And Verify Selection Code is equal to "GEM"
    And Verify Selection Code is not equal to "SMOW"
    And Verify Clearance Scheme is not equal to "BSO"
    Then Unassign the Shipment

    Examples: 
      | SheetName | ColumnName | RowNumber |
      | TeamRule  | AWB Number |        14 |

  @CICD
  Scenario Outline: TeamRule_15_9725: Validating shipment rules for ACCS Team
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    #And Disable Team "Default"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Verify Selection Code is not equal to "GEM"
    And Verify Selection Code is not equal to "SMOW"
    Then Unassign the Shipment

    Examples: 
      | SheetName | ColumnName | RowNumber |
      | TeamRule  | AWB Number |        15 |

  @CICD
  Scenario Outline: TeamRule_16_9711: Validating shipment rules for Exception Team
    Given User clicks on "MANIFEST_CHECK" competency
    And Select Team as "Exception"
    #And Disable Team "Default"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Verify Selection Code is equal to "GEM"
    And Verify Selection Code is not equal to "SMOW"
    Then Unassign the Shipment

    Examples: 
      | SheetName | ColumnName | RowNumber |
      | TeamRule  | AWB Number |        16 |
