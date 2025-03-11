@Regression
Feature: Automation SG - Customer Matching Module
  * Validate Customer successfully linked to the shipment for Search Consignee
  * Create New Consignee/Importer and link to the shipment

  Background: Flow till login page
    Given User is in Gemini application login page

  @CICD
  Scenario Outline: Customer Matching_01_9504: Verify the message No Data Available once all the competency are updated in User List
    Given User is in Customer Matching Competency with teamlist
    And Click on User List
    And Unassign all the shipments in user list
    And Click on team list
    And Select Team as "ACCS Shipments"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    #And Store the AWB number
    #And Search the shipment in Manifest Check "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    #And Search the stored shipment
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    When Double click on the first shipment
    And User search for Importer and click on the Link Importer icon for all shipments
    #And Verify Toaster Message "Customer successfully linked to the shipment"
    And Click on User List icon
    Then Verify message No Data Available once all the competency is updated

    Examples: 
      | SheetName        | ColumnName | RowNumber |
      | CustomerMatching | AWB Number |         1 |

  @CICD
  Scenario Outline: Customer Matching_02_9499: Verify if the Shipment is in Entry Build after overriding HV shipment in Manifest Check
    Given User clicks on Manifest Check Competency with teamlist
    And Select Team as "ACCS Shipments"
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Filter using columnname "Clearance Scheme" as "HV"
    And Filter using "Consignee Company" as "Contains"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    #And Search the shipment in Manifest Check "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    #And Search the stored shipment
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Override button
    And Click on Global search
    And Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    Then "Competency" should be displayed as "Entry Build"

    Examples: 
      | SheetName        | ColumnName | RowNumber |
      | CustomerMatching | AWB Number |         2 |

  @CICD
  Scenario Outline: Customer Matching_03_9500: Verify if the Shipment is in Entry Build after overriding X-HIGH shipment in Manifest Check
    Given User clicks on Manifest Check Competency with teamlist
    And Select Team as "ACCS Shipments"
    And Filter using columnname "Clearance Scheme" as "X-HIGH"
    And Filter using "Consignee Company" as "Contains"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Override button
    And Click on Global search
    And Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    Then "Competency" should be displayed as "Entry Build"

    Examples: 
      | SheetName        | ColumnName | RowNumber |
      | CustomerMatching | AWB Number |         3 |

  @CICD4
  Scenario Outline: Customer Matching_04_9501: Verify if the Shipment is in Entry Build after overriding LV Truck shipment in Manifest Check
    Given User clicks on Manifest Check Competency with teamlist
    And Select Team as "ACCS Shipments"
     And Click on activity log and download
    And Filter using columnname "Clearance Scheme" as "LV"
    #And Filter using Clearance Scheme as "LV"
    #And Filter using route as "KS666"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    #And Search the shipment in Manifest Check "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    #And Search the shipment in Manifest Check "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Override button
    #And Click on Entry Build Icon
    #When Select ACSS Shipments toggle in Entry Build
    #And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    #Then The shipment should be in Entry Build page
    And Click on Global search
    And Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    Then "Competency" should be displayed as "Entry Build"

    Examples: 
      | SheetName        | ColumnName | RowNumber |
      | CustomerMatching | AWB Number |         4 |

  @CICD
  Scenario Outline: Customer Matching_05_9505: Verify Consignee and Importer match with Customer Profile as per the search criteria
    Given User is in Customer Matching Competency with teamlist
    And Select Team as "ACCS Shipments"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    #And Search the shipment in Manifest Check "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    When In Quick Search user click on CLEAR
    And User enters the Company Name Postal Code and Address then click on GO
    Then Verify Consignee and Importer match with CP as per the search criteria

    Examples: 
      | SheetName        | ColumnName | RowNumber |
      | CustomerMatching | AWB Number |         5 |

  @CICD5
  Scenario Outline: Customer Matching_06_9502: Verify if the Shipment is in Entry Build for HV Multimatch Consignee/Importer
    Given User clicks on Manifest Check Competency with teamlist
    And Select Team as "ACCS Shipments"
    #And Unselect Default toggle
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Filter using columnname "Clearance Scheme" as "HV"
    #And Filter using Clearance Scheme as "HV"
    #And Filter using Importer Company as "Blank Cells"
    And Filter using "Importer Company" as "Blank Cells"
    And Filter using "Consignee Company" as "Blank Cells"
    #And Filter using Consignee Company  as "Blank Cells"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    #And Search the shipment in Manifest Check "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    #And Search the shipment in Manifest Check "<SheetName>", "<ColumnName>", "<RowNumber>"
    When Click on Override button
    And Click on Global search
    And Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Click on Shipment Search
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Fetch the teams and value from global search
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    #And Search the shipment in Manifest Check "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Select a shipment
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    #And Search the shipment in Manifest Check "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And User search for Importer and click on the Link Importer icon for all shipments
    And Click on Global search
    #And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    Then "Competency" should be displayed as "Entry Build"

    Examples: 
      | SheetName        | ColumnName | RowNumber |
      | CustomerMatching | AWB Number |         6 |

  @CICD
  Scenario Outline: Customer Matching_07_9503: Verify if the Shipment is in Entry Build for X-HIGH Multimatch Consignee/Importer
    Given User clicks on Manifest Check Competency with teamlist
    And Select Team as "ACCS Shipments"
    #And Unselect Default toggle
    #And Filter using Clearance Scheme as "X-HIGH"
    #And Filter using Importer Company as "Blank Cells"
    #And Filter using Consignee Company  as "Blank Cells"
    And Filter using columnname "Clearance Scheme" as "X-HIGH"
    #And Filter using Importer Company as "Blank Cells"
    And Filter using "Importer Company" as "Blank Cells"
    And Filter using "Consignee Company" as "Blank Cells"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    #And Search the shipment in Manifest Check "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    #And Search the shipment in Manifest Check "<SheetName>", "<ColumnName>", "<RowNumber>"
    When Click on Override button
    And Click on Global search
    #And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Click on Shipment Search
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Fetch the teams and value from global search
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    #And Search the shipment in Manifest Check "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Select a shipment
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    #And Search the shipment in Manifest Check "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And User search for Importer and click on the Link Importer icon for all shipments
    #And Click on Entry Build Icon
    #When Select ACSS Shipments toggle in Entry Build
    #And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    #Then The shipment should be in Entry Build page
    And Click on Global search
    #And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    Then "Competency" should be displayed as "Entry Build"

    Examples: 
      | SheetName        | ColumnName | RowNumber |
      | CustomerMatching | AWB Number |         7 |

  @CICD5
  Scenario Outline: Customer Matching_08_9948: CreateNewConsignee_ToggleOn_Consignee ImporterSync
    Given User is in Customer Matching Competency with teamlist
    And Select Team as "ACCS Shipments"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    #And Search the shipment in Manifest Check "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    #And Search the shipment in Manifest Check "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And Create new Consignee and Consignee is same as Importer "Toggle On"
    #Then Toaster message should be displayed as "Customer successfully linked to the shipment"
    #And Click on Entry Build Icon
    #And Select ACSS Shipments toggle in Entry Build
    #And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    #Then The shipment should be in Entry Build page
    And Click on Global search
    And Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    Then "Competency" should be displayed as "Entry Build"
    And Click on Entry Build Icon
    And Select ACSS Shipments toggle in Entry Build
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    Then Verify Consignee and Importer details match with as per CM linked

    Examples: 
      | SheetName        | ColumnName | RowNumber |
      | CustomerMatching | AWB Number |         8 |

  @CICD
  Scenario Outline: Customer Matching_09_9998: CreateNewConsignee_ToggleOff_Consignee ImporterSync
    Given User is in Customer Matching Competency with teamlist
    And Select Team as "ACCS Shipments"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    #And Search the shipment in Manifest Check "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And Create new Consignee and Consignee is same as Importer "Toggle Off"
    #Then Toaster message should be displayed as "Customer successfully linked to the shipment"
    And Click on Entry Build Icon
    And Select ACSS Shipments toggle in Entry Build
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    #Then The shipment should be in Entry Build page
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    Then Verify Consignee and Importer details match with as per CM linked

    Examples: 
      | SheetName        | ColumnName | RowNumber |
      | CustomerMatching | AWB Number |         9 |

  @CICD
  Scenario: CustomerMatching_10_1631993: CustomerMatching-Column Configuration Validate all columns are loaded properly and Should not duplicate
    Given User clicks on "CUSTOMER_MATCHING" competency
    #When Select ACSS Shipments toggle
    And All columns in modal window are enabled
    Then Get all the Column Names to Verify Column Names is not duplicate
    And Get total count of Coulmn Names to Validate Column Count is 66

  @CICD1
  Scenario: CustomerMatching_11_1631993:Column Configuration [save user preferences and perform some operation and load the data , sign-off and then sign-in should retain those column configuration]
    Given User clicks on "CUSTOMER_MATCHING" competency
    When Few columns in modal window are enabled and few disable
    #Then Select ACSS Shipments toggle
    And Logout from the application
    And User login again Gemini application
    And User clicks on "CUSTOMER_MATCHING" competency
    Then validate the Saved column configuration

  @CICD
  Scenario Outline: Customer Matching_12: Work allocation - Team Leader list
    Given User is in Customer Matching Competency with Team Leader List
    When Select ACCS Shipments radio button
    And Click on activity log and download
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    #And Double Click on Arrival Date
    And Select multiple shipments in Shipment Result(s)
    #And Write the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Read limited shipment AWB number "<SheetName>","<ColumnName>","<RowNumber>"
    And Click on Assign To
    And Select the member(s) to reassign  "<SheetName>", "<FedExID>", "<RowNumber>"
    When Click on Save
    #Then "Shipment Assigned to User Successfully" Toaster message is displayed
    Then verify the shipment is in Team Leader List Assigned User ID "<SheetName>","<ColumnName>","<FedExID>","<RowNumber>"

    #And verify the shipment is in User List "<SheetName>","<ColumnName>","<RowNumber>"
    #Then Unassign the Shipment
    #Then "User Assignment Removed" Toaster message should be displayed
    Examples: 
      | SheetName        | ColumnName | FedExID  | RowNumber |
      | CustomerMatching | AWB Number | FedEx_ID |        12 |

  @CICD
  Scenario Outline: CustomerMatching_13_1631993:Perform Global Search [ assign the user to self and others ]
    Given User clicks on "CUSTOMER_MATCHING" competency
    When Click on team leader list
    Then Read limited shipment AWB number "<SheetName>","<ColumnName>","<RowNumber>"
    And select the shipment
    When Click on Assign to me in TeamLeader List
    And Wait for page to retrieve the user list
    Then Select multiple user and submit
    When Click on Global search
    And Enter multiple shipment value "<SheetName>","<ColumnName>","<RowNumber>"
    And Click on Shipment Search

    Examples: 
      | SheetName        | ColumnName | RowNumber |
      | CustomerMatching | AWB Number |        13 |

  @CICD
  Scenario Outline: CustomerMatching_14_1631993:Shipment reassignment from user list
    Given User clicks on "CUSTOMER_MATCHING" competency
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Click on Add Notification and add comment for all competencies as "Customer Matching Team List"
    #And Filter using Image Flag as "Y","<SheetName>","<ColumnName>","<RowNumber>"
    And Filter using "Image Flag" as "Y"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    Then Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    When Click on Assign to Me icon
    Then Click on User List icon
    Then Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Add Notification and add comment for all competencies as "Customer Matching User List"
    And Click on activity log and download
    And Unassign the Shipment

    Examples: 
      | SheetName | ColumnName | RowNumber |
      | Common    | AWB Number |        11 |

  @CICD
  Scenario: CustomerMatching_15_1631993:Verify Filter and Sort in Grid Columns
    Given User clicks on "CUSTOMER_MATCHING" competency
    And Select more than one teams as "ACCS Shipments"
    And Select more than one teams as "ATFC"
    And Select more than one teams as "Company Group"
    Then Click on team list
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Read the column "AWB Number" and verify the sorting is successful

  # And Read the column "Clearance Scheme" and verify the sorting is successful
  # And Read the column "Clearance Status" and verify the sorting is successful
  # And Read the column "Teams" and verify the sorting is successful
  @CICD
  Scenario: CustomerMatching_16_1631993:Verify Filter and Sort in Grid Columns
    Given User clicks on "CUSTOMER_MATCHING" competency
    When Click on team leader list
    #And Select Team as "ACCS Shipments"
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Click on Add Notification and add comment for all competencies as "Customer Matching Team Leader List"
    And Read the column "AWB Number" and verify the sorting is successful

  # And Read the column "Clearance Scheme" and verify the sorting is successful
  @CICD51
  Scenario Outline: CustomerMatching_17_15_1631993:Verify Filter and Sort in Grid Columns
    Given User clicks on "CUSTOMER_MATCHING" competency
    And Select more than one teams as "ACCS Shipments"
    And Select more than one teams as "Company Group"
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Click on activity log and download
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

    # And Read the column "Clearance Scheme" and verify the sorting is successful
    Examples: 
      | SheetName        | ColumnName | RowNumber |
      | CustomerMatching | AWB Number |        17 |

	@CICD
  Scenario Outline: CustomerMatching_18_18366_Verify Importer Name is shown as MDE consignee value in Entry build declaration view for manual linked Personal shipment records in Customer Matching
    Given User clicks on "CUSTOMER_MATCHING" competency
    And Select Team as "ATFC ("
     When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    Then Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And User enters the Company name as "Personal Shipment" and click on GO
     #Then Verify Consignee and Importer match with CP as per the search criteria
     Then Click on User List
      And Click on Global search
    And Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
     Then "Competency" should be displayed as "Entry Build"
     And Importer company should not display as Personal Shipment
    
    
    Examples: 
      | SheetName        | ColumnName | RowNumber |
      | CustomerMatching | AWB Number |        18 |
