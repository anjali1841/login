@Regression
Feature: Automation SG - Global Search Module
  
  * Validate one or more shipments in Global Search
  
  * Verify the sort codes are added for all the Competencies from Global Search

  Background: Flow till login page
    Given User is in Gemini application login page

  @CICD
  Scenario Outline: ImageViewer_1_Verify the document is downloaded successfully from Manifest check from Image Viewer.
    When User clicks on "MANIFEST_CHECK" competency
    When Click on team leader list
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    When Click on Assign to me in TeamLeader List
    And Enter the user id to assign the shipment to the user
    Then Select the user and submit
    Then Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Upload button in floating panel
    And Select location as 'SG' and type as 'LICENSE' and upload sample file
    And Select file to upload
    And Click on User List
    Then Download "LIC" document from Image viewer
    And Click on User List
    And Verify the file "LICENSE" is successfully downloaded

    Examples: 
      | SheetName   | ColumnName | RowNumber |
      | ImageViewer | AWB Number |         1 |

  @CICD
  Scenario Outline: ImageViewer_2_Verify the document is downloaded successfully from customer matching from Image viewer.
    When User clicks on "CUSTOMER_MATCHING" competency
    When Click on team leader list
    When Select ACCS Shipments radio button
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    When Click on Assign to me in TeamLeader List
    And Enter the user id to assign the shipment to the user
    Then Select the user and submit
    Then Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Upload button in floating panel
    And Select location as 'SG' and type as 'PERMIT' and upload sample file
    And Select file to upload
    And Click on User List
    Then Download "PERMIT" document from Image viewer
    And Click on User List
    And Verify the file "PERMIT" is successfully downloaded

    Examples: 
      | SheetName   | ColumnName | RowNumber |
      | ImageViewer | AWB Number |         2 |

  @CICD
  Scenario Outline: ImageViewer_3_Verify the document is downloaded successfully from entry build from image viewer.
    When User clicks on "ENTRY_BUILD" competency
    When Click on team leader list
    When Select ACCS Shipments radio button
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    When Click on Assign to me in TeamLeader List
    And Enter the user id to assign the shipment to the user
    Then Select the user and submit
    Then Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Upload button in floating panel
    And Select location as 'SG' and type as 'SUBCT' and upload sample file
    And Select file to upload
    And Click on User List
    Then Download "SUBCT" document from Image viewer
    And Click on User List
    And Verify the file "SUBCT" is successfully downloaded

    Examples: 
      | SheetName   | ColumnName | RowNumber |
      | ImageViewer | AWB Number |         3 |

  @CICD
  Scenario Outline: ImageViewer_4 Customer invoice label of the shipment should match with the same shipment CI in global search
    When User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Click on Assign to me
    #And Enter the user id to assign the shipment to the user
    #Then Select the user and submit
    Then Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Upload button in floating panel
    And Select location as 'SG' and type as 'PERMIT' and upload sample file
    And Select file to upload
    And Click on User List
    Then Download "PERMIT" document from Image viewer
    When User clicks on "CONVEYANCE" competency
    And Click on Global search
    And Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Verify the thumnails are matched

    Examples: 
      | SheetName   | ColumnName | RowNumber |
      | ImageViewer | AWB Number |         4 |

  @CICD
  Scenario Outline: ImageViewer_5_Verify the document is deleted successfully in Image viewer
    When User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Filter using columnname "Image Flag" as "Y"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Click on Assign to me
    Then Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Delete "CI" document from Image viewer
    And Click on User List
    Then Validate CI flag is removed from the shipment

    Examples: 
      | SheetName   | ColumnName | RowNumber |
      | ImageViewer | AWB Number |         5 |

  @CICD
  Scenario Outline: ImageViewer_6_Verify document upload in Customer Profile and reflected in Entry build image viewer
    When User clicks tools icon
    And Select "Customer Profile" from tools option
    And Create new profile icon
    And Enter company name
    And Enter address details in customer profile
    And Click new customer Instruction
    And Select customer instruction type as "Authorization & License"
    And Select license type as "LICENSE"
    And Select sub license type as "Direct"
    And Select valid to date
    Then Select document type "LIC-License" from dropdown
    Then Upload supportive document
    And Save customer profile

    Examples: 
      | SheetName   | ColumnName | RowNumber |
      | ImageViewer | AWB Number |         6 |

  @CICD
  Scenario Outline: ImageViewer_7_Verify the document is downloaded successfully, clicking download in image viewer.
    Given User clicks on "ENTRY_BUILD" competency
    #And Select Team as "ACCS Shipments"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    When Click on Assign to me
    Then Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Upload button in floating panel
    And Select location as 'SG' and type as 'AWB' and upload sample file
    And Select file to upload
    And Verify the selected "AWB" document is downloaded successfully
    And search thumbnail match with "AWB" document and delete document
    #And Click on delete icon in document section
    Then Unassign the Shipment

    Examples: 
      | SheetName   | ColumnName | RowNumber |
      | ImageViewer | AWB Number |         7 |

  @CICD
  Scenario Outline: ImageViewer_8_TCP05_Enable the refresh button otherthan CI document
    Given User clicks on "ENTRY_BUILD" competency
    #And Select Team as "ACCS Shipments"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    When Click on Assign to me
    Then Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Upload button in floating panel
    And Select location as 'SG' and type as 'AWB' and upload sample file
    And Select file to upload
    And search thumbnail match with 'AWB' document and  click on refresh button

    Examples: 
      | SheetName   | ColumnName | RowNumber |
      | ImageViewer | AWB Number |         8 |

  @CICD
  Scenario Outline: ImageViewer_9_Verify the Image Flag column is displayed in grid view of Customer Matching in Team list, Team leader list and User list
    When User clicks on "CUSTOMER_MATCHING" competency
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Verify Image Flag in the Shipments Grid
    When Click on Assign to me
    When Click on team leader list
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Verify Image Flag in the Shipments Grid
    Then Click on User List
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Verify Image Flag in the Shipments Grid

  @CICD
  Scenario Outline: ImageViewer_10_Verify the Image Flag column is displayed in grid view of Entry Build in Team list, Team leader list and User list
    Given User clicks on "ENTRY_BUILD" competency
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Verify Image Flag in the Shipments Grid
    When Click on Assign to me
    When Click on team leader list
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Verify Image Flag in the Shipments Grid
    Then Click on User List
    When Disable the columns in modal window
    Then Enable the required columns in modal window
    And Verify Image Flag in the Shipments Grid

  @CICD
  Scenario Outline: ImageViewer_11_Verify the Image Flag column is displayed in global search
    Given User clicks on "CUSTOMER_MATCHING" competency
    And Read 2 shipment AWB number "<SheetName>","<ColumnName>","<RowNumber>"
    And Click on Global search
    When Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    When Disable the columns in modal window
    And All columns in modal window are enabled
    And Verify Image Flag in the Shipments Grid

    Examples: 
      | SheetName   | ColumnName | RowNumber |
      | ImageViewer | AWB Number |         9 |

  @CICD
  Scenario Outline: ImageViewer_12_E-417213_TCP001 Display Image Viewer in Entry Build_Team List
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    And Filter using columnname "Image Flag" as "Y"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Upload button in floating panel
    And Select location as 'SG' and type as 'CI' and upload sample file
    And Select file to upload and cancel button
    Then Verify Customer Invoice Icons displayed with "<SheetName>", "<Column_Widget>" , "<RowNumber>"
    Then Click on User List

    Examples: 
      | SheetName   | ColumnName | RowNumber | Column_Widget    |
      | ImageViewer | AWB Number |        10 | Customer Invoice |

  @CICD
  Scenario Outline: ImageViewer_13_E-417213_TCP004 Display Image Viewer in Entry Build_Team Leader List
    Given User clicks on "ENTRY_BUILD" competency
    When Click on team leader list
    When Select ACCS Shipments radio button
    And Filter using columnname "Image Flag" as "Y"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Upload button in floating panel
    And Select location as 'SG' and type as 'CI' and upload sample file
    And Select file to upload and cancel button
    Then Verify Customer Invoice Icons displayed with "<SheetName>", "<Column_Widget>" , "<RowNumber>"
    Then Click on User List

    Examples: 
      | SheetName   | ColumnName | RowNumber | Column_Widget    |
      | ImageViewer | AWB Number |        11 | Customer Invoice |
      
      
      
   @CICD
  Scenario Outline: ImageViewer_14_D-3507_18625_Ability to verify the Document or Image name displayed in Global search image viewer
    Given User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    And Filter using columnname "Image Flag" as "Y"
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    Given Click on Global search
    When Search the shipment "<SheetName>","<ColumnName>","<RowNumber>" in Global Search
    And Click on Upload button in floating panel
    And Select location as 'SG' and type as 'CI' and upload sample file
    And Select file to upload
    And Verify document type name in invoice as 'CI'
    And Click on Upload button in floating panel
    And Select location as 'SG' and type as 'GST' and upload sample file
    And Select file to upload
    Then Download "GST" document from Image viewer
    And Verify document type name in invoice as 'GST'
    
     Examples: 
      | SheetName   | ColumnName | RowNumber |
      | ImageViewer | AWB Number |         12 |
