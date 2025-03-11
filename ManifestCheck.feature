@Regression
Feature: Automation SG - Manifest Check Module
  
  * Validate Sanity Check/Rules Override  
  * Validate Modify Clearance Scheme  
  * Validate Upload document using Image viewer

  Background: Flow till login page
    Given User is in Gemini application login page

  @CICD
  Scenario Outline: ManifestCheck_01_8572: Verify the document is uploaded successfully if CI Flag is Empty cell
    Given User clicks on "MANIFEST_CHECK" competency
    And Select Team as "ACCS Shipments"
    And Filter using "Image Flag" as "Blank Cells"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Upload button in floating panel
    And Select location as 'SG' and type as 'CI' and upload sample file
    And Select file to upload
    Then Click on User List icon
    And Enable the required columns in modal window
    Then Verify "Image Flag" value is equal to "Y"

    Examples: 
      | SheetName     | ColumnName | RowNumber |
      | ManifestCheck | AWB Number |         1 |

  @CICD1100
  Scenario Outline: ManifestCheck_02_8574: Verify the document is uploaded successfully from image viewer for any document
    Given User clicks on "MANIFEST_CHECK" competency
    And Select Team as "ACCS Shipments"
    And Filter using "Image Flag" as "Blank Cells"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Upload button in floating panel
    And Select location as 'SG' and type as 'CI' and upload sample file
    And Select file to upload
    Then Click on User List icon
    And Enable the required columns in modal window
    Then Verify "Image Flag" value is equal to "Y"

    Examples: 
      | SheetName     | ColumnName | RowNumber |
      | ManifestCheck | AWB Number |         2 |

  @CICD1100
  Scenario Outline: ManifestCheck_03_8548: Validate Shipment Override for LV Single and Multiple Shipment
    Given User clicks on "MANIFEST_CHECK" competency
    Then Click on User List icon
    And Unassign the Shipment
    And Click on team list
    And Select more than one teams as "ACCS Shipments"
    And Select more than one teams as "Company Group"
    And Filter using columnname "Clearance Scheme" as "LV"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Override button
    Then Click on User List icon
    And Click on teamlist
    And Select more than one teams as "ACCS Shipments"
    And Select more than one teams as "Company Group"
    And Filter using columnname "Clearance Scheme" as "LV"
    And Read 2 shipment AWB number "<SheetName>","<ColumnName1>","<RowNumber>"
    And Click on Assign to Me icon
    #And Toaster message should be displayed as "Shipments Assigned to User List"
    And Click on User List icon
    And Select all the shipments from the grid
    And Click on Override button
    #And Click on User List icon
    And On Demand - Click on User List Icon
    Then Click on Global search
    And Search the shipment "<SheetName>","<ColumnName1>","<RowNumber>" in Global Search
    And Verify shipment is moved to other competency

    Examples: 
      | SheetName     | ColumnName | ColumnName1      | RowNumber |
      | ManifestCheck | AWB Number | Addnl_AWB Number |         3 |

  @CICD
  Scenario Outline: ManifestCheck_04_8561: Validate Shipment Override for HV Single and Multiple Shipment
    Given User clicks on "MANIFEST_CHECK" competency
    Then Click on User List icon
    And Unassign the Shipment
    And Click on team list
    And Select more than one teams as "ACCS Shipments"
    And Select more than one teams as "Company Group"
    And Filter using columnname "Clearance Scheme" as "HV"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    #And Toaster message should be displayed as "Shipment Assigned to User List"
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And Click on Override button
    #Then Toaster message should be displayed as "Sanity check overridden"
    And Click on teamlist
    #And Select ACCS Shipments toggle
    And Select more than one teams as "ACCS Shipments"
    And Select more than one teams as "Company Group"
    And Filter using columnname "Clearance Scheme" as "HV"
    #And Filter using Clearance Scheme as "HV"
    And Read 2 shipment AWB number "<SheetName>","<ColumnName1>","<RowNumber>"
    And Click on Assign to Me icon
    #And Toaster message should be displayed as "Shipments Assigned to User List"
    And Click on User List icon
    And Select all the shipments from the grid
    And Click on Override button
    #And Click on User List icon
    #Then Toaster message should be displayed as "Sanity check overridden"
    And On Demand - Click on User List Icon
    Then Click on Global search
    And Search the shipment "<SheetName>","<ColumnName1>","<RowNumber>" in Global Search
    And Verify shipment is moved to other competency

    Examples: 
      | SheetName     | ColumnName | ColumnName1      | RowNumber |
      | ManifestCheck | AWB Number | Addnl_AWB Number |         4 |

  @CICD
  Scenario Outline: ManifestCheck_05_8562: Validate Shipment Override for X-HIGH Single and Multiple Shipment
    Given User clicks on "MANIFEST_CHECK" competency
    Then Click on User List icon
    And Unassign the Shipment
    And Click on team list
    And Select Team as "Phantom"
    And Filter using columnname "Clearance Scheme" as "X-HIGH"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    #And Toaster message should be displayed as "Shipment Assigned to User List"
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And Click on Override button
    #Then Toaster message should be displayed as "Sanity check overridden"
    And Click on teamlist
    And Select Team as "Phantom"
    And Filter using columnname "Clearance Scheme" as "X-HIGH"
    And Read 2 shipment AWB number "<SheetName>","<ColumnName1>","<RowNumber>"
    And Click on Assign to Me icon
    #And Toaster message should be displayed as "Shipments Assigned to User List"
    And Click on User List icon
    And Select all the shipments from the grid
    And Click on Override button
    #And Click on User List icon
    #Then Toaster message should be displayed as "Sanity check overridden"
    And On Demand - Click on User List Icon
    Then Click on Global search
    And Search the shipment "<SheetName>","<ColumnName1>","<RowNumber>" in Global Search
    And Verify shipment is moved to other competency

    Examples: 
      | SheetName     | ColumnName | ColumnName1      | RowNumber |
      | ManifestCheck | AWB Number | Addnl_AWB Number |         5 |

  @CICD
  Scenario Outline: ManifestCheck_06_8563: Validate Modify Clearance Scheme for the Shipment
    Given User clicks on "MANIFEST_CHECK" competency
    And Select Team as "ACCS Shipments"
    And Filter using columnname "Clearance Scheme" as "LV"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Modify Clearance Scheme button
    And Modify Clearance Scheme to "X-HIGH"
    #Then Verify Toaster Message "Scheme is modified successfully"
    And Click on User List icon

    Examples: 
      | SheetName     | ColumnName | RowNumber |
      | ManifestCheck | AWB Number |         6 |
	
	@CICD
  Scenario Outline: ManifestCheck_07_9682: Adding NMOW Sort code for the shipment, shipment failed only for SCANS rule
    Given User clicks on "MANIFEST_CHECK" competency
    And Select Team as "ACCS Shipments"
    And Store the AWB number
    And Search the stored shipment
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the stored shipment
    And Click on Sort Message icon from Floating Panel
    And Select Selection Code as "NMOW" and Save

    Examples: 
      | SheetName     | ColumnName | RowNumber |
      | ManifestCheck | AWB Number |         7 |

  @CICD1100
  Scenario Outline: ManifestCheck_08_9682: Work allocation - Team Leader list
    Given User clicks on "MANIFEST_CHECK" competency
    And Click on team leader list
    And Select ACSS Shipments toggle in team leader list
    And Click on activity log and download
    And Read 3 shipment AWB number "<SheetName>","<ColumnName>","<RowNumber>"
    #And Select 15 number of shipments in the Grid
    When Click on Assign to me in TeamLeader List
    #And Select any 3 user and submit
    #And Toaster message should be displayed as "Shipments Assigned To User Successfully"
    Then Assigned To of selected 15 shipments should be assigned to user in round robin
    And Select the member(s) to reassign  "<SheetName>", "<FedExID>", "<RowNumber>"
    When Click on Save
    #Then "Shipment Assigned to User Successfully" Toaster message is displayed
    Then verify the shipment is in Team Leader List Assigned User ID "<SheetName>","<ColumnName>","<FedExID>","<RowNumber>"

    #And Click on User List icon
    #And Click on Global search
    #When Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    #And Verify selected shipments assigned to Userlist "<SheetName>","<ColumnName>","<RowNumber>"
    #And Unassign all the shipments in user list
    Examples: 
      | SheetName     | ColumnName | FedExID  | RowNumber |
      | ManifestCheck | AWB Number | FedEx_ID |         8 |

  #And Toaster message should be displayed as "User Assignments Removed"
  #Then Verify Toaster Message "User Assignments Removed"
  @CICD
  Scenario: ManifestCheck_09_1631993: Manifest Check-ColumnConfiguration Validate all columns are loaded properly and Should not duplicate
    Given User clicks on "MANIFEST_CHECK" competency
    #When Select ACSS Shipments toggle
    And All columns in modal window are enabled
    Then Get all the Column Names to Verify Column Names is not duplicate
    And Get total count of Coulmn Names to Validate Column Count is 72

  @CICD
  Scenario: ManifestCheck_10_1631993:Column Configuration [save user preferences and perform some operation and load the data , sign-off and then sign-in should retain those column configuration]
    Given User clicks on "MANIFEST_CHECK" competency
    When Few columns in modal window are enabled and few disable
    And Logout from the application
    And User login again Gemini application
    And User clicks on "MANIFEST_CHECK" competency
    Then validate the Saved column configuration

  @CICD
  Scenario Outline: ManifestCheck_11_1631993:Perform Global Search [ assign the user to self and others ]
    Given User clicks on "MANIFEST_CHECK" competency
    When Click on team leader list
    And Read limited shipment AWB number "<SheetName>","<ColumnName>","<RowNumber>"
    And select the shipment
    When Click on Assign to me in TeamLeader List
    And Wait for page to retrieve the user list
    Then Select multiple user and submit
    When Click on Global search
    And Enter multiple shipment value "<SheetName>","<ColumnName>","<RowNumber>"
    And Click on Shipment Search
     When Disable the columns in modal window
    Then Enable the required columns in modal window
    

    Examples: 
      | SheetName     | ColumnName | RowNumber |
      | ManifestCheck | AWB Number |        11 |

  @CICD
  Scenario Outline: ManifestCheck_12_1631993:Shipment reassignment from user list
    Given User clicks on "MANIFEST_CHECK" competency
    And Select Team as "ACCS Shipments"
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Click on Add Notification and add comment for all competencies as "Manifest Check Team List"
    And Filter using Image Flag as "Y","<SheetName>","<ColumnName>","<RowNumber>"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    Then Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    When Click on Assign to Me icon
    Then Click on User List icon
    Then Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Add Notification and add comment for all competencies as "Manifest Check User List"
    And Click on activity log and download
    And Unassign the Shipment

    Examples: 
      | SheetName     | ColumnName | RowNumber |
      | ManifestCheck | AWB Number |        12 |

  @CICD
  Scenario: ManifestCheck_13_1631993:Verify Filter and Sort in Grid Columns
    Given User clicks on "MANIFEST_CHECK" competency
    Then Click on team list
    And Select Team as "ACCS Shipments"
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Read the column "AWB Number" and verify the sorting is successful

  # And Read the column "Clearance Scheme" and verify the sorting is successful
  @CICD
  Scenario: ManifestCheck_14_1631993:Verify Filter and Sort in Grid Columns
    Given User clicks on "MANIFEST_CHECK" competency
    When Click on team leader list
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Click on Add Notification and add comment for all competencies as "Manifest Check Team Leder List"
    And Read the column "AWB Number" and verify the sorting is successful

  # And Read the column "Clearance Scheme" and verify the sorting is successful
  @CICD
  Scenario Outline: ManifestCheck_15_1631993:Verify Filter and Sort in Grid Columns
    Given User clicks on "MANIFEST_CHECK" competency
    And Select Team as "ACCS Shipments"
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

    #  And Read the column "Clearance Scheme" and verify the sorting is successful
    Examples: 
      | SheetName     | ColumnName | RowNumber |
      | ManifestCheck | AWB Number |        15 |

  @CICD
  Scenario Outline: ManifestCheck_16_16977_Verify CI Flag type as Y  for shipment in Userlist  from floating panel
    Given User clicks on "MANIFEST_CHECK" competency
    When Click on team leader list
    And Select ACCS Shipments radio button
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    #And Select filter option for Image flag as "Image Flag","Blank Cells"
    And Filter using "Image Flag" as "Blank Cells"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign To
    And Select only 1 user and submit
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Upload button in floating panel
    And Select location as 'SG' and type as 'CI' and upload sample file
    And Select file to upload
    And Click on User List
    Then Validate the Image flag "Y" assigned for the shipment
    And Unassign the Shipment
    And Click on team list
    And Select Team as "ACCS Shipments"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    Then Validate the Image flag "Y" assigned for the shipment
    When Click on team leader list
    And Select ACCS Shipments radio button
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    Then Validate the Image flag "Y" assigned for the shipment

    Examples: 
      | SheetName     | ColumnName | RowNumber |
      | ManifestCheck | AWB Number |        16 |

  @CICD
  Scenario Outline: ManifestCheck_17_8574: Shipment Reassignment from UserList
    Given User clicks on "MANIFEST_CHECK" competency
    And Select Team as "ACCS Shipments"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Unassign the Shipment
    And Click on team list
    And Select Team as "ACCS Shipments"
    And Disable Team "Default"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    And Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"

    Examples: 
      | SheetName     | ColumnName | RowNumber |
      | ManifestCheck | AWB Number |        17 |

  @CICD
  Scenario Outline: ManifestCheck_18_17670,_19_17672:  Assigning and Un-assigning multiple shipments to user list_Manifest check
    Given User clicks on "MANIFEST_CHECK" competency
    And Select more than one teams as "ACCS Shipments"
    And Select more than one teams as "Phantom"
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Read 10 shipment AWB number "<SheetName>","<ColumnName>","<RowNumber>"
    And Filter using "AWB Number" as "In"
    And Search the Multiple shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click toggle to select all available shipment
    And Click on Assign to me
    And Click on User List
    And Click toggle to select all available shipment
    And Unassign the Shipment
    And Click on User List
    Then Verify message No Data Available once all the competency is updated

    Examples: 
      | SheetName     | ColumnName | RowNumber |
      | ManifestCheck | AWB Number |        18 |

  @CICD
  Scenario Outline: ManifestCheck_20_17671: Overriding Multiple shipments_Manifest check
    Given User clicks on "MANIFEST_CHECK" competency
    Then Click on User List icon
    And Unassign the Shipment
    And Click on team list
    And Select more than one teams as "ACCS Shipments"
    And Select more than one teams as "Phantom"
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Read 10 shipment AWB number "<SheetName>","<ColumnName>","<RowNumber>"
    And Filter using "AWB Number" as "In"
    And Search the Multiple shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click toggle to select all available shipment
    And Click on Assign to me
    And Click on User List
    And Filter using "AWB Number" as "In"
    And Search the Multiple shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click toggle to select all available shipment
    And Click on Override button
    And On Demand - Click on User List Icon
    Then Click on Global search
    And Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Close Global Search Window
    And Click on User List
    Then Verify message No Data Available once all the competency is updated

    Examples: 
      | SheetName     | ColumnName | RowNumber |
      | ManifestCheck | AWB Number |        19 |

  @CICD
  Scenario Outline: ManifestCheck_21_17674: After overridden shipment should move to the respective competency
    Given User clicks on "MANIFEST_CHECK" competency
    And Select more than one teams as "ACCS Shipments"
    And Select more than one teams as "Phantom"
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Filter using "Importer Company" as "Blank Cells"
    And Filter using "Consignee Company" as "Blank Cells"
    And Filter using columnname "Clearance Scheme" as "HV"
    And Read 5 shipment AWB number "<SheetName>","<ColumnName>","<RowNumber>"
    And Filter using "AWB Number" as "In"
    And Search the Multiple shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click toggle to select all available shipment
    And Click on Assign to me
    And Click on User List
    And Filter using "AWB Number" as "In"
    And Search the Multiple shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click toggle to select all available shipment
    And Click on Override button
    And On Demand - Click on User List Icon
    Then Click on Global search
    And Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    Then "Competency" should be displayed as "Customer Matching"
    # And Close Global Search Window
    And Click on User List
    Given User clicks on "CUSTOMER_MATCHING" competency
    And Select more than one teams as "ACCS Shipments"
    And Select more than one teams as "ATFC Prioity"
    And Select more than one teams as "ATFC"
    #  And Read 5 shipment AWB number "<SheetName>","<ColumnName>","<RowNumber>"
    And Filter using "AWB Number" as "In"
    And Search the Multiple shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click toggle to select all available shipment
    And Click on Assign to me
    And Click on User List
    And Filter using "AWB Number" as "In"
    And Search the Multiple shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    When Double click on the first shipment
    And User search for Importer and click on the Multiple Link Importer icon for all shipments
    And On Demand - Click on User List Icon
    Then Click on Global search
    And Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    Then "Competency" should be displayed as "Entry Build"

    Examples: 
      | SheetName     | ColumnName | RowNumber |
      | ManifestCheck | AWB Number |        21 |
