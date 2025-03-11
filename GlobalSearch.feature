@Regression
Feature: Automation SG - Global Search Module
  
  * Validate one or more shipments in Global Search
  
  * Verify the sort codes are added for all the Competencies from Global Search

  Background: Flow till login page
    Given User is in Gemini application login page

  @CICD
  Scenario Outline: GlobalSearch_01_8461: Validate added sortcodes to Single and Multiple shipments from Global Search without loading any competency
    Given Click on Global search
    When Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Save the AWB from the UserList
    And Click sort message in floating panel
    And Click on the sort Icon for Sort Description for Ascending and Descending order
    And Unselect all sort codes
    And Click Sort Message Save button
    And Click sort message in floating panel
    And Assign "INVIC" sort codes to the shipment
    And Click Sort Message Save button
    #And Toaster message should be displayed as "Sort Codes saved"
    And User select all the shipments in Grid
    And Click sort message in floating panel
    And Add multiple sort codes
    And Click on Add button in Sort Message popup
    #And Toaster message should be displayed as "Sort Codes saved"
    And Unselect all the shipments in Grid
    And Click on Activity log in floating panel
    Then Verify the activity log is displyed with sort code "INVIC"
    And Close the activity log popup
    And Verify Route in the Global Search Grid
    Then Double click on the second shipment in Global Search
    Then Validate the selection codes "SEC" in Declaration Page

    Examples: 
      | SheetName    | ColumnName | RowNumber |
      | GlobalSearch | AWB Number |         1 |

  @CICD
  Scenario Outline: GlobalSearch_02_9470: Validate added sortcodes to Single and Multiple shipments from Global Search in MC
    Given User clicks on "MANIFEST_CHECK" competency
    And Select Team as "Phantom"
    And Read limited shipment AWB number "<SheetName>","<ColumnName>","<RowNumber>"
    Given Click on Global search
    When Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    #And Save the AWB from the UserList
    # And Click sort message
    #And Unselect all sort codes
    #And Click Sort Message Save button
    #And Click sort message
    #And Assign "INVIC" sort codes to the shipment
    #And Click Sort Message Save button
    Then Click on Sort Message on Floating Panel and select 'INVIC'
    #And Toaster message should be displayed as "Sort Codes saved"
    And Select multiple shipment from global search results
    #And User select all the shipments in Grid
    #And Click sort message
    Then Click on Sort Message on Floating Panel and select 'PAL'
    #And Add multiple sort codes
    #And Click on Add button in Sort Message
    #And Toaster message should be displayed as "Sort Codes saved"
    # And Unselect all the shipments in Grid
    When Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Click on Activity log in floating panel
    Then Verify the activity log is displyed with sort code "INVIC"
    And Close the activity log popup
    Then Double click on the first shipment in Global Search
    Then Validate the selection codes "INVIC" in Declaration Page

    #Then Verify the sort codes in Team List
    Examples: 
      | SheetName    | ColumnName | RowNumber |
      | GlobalSearch | AWB Number |         2 |

  @CICD
  Scenario Outline: GlobalSearch_03_8545: Validate added sortcodes to Single and Multiple shipments from Global Search in CM
    Given User clicks on "CUSTOMER_MATCHING" competency
    And Select Team as "SG"
    And Read limited shipment AWB number "<SheetName>","<ColumnName>","<RowNumber>"
    Given Click on Global search
    When Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    Then Click on Sort Message on Floating Panel and select 'ADT'
    #And Toaster message should be displayed as "Sort Codes saved"
    And Select multiple shipment from global search results
    #And User select all the shipments in Grid
    #And Click sort message
    Then Click on Sort Message in Floating Panel and select 'INVIC'
    When Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Click on Activity log in floating panel
    Then Verify the activity log is displyed with sort code "INVIC"
    And Close the activity log popup
    Then Double click on the second shipment in Global Search
    Then Validate the selection codes "INVIC" in Declaration Page

    Examples: 
      | SheetName    | ColumnName | RowNumber |
      | GlobalSearch | AWB Number |         3 |

  @CICD
  Scenario Outline: GlobalSearch_04_8546: Add sortcodes to Single and Multiple shipments Global Search in Conveyance and validate in Activity log
    Given User clicks on "CUSTOMER_MATCHING" competency
    And Read limited shipment AWB number "<SheetName>","<ColumnName>","<RowNumber>"
    Given User clicks on "CONVEYANCE" competency
    And Click on Global search
    When Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    Then Click on Sort Message on Floating Panel and select 'GEM'
    #And Toaster message should be displayed as "Sort Codes saved"
    And Select multiple shipment from global search results
    #And User select all the shipments in Grid
    #And Click sort message
    Then Click on Sort Message in Floating Panel and select 'INVIC'
    When Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Click on Activity log in floating panel
    Then Verify the activity log is displyed with sort code "INVIC"
    And Close the activity log popup
    Then Double click on the second shipment in Global Search
    Then Validate the selection codes "INVIC" in Declaration Page

    Examples: 
      | SheetName    | ColumnName | RowNumber |
      | GlobalSearch | AWB Number |         4 |

  @CICD
  Scenario Outline: GlobalSearch_05_9648: Validate added sortcodes to Single and Multiple shipments from Global Search in EB
    Given User clicks on "ENTRY_BUILD" competency
    #And Select Team as "ATFC"
    And Select Team as "ACCS Shipments"
    And Read limited shipment AWB number "<SheetName>","<ColumnName>","<RowNumber>"
    Given Click on Global search
    When Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    Then Click on Sort Message on Floating Panel and select 'FDA'
    #And Toaster message should be displayed as "Sort Codes saved"
    And Select multiple shipment from global search results
    Then Click on Sort Message in Floating Panel and select 'INVIC'
    When Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Click on Activity log in floating panel
    Then Verify the activity log is displyed with sort code "INVIC"
    And Close the activity log popup
     When Click Add Notification and add comment as "Test Comments Added"
     #Then click save button
    Then Double click on the second shipment in Global Search
    Then Validate the selection codes "INVIC" in Declaration Page

    Examples: 
      | SheetName    | ColumnName | RowNumber |
      | GlobalSearch | AWB Number |         5 |
   
   # /* Duplicate test case */
  @CICD
  Scenario Outline: GlobalSearch_06_17291: Verify that all fields relevant to Ops is available for user to change the order of the fields
    Given User clicks on "CUSTOMER_MATCHING" competency
    And Select Team as "SG"
    And Read 2 shipment AWB number "<SheetName>","<ColumnName>","<RowNumber>"
    When Click on Global search
    And Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    Then All columns in modal window are enabled
    And Get all the Column Names to Verify Column Names is not duplicate
    And Get total count of Coulmn Names to Validate Column Count is 56

    Examples: 
      | SheetName    | ColumnName | RowNumber |
      | GlobalSearch | AWB Number |         6 |

  @CICD
  Scenario Outline: GlobalSearch_07_17388_Verify Next button is disabled for the last shipment in global search Entry build view screen
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ATFC"
    And Read 2 shipment AWB number "<SheetName>","<ColumnName>","<RowNumber>"
    And Click on Global search
    When Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Double click on the first shipment in Global Search
    And Verify next button is Enabled
    Then Click next button of Declaration Page
    And Verify next button is Disabled
    And Cancel the Decalaration
    
    Examples: 
      | SheetName    | ColumnName | RowNumber |
      | GlobalSearch | AWB Number |         7 |

  @CICD
  Scenario Outline: GlobalSearch_08_Verify that all fields relevant to Ops is available for user to add or Remove fields
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ATFC"
    And Read limited shipment AWB number "<SheetName>","<ColumnName>","<RowNumber>"
    And Click on Global search
    When Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Disable the columns in modal window
    And Enable all columns in modal window
    And Read all header names in the global search

    Examples: 
      | SheetName    | ColumnName | RowNumber |
      | GlobalSearch | AWB Number |         8 |

  @CICD
  Scenario Outline: GlobalSearch_09_E-194202_Verify that all fields relevant to Ops is available for user to change the order of the fields
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ATFC"
    And Read limited shipment AWB number "<SheetName>","<ColumnName>","<RowNumber>"
    And Click on Global search
    When Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Disable the columns in modal window
    And Change the order of the column

    Examples: 
      | SheetName    | ColumnName | RowNumber |
      | GlobalSearch | AWB Number |         9 |

  @CICD
  Scenario Outline: GlobalSearch_10_17291: Verify that all fields relevant to Ops is available for user to change the order of the  fields
    Given User clicks on "CUSTOMER_MATCHING" competency
    And Select Team as "SG ("
    And Read 2 shipment AWB number "<SheetName>","<ColumnName>","<RowNumber>"
    And Click on Global search
    When Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And All columns in modal window are enabled
    Then Get all the Column Names to Verify Column Names is not duplicate
    And Get total count of Coulmn Names to Validate Column Count is 56

    Examples: 
      | SheetName    | ColumnName | RowNumber |
      | GlobalSearch | AWB Number |        10 |

  @CICD
  Scenario Outline: GlobalSearch_11_17388_Verify Next button is disabled for the last shipment in global search Entry build view screen
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ATFC"
    And Read 2 shipment AWB number "<SheetName>","<ColumnName>","<RowNumber>"
    And Click on Global search
    When Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Double click on the first shipment in Global Search
    And Verify next button is Enabled
    Then Click next button of Declaration Page
    And Verify next button is Disabled
    And Cancel the Decalaration

    Examples: 
      | SheetName    | ColumnName | RowNumber |
      | GlobalSearch | AWB Number |        11 |

  @CICD
  Scenario Outline: GlobalSearch_12:TCP04_Assign a shipment to user after warning
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ATFC"
    #And Select Team as ACCS Shipments
    When Click on team list
    #And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    #And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    #And select the shipment
    And Read 2 shipment AWB number "<SheetName>","<ColumnName>","<RowNumber>"
    Given Click on Global search
    When Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Click on Shipment Search
    When Click on Assign to me in TeamLeader List
    And Select two user and submit

    Examples: 
      | SheetName     | ColumnName | RowNumber |
      | GlobalSearch | AWB Number |        12 |

  @CICD
  Scenario Outline: GlobalSearch_13_9648: Verify that all fields relevant to Ops is available for user to remove fields
    Given User clicks on "ENTRY_BUILD" competency
    Then Read 2 shipment AWB number "<SheetName>","<ColumnName>","<RowNumber>"
    Given Click on Global search
    When Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    When Disable the columns in modal window
    And All columns in modal window are enabled
    Then Get all the Column Names to Verify Column Names is not duplicate
    And Get total count of Coulmn Names to Validate Column Count is 56
    #Then Disable the required columns in modal window

    Examples: 
      | SheetName     | ColumnName | RowNumber |
      | GlobalSearch | AWB Number |        13 |

  @CICD
  Scenario Outline: GlobalSearch_14_Verify Download icon  in Activity log Global search
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ATFC"
    Then Read 2 shipment AWB number "<SheetName>","<ColumnName>","<RowNumber>"
    Given Click on Global search
    When Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Click on Activity log in floating panel
    Then verify the download icon in Activity log

    Examples: 
      | SheetName     | ColumnName | RowNumber |
      | GlobalSearch | AWB Number |        14 |

  @CICD
  Scenario Outline: GlobalSearch_15_9648: Validate CI document is available for shipment where CI flag is Y in the grid from Global Search in EB
    Given User clicks on "ENTRY_BUILD" competency
    #And Select Team as "ATFC"
    And Select Team as "ACCS Shipments"
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Filter using columnname "Image Flag" as "Y"
    And Read limited shipment AWB number "<SheetName>","<ColumnName>","<RowNumber>"
    And Click on Global search
    When Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Verify CI Document visible in Image Viewer
    And Click Close Global search

    #Then Verify the Previous document should not be loaded in the Image viewer
    Examples: 
      | SheetName    | ColumnName | RowNumber |
      | GlobalSearch | AWB Number |         15 |
