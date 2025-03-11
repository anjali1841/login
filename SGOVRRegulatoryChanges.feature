Feature: SG OVR Regulatory changes
  * Validate the OVR field and GST field for various LV & other shipments, 
  * Validate the OVR field and GST field for clearance mode CAGED & Others
  * Validate the OVR field and GST field for Mode of Transport FLIGHT & TRUCK

  Background: Flow till login page
    Given User is in Gemini application login page

  @CICD
  Scenario Outline: Scenario_01_9971: Verify the option ROAD is removed in Clearance Mode dropdown, OVR registration No, length in Entry Build View Page
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    And Disable Team "Default"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    Then ROAD option should not be displayed in Clearance Mode
    And Cancel the Decalaration
    Then Unassign the Shipment

    Examples: 
      | SheetName    | ColumnName | RowNumber |
      | SGOVRchanges | AWB Number |         1 |

  @CICD
  Scenario Outline: SGOVR_Scenario_02_9967: Verify OVR and GST enabled for LV shipment with mode of Transport FLIGHT based on clearance mode
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    And Filter using columnname "Clearance Scheme" as "LV"
    And Filter using route as "SM015"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    Then Change the total value to "390.01"
    Then Update currency in declaration screen "SGD"
    Then Expand the commodity details
    And Mode of transport in Declaration is "FLIGHT"
    And Add the sort code "DPIA" and save it succesfully in Declaration Page
    And Select the Clearance Mode in Decalaration as "CAGED"
    Then OVR Registration No. should be enabled
    And GST Paid should be enabled
    And Select the Clearance Mode in Decalaration as "MES"
    Then OVR Registration No. should be disabled
    And GST Paid should be disabled
    Then Previous Value of GST Paid should be Retained
    And Click on Validate
    And Select the Clearance Mode in Decalaration as "CAGED"
    And Click on Validate
    Then No Alert should be displayed in Declaration screen
    And Cancel the Decalaration
    Then Unassign the Shipment

    Examples: :
      | SheetName    | ColumnName | RowNumber |
      | SGOVRchanges | AWB Number |         2 |

  @CICD
  Scenario Outline: SGOVR_Scenario_03_9968: Verify OVR and GST enabled for LV shipment with mode of Transport TRUCK based on clearance mode
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
    Then Change the total value to "390.01"
    Then Update currency in declaration screen "SGD"
    Then Expand the commodity details
    And Mode of transport in Declaration is "TRUCK"
    And Add the sort code "DPIA" and save it succesfully in Declaration Page
    And Select the Clearance Mode in Decalaration as "CAGED"
    Then OVR Registration No. should be enabled
    And GST Paid should be enabled
    And Select the Clearance Mode in Decalaration as "MES"
    Then OVR Registration No. should be enabled
    And GST Paid should be enabled
    Then Previous Value of GST Paid should be Retained
    And Click on Validate
    And Select the Clearance Mode in Decalaration as "CAGED"
    And Click on Validate
    Then No Alert should be displayed in Declaration screen
    And Cancel the Decalaration
    And Unassign the Shipment

    Examples: 
      | SheetName    | ColumnName | RowNumber |
      | SGOVRchanges | AWB Number |         3 |

  @CICD
  Scenario Outline: SGOVR_Scenario_04_9972: Verify OVR and GST enabled for HV shipment with mode of Transport FLIGHT based on clearance mode
    Given User clicks on "ENTRY_BUILD" competency
    #And Select Team as "ACCS Shipments"
    And Select Team as "EDI Ready"
    And Disable Team "Default"
    And Filter using columnname "Clearance Scheme" as "HV"
    And Filter using route as "SM015"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    Then Change the total value to "1390.01"
    Then Update currency in declaration screen "SGD"
    Then Expand the commodity details
    And Mode of transport in Declaration is "FLIGHT"
    And Add the sort code "DPIA" and save it succesfully in Declaration Page
    And Select the Clearance Mode in Decalaration as "CAGED"
    Then OVR Registration No. should be enabled
    And GST Paid should be enabled
    And Select the Clearance Mode in Decalaration as "MES"
    Then OVR Registration No. should be enabled
    And GST Paid should be enabled
    Then Previous Value of GST Paid should be Retained
    And Click on Validate
    And Select the Clearance Mode in Decalaration as "CAGED"
    And Click on Validate
    Then No Alert should be displayed in Declaration screen
    And Cancel the Decalaration
    And Unassign the Shipment

    Examples: 
      | SheetName    | ColumnName | RowNumber |
      | SGOVRchanges | AWB Number |         4 |

  @CICD
  Scenario Outline: Scenario_05_9973: Verify OVR and GST enabled for HV shipment with mode of Transport TRUCK based on clearance mode
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "EDI Ready"
    And Disable Team "Default"
    And Filter using columnname "Clearance Scheme" as "HV"
    And Filter using route as "KS666"
    And Filter using columnname "Clearance Status" as "EDI Ready"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    Then Change the total value to "4600.01"
    Then Update currency in declaration screen "SGD"
    Then Expand the commodity details
    And Mode of transport in Declaration is "TRUCK"
    And Add the sort code "DPIA" and save it succesfully in Declaration Page
    And Select the Clearance Mode in Decalaration as "CAGED"
    Then OVR Registration No. should be enabled
    And GST Paid should be enabled
    And Select the Clearance Mode in Decalaration as "MES"
    Then OVR Registration No. should be enabled
    And GST Paid should be enabled
    Then Previous Value of GST Paid should be Retained
    And Click on Validate
    And Select the Clearance Mode in Decalaration as "CAGED"
    And Click on Validate
    Then No Alert should be displayed in Declaration screen
    And Cancel the Decalaration
    And Unassign the Shipment

    Examples: 
      | SheetName    | ColumnName | RowNumber |
      | SGOVRchanges | AWB Number |         5 |
   @CICD
  Scenario Outline: Scenario_06_9974: Verify OVR and GST enabled for X-HIGH shipment with mode of Transport TRUCK based on clearance mode
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    And Filter using columnname "Clearance Scheme" as "X-HIGH"
    And Filter using route as "KS666"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    Then Change the total value to "30000.01"
    Then Update currency in declaration screen "SGD"
    Then Expand the commodity details
    And Mode of transport in Declaration is "TRUCK"
    And Add the sort code "DPIA" and save it succesfully in Declaration Page
    And Select the Clearance Mode in Decalaration as "CAGED"
    Then OVR Registration No. should be enabled
    And GST Paid should be enabled
    And Select the Clearance Mode in Decalaration as "MES"
    Then OVR Registration No. should be enabled
    And GST Paid should be enabled
    Then Previous Value of GST Paid should be Retained
    And Click on Validate
    And Select the Clearance Mode in Decalaration as "CAGED"
    And Click on Validate
    Then No Alert should be displayed in Declaration screen
    And Cancel the Decalaration
    And Unassign the Shipment

    Examples: 
      | SheetName    | ColumnName | RowNumber |
      | SGOVRchanges | AWB Number |         6 |
	
	@CICD
  Scenario Outline: Scenario_07_9975: Verify OVR and GST enabled for X-HGH shipment with mode of Transport FLIGHT based on clearance mode
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    And Filter using columnname "Clearance Scheme" as "X-HIGH"
    And Filter using route as "SM015"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    Then Change the total value to "30000.01"
    Then Update currency in declaration screen "SGD"
    Then Expand the commodity details
    And Mode of transport in Declaration is "FLIGHT"
    And Add the sort code "DPIA" and save it succesfully in Declaration Page
    And Select the Clearance Mode in Decalaration as "CAGED"
    Then OVR Registration No. should be enabled
    And GST Paid should be enabled
    And Select the Clearance Mode in Decalaration as "MES"
    Then OVR Registration No. should be enabled
    And GST Paid should be enabled
    Then Previous Value of GST Paid should be Retained
    And Click on Validate
    And Select the Clearance Mode in Decalaration as "CAGED"
    And Click on Validate
    Then No Alert should be displayed in Declaration screen
    And Cancel the Decalaration
    And Unassign the Shipment

    Examples: 
      | SheetName    | ColumnName | RowNumber |
      | SGOVRchanges | AWB Number |         7 |
	
	@CICD
  Scenario Outline: Scenario_08_9976: Verify OVR and GST enabled for random shipment with mode of Transport is BLANK based on clearance mode
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    And Filter using "Route" as "Blank Cells"
    And Filter using columnname "Clearance Scheme" as "HV"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    Then Change the total value to "1300.01"
    Then Update currency in declaration screen "SGD"
    Then Expand the commodity details
    #And Mode of transport in Declaration is ""
    And Add the sort code "DPIA" and save it succesfully in Declaration Page
    And Select the Clearance Mode in Decalaration as "CAGED"
    Then OVR Registration No. should be enabled
    And GST Paid should be enabled
    And Select the Clearance Mode in Decalaration as "MES"
    Then OVR Registration No. should be enabled
    And GST Paid should be enabled
    Then Previous Value of GST Paid should be Retained
    And Click on Validate
    And Select the Clearance Mode in Decalaration as "CAGED"
    And Click on Validate
    Then No Alert should be displayed in Declaration screen
    And Cancel the Decalaration
    And Unassign the Shipment

    Examples: 
      | SheetName    | ColumnName | RowNumber |
      | SGOVRchanges | AWB Number |         8 |

  @CICD
  Scenario Outline: Scenario_09_9977: Verify OVR Registration No. Max Digits
    Given User clicks on "ENTRY_BUILD" competency
    #And Select Team as "ACCS Shipments"
    And Select Team as "EDI Ready"
    #And Disable Team "Default"
    And Filter using columnname "Clearance Status" as "EDI Ready"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    #Then Click on Sort Message on Floating Panel and select 'DPIA'
    And Double click on the first shipment
    And Add the sort code "DPIA" and save it succesfully in Declaration Page
    And Select the Clearance Mode in Decalaration as "CAGED"
    Then OVR Registration No. should be enabled
    And GST Paid should be enabled
    And Max Length of OVR Registration No. should be "10"
    And Click on Validate
    Then No Alert should be displayed in Declaration screen
    And Cancel the Decalaration
    And Unassign the Shipment

    Examples: 
      | SheetName    | ColumnName | RowNumber |
      | SGOVRchanges | AWB Number |         9 |

  @CICD
  Scenario Outline: SGOVR_Scenario_10_17364_Change_ClearanceScheme_ClearanceStatus_check OVR, GST fields
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "EDI Ready"
    #And Disable Team "Default"
    And Filter using columnname "Clearance Scheme" as "LV"
    And Filter using route as "SM015"
    And Filter using columnname "Clearance Status" as "EDI Ready"
    And Read 2 shipment AWB number "<SheetName>","<ColumnName>","<RowNumber>"
    And Filter using "AWB Number" as "In"
    And Search the Multiple shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click toggle to select all available shipment
    And Click on Assign to Me icon
    Then Click on User List icon
    And Filter using "AWB Number" as "In"
    And Search the Multiple shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    #Then Click on Sort Message on Floating Panel and select 'DPIA'
    And Double click on the first shipment
    And Add the sort code "DPIA" and save it succesfully in Declaration Page
    And Select the Clearance Mode in Decalaration as "G7"
    Then OVR Registration No. should be disabled
    And Click on Validate
    And Select the Clearance Mode in Decalaration as "CAGED"
    Then OVR Registration No. should be enabled
    #Then Click on Sort Message on Floating Panel and select 'DPIA'
    And Max Length of OVR Registration No. should be "10"
    And Click on Validate
    #Then No Alert should be displayed in Declaration screen
    Then Submit the Declaration
    And Change Clearance Scheme "HV"
    Then OVR Registration No. should be enabled
    And Select the Clearance Mode in Decalaration as "MES"
    Then OVR Registration No. should be enabled
    And Click on Validate
    And Cancel the Decalaration
    And Double click on the first shipment
    And Verify OVR Registration No. is retrieved

    Examples: 
      | SheetName    | ColumnName | RowNumber |
      | SGOVRchanges | AWB Number |        10 |
