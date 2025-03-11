@Regression
Feature: Automation SG - CustomerProfile Module
  * Create a Customer profile with Consignee/Importer
  * Update and Save the Customer Profile

  Background: Flow till login page
    Given User is in Gemini application login page

  @CICD
  Scenario Outline: CustomerProfile_01_9533: Validate if create a cutomer profile is successful
    Given Navigate to "CUSTOMER_PROFILE" Page
    And Select Role as "Importer"
    And Click on Create New Importer icon
    And Click on Consignee icon
    And Enter Company Name as "<SheetName>", "<Shipper_Company>" , "<RowNumber>"
    Then Enter the IOR number and click search "<SheetName>","<IORNO>","<RowNumber>"
    And Enter contact Name as "<SheetName>", "<Shipper_Company>" , "<RowNumber>"
    And Enter Address Line1 as "<SheetName>", "<Shipper_Address>" , "<RowNumber>"
    And Enter City as "<SheetName>", "<Shipper_City>" , "<RowNumber>"
    And Enter Postal Code as "<SheetName>", "<Shipper_PostalCode>" , "<RowNumber>"
    And Select Country as "SWEDEN"
    And Select Country as "SINGAPORE"
    And Select Language Pref as "<SheetName>", "<Language_Pref>" , "<RowNumber>"
    And Click on Save button
    And Click on Add Linked Profiles icon
    And Select Linked Profile Role as "Importer"
    And Click on Add Linked Profiles Link
    Then Select Valid To Date
    Then Select Rule Condition as "Any"
    Then Select Parameter value as "Bill To D/T Account"
    Then Select Condition value as "Contains"
    Then Select or Enter value as "10"
    And Enter Search Profile Company Name as "<SheetName>", "<Recipient_Company>" , "<RowNumber>"
    And Click on Go button
    And Select First Card
    And Click on Save Profile button
    And Click on Save Customer Profile button
    #Then Verify ToasterMessage "Customer profile saved successfully"
    Given User clicks on "ENTRY_BUILD" competency
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to me
    And Click on User List
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And Enter Consignee Company Name as "<SheetName>", "<Shipper_Company>" , "<RowNumber>"

    Examples: 
      #     | SheetName       | ColumnName  			| ColumnName1 		| ColumnName2 	| ColumnName3 				| ColumnName4  		| ColumnName5   			| RowNumber |
      | SheetName       | Shipper_Company | Shipper_Address | Shipper_City | Shipper_PostalCode | Language_Pref | Recipient_Company | ColumnName | RowNumber |  | IORNO |
      | CustomerProfile | CompanyName     | AddressLine     | City         | PostalCode         | LanguagePref  | SPCompanyName     | AWB Number |         1 |  | IOR   |

  @CICD
  Scenario: CustomerProfile_02_9538: Validate Confirmation Threshold and Payment Threshold accepts Decimal Values
    Given Navigate to "CUSTOMER_PROFILE" Page
    And Enter Company Name as "VRJ"
    And Click on Search icon
    And Click on Edit icon
    Then Verify Confirmation Thershold "1.2" and Payment Threshold "2.2" field accept decimal values

  @CICD
  Scenario Outline: CustomerProfile_03_9963: Delete linked profile in Alias
    Given Navigate to "CUSTOMER_PROFILE" Page
    And Enter Company Name as "BST CONSULTANTS PTE LTD"
    And Select Role as "Consignee"
    And Select Alias as "All"
    And Click on Search icon
    And Select any row
    And Click on Edit icon
    And Validate default displayed field "Consignee"
    And Click on Alias Icon
    And Select any row
    And Delete the Alias
    Then Verify ToasterMessage "Linked Profile Deleted"
    And Click on Save Customer Profile button
    Then Verify ToasterMessage "Customer profile updated successfully"

    Examples: 
      | SheetName       | ColumnName  | RowNumber |
      | CustomerProfile | CompanyName |         2 |

  @CICD
  Scenario Outline: CustomerProfile_04_17441: CP_Search_by_Full_Company_name and CP_Search_by_IOR_only
    Given Navigate to "CUSTOMER_PROFILE" Page
    And Select Role as "Importer"
    And Enter Company Name as "INQUIRO CONSULTING PTE. LIMITED"
    And Click on Search icon
    And Enter Company Name as "INQUIRO CONSULTING PTE."
    And Click on Search icon
    And Filter using columnname "IOR#" as "2"
    And Click on Edit icon
    Given User clicks on "ENTRY_BUILD" competency
    And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Click on Assign to Me icon
    Then Click on User List icon
    And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
    And Double click on the first shipment
    And Search and Link the Importer under Customer Information using company name "INQUIRO CONSULTING PTE. LIMITED"
    And Search and Link the Importer under Customer Information using company name "INQUIRO CONSULTING PTE."
    And Search and Link the Consignee under Customer Information using company name "INQUIRO CONSULTING PTE. LIMITED"
    And Search and Link the Consignee under Customer Information using company name "INQUIRO CONSULTING PTE."

    Examples: 
      | SheetName       | ColumnName | RowNumber |
      | CustomerProfile | AWB Number |         3 |

  #@CICD
  #Scenario Outline: TCP03_CP_Search_by_Full_Company_name and CP_Search_by_IOR_only
  #Given Navigate to "CUSTOMER_PROFILE" Page
  #When Search using "<SheetName>", "<fCompanyName>" , "<RowNumber>"
  #Then Verify "Exact" match records should be displayed in the grid "<SheetName>", "<fCompanyName>" , "<RowNumber>"
  #When Search using "<SheetName>", "<pCompanyName>" , "<RowNumber>"
  #Then Verify "Partial" match records should be displayed in the grid "<SheetName>", "<pCompanyName>" , "<RowNumber>"
  #And Search using IOR "<SheetName>","<IOR>","<RowNumber>" in customer profile
  #Then Matching "IOR" value should be displayed in the grid "<SheetName>","<IOR>","<RowNumber>"
  #Given User clicks on "ENTRY_BUILD" competency
  #And Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
  #And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
  #And Click on Assign to Me icon
  #Then Click on User List icon
  #And Search the shipment "<SheetName>", "<ColumnName>", "<RowNumber>"
  #And Double click on the first shipment
  #Then Fill Importer Search icon with company name "<SheetName>","<fCompanyName>","<RowNumber>" and search
  #And Verify the company search fetch the result
  #Then Enter the IOR number and click search "<SheetName>","<IOR>","<RowNumber>"
  #And Verify the IOR search fetch the result
  #
  #
  #
  #Examples:
  #| SheetName       | ColumnName | fCompanyName | pCompanyName    | IOR | RowNumber |
  #| CustomerProfile | AWB Number | Full Company | Partial Company | IOR |         4 |
  @CICD
  Scenario Outline: CustomerProfile_05: Upload document through Customer Profile
    Given Navigate to "CUSTOMER_PROFILE" Page
    And Select Role as "Importer"
    And Click on Create New Importer icon
    And Click on Importer icon
    And Enter Company Name as "<SheetName>", "<Shipper_Company>" , "<RowNumber>"
    And Enter Address Line1 as "<SheetName>", "<Shipper_Address>" , "<RowNumber>"
    And Enter City as "<SheetName>", "<Shipper_City>" , "<RowNumber>"
    And Enter Postal Code as "<SheetName>", "<Shipper_PostalCode>" , "<RowNumber>"
    And Select Country as "SWEDEN"
    And Select Country as "SINGAPORE"
    And Select Language Pref as "<SheetName>", "Language_Pref" , "<RowNumber>"
    And Click on Save button
    And Click on Add Customer Instruction
    And Click on Instruction Type
    And Select Instruction_type as Authorization & Licence
    And Select the Licence Type as LICENCE
    And Select the Licence_Type as Direct
    And Select Valid To Date
    And Click Document Type
    And Select Document_Type as PERMIT
    And Upload document
    And Click on Save Customer Instruction button
    And Click on Save Customer Profile button
    # And Click cancel Customer Profile button
    When User clicks on "MANIFEST_CHECK" competency
    And Click on team list
    And Select Team as "ACCS Shipments"
    And Filter using columnname "Clearance Scheme" as "LV"
    And Fetch the AWBNo "<SheetName1>","<ColumnName1>","<RowNumber1>"
    And Search the shipment "<SheetName1>", "<ColumnName1>", "<RowNumber1>"
    And Click on Assign to Me icon
    And Click on User List icon
    And Search the shipment "<SheetName1>", "<ColumnName1>", "<RowNumber1>"
    And Click on Override button
    And Click on User List icon
    And User clicks on "CUSTOMER_MATCHING" competency
    And Select Team as "ACCS Shipments"
    #And Search the shipment "<SheetName>", "<ColumnName1>", "<RowNumber>"
    And Click on Assign to Me icon
    And Click on User List
    And Double click on the first shipment
    And In Quick Search user click on CLEAR
    And User enters the Company Name Postal Code and Address then click on GO
    And Verify Consignee and Importer match with CP as per the search criteria
    And User clicks on "ENTRY_BUILD" competency
    And Select Team as "ACCS Shipments"
    And Fetch the AWBNo "<SheetName3>","<ColumnName2>","<RowNumber3>"
    And Search the shipment "<SheetName3>", "<ColumnName2>", "<RowNumber3>"
    And Click on Assign to Me icon
    And Click on User List icon
    And Search the shipment "<SheetName3>", "<ColumnName2>", "<RowNumber3>"
    And Click on Upload button in floating panel
    And Select location as 'SG' and type as 'CI' and upload sample file
    And Select file to upload
    And Click on User List icon
    Then Download "CI" document from Image viewer

    # And User should be able to see the "PERMIT" document in the Image Viewer
    Examples: 
      | SheetName       | Shipper_Company | Shipper_Address | Shipper_City | Shipper_PostalCode | Language_Pref | Recipient_Company | RowNumber | SheetName1      | ColumnName1 | RowNumber1 | SheetName2      | ColumnName2 | RowNumber2 | SheetName3      | ColumnName3 | RowNumber3 |
      | CustomerProfile | CompanyName     | AddressLine     | City         | PostalCode         | LanguagePref  | SPCompanyName     |         4 | CustomerProfile | AWB Number  |          4 | CustomerProfile | AWB Number  |          4 | CustomerProfile | AWB Number  |          4 |

  @CICD
  Scenario Outline: CustomerProfile_06_18699:TCP 001_ Verify EDM Upload icon under Maintenance screen or icon
    Given User clicks on "ENTRY_BUILD" competency
    Then Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    When Navigate to "EDM_UPLOAD" Page
    And Search the shipment "<SheetName>","<ColumnName>","<RowNumber>","<DocumentType>" in Customer Profile
    And Click on Save button icon

    Examples: 
      | SheetName       | ColumnName | RowNumber | DocumentType |
      | CustomerProfile | AWB Number |         5 | DocumentType |

  @CICD
  Scenario Outline: CustomerProfile_07_18702:TCP 004_Verify Upload and Reset buttons
    Given User clicks on "ENTRY_BUILD" competency
    Then Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    When Navigate to "EDM_UPLOAD" Page
    And Search the shipment "<SheetName>","<ColumnName>","<RowNumber>","<DocumentType>" in Customer Profile
    And Click on Reset button Icon

    Examples: 
      | SheetName       | ColumnName | RowNumber | DocumentType |
      | CustomerProfile | AWB Number |         6 | DocumentType |

  @CICD
  Scenario Outline: CustomerProfile_08_18702:TCN 005 & TCN 006 & TCN 007_Upload files which are more than 2 MB and which are not TIFF or PDF formats
    Given User clicks on "ENTRY_BUILD" competency
    Then Fetch the AWBNo "<SheetName>","<ColumnName>","<RowNumber>"
    When Navigate to "EDM_UPLOAD" Page
    And Select the shipment with AWB "<SheetName>","<ColumnName>","<RowNumber>"
    And Select document type as "CI"
    And Upload Document more than 2MB and not TIFF or PDF formats
    And Search the shipment with "<SheetName>","<ColumnNameAWB>","<RowNumber>" in AWB

    Examples: 
      | SheetName       | ColumnName | RowNumber | ColumnNameAWB |
      | CustomerProfile | AWB Number |         7 | AWB_digits    |
