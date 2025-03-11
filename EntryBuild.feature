@Regression
Feature: Automation SG - Entry Build Module

  Background: Flow till login page
    Given User is in Gemini application login page

  @CICD
  Scenario Outline: EntryBuild_01_9419: Verify if URG sort code is added from Activity log and should be displayed in floating panel
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    #And Disable Team "Default"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    #And Add the sort code "URG" and save it succesfully in Declaration Page
    #And All columns in modal window are enabled
    Then Click on Sort Message on Floating Panel and select 'URG'
    Then Click on User List icon
    And Verify Selection Code is equal to "URG"
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |         1 |

  @CICD
  Scenario Outline: EntryBuild_02_9432: Verify if URG sort code is removed from Activity log and should be displayed in floating panel
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    #And Disable Team "Default"
    And Filter using columnname "Selection Codes" as "URG"
    #And Filter using Selection Codes as "URG"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    Then Click on Sort Message on Floating Panel and select 'FRC'
    #And Remove the sort code "URG" and save it succesfully in Declaration Page
    Then Click on User List icon
    #And All columns in modal window are enabled
    And Verify Selection Code is not equal to "URG"
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |         2 |

  @CICD
  Scenario Outline: EntryBuild_03_9392: Validate autocomplete suggestions function of selection code in SortMessage window
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    #And Disable Team "Default"
    #And Filter using Selection Codes as "URG"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>" 
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    #And Add the sort code "BOND" and save it succesfully in Declaration Page
    Then Click on Sort Message on Floating Panel and select 'BOND'
    And Click on User List
    #And All columns in modal window are enabled
    And Verify Selection Code is equal to "BOND"
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |         3 |

  #@CICD  #//Data needs to input to this test case//
  #Scenario Outline: EntryBuild_04_9395: Validate HS code icons under Commodity details in Declaration Information Screen
  #Given User clicks on "ENTRY_BUILD" competency
  #And Select Team as "ACCS Shipments"
  #And Disable Team "Default"
  #And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
  #And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
  #And Click on Assign to me
  #And Click on User List
  #And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
  #And Double click on the first shipment
  #And Verify HS Code Multimatch Icon is displayed
  #And Input the HS code and Select the HS code through Search Icon
  #And Verify HS Code Match Icon
  #Then Cancel the Decalaration
  #Then Unassign the Shipment
  #
  #Examples:
  #| SheetName  | ColumnName | RowNumber |
  #| EntryBuild | AWB Number |         4 |
  
  @CICD
  Scenario Outline: EntryBuild_05_9396: Validating no HS code alert with Clearance scheme LV
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    #And Disable Team "Default"
    And Filter using columnname "Clearance Scheme" as "LV"
    #And Filter using Clearance Scheme as "LV"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    Then Click on Sort Message on Floating Panel and select 'SEC'
    Then Click on Sort Message on Floating Panel and select 'GEM'
    And Double click on the first shipment
    And Click on Validate
    #Then Toaster message should be displayed as "Commodity validation request is successful"
    And Verify Shipment details
    Then Submit the Declaration
    #Then Toaster message should be displayed as "Shipment has been submitted successfully"
    #Then Cancel the Decalaration
    # When User clicks on "ENTRY_BUILD" competency
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |         5 |

  @CICD
  Scenario Outline: EntryBuild_06_9398: Validate Declaration Information section fields
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    #And Disable Team "Default"
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Filter using columnname "Clearance Scheme" as "LV"
    #And Filter using Clearance Scheme as "LV"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And Verify if Declaration Information text is displayed with purple color and bold letters
    And Validate Importer Instructions text field in Declaration information section
    And Validate Shipment Description text field in Declaration information section
    And Validate Clearance Scheme drop down in Declaration information section
    And Validate Clearance mode drop down in Declaration information section
    And Validate Incoterm drop down in Declaration information section
    And Validate Total Value text field in Declaration information section
    And Validate Currency drop down in Declaration information section
    And Validate Weight text field in Declaration information section
    And Validate Bill duty to Code in Declaration information section
    And Validate Transport Bill to Code in Declaration information section
    And Validate Xrate in Declaration information section
    And Validate CIF in Declaration information section
    And Validate GST in Declaration information section
    And Validate PKG in Declaration information section
    And Validate Insurance in Declaration information section
    And Validate Freight in Declaration information section
    And Validate Selection Code in Declaration information section
    And Validate the location information field whether field number and mode of transport are displaying
    And Verify Total Value field value and the text box are highlighed with different colour
    Then Cancel the Decalaration
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |         6 |

  @CICD
  Scenario Outline: EntryBuild_07_9387_and_25_9411: Validate Commodity Details fields
    Given User clicks on "ENTRY_BUILD" competency
    And Filter using columnname "Clearance Scheme" as "LV"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    #And Add the sort code "GEM" and save it succesfully in Declaration Page
    #And Remove the sort code "AGRI" and save it succesfully in Declaration Page
    Then Click on Sort Message on Floating Panel and select 'GEM'
    And Double click on the first shipment
    And Clear HSCode required alert
    #And Clear CAGE Mode Required Alert
    And Click on the first Commodity
    And Enter the Quantity of commodity as ""
    #And Submit the Declaration
    And Click on Validate
    And Alert message should be displayed as "Please enter the quantity"
    And Enter the Quantity of commodity as "1"
    And Enter the total Value as "300"
    And Create new commodity details
    #And Enter the HS Code ""
    #And Verify HS Code is Blank and red Harmonized Code Match Icon is present
    And Enter the HS Code "52030000"
    And Verify HS Code is Filled and Green Harmonized Code Match Icon is present
    Then The Decl Value of new commodity should be total value minus the first commodity
    And CIF Field of commodity is not editable
    Then The CIF of new commodity should be total CIF minus the first commodity
    # Need to revisit the calculation
    # And GST of the Commodity should be "0.07" of CIF
    And Country of the commodity should be selected by default
    And Commodity description should be auto populated by HS Code
    And Enter the Quantity of commodity as "1"
    #And Click on Second Commodity
    And Branded value of the commodity should be "Unbranded"
    And Product value of the commodity should be ""
    And Click on Validate
    Then CIF, GST, Exchange Rate, Auto FC & Insurance should be autocalculated and displayed
    And Enter the Clearance scheme as "LV"
    And Enter the Currency as "SRD"
    And Enter the Gross Weight of the shipment as "5"
    And Enter the Incoterm as "CFR"
    And Enter the Shipment Description as "CUT SEMI PRECIOUS STONES"
    And Click on Validate
    And Select the Clearance Mode in Decalaration as "MES"
    And Click on Validate
    And No Alert should be displayed in Declaration screen
    And Cancel the Decalaration
    And Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |         7 |

  @CICD
  Scenario Outline: EntryBuild_08_9964: Verify image group name and role name related to SG
    Given User clicks on "ENTRY_BUILD" competency
    Then Verify image roles having prefix dev is added for all the SG roles

  @CICD
  Scenario Outline: EntryBuild_09_9385: Validate left side panel in Customer information to link Importer for Importer Icon
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    #And Disable Team "Default"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And User search for Importer and click on the Link Importer icon
    #Then Toaster message should be displayed as "Customer linked successfully"
    Then Cancel the Decalaration
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |         9 |

  @CICD
  Scenario Outline: EntryBuild_10_9386: Validate left side panel in Customer information to link Importer for Consignee Icon
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    #And Disable Team "Default"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And Search and Link the Consignee under Customer Information
    #Then Toaster message should be displayed as "Customer linked successfully"
    Then Cancel the Decalaration
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        10 |

  @CICD
  Scenario Outline: EntryBuild_11_9382: Validate Incoterm for SG Account location in Declaration Information Screen
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    #And Disable Team "Default"
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Filter using columnname "Incoterm" as "FOB"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And Validate Incoterm Field value "FOB"
    And Validate Bill Duty to Account Location "SG"
    Then Cancel the Decalaration
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        11 |

  @CICD
  Scenario Outline: EntryBuild_12_9383: Validate Clearance Mode for SG Account location in Declaration Information Screen
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    #And Disable Team "Default"
    And Filter using columnname "Incoterm" as "FOB"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And Validate Bill Duty to Account Location "SG"
    And Validate Incoterm Field value "FOB"
    And Verify the Clearance Mode in the dropdown as "GF"
    Then Cancel the Decalaration
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        12 |

  @CICD
  Scenario Outline: EntryBuild_13_9384: Validate Incoterm for not an SG Account location in Declaration Information Screen
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    #And Disable Team "Default"
    And Filter using columnname "Incoterm" as "CFR"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And Validate Bill Duty to Account Location is not "SG"
    And Validate Incoterm Field value "CFR"
    Then Cancel the Decalaration
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        13 |

  @CICD
  Scenario Outline: EntryBuild_14_9400: Validate Clearance Mode for not an SG Account location in Declaration Information Screen
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    #And Disable Team "Default"
    And Filter using columnname "Incoterm" as "CFR"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And Validate Bill Duty to Account Location is not "SG"
    And Validate Incoterm Field value "CFR"
    And Verify the Clearance Mode in the dropdown as "G7"
    Then Cancel the Decalaration
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        14 |

  @CICD
  Scenario Outline: EntryBuild_15_9390: BFC_Transport Bill AccountLocation for CP Automatch X-High Shipment
    Given User clicks on "MANIFEST_CHECK" competency
    And Select Team as "ACCS Shipments"
    #And Disable Team "Default"
    And Filter using columnname "Clearance Scheme" as "LV"
    #And Filter using Clearance Scheme as "LV"
    And Filter using columnname "Incoterm" as "FOB"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Override button
    And On Demand - Click on User List Icon
    #Then Toaster message should be displayed as "Sanity check overridden"
    #  And Click on User List
    And Click on Entry Build Icon
    And Select Team as "ACCS Shipments"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    Then Validate Transport Bill Account Number

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        15 |

  @CICD
  Scenario Outline: EntryBuild_16_9403: Verify the Sequence of AWB numbers in Declaration page from User List with selection code GEM
    Given User clicks on "ENTRY_BUILD" competency
    And Click on User List
    And Unassign all the shipments in user list
    And Click on team list
    And Select Team as "ATFC ("
    #And Disable Team "Default"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Fetch the AWBNo "<SheetName>","<ColumnName1>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName1>", "<RowNumber>"
    And Click on Assign to me
    And Fetch the AWBNo "<SheetName>","<ColumnName2>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName2>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Double click on the first shipment
    And Validate the AWB number "<SheetName>", "<ColumnName>", "<RowNumber>" in Declaration screen
    Then Click next button of Declaration Page
    And Validate the AWB number "<SheetName>", "<ColumnName1>", "<RowNumber>" in Declaration screen
    Then Click next button of Declaration Page
    And Validate the AWB number "<SheetName>", "<ColumnName2>", "<RowNumber>" in Declaration screen
    Then Cancel the Decalaration
    And Select all the shipments from the grid
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber | ColumnName1       | ColumnName2       |
      | EntryBuild | AWB Number |        16 | Addnl1_AWB Number | Addnl2_AWB Number |

  @CICD
  Scenario Outline: EntryBuild_17_9404: Click on Rework button for Multiple clearance status Shipments
    Given User clicks on "ENTRY_BUILD" competency
    And Click on User List
    And Unassign all the shipments in user list
    And Click on team list
    And Select Team as "EDI Ready"
    #And Disable Team "Default"
    And Filter using columnname "Clearance Status" as "EDI SENT FROM GEMINI"
    And Click on Assign to me
    And Select Team as "EDI Reject"
    #And Disable Team "EDI Ready"
    And Filter using columnname "Clearance Status" as "CUSTOMS REJECTED"
    And Click on Assign to me
    And Click on User List
    Then Save two AWB numbers from grid in "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Select all the shipments from the grid
    And Click on rework shipment
    And Click on Global search icon
    Then Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>" in Global Search popup
    Then Verify Clearance Status as "UNWORKED"
    And Close Global Search Window
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        17 |

  @CICD
  Scenario Outline: EntryBuild_18_9401: Verify if Commodity Details Displays Previous Shipment Data once the user is navigated to next shipment
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "EDI Ready"
    #And Disable Team "Default"
    And Filter using columnname "Clearance Status" as "EDI Ready"
    And Read 2 shipment AWB number "<SheetName>","<ColumnName>","<RowNumber>"
    ##And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Filter using "AWB Number" as "In"
    And Search the Multiple shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click toggle to select all available shipment
    And Click on Assign to me
    And Click on User List
    And Filter using "AWB Number" as "In"
    And Search the Multiple shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And Enter Commodity Description "Commodity Details Updated"
    Then Submit the Declaration
    #And Click Next in Commodity Description Page
    And Verify if commodity description is same as previous shipment
    Then Cancel the Decalaration
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        18 |

  @CICD
  Scenario Outline: EntryBuild_19_9405: Validation in Entry Build COM ValidCtryCode
    Given User clicks on "MANIFEST_CHECK" competency
    And Select Team as "ACCS Shipments"
    #And Disable Team "Default"
    And Filter using columnname "Clearance Scheme" as "LV"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Override button
    #Then Verify popup "Sanity check overridden"
    And On Demand - Click on User List Icon
    #And Click on User List
    And Click on Entry Build Icon
    And Select ACSS Shipments toggle in Entry Build
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And Verify COM Alerts
    And Verify clearnce mode should not be "CAGED"

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        19 |

  @CICD
  Scenario Outline: EntryBuild_20_9426: Verify Priority shipment for service code 06/17/18/70/84/86/94/1P
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    #And Disable Team "Default"
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Filter using columnname "Service Code" as "70"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Verify Commodity category is equal to "PRIORITY_SHIPMENT"
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        20 |

  @CICD
  Scenario Outline: EntryBuild_21_9410: Verify Clearance Mode changed to Brokerage Type of the Importer when Brokerage type is MES/AISS
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    #And Disable Team "Default"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And Search and Link the Importer under Customer Information using company name "Test1234"
    #Then Toaster message should be displayed as "Customer linked successfully"
    And Verify the Clearance Mode in the dropdown as "AISS"
    Then Cancel the Decalaration
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        21 |

  @CICD
  Scenario Outline: EntryBuild_22_9421: Verify Clearance Mode changed to Brokerage Type of the Importer when Determent type is G7/GF
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    #And Disable Team "Default"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And Search and Link the Importer under Customer Information using company name "NEW FAMILY-COM PTE LTD"
    #Then Toaster message should be displayed as "Customer linked successfully"
    And Verify the Clearance Mode in the dropdown as "GF"
    #And Verify the Clearance Mode is updated changed after customer link
    Then Cancel the Decalaration
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        22 |

  @CICD
  Scenario Outline: EntryBuild_23_9423: Verify Clearance Mode remains unchanged if Broker Type/Deferment Type is present
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    #And Disable Team "Default"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And Read the Clearance mode
    And Search and Link the Importer under Customer Information using company name "Test123"
    #Then Toaster message should be displayed as "Customer linked successfully"
    And Verify the Clearance Mode remains unchanged
    Then Cancel the Decalaration
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        23 |

  @CICD
  Scenario Outline: EntryBuild_24_9415: Verify newly Added and Removed Locations in Declaration Information Screen
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    #And Disable Team "Default"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And Verify added and removed locations
    Then Cancel the Decalaration
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        24 |

  @CICD
  Scenario Outline: EntryBuild_25_9418: Verify Commodity Group for SpecialHandCode14_AccessibleDangerousGoods
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    #And Disable Team "Default"
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Filter using columnname "Special handling code" as "14"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Verify Commodity category is equal to "PRIORITY_SHIPMENT"
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        25 |

  @CICD
  Scenario Outline: EntryBuild_26_9427: Verify Commodity Group for SpecialHandCode04_ Inaccessible Dangerous Goods
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    #And Disable Team "Default"
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Filter using columnname "Special handling code" as "04"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Verify Commodity category is equal to "PRIORITY_SHIPMENT"
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        26 |

  @CICD
  Scenario Outline: EntryBuild_27_9430: Verify Commodity Group for SpecialHandCode06_Dry Ice
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    #And Disable Team "Default"
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Filter using columnname "Special handling code" as "06"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Verify Commodity category is equal to "PRIORITY_SHIPMENT"
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        27 |

  @CICD
  Scenario Outline: EntryBuild_28_9433: Verify Commodity Group for SpecialHandCode15 - Priority Alert
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    #And Disable Team "Default"
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Filter using columnname "Special handling code" as "15"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Verify Commodity category is equal to "PRIORITY_SHIPMENT"
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        28 |

  @CICD
  Scenario Outline: EntryBuild_29_9435: Verify Commodity Group for SpecialHandCode37 - Priority Alert Plus
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    #And Disable Team "Default"
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Filter using columnname "Special handling code" as "37"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Verify Commodity category is equal to "PRIORITY_SHIPMENT"
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        29 |

  @CICD
  Scenario Outline: EntryBuild_30_9447: Verify Commodity Group for SpecialHandCode73 - Fully Regulated DG
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    #And Disable Team "Default"
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Filter using columnname "Special handling code" as "73"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Verify Commodity category is equal to "PRIORITY_SHIPMENT"
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        30 |

  @CICD
  Scenario Outline: EntryBuild_31_9438: Verify Commodity Group for SpecialHandCode38- ON DEMAND CARE - DRY ICE
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    #And Disable Team "Default"
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Filter using columnname "Special handling code" as "38"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Verify Commodity category is equal to "PRIORITY_SHIPMENT"
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        31 |

  @CICD
  Scenario Outline: EntryBuild_32_9440: Verify Commodity Group for SpecialHandCode59_OnDemandCare-ColdStorage
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    #And Disable Team "Default"
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Filter using columnname "Special handling code" as "59"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Verify Commodity category is equal to "PRIORITY_SHIPMENT"
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        32 |

  @CICD
  Scenario Outline: EntryBuild_33_9412: Verify Consignee Company MDE from Columnconfiguration Teamlist in Entry Build module
    Given User clicks on "ENTRY_BUILD" competency
    And Add the Column "Consignee Company-MDE" in the grid
    Then Verify Consignee Company MDE in shipment results

  @CICD
  Scenario Outline: EntryBuild_34_9424: Verify Consignee Company MDE from Columnconfiguration Teamleader List list in Entry Build module
    Given User clicks on "ENTRY_BUILD" competency
    When User click on Team Leader List
    And Add the Column "Consignee Company-MDE" in the grid
    Then Verify Consignee Company MDE in shipment results

  @CICD
  Scenario Outline: EntryBuild_35_9429: Verify Consignee Company MDE from Columnconfiguration User list in Entry Build module
    Given User clicks on "ENTRY_BUILD" competency
    When Click on User List
    When User click Column Configuration
    And Add the Column "Consignee Company-MDE" in the grid
    Then Verify Consignee Company MDE in shipment results

  @CICD
  Scenario Outline: EntryBuild_36_9444: Verify removal of URG sort code is reflected in grid - selecetion code and in declaraion screen
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    #And Disable Team "Default"
    And Filter using columnname "Selection Codes" as "URG"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    Then Click on Sort Message on Floating Panel and select 'FRC'
    And Double click on the first shipment
    #And Remove the sort code "URG" and save it succesfully in Declaration Page
    Then Validate the selection codes "URG","XYZ" not in Declaration Page
    And Cancel the Decalaration
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        36 |

  @CICD
  Scenario Outline: EntryBuild_37_9961: Verify Auto EDI Flag is set to N for LV Shipment
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "EDI Ready"
    #And Disable Team "Default"
    And Filter using columnname "Clearance Status" as "EDI Ready"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    Then Submit the Declaration
    And Click on Global search
    Then Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    #Then Cancel the Decalaration
    And Add the Column "Auto EDI Flag" in the grid
    And Verify Clearance Status as "EDI READY"
    And Verify Auto EDI Flag is equal to "N"
    And Click Close Global search
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        37 |

  @CICD
  Scenario Outline: EntryBuild_38_9962: Verify IOR from Columnconfiguration Teamlist in Entry Build module
    Given User clicks on "ENTRY_BUILD" competency
    #When User click Column Configuration
    #And Add the Column "IOR" in the grid
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Filter using columnname "IOR" as "1"
    Then Verify column IOR in shipment results

  @CICD
  Scenario Outline: EntryBuild_39_1631993:Perform Global Search [ assign the user to self and others ]
    Given User clicks on "ENTRY_BUILD" competency
    When Click on team leader list
    And Read limited shipment AWB number "<SheetName>","<ColumnName>","<RowNumber>"
    And select the shipment
    When Click on Assign to me in TeamLeader List
    And Wait for page to retrieve the user list
    Then Select multiple user and submit
    When Click on Global search
    And Enter multiple shipment value "<SheetName>","<ColumnName>","<RowNumber>"
    And Click on Shipment Search

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        39 |

  @CICD
  Scenario Outline: EntryBuild_40_1631993:Shipment reassignment from user list
    Given User clicks on "ENTRY_BUILD" competency
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Click on Add Notification and add comment for all competencies as "Entry Build Team List"
    And Filter using columnname "Image Flag" as "Y"
    #And Filter using Image Flag as "Y","<SheetName>","<ColumnName>","<RowNumber>"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    Then Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    When Click on Assign to Me icon
    Then Click on User List icon
    Then Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Add Notification and add comment for all competencies as "Entry Build User List"
    And Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        40 |

  @CICD
  Scenario: EntryBuild_41_1631993:Verify Filter and Sort in Grid Columns
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    Then Click on team list
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Read the column "AWB Number" and verify the sorting is successful

  # And Read the column "Clearance Scheme" and verify the sorting is successful
  @CICD
  Scenario: EntryBuild_42_1631993:Verify Filter and Sort in Grid Columns
    Given User clicks on "ENTRY_BUILD" competency
    When Click on team leader list
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Click on Add Notification and add comment for all competencies as "Entry Build Team Leader List"
    And Read the column "AWB Number" and verify the sorting is successful

  # And Read the column "Clearance Scheme" and verify the sorting is successful
  @CICD
  Scenario Outline: EntryBuild_43_1631993:Verify Filter and Sort in Grid Columns
    Given User clicks on "ENTRY_BUILD" competency
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Filter using clearance scheme as "LV","<SheetName>","<ColumnName>","<RowNumber>"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Filter using clearance scheme as "HV","<SheetName>","<ColumnName>","<RowNumber>"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    Then Click on User List
    And Read the column "AWB Number" and verify the sorting is successful

    #And Read the column "Clearance Scheme" and verify the sorting is successful
    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        43 |

  @CICD
  Scenario Outline: EntryBuild_44_Verify clearance scheme based on the CIF values
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    Then Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    Then Change the total value to "396.04"
    Then Update currency in declaration screen "SGD"
    Then Update clearance scheme in declaration screen "LV"
    Then Expand the commodity details
    And Click on Validate
    Then Verify CIF value is "400.00"
    Then Change the total value to "396.03"
    Then Update currency in declaration screen "SGD"
    Then Update clearance scheme in declaration screen "LV"
    Then Expand the commodity details
    And Click on Validate
    Then Verify CIF value is "399.99"
    Then Change the total value to "396.05"
    Then Update currency in declaration screen "SGD"
    Then Update clearance scheme in declaration screen "HV"
    Then Expand the commodity details
    And Click on Validate
    Then Verify CIF value is "400.01"
    Then Change the total value to "397.02"
    Then Update currency in declaration screen "SGD"
    Then Update clearance scheme in declaration screen "HV"
    Then Expand the commodity details
    And Click on Validate
    Then Verify CIF value is "400.99"
    Then Change the total value to "19801.98"
    Then Update currency in declaration screen "SGD"
    Then Update clearance scheme in declaration screen "HV"
    Then Expand the commodity details
    And Click on Validate
    Then Verify CIF value is "20000.00"

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        44 |

  @CICD
  Scenario Outline: EntryBuild_45_Auto-exit to EB grid view after submitting last shipment
    Given User clicks on "ENTRY_BUILD" competency
    When Click on User List icon
    Then Unassign the Shipment
    And Click on team list
    And Select Team as "EDI Ready"
    #And Disable Team "Default"
    And Read 2 shipment AWB number "<SheetName>","<ColumnName>","<RowNumber>"
    And Filter using "AWB Number" as "In"
    And Search the Multiple shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click toggle to select all available shipment
    And Click on Assign to me
    Then Click on User List
    And Double click on the first shipment
    And Click on Validate
    And Submit the Declaration
    And Click on Validate
    And Submit the Declaration

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        45 |

  @CICD
  Scenario Outline: EntryBuild_46_ Verify Download icon  in Entry build Activity log
    Given User clicks on "ENTRY_BUILD" competency
    And Click on activity log and download
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    When Click on Assign to me
    Then Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Activity log in floating panel
    Then Click on the Download Icon

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        46 |

  @CICD
  Scenario Outline: EntryBuild_47_ Verify Download icon in Conveyance Action history.
    Given User clicks on "CONVEYANCE" competency
    And click Search icon
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Enter Conveyance Number "<SheetName>", "<ColumnName>", "<RowNumber>"
    Then Select First Record from the Grid
    Then Click on the Download Icon

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        47 |

  @CICD
  Scenario Outline: EntryBuild_48_TC05_Verify Download icon in Activity log Global search
    Given User clicks on "ENTRY_BUILD" competency
    And Read 2 shipment AWB number "<SheetName>","<ColumnName>","<RowNumber>"
    Given Click on Global search
    When Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Click on Activity log in floating panel
    Then Click on the Download Icon

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        48 |

  @CICD
  Scenario Outline: EntryBuild_49: TC05_Validating no HS code alert with Clearance scheme LV
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    And Filter using columnname "Clearance Scheme" as "HV"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And Display all alerts

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        49 |

  @CICD
  Scenario Outline: EntryBuild_50_1631993:TCP09_Enable Cycle Assignment in Team Leader list view for EDI Ready and Non EDI Ready team
    Given User clicks on "ENTRY_BUILD" competency
    When Click on team leader list
    When enable all the teams

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        50 |

  @CICD
  Scenario Outline: EntryBuild_51_1631993:TC52_Validating Arrivaldate and Commitmentdate format
    When User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    Then Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Disable the columns in modal window
    And Enable the required columns in modal window
    Then Moveover to commintmentdate and  Arrivaldate "<SheetName>","<ColumnName>","<RowNumber>"

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        51 |

  @CICD
  Scenario Outline: EntryBuild_52_8444: Perform Global Search [ Assign shipment to others Id's and verify using global Search in user list ]
    Given User clicks on "ENTRY_BUILD" competency
    And Click on team leader list
    And Select ACSS Shipments toggle in team leader list
    And Click on activity log and download
    And Read 2 shipment AWB number "<SheetName>","<ColumnName>","<RowNumber>"
    When Click on Assign to me in TeamLeader List
    And Select any 2 user and submit
    #And Toaster message should be displayed as "Shipments Assigned To User Successfully"
    Then Assigned To of selected 2 shipments should be assigned to user in round robin
    And Click on Global search
    When Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Verify selected shipments assigned to Userlist "<SheetName>","<ColumnName>","<RowNumber>"

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        52 |

  @CICD
  Scenario Outline: EntryBuild_53_8444: Verify sort codes should  be allowed to be addedd when the single or multiple shipments are locked and for the same shipment is accessed by same user
    Given User clicks on "ENTRY_BUILD" competency
    Then Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And Click on the Duplicate Tab
    And Switch to the Last Window "Child"
    And User login again Gemini application
    Given Click on Global search
    When Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    Then Click on Sort Message in Floating Panel and select 'FRC'
    And Verify Selection Code is equal to "FRC"

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        53 |

  @CICD
  Scenario Outline: EntryBuild_54_17769: Verify unassignment of  EDI Sent from GEMINI shipment in two tabs
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ATFC Prioity"
    And Filter using columnname "Clearance Scheme" as "LV"
    Then Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    Then Click on Sort Message on Floating Panel and select 'GEM'
    And Click on Validate
    And Submit the Declaration
    And Click on User List
     And Click on Global search
    Then Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Assign the shipment in the GlobalSearch
    And Select only 1 user and submit
    And Click Close Global search
    And Click on User List
    And Verify Clearance Status as "EDI READY"
    And Click on the Duplicate Tab
    And Switch to the Last Window "Child"
    And User login again Gemini application
    Given User clicks on "ENTRY_BUILD" competency
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Cycle changes
    And Set the Cycle Date and select the Cycle number "13"
    Then Click on Save in Cycle Change
    And Click on the Console Submission
    And Select Cycle Date and select the record with cycle Date "13"
    And Submit the Console Submission
    And Click Cancel on Console Submission
    And Click on User List
    And Click on Global search
    And Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    Then Verify Clearance Status as "EDI SENT FROM GEMINI"
    And Switch to the Last Window "Parent"
    And Verify Clearance Status as "EDI READY"
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        54 |

  @CICD
  Scenario Outline: EntryBuild_55_17771: Verify shipment having clearance status CUSTOMS RELEASED_ CUSTOMS INSPECTION_ CUSTOMS REJECTED_EDI SENT FROM GEMINI is not removed from user list after unassignment
    Given User clicks on "ENTRY_BUILD" competency
    And Click on User List
    And Unassign all the shipments in user list
    And Click on team list
    And Select Team as "EDI Ready"
    And Filter using columnname "Clearance Status" as "EDI SENT FROM GEMINI"
    And Click on Assign to me
    And Select Team as "EDI Complete"
    And Filter using columnname "Clearance Status" as "Customs"
    And Click on Assign to me
    And Click on User List
    Then Save two AWB numbers from grid in "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Select all the shipments from the grid
    # Then Unassign the Shipment
    Then Click on Unassign icon but shipments should be display

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        55 |

  @CICD
  Scenario Outline: EntryBuild_56_17681_Verify all icons below the grid view of Entry Build user list are enabled
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    Then Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Select Team as "EDI Ready"
    And Filter using columnname "Clearance Status" as "EDI Ready"
    Then Fetch the AWBNo "<SheetName>","<ColumnName1>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName1>", "<RowNumber>"
    And Click on Assign to me
    And Select Team as "HVU"
    And Filter using columnname "Clearance Status" as "HVU Ready"
    Then Fetch the AWBNo "<SheetName>","<ColumnName2>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName2>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Click on all Icons in the Grid
    And Click on Modify Clearance Scheme button
    And Modify Clearance Scheme to "BSO"
    When Click Add Notification and add comment as "Test Comments Added"
    #Then click save button
    And Filter using columnname "Clearance Status" as "EDI Ready"
    And Click on Cycle changes
    And Set the Cycle Date and select the Cycle number "13"
    Then Click on Save in Cycle Change
    And Click on the Console Submission
    And Select Cycle Date and select the record with cycle Date "13"
    And Submit the Console Submission
    And Click Cancel on Console Submission
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber | ColumnName1       | ColumnName2       |
      | EntryBuild | AWB Number |        56 | Addnl1_AWB Number | Addnl2_AWB Number |

              #  In Staging env we can't run this TC, because Client Credentials issues
  @CICD
  Scenario Outline: EntryBuild_57_18393_E-421247 Ability to verify submitTeam field captured ATFC team after Entry Build submission
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ATFC ("
    And Fliter Arrival Date with latest shipment
    And Filter using columnname "Clearance Scheme" as "LV"
    Then Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Call the webservices to verify the class version id for awb "<SheetName>","<ColumnName>","<RowNumber>" is greaterthanOrEqual to '17'
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    Then Change the total value to "296.04"
    Then Update currency in declaration screen "SGD"
    Then Expand the commodity details
    Then Click on Sort Message on Floating Panel and select 'GEM'
    And Click on Validate
    And Submit the Declaration
    And Click on User List
    And Call the webservice to verify submitTeam is "<SheetName>","<ColumnName>","<RowNumber>",'ATFC'
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        57 |
      
       #  In Staging env we can't run this TC, because Client Credentials issues

  @CICD
  Scenario Outline: EntryBuild_58_18395_E-421247 Ability to verify submitTeam field captured ACCS Shipments team after Entry Build submission
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    And Fliter Arrival Date with latest shipment
    And Filter using columnname "Clearance Scheme" as "LV"
    Then Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Call the webservices to verify the class version id for awb "<SheetName>","<ColumnName>","<RowNumber>" is greaterthanOrEqual to '17'
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    Then Change the total value to "296.04"
    Then Update currency in declaration screen "SGD"
    Then Expand the commodity details
    Then Click on Sort Message on Floating Panel and select 'GEM'
    And Click on Validate
    And Submit the Declaration
    And Click on User List
    And Call the webservice to verify submitTeam is "<SheetName>","<ColumnName>","<RowNumber>",'ACCS Shipments'
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        58 |
      
       #  In Staging env we can't run this TC, because Client Credentials issue
  @CICD
  Scenario Outline: EntryBuild_59_18397_E-421247 Ability to verify submitTeam field captured SG team after Entry Build submission
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "SG ("
    And Fliter Arrival Date with latest shipment
    And Filter using columnname "Clearance Scheme" as "LV"
    Then Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Call the webservices to verify the class version id for awb "<SheetName>","<ColumnName>","<RowNumber>" is greaterthanOrEqual to '17'
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    Then Change the total value to "296.04"
    Then Update currency in declaration screen "SGD"
    Then Expand the commodity details
    Then Click on Sort Message on Floating Panel and select 'GEM'
    And Click on Validate
    And Submit the Declaration
    And Click on User List
    And Call the webservice to verify submitTeam is "<SheetName>","<ColumnName>","<RowNumber>",'SG'
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        59 |
      
       #  In Staging env we can't run this TC, because Client Credentials issues

  @CICD
  Scenario Outline: EntryBuild_60_18393_E-421247 Ability to verify submitTeam field captured ATFC Prioity team after Entry Build submission
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ATFC Prioity ("
    And Fliter Arrival Date with latest shipment
    And Filter using columnname "Clearance Scheme" as "LV"
    Then Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Call the webservices to verify the class version id for awb "<SheetName>","<ColumnName>","<RowNumber>" is greaterthanOrEqual to '17'
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    Then Change the total value to "296.04"
    Then Update currency in declaration screen "SGD"
    Then Expand the commodity details
    Then Click on Sort Message on Floating Panel and select 'GEM'
    And Click on Validate
    And Submit the Declaration
    And Click on User List
    And Call the webservice to verify submitTeam is "<SheetName>","<ColumnName>","<RowNumber>",'ATFC Prioity'
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        60 |
      
       #  In Staging env we can't run this TC, because Client Credentials issues

  @CICD
  Scenario Outline: EntryBuild_61_18393_E-421247 Ability to verify submitTeam field captured SG Priority team after Entry Build submission
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "SG Priority ("
    And Fliter Arrival Date with latest shipment
    And Filter using columnname "Clearance Scheme" as "LV"
    Then Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Call the webservices to verify the class version id for awb "<SheetName>","<ColumnName>","<RowNumber>" is greaterthanOrEqual to '17'
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    Then Change the total value to "296.04"
    Then Update currency in declaration screen "SGD"
    Then Expand the commodity details
    Then Click on Sort Message on Floating Panel and select 'GEM'
    And Click on Validate
    And Submit the Declaration
    And Click on User List
    And Call the webservice to verify submitTeam is "<SheetName>","<ColumnName>","<RowNumber>",'SG Priority'
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        61 |
      
       #  In Staging env we can't run this TC, because Client Credentials issues

  @CICD
  Scenario Outline: EntryBuild_62_18393_E-421247 Ability to verify submitTeam field captured ATFC Select Customers team after Entry Build submission
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ATFC Select Customers"
    #And Fliter Arrival Date with latest shipment
    And Filter using columnname "Clearance Scheme" as "LV"
    Then Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Call the webservices to verify the class version id for awb "<SheetName>","<ColumnName>","<RowNumber>" is greaterthanOrEqual to '17'
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    Then Change the total value to "296.04"
    Then Update currency in declaration screen "SGD"
    Then Expand the commodity details
    Then Click on Sort Message on Floating Panel and select 'GEM'
    And Click on Validate
    And Submit the Declaration
    And Click on User List
    And Call the webservice to verify submitTeam is "<SheetName>","<ColumnName>","<RowNumber>",'ATFC Select Customers'
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        62 |
      
       #  In Staging env we can't run this TC, because Client Credentials issues

  @CICD
  Scenario Outline: EntryBuild_63_18393_E-421247 Ability to verify submitTeam field captured SG Select Customers team after Entry Build submission
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "SG Select Customers"
    #And Fliter Arrival Date with latest shipment
    And Filter using columnname "Clearance Scheme" as "LV"
    Then Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Call the webservices to verify the class version id for awb "<SheetName>","<ColumnName>","<RowNumber>" is greaterthanOrEqual to '17'
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    Then Change the total value to "296.04"
    Then Update currency in declaration screen "SGD"
    Then Expand the commodity details
    Then Click on Sort Message on Floating Panel and select 'GEM'
    And Click on Validate
    And Submit the Declaration
    And Click on User List
    And Call the webservice to verify submitTeam is "<SheetName>","<ColumnName>","<RowNumber>",'SG Select Customers'
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        63 |
      
       #  In Staging env we can't run this TC, because Client Credentials issues

  @CICD
  Scenario Outline: EntryBuild_64_18393_E-421247 Ability to verify submitTeam field captured BSO team after Entry Build submission
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "BSO Team"
    #And Fliter Arrival Date with latest shipment
    #And Filter using columnname "Clearance Scheme" as "LV"
    Then Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Call the webservices to verify the class version id for awb "<SheetName>","<ColumnName>","<RowNumber>" is greaterthanOrEqual to '17'
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    Then Change the total value to "296.04"
    Then Update currency in declaration screen "SGD"
    Then Expand the commodity details
    Then Update clearance scheme in declaration screen "LV"
    And Select the Clearance Mode in Decalaration as "DEMIN"
    Then Click on Sort Message on Floating Panel and select 'GEM'
    And Click on Validate
    And Submit the Declaration
    And Click on User List
    And Call the webservice to verify submitTeam is "<SheetName>","<ColumnName>","<RowNumber>",'BSO Team'
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        64 |
      
       #  In Staging env we can't run this TC, because Client Credentials issues

  @CICD
  Scenario Outline: EntryBuild_65_18393_E-421247 Ability to verify submitTeam field captured DOCS team after Entry Build submission
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "Docs"
    #And Fliter Arrival Date with latest shipment
    #And Filter using columnname "Clearance Scheme" as "LV"
    Then Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Call the webservices to verify the class version id for awb "<SheetName>","<ColumnName>","<RowNumber>" is greaterthanOrEqual to '17'
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    Then Change the total value to "296.04"
    Then Update currency in declaration screen "SGD"
    Then Expand the commodity details
    Then Update clearance scheme in declaration screen "LV"
    And Select the Clearance Mode in Decalaration as "DEMIN"
    Then Click on Sort Message on Floating Panel and select 'GEM'
    And Click on Validate
    And Submit the Declaration
    And Click on User List
    And Call the webservice to verify submitTeam is "<SheetName>","<ColumnName>","<RowNumber>",'Docs'
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        65 |
      
       #  In Staging env we can't run this TC, because Client Credentials issues

  @CICD
  Scenario Outline: EntryBuild_66_18353_Verify Importer Name is shown as MDE consignee value in Entry build declaration view for manual linked Personal shipment records in Entry build
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    And Filter using columnname "Clearance Scheme" as "LV"
    And Filter using "Importer Company" as "Blank Cells"
    Then Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And User link the importer icon name as "ABCELL"
    Then Click on Sort Message on Floating Panel and select 'GEM'
    And Click on Validate
    And User link the importer icon name as "Personal Shipment"
    And Click on Validate
    And Submit the Declaration
    And Click on User List
    And Click on Global search
    And Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Importer company should not display as Personal Shipment
    And Close Global Search Window
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        66 |

  @CICD
  Scenario Outline: EntryBuild_67_18457_TCP01_Ability to verify Importer instructions when old importer instruction is non-empty and new importer instruction is empty
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    And Filter using columnname "Clearance Scheme" as "HV"
    Then Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    Then Change the total value to "996.04"
    Then Update currency in declaration screen "SGD"
    And Select the Clearance Mode in Decalaration as "G7"
    #Then Expand the commodity details
    And Input the HS code and Select the HS code through Search Icon
    Then Click on Sort Message on Floating Panel and select 'GEM'
    And User link the importer icon name as "HEALTH SPORTS"
    And Importer Instruction displays the CP instruction value as "HEALTH SPORTS"
    And Click on Validate
    And Submit the Declaration
    And Click on User List
    And Click on Global search
    Then Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Assign the shipment in the GlobalSearch
    And Select only 1 user and submit
    And Click Close Global search
    And Click on User List
    And Double click on the first shipment
    And Importer Instruction displays the CP instruction value as "HEALTH SPORTS"
    Then Cancel the Decalaration
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        67 |

  @CICD
  Scenario Outline: EntryBuild_68_18458_TCP02_Ability to verify Importer instructions when old importer instruction is empty and new importer instruction is non-empty
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    And Filter using columnname "Clearance Scheme" as "LV"
    And Filter using "Importer Company" as "Blank Cells"
    Then Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    Then Change the total value to "296.04"
    Then Update currency in declaration screen "SGD"
    #And Input the HS code and Select the HS code through Search Icon
    Then Click on Sort Message on Floating Panel and select 'GEM'
    And User link the importer icon name as "HEALTHBIZ"
    And Importer Instruction displays the CP instruction value as "HEALTHBIZ"
    And Click on Validate
    And Submit the Declaration
    And Click on User List
    And Click on Global search
    Then Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Assign the shipment in the GlobalSearch
    And Select only 1 user and submit
    And Click Close Global search
    And Click on User List
    And Double click on the first shipment
    And Importer Instruction displays the CP instruction value as "HEALTHBIZ"
    Then Cancel the Decalaration
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        68 |

  @CICD
  Scenario Outline: EntryBuild_69_18459_TCP03_Ability to verify Importer instructions in when old importer instruction are empty and new importer instructions also empty
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    And Filter using columnname "Clearance Scheme" as "LV"
    And Filter using "Importer Company" as "Blank Cells"
    Then Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    Then Change the total value to "296.04"
    Then Update currency in declaration screen "SGD"
    And Input the HS code and Select the HS code through Search Icon
    Then Click on Sort Message on Floating Panel and select 'GEM'
    And User link the importer icon name as "HEALTH Factor"
    And Click on Validate
    And Importer Instruction displays the CP instruction value as "HEALTH Factor"
    And Submit the Declaration
    And Click on User List
    And Click on Global search
    Then Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Assign the shipment in the GlobalSearch
    And Select only 1 user and submit
    And Click Close Global search
    And Click on User List
    And Double click on the first shipment
    And Importer Instruction displays the CP instruction value as "HEALTH Factor"
    Then Cancel the Decalaration
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        69 |

  @CICD
  Scenario Outline: EntryBuild_70_18466_TCP04_Ability to verify Importer instructions when old importer instruction are not empty and new importer instructions also not empty
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "EDI Ready"
    And Filter using columnname "Importer Company" as "HEALTHBIZ"
    #And Filter using "Importer Company" as "HEALTHBIZ"
    Then Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    Then Change the total value to "296.04"
    Then Update currency in declaration screen "SGD"
    Then Click on Sort Message on Floating Panel and select 'GEM'
    And Enter the Clearance scheme as "LV"
    And Select the Clearance Mode in Decalaration as "DEMIN"
    #And Input the HS code and Select the HS code through Search Icon
    And User link the importer icon name as "Abbott laboratories"
    And Importer Instruction displays the CP instruction value as "Abbott laboratories"
    And Click on Validate
    And Submit the Declaration
    And Click on User List
    And Click on Global search
    Then Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Assign the shipment in the GlobalSearch
    And Select only 1 user and submit
    And Click Close Global search
    And Click on User List
    And Double click on the first shipment
    And Importer Instruction displays the CP instruction value as "Abbott laboratories"
    Then Cancel the Decalaration
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        70 |

  #Dops feature we need to execute in only UAT environment
  @CICD71
  Scenario Outline: EntryBuild_71_TCP05_Dops_Payment triggered_Successful payment DOPS STATUS updated to PAID
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ATFC ("
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Fliter Arrival Date with latest shipment
    And Filter using columnname "Clearance Scheme" as "HV"
    And Filter using columnname "Duty Bill" as "C"
    And Filter using columnname "FedEx Account for D&T" as "000000000"
    And Filter using columnname "Incoterm" as "CFR"
    And Filter using columnname "IOR" as "1"
    And Filter using columnname "Clearance Mode" as "G7"
    Then Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Double click on the first shipment
    And Input the HS code and Select the HS code through Search Icon
    Then Click on Sort Message on Floating Panel and select 'GEM'
    And Validate Bill Duty to Account Location is not "SG"
    And User link the importer icon name as "DOPS Importer"
    And Click on Validate
    Then Submit the Declaration
    And Click on User List
    And Click on Global search
    Then Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Assign the shipment in the GlobalSearch
    And Select only 1 user and submit
    And Click Close Global search
    And Click on User List
    And Verify Selection Code is equal to "DTQ"
    Then "Teams" name should be displayed as "DTQ Unassigned"
    Then "Payment Option" name should be displayed as "DOPS"
    And Calculate the GST and Advancement Fee
    And Click on User List
    Then "DOPS Status" name should be displayed as "MESSAGE SENT"
    Then Write the AWB to file
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        71 |

  #Dops feature we need to execute in only UAT environment
  @CICD89
  Scenario Outline: EntryBuild_72_E – 398759 Ability to impose Advancement Fee as Ancillary Charges for shipments collected under DTQ and DOPS process.
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ATFC ("
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Fliter Arrival Date with latest shipment
    And Filter using columnname "Clearance Scheme" as "X-HIGH"
    And Filter using columnname "Duty Bill" as "C"
    And Filter using columnname "FedEx Account for D&T Charges" as "000000000"
    And Filter using columnname "Incoterm" as "CFR"
    And Filter using columnname "IOR" as "1"
    And Filter using columnname "Clearance Mode" as "G7"
    Then Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Double click on the first shipment
    And Input the HS code and Select the HS code through Search Icon
    Then Click on Sort Message on Floating Panel and select 'GEM'
    And Validate Bill Duty to Account Location is not "SG"
    And User link the importer icon name as "DOPS Importer"
    And Click on Validate
    Then Submit the Declaration
    And Click on User List
    And Click on Global search
    Then Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Assign the shipment in the GlobalSearch
    And Select only 1 user and submit
    And Click Close Global search
    And Click on User List
    And Verify Selection Code is equal to "DTQ"
    Then "Teams" name should be displayed as "DTQ Unassigned"
    Then "Payment Option" name should be displayed as "DOPS"
    And Calculate the GST and Advancement Fee
    And Click on User List
    Then "DOPS Status" name should be displayed as "MESSAGE SENT"
    And Add the sort code "CMOD" and save it succesfully in Declaration Page
    And Verify Selection Code is equal to "CMOD"
    Then Write the AWB to file
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        72 |

  #	NOTE: Execute this test cases after executing the Testcase 71 and complete the payment manually and later execute the TC-->73
  @CICD73
  Scenario Outline: EntryBuild_73_TCP06_Dops_Payment triggered_Successful payment DOPS STATUS updated to PAID (Execute this TC after--> EntryBuild_71_TCP05_Dops_Payment triggered_Successful payment DOPS STATUS updated to PAID)
    Given Click on Global search
    And Search the shipment from text file
    #And Click on Assign to self
    #And Click on User List
    #And Click on Assign To
    #And Select only 1 user and submit
    Then "DOPS Status" name should be displayed as "PAID"
    And Verify Selection Code is not equal to "DTQ"
    Then "Teams" name should be displayed as "EDI Ready"

  #NOTE: Execute this test cases after executing the Testcase 72 and complete the payment manually and later execute the TC-->74
  @CICD74
  Scenario Outline: EntryBuild_74_TCP008 Ability to verify DTQ & CMOD sort code is removed after receiving payment when shipment is submitted to DOPS (Execute this TC after--> EntryBuild_72_TCP05_Dops_Payment triggered_Successful payment DOPS STATUS updated to PAID)
    Given Click on Global search
    And Search the shipment from text file
    Then "DOPS Status" name should be displayed as "PAID"
    And Verify Selection Code is not equal to "DTQ"
    And Verify Selection Code is not equal to "CMOD"
    Then "Teams" name should be displayed as "EDI Ready"

  #Dops defect# Defect #3458 - [SG - UAT] - DOPS status, response time and payment option column values are empty in global search. Giri
  @CICD75
  Scenario Outline: EntryBuild_75_D – 3458 DOPS status, response time and payment option column values are empty in global search.
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "DTQ Unassigned"
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Filter using columnname "DOPS Status" as "MESSAGE SENT"
    Then Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Click on Global search icon
    Then Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>" in Global Search popup
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    Then "DOPS Status" name should be displayed as "MESSAGE SENT"
    Then "Payment Option" name should be displayed as "CUST"
    Then "DOPS Response Time" text should be displayed
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        73 |

  #E-429102/B-2131605 Configuration of Google to SG Select, Bayer to SG Priority and PRADA SINGAPORE PTE LTD, SINGAPORE REPAIR CENTRE should go to ATFC.
  #Bayer to SG Priority
  
   #  In Staging env we can't run this TC, because Client Credentials issues
   
  @CICD1122
  Scenario Outline: EntryBuild_76_E-429102/B-2131605 Configuration Bayer to SG Priority _ Scenario_1 .
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "SG Priority"
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Filter using columnname "Commodity Category" as "TAMR"
    And Filter using columnname "Consignee Company" as "a"
    Then Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Call the webservices to fetch the JSON from the seelcted awb "<SheetName>","<ColumnName>","<RowNumber>" is greaterthanOrEqual to '17',"SG Priority","BAYER (SOUTH EAST ASIA) PTE LTD"

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        74 |

  #E-429102/B-2131605 Configuration of Google to SG Select, Bayer to SG Priority and PRADA SINGAPORE PTE LTD, SINGAPORE REPAIR CENTRE should go to ATFC.
  #Google to SG Select
   #  In Staging env we can't run this TC, because Client Credentials issues
  @CICD3366
  Scenario Outline: EntryBuild_77_E-429102/B-2131605 Configuration of Google to SG Select _ Scenario_2.
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "SG Select Customers"
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Filter using columnname "Commodity Category" as "TAMR"
    And Filter using columnname "Consignee Company" as "a"
    Then Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Call the webservices to fetch the JSON from the seelcted awb "<SheetName>","<ColumnName>","<RowNumber>" is greaterthanOrEqual to '17',"SG Select","Google"

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        75 |

  #E-429102/B-2131605 Configuration of Google to SG Select, Bayer to SG Priority and PRADA SINGAPORE PTE LTD, SINGAPORE REPAIR CENTRE should go to ATFC.
  #ATFC1 to PRADA SINGAPORE PTE LTD
   #  In Staging env we can't run this TC, because Client Credentials issues
  @CICD3366
  Scenario Outline: EntryBuild_78_E-429102/B-2131605 Configuration of PRADA SINGAPORE PTE LTD to ATFC _ Scenario_ 3.
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ATFC ("
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Filter using columnname "Commodity Category" as "TAMR"
    And Filter using columnname "Consignee Company" as "a"
    Then Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Call the webservices to fetch the JSON from the seelcted awb "<SheetName>","<ColumnName>","<RowNumber>" is greaterthanOrEqual to '17',"ATFC1","PRADA"

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        76 |

  #E-429102/B-2131605 Configuration of Google to SG Select, Bayer to SG Priority and PRADA SINGAPORE PTE LTD, SINGAPORE REPAIR CENTRE should go to ATFC.
  #ATFC2 to SINGAPORE REPAIR CENTER
   #  In Staging env we can't run this TC, because Client Credentials issues
  @CICD3367
  Scenario Outline: EntryBuild_79_E-429102/B-2131605 Configuration of  SINGAPORE REPAIR CENTRE to ATFC _scenario_ 4.
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ATFC"
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Filter using columnname "Commodity Category" as "TAMR"
    And Filter using columnname "Consignee Company" as "a"
    Then Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Call the webservices to fetch the JSON from the seelcted awb "<SheetName>","<ColumnName>","<RowNumber>" is greaterthanOrEqual to '17',"ATFC2","SINGAPORE REPAIR"

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        77 |

  #E-421780 Ability to consume MAWB from enterprise(SEP/CLASS)whenever it is available
  #TCP001_ Verify MAWB updated when Removed (MAWB null)
   #  In Staging env we can't run this TC, because Client Credentials issues
  @CICD3366
  Scenario Outline: EntryBuild_80_E-421780 Ability to consume MAWB from enterprise(SEP/CLASS)
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ATFC ("
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    Then Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Call the webservices for the AWBNo for MAWB "<SheetName>","<ColumnName>","<RowNumber>","TCP001"

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        78 |

  @CICD3637
  Scenario Outline: EntryBuild_81_TCN01_Dops_Payment triggered_Successful payment DOPS STATUS updated to CUST -After 24 hrs of failed payment this test case will be executed.
    Given Click on Global search
    Then Search the payment failed shipment from text file
    And "DOPS Status" name should be displayed as "CUST"

  @CICD
  Scenario Outline: EntryBuild_82_E-448162_TCP001 Ability to verify Warehouse Handling code COMD in Entry Build competency
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "DTQ Unassigned"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Add the sort code "CMOD" and save it succesfully in Declaration Page
    And Toaster message should be displayed as "Sort Codes saved"
    And Verify Selection Code is equal to "DTQ"
    And Verify Selection Code is equal to "CMOD"
    Then Click on User List icon
    Then "Teams" name should be displayed as "DTQ Assigned"
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        79 |

  @CICD4
  Scenario Outline: EntryBuild_83_E-448162_TCP004 Ability to verify manually adding of CMOD in entry build  Declaration page
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "DTQ Unassigned"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Verify Selection Code is equal to "DTQ"
    And Double click on the first shipment
    And Add the sort code "CMOD" and save it succesfully in Declaration Page
    Then Toaster message should be displayed as "Sort Codes saved"
    Then Validate the selection codes "CMOD" in Declaration Page
    And Click on Validate
    And Submit the Declaration
    Then "Teams" name should be displayed as "DTQ Assigned"
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        80 |

  @CICD
  Scenario Outline: EntryBuild_84_E-448162_TCP005 Ability to verify manually adding of CMOD in Global search
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "DTQ Unassigned"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    Given Click on Global search
    When Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Verify Selection Code is equal to "DTQ"
    And Add the sort code "CMOD" and save it succesfully in Declaration Page
    And Toaster message should be displayed as "Sort Codes saved"
    And Verify Selection Code is equal to "CMOD"
    Then "Teams" name should be displayed as "DTQ Assigned"
    And Click Close Global search
    And Select Team as "DTQ Unassigned"
    And Read limited shipment AWB number "<SheetName>","<ColumnName>","<RowNumber>"
    Given Click on Global search
    When Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Verify Selection Code is equal to "DTQ"
    And Select multiple shipment from global search results
    And Add the sort code "CMOD" and save it succesfully in Declaration Page
    And Toaster message should be displayed as "Sort Codes saved"
    And Select multiple shipment from global search results
    And Verify Selection Code is equal to "CMOD"
    Then "Teams" name should be displayed as "DTQ Assigned"
    And Click Close Global search

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        81 |

  @CICD
  Scenario Outline: EntryBuild_85_E-448162_-TCP007 Ability to remove DTQ sort code manually in entry build user list Ability to verify manually adding of CMOD in entry build  Declaration page
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "DTQ Assigned"
    And Filter using columnname "Selection Codes" as "DTQ,CMOD"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Verify Selection Code is equal to "DTQ"
    And Verify Selection Code is equal to "CMOD"
    And Remove the sort code "DTQ" and save it succesfully in Declaration Page
    Then Toaster message should be displayed as "Sort Code saved. CMOD/DTQ not assigned due to non DTQ shipment."
    And Click on User List
    And Verify Selection Code is not equal to "DTQ"
    And Verify Selection Code is not equal to "CMOD"
    Then "Teams" name should be displayed as "EDI Ready"
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        82 |

  @CICD
  Scenario Outline: EntryBuild_86_E-448162_TCN002 Ability to remove CMOD sort code manually
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "DTQ Assigned"
    And Filter using columnname "Selection Codes" as "DTQ,CMOD"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Verify Selection Code is equal to "DTQ"
    And Verify Selection Code is equal to "CMOD"
    And Remove the sort code "CMOD" and save it succesfully in Declaration Page
    And Toaster message should be displayed as "Sort Codes saved"
    And Click on User List
    Then "Teams" name should be displayed as "DTQ Unassigned"
    And Verify Selection Code is equal to "DTQ"
    And Verify Selection Code is not equal to "CMOD"
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        83 |

  @CICD
  Scenario Outline: EntryBuild_87_E-448162_TCN001,TCN003 Ability to add CMOD sort code along with few other sort codes when shipment not in DTQ teams_EB UL
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "SG ("
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Add the sort code "CMOD" and save it succesfully in Declaration Page
    Then Toaster message should be displayed as "Sort Code saved. CMOD/DTQ not assigned due to non DTQ shipment."
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click sort message in floating panel
    And Assign Multiplesortcodes "CMOD,ADT,URG" sort codes to the shipment
    And Click Sort Message Save button
    Then Toaster message should be displayed as "Sort Code saved. CMOD/DTQ not assigned due to non DTQ shipment."
    And Verify Selection Code is equal to "URG"
    And Verify Selection Code is not equal to "CMOD"
    Then Click on User List icon
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        84 |

  @CICD
  Scenario Outline: EntryBuild_88_E-448162_TCN004 Ability to add CMOD sort code along with few other sort codes when shipment not in DTQ teams_Global search
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "SG ("
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Click on Global search
    When Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Click sort message in floating panel
    And Assign Multiplesortcodes "CMOD,ADT,URG" sort codes to the shipment
    And Click Sort Message Save button
    Then Toaster message should be displayed as "Sort Code saved. CMOD/DTQ not assigned due to non DTQ shipment."
    And Verify Selection Code is equal to "URG"
    And Verify Selection Code is equal to "ADT"
    And Verify Selection Code is not equal to "CMOD"
    And Click Close Global search

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        85 |

  @CICD
  Scenario Outline: EntryBuild_89_E-448162_TCN005 Ability to add CMOD sort code along with few other sort codes for shipments in different teams_EB-UL
    Given User clicks on "ENTRY_BUILD" competency
    And Click on User List
    And Unassign all the shipments in user list
    And Click on team list
    And Select Team as "DTQ Unassigned"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Select Team as "ACCS Shipments"
    And Fetch the AWBNo "<SheetName>","<ColumnName1>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName1>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Click toggle to select all available shipment
    And Click sort message in floating panel
    And Assign Multiplesortcodes "ADT,CMOD" sort codes to the shipment
    And Click on Add button in Sort Message popup
    Then Toaster message should be displayed as "Sort Code saved. CMOD/DTQ not assigned due to non DTQ shipment."
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Verify Selection Code is equal to "CMOD"
    Then Unassign the Shipment
    And Search the shipment "<SheetName>", "<ColumnName1>", "<RowNumber>"
    And Verify Selection Code is not equal to "CMOD"
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber | ColumnName1       |
      | EntryBuild | AWB Number |        86 | Addnl1_AWB Number |

  @CICD
  Scenario Outline: EntryBuild_90_E-448162_TCN006 Ability to add CMOD sort code along with few other sort codes for shipments in different teams_GS
    Given User clicks on "ENTRY_BUILD" competency
    And Click on User List
    And Unassign all the shipments in user list
    And Click on team list
    And Select Team as "DTQ Unassigned"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Select Team as "ACCS Shipments"
    And Fetch the AWBNo "<SheetName>","<ColumnName1>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName1>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Read 2 shipment AWB number "<SheetName>","<ColumnName2>","<RowNumber>"
    When Click on Global search
    And Search the shipment "<SheetName>","<ColumnName2>","<RowNumber>" in Global Search
    And Click toggle to select all available shipment
    And Click sort message in floating panel
    And Assign Multiplesortcodes "URG,CMOD" sort codes to the shipment
    And Click on Add button in Sort Message popup
    Then Toaster message should be displayed as "Sort Code saved. CMOD/DTQ not assigned due to non DTQ shipment."
    And Click Close Global search
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Verify Selection Code is equal to "CMOD"
    And Search the shipment "<SheetName>", "<ColumnName1>", "<RowNumber>"
    And Verify Selection Code is not equal to "CMOD"
    Then Unassign the Shipment

    Examples: 
      | SheetName  | ColumnName | RowNumber | ColumnName1       | ColumnName2       |
      | EntryBuild | AWB Number |        87 | Addnl1_AWB Number | Addnl2_AWB Number |

  @CICD
  Scenario Outline: EntryBuild_91_9412:TCP002_Verify new Duty bill account number column Is shown in Entry build Team List, Team Leader list and User list
    Given User clicks on "ENTRY_BUILD" competency
    And Click on team list
    And Add the Column "FedEx Account for D&T Charges" in the grid
    Then Verify FedEx Account for Charges in shipment result
    When User click on Team Leader List
    And Add the Column "FedEx Account for D&T Charges" in the grid
    Then Verify FedEx Account for Charges in shipment result
    When Click on User List
    And Add the Column "FedEx Account for D&T Charges" in the grid
    Then Verify FedEx Account for Charges in shipment result

  @CICD
  Scenario Outline: EntryBuild_92_TCN009_Scenario1 for LV_Verify DTQ sort code NOT automatically applied when DTQ criteria not satisfied & Company name matches does match
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ATFC ("
    And Filter using columnname "Clearance Scheme" as "LV"
    And Filter using columnname "FedEx Account for D&T Charges" as "9"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And Clear HSCode required alert
    And Enter the Quantity of commodity as "1"
    And Enter the HS Code "52030000"
    And Verify HS Code is Filled and Green Harmonized Code Match Icon is present
    And Enter Commodity Description "Commodity Details Updated"
    Then Click on Sort Message on Floating Panel and select 'GEM'
    And Click on Validate
    Then Submit the Declaration
    And Click on User List
    And  Click on Global search
    When Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    Then "Teams" name should be displayed as "EDI Ready"
     And Click Close Global search
    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        90 |

  @CICD5
  Scenario Outline: EntryBuild_93_TCN0011_Verify DTQ sort code applied manually shipment does not move shipment into DTQ Unassigned from Global search
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ATFC ("
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    Then Click on Sort Message on Floating Panel and select 'DTQ'
    Then Cancel the Decalaration
    And Click on User List
    Then "Teams" name should be displayed as "ACCS Shipments"

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        91 |

  @CICD
  Scenario Outline: EntryBuild_94_TCN009_Scenario2 for HV_Verify DTQ sort code NOT automatically applied when DTQ criteria not satisfied & Company name matches does match
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ATFC ("
    And Filter using columnname "Clearance Scheme" as "HV"
    And Filter using columnname "Clearance Mode" as "MES"
    And Filter using columnname "FedEx Account for D&T Charges" as "9"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And Clear HSCode required alert
    And Enter the Quantity of commodity as "1"
    And Enter the HS Code "52030000"
    And Verify HS Code is Filled and Green Harmonized Code Match Icon is present
    And Enter Commodity Description "Commodity Details Updated"
    Then Click on Sort Message on Floating Panel and select 'GEM'
    And Click on Validate
    Then Submit the Declaration
    And Click on User List
    And  Click on Global search
    When Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    Then "Teams" name should be displayed as "EDI Ready"
     And Click Close Global search

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        90 |

  @CICD
  Scenario Outline: EntryBuild_95_E-448156_TCP001_Update DT Bill account number in global search for shipments in DTQ Unassigned team for payment option CUST with Message Failed DOPS Status
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "DTQ Unassigned"
    And Filter using columnname "DOPS Status" as "MESSAGE FAILED"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Global search
    When Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Click on Duty bill account search icon "232120525"
    #Then Click on go
    And Toaster message should be displayed as "D/T bill customer retrieved successfully."
    Then Click on Link
    And Toaster message should be displayed as " D/T bill customer details saved successfully."
    And Click Close Global search
    Given Click on Global search
    And Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    Then "Teams" name should be displayed as "EDI Ready"
    And Verify Selection Code is not equal to "DTQ"
    And Verify Selection Code is not equal to "CMOD"
    And Click Close Global search

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        91 |

  @CICD
  Scenario Outline: EntryBuild_96_E-448156_TCP002_Update DT Bill account number in global search for shipments in DTQ Unassigned team for payment option CUST with blank DOPS Status
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "DTQ Unassigned"
    And Sort using columnname "DOPS Status"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Global search
    When Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Click on Duty bill account search icon "232120525"
    #Then Click on go
    And Toaster message should be displayed as "D/T bill customer retrieved successfully."
    Then Click on Link
    And Toaster message should be displayed as " D/T bill customer details saved successfully."
    And Click Close Global search
    Given Click on Global search
    When Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    Then "Teams" name should be displayed as "EDI Ready"
    And Verify Selection Code is not equal to "DTQ"
    And Verify Selection Code is not equal to "CMOD"
    And Click Close Global search

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        92 |

  @CICD
  Scenario Outline: EntryBuild_97_E-448156_TCP003_Update DT Bill account number in global search for shipments in DTQ Assigned team for payment option CUST with Message Failed DOPS Status
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "DTQ Assigned"
    And Filter using columnname "DOPS Status" as "MESSAGE FAILED"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Global search
    When Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Click on Duty bill account search icon "232120525"
    #Then Click on go
    And Toaster message should be displayed as "D/T bill customer retrieved successfully."
    Then Click on Link
    And Toaster message should be displayed as " D/T bill customer details saved successfully."
    And Click Close Global search
    Given Click on Global search
    And Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    Then "Teams" name should be displayed as "EDI Ready"
    And Verify Selection Code is not equal to "DTQ"
    And Verify Selection Code is not equal to "CMOD"
    And Click Close Global search

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        93 |

  @CICD
  Scenario Outline: EntryBuild_98_E-448156_TCP004_Update DT Bill account number in global search for shipments in DTQ Assigned team for payment option CUST with blank DOPS Status
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "DTQ Assigned"
    And Sort using columnname "DOPS Status"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Global search
    When Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Click on Duty bill account search icon "232120525"
    #Then Click on go
    And Toaster message should be displayed as "D/T bill customer retrieved successfully."
    Then Click on Link
    And Toaster message should be displayed as " D/T bill customer details saved successfully."
    And Click Close Global search
    Given Click on Global search
    And Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    Then "Teams" name should be displayed as "EDI Ready"
    And Verify Selection Code is not equal to "DTQ"
    And Verify Selection Code is not equal to "CMOD"
    And Click Close Global search

    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        94 |
      
    @CICD1112
  Scenario Outline: EntryBuild_99_E-448156_TCN001,TCN002,TCN003,TCN004_Update DT Bill account number in global search for shipments in DTQ Assigned team for payment option CUST with blank DOPS Status
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "EDI Ready"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Global search
    When Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Check for Duty bill account search icon disabled
      
   Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        94 |
      
    @Dataload
  Scenario Outline: Generating Shipments with different event sequence number
    Given User clicks on "MANIFEST_CHECK" competency
    And Select Team as "ACCS Shipments ("
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    #And Filter using columnname "Commodity Category" as "TAMR"
   # And Filter using columnname "Clearance Scheme" as "X-HIGH"
    And Filter using columnname "FedEx Account for D&T Charges" as "000000000"
    And Filter using columnname "Incoterm" as "CFR"
    And Filter using columnname "Clearance Mode" as "G7"
    And Filter using "Importer Company" as "Blank Cells"
    And Filter using "Consignee Company" as "Blank Cells"  
    And Filter using columnname "Duty Bill" as "C"
    Then Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Creating mulitple Shipments with different event sequence number from the selected awb "<SheetName>","<ColumnName>","<RowNumber>"
 
    Examples: 
      | SheetName  | ColumnName | RowNumber |
      | EntryBuild | AWB Number |        96 |
      