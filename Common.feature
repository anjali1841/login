@Regression
Feature: Automation SG - Common Module

  Background: Flow till login page
    Given User is in Gemini application login page

  @CICD
  Scenario Outline: Common_01_8442: Verify all the shipments are selected if user performs ctrl+A in Customer Matching
    Given User clicks on "CUSTOMER_MATCHING" competency
    And Select Team as "ACCS Shipments"
    And Read limited shipment AWB number "<SheetName>","<ColumnName>","<RowNumber>"
    When Click on Global search
    And Enter multiple shipment value "<SheetName>","<ColumnName>","<RowNumber>"
    #And Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Click on Shipment Search
    And Performs CtrlA
    Then All the Shipments should be selected in Global search window
    Then Close the global search window

    Examples: 
      | SheetName | ColumnName | RowNumber |
      | Common    | AWB Number |         1 |

  @CICD
  Scenario Outline: Common_02_8443: Verify all the shipments are selected if user performs ctrl+A in Entry Build
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    And Read limited shipment AWB number "<SheetName>","<ColumnName>","<RowNumber>"
    When Click on Global search
    And Enter multiple shipment value "<SheetName>","<ColumnName>","<RowNumber>"
    #And Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Click on Shipment Search
    And Performs CtrlA
    Then All the Shipments should be selected in Global search window
    Then Close the global search window

    Examples: 
      | SheetName | ColumnName | RowNumber |
      | Common    | AWB Number |         2 |

  @CICD
  Scenario Outline: Common_03_8444: Verify all the shipments are selected if user performs ctrl+A in Manifest Check
    Given User clicks on "MANIFEST_CHECK" competency
    And Select Team as "ACCS Shipments"
    And Read limited shipment AWB number "<SheetName>","<ColumnName>","<RowNumber>"
    When Click on Global search
    And Enter multiple shipment value "<SheetName>","<ColumnName>","<RowNumber>"
    #And Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Click on Shipment Search
    And Performs CtrlA
    Then All the Shipments should be selected in Global search window
    Then Close the global search window

    Examples: 
      | SheetName | ColumnName | RowNumber |
      | Common    | AWB Number |         3 |

  @CICD
  Scenario Outline: Common_04_8448: Verify the added sort codes from Global Search [D- 1311]
    Given Click on Entry Build Icon
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    #And Store the AWB number
    And Click on Assign to me
    And Click on User List
    When Click on Global search
    #And Search the stored shipment
    And Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    Then Double click on the first shipment in global Search
    Then Validate the selection codes 'INVIC','PWK' not in Declaration Page
    Then Click on Sort Message on Floating Panel and select 'PWK'
    Then Validate the selection codes are added 'PWK' in Declaration Page

    Examples: 
      | SheetName | ColumnName | RowNumber |
      | Common    | AWB Number |         4 |

  @CICD
  Scenario Outline: Common_05_8445: Validate Save and Close buttons of AddNotification both in Userlist and declaration of the shipment in Entry Build
    Given Click on Entry Build Icon
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    #And Store the AWB number
    And Click on Assign to me
    Then Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    #And Search the stored shipment
    When Click Add Notification and add comment as "Test Comment"
    #Then click save button
    #Then Verify popup "Comments saved successfully"
    Then Double click on the first shipment
    Then Click notification from Floating Panel
    Then Add comment as "Floating Panel Comment"
    #Then click save button
    And Close the declartion page
    Then Unassign the Shipment

    Examples: 
      | SheetName | ColumnName | RowNumber |
      | Common    | AWB Number |         5 |

  @CICD
  Scenario Outline: Common_06_8455: Verify if Customer Invoice label of the shipment should match with the same shipment CI in global search[RTG PROD]
    Given Click on Entry Build Icon
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Select Team as "ACCS Shipments"
    And Filter using columnname "Image Flag" as "Y"
    #And Filter using Image Flag as "Y","<SheetName>","<ColumnName>","<RowNumber>"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    #Then Verify popup "Shipment Assigned to User List"
    Then Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Upload button in floating panel
    And Select location as 'SG' and type as 'CI' and upload sample file
    And Select file to upload
    And Capture customer invoice label
    When Click on Global search
    And Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Click on Shipment Search
    And Capture customer invoice label
    Then Close the global search window
    Then Unassign the Shipment

    Examples: 
      | SheetName | ColumnName | RowNumber |
      | Common    | AWB Number |         6 |

  @CICD
  Scenario Outline: Common_07_8523: Validate the shipment by adding URG sort code from the floating Panel
    Given Click on Entry Build Icon
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    #Then Verify popup "Shipment Assigned to User List"
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    Then Click on Sort Message on Floating Panel and select 'URG'
    #Then Verify popup "Sort Codes saved"
    #Then Click on Entry Build Icon
     #Then Cancel the Decalaration
    #And Click on User List
    When Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    Then Double click on the first shipment
    Then Validate the selection codes are added 'URG' in Declaration Page
    And Close the declartion page
    Then Unassign the Shipment

    Examples: 
      | SheetName | ColumnName | RowNumber |
      | Common    | AWB Number |         7 |

  @CICD
  Scenario Outline: Common_08_8457: Verify CI documents should get displayed without duplicate images in Manifest check [D-1363]
    Given User clicks on "MANIFEST_CHECK" competency
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Select Team as "ACCS Shipments"
    #And Filter using "Image Flag" as "Equals"
    And Filter using columnname "Image Flag" as "Y"
    #And Filter using Image Flag as "Y","<SheetName>","<ColumnName>","<RowNumber>"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Upload button in floating panel
    And Select location as 'SG' and type as 'CI' and upload sample file
    And Select file to upload
    Then CI Document should not have duplicate image
    Then Click on User List icon
    Then Unassign the Shipment

    Examples: 
      | SheetName | ColumnName | RowNumber |
      | Common    | AWB Number |         8 |

  @CICD
  Scenario Outline: Common_09_8462: Verify CI documents should get displayed without duplicate images in Customer Matching [D-1363]
    Given User clicks on "CUSTOMER_MATCHING" competency
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Select Team as "ACCS Shipments"
    #And Filter using "Image Flag" as "Equals"
    #And Filter using CI Flag as "Blank Cells"
    #And Filter using Image Flag as "Y","<SheetName>","<ColumnName>","<RowNumber>"
    And Filter using columnname "Image Flag" as "Y"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Upload button in floating panel
    And Select location as 'SG' and type as 'CI' and upload sample file
    And Select file to upload
    Then Click on User List icon
    Then CI Document should not have duplicate image
    Then Unassign the Shipment

    Examples: 
      | SheetName | ColumnName | RowNumber |
      | Common    | AWB Number |         9 |

  @CICD
  Scenario Outline: Common_10_8464: Verify CI documents should get displayed without duplicate images in Entry Build check [D-1363]
    Given User clicks on "ENTRY_BUILD" competency
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Select Team as "ACCS Shipments"
    #And Filter using CI Flag as "Equals"
    And Filter using columnname "Image Flag" as "Y"
    #And Filter using Image Flag as "Y","<SheetName>","<ColumnName>","<RowNumber>"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Upload button in floating panel
    And Select location as 'SG' and type as 'CI' and upload sample file
    And Select file to upload
    Then Click on User List icon
    Then CI Document should not have duplicate image
    Then Unassign the Shipment

    Examples: 
      | SheetName | ColumnName | RowNumber |
      | Common    | AWB Number |        10 |

 	@CICD
  Scenario Outline: Common_11_8449: Verify CI flag type as Y after uploading CI DocumentType to the shipment from userlist in Entry Build
    Given Click on Entry Build Icon
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Filter using "Image Flag" as "Blank Cells"
    #And Select filter option for Image flag as "Image Flag","Blank Cells"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    When Click on Assign to me
    Then Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Upload button in floating panel
    And Select location as 'SG' and type as 'CI' and upload sample file
    And Select file to upload
    When Click on Entry Build Icon
    Then Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    Then Validate the Image flag "Y" assigned for the shipment

    Examples: 
      | SheetName | ColumnName | RowNumber |
      | Common    | AWB Number |        11 |

  @CICD
  Scenario Outline: Common_12_8451: Verify the document is uploaded successfully in image viewer from teamleaderlist in Entry Build
    Given User clicks on "ENTRY_BUILD" competency
    When Click on team leader list
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    When Click on Assign to me in TeamLeader List
    And Wait for page to retrieve the user list
    Then Search the user
    Then Select the user and submit
    #Then Verify popup "Shipment Assigned to User List"
    Then Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Upload button in floating panel
    And Select location as 'SG' and type as 'GST' and upload sample file
    And Select file to upload
    When Click on Entry Build Icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    Then Verify the uploaded document in customer invoice 'GST'

    Examples: 
      | SheetName | ColumnName | RowNumber |
      | Common    | AWB Number |        12 |

  @CICD
  Scenario Outline: Common_13_8459: Verify Thumbnails for multiple documents in a shipment displayed as default in detached mode in Manifest Check[D-1429]
    Given User clicks on "MANIFEST_CHECK" competency
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Select Team as "ACCS Shipments"
    And Filter using columnname "Image Flag" as "Y"
    #And Filter using Image Flag as "Y","<SheetName>","<ColumnName>","<RowNumber>"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    When Click on Assign to me
    Then Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Upload button in floating panel
    And Select location as 'SG' and type as 'GST' and upload sample file
    And Select file to upload
    And Click on the new open in new tab in document section
    Then Document thumbnail should be in detached view in new tab
    #And Unassign the Shipment
    #Then Click on team list
    #And Select Team as "ACCS Shipments"
    #And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    #And Click on Assign to me
    #Then Click on User List
    #And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Upload button in floating panel
    And Select location as 'SG' and type as 'PERMIT' and upload sample file
    And Select file to upload
    And Click on the new open in new tab in document section
    Then Document thumbnail should be in detached view in new tab
    And Unassign the Shipment

    Examples: 
      | SheetName | ColumnName | RowNumber |
      | Common    | AWB Number |        13 |

  @CICD
  Scenario Outline: Common_14_8465: Verify Thumbnails for multiple documents in a shipment displayed as default in detached mode in Entry Build[D-1429]
    Given User clicks on "ENTRY_BUILD" competency
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Select Team as "ACCS Shipments"
    And Filter using columnname "Image Flag" as "Y"
    #And Filter using Image Flag as "Y","<SheetName>","<ColumnName>","<RowNumber>"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    When Click on Assign to me
    Then Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Upload button in floating panel
    And Select location as 'SG' and type as 'LICENSE' and upload sample file
    And Select file to upload
    And Click on the new open in new tab in document section
    Then Document thumbnail should be in detached view in new tab
    #And Unassign the Shipment
    #Then Click on team list
    #And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    #And Click on Assign to me
    #Then Click on User List
    #And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    #And Double click on the first shipment
    And Click on Upload button in floating panel
    And Select location as 'SG' and type as 'PERMIT' and upload sample file
    And Select file to upload
    And Click on the new open in new tab in document section
    Then Document thumbnail should be in detached view in new tab
    And Unassign the Shipment

    Examples: 
      | SheetName | ColumnName | RowNumber |
      | Common    | AWB Number |        14 |
