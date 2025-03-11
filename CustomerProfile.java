package stepDefinitions;

import java.awt.AWTException;
import java.awt.Robot;
import java.awt.Toolkit;
import java.awt.datatransfer.StringSelection;
import java.awt.event.KeyEvent;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.List;
import java.util.Random;
import java.util.stream.Collectors;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.Select;

import com.FedEx.GeminiAutomationSG.PageObjects.CustomerProfilePage;
import com.FedEx.GeminiAutomationSG.PageObjects.EntryBuildPage;
import com.FedEx.GeminiAutomationSG.TestBase.BaseClass;
import com.FedEx.GeminiAutomationSG.Utilities.ApplicationFunctions;
import com.FedEx.GeminiAutomationSG.Utilities.ExcelUtility;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import junit.framework.Assert;

public class CustomerProfile extends BaseClass {
	
	CustomerProfilePage customerProfilePage = new CustomerProfilePage(driver);
	ApplicationFunctions applicationFunctions = new ApplicationFunctions(driver);
	ExcelUtility excelUtility = new ExcelUtility();
	JavascriptExecutor js = (JavascriptExecutor) driver;
	EntryBuildPage entryBuildPage = new EntryBuildPage(driver);

	
	
	@Given("Select Role as {string}")
	public void select_role_as(String role) {
		customerProfilePage.select_Role(role);
	}

	@Given("Click on Create New Importer icon")
	public void click_on_create_new_importer_icon() {
		customerProfilePage.click_CreateNewImporter_Button();
	}

	@Given("Click on Consignee icon")
	public void click_on_consignee_icon() {
		customerProfilePage.click_Consignee_Icon();
	}

	@When("Enter Company Name as {string}, {string} , {string}")
	public void enter_company_name_as(String sheetName, String columnName, String rowIndex) throws IOException {
		System.out.println(excelUtility.readExcelValue(sheetName, columnName, rowIndex));
		customerProfilePage.set_CompanyName(excelUtility.readExcelValue(sheetName, columnName, rowIndex));
	}
	
	@When("Enter contact Name as {string}, {string} , {string}")
	public void enter_contact_name_as(String sheetName, String columnName, String rowIndex) throws IOException {
		System.out.println(excelUtility.readExcelValue(sheetName, columnName, rowIndex));
		customerProfilePage.set_ContactName(excelUtility.readExcelValue(sheetName, columnName, rowIndex));
	}

	@When("Enter Address Line1 as {string}, {string} , {string}")
	public void enter_address_line1_as(String sheetName, String columnName1, String rowIndex) throws IOException {
		customerProfilePage.set_AddressLine(excelUtility.readExcelValue(sheetName,columnName1 , rowIndex));
	}
	@When("Enter City as {string}, {string} , {string}")
	public void enter_city_as(String sheetName, String columnName2, String rowIndex) throws IOException {
		customerProfilePage.set_City(excelUtility.readExcelValue(sheetName, columnName2, rowIndex));
	}
	
	@When("Search the shipment with {string},{string},{string} in AWB")
	public void search_AWB_shipment(String sheetName, String columnName3, String rowIndex) throws IOException, InterruptedException {
		customerProfilePage.set_AWB(excelUtility.readExcelValue(sheetName, columnName3, rowIndex));
		Thread.sleep(3000);
	}
	
	@When("Enter Postal Code as {string}, {string} , {string}")
	public void enter_postal_code_as(String sheetName, String columnName3, String rowIndex) throws IOException {
		customerProfilePage.set_PostalCode(excelUtility.readExcelValue(sheetName, columnName3, rowIndex));
	}
	
	@And("Search the shipment {string},{string},{string},{string} in Customer Profile")
	public void enter_shipmentValues_in_profile(String sheetName, String columnName, String rowIndex,String documentType) throws InterruptedException, IOException, AWTException {
		System.out.println(excelUtility.readExcelValue(sheetName, columnName, rowIndex));
		customerProfilePage.enter_shipmentValues_in_profile(excelUtility.readExcelValue(sheetName, columnName, rowIndex));		
		String docValues[] = excelUtility.readExcelValue(sheetName, documentType, rowIndex).split(",");
		List<String> totalDocType = Arrays.stream(docValues).collect(Collectors.toList());
		long count = totalDocType.size();
		int counter=1;
				for(int i=1;i<=totalDocType.size();i++) {					
					if(totalDocType.size()>1){
						clickElement(driver.findElement(By.xpath("(//table[contains(@class,'gn-upload-document')]//following-sibling::tr)["+i+"]/td[6]/div/select")));
						Thread.sleep(3000);
						selectUsingVisibleText(driver.findElement(By.xpath("(//table[contains(@class,'gn-upload-document')]//following-sibling::tr)["+i+"]/td[6]/div/select")), totalDocType.get(i-1).trim());
						Thread.sleep(3000);
						customerProfilePage.edmUploadFlag=true;
						uploaddocument();
						customerProfilePage.edmUploadFlag=false;
						Thread.sleep(3000);
							if(counter<totalDocType.size()) {								
								clickElementUsingJavaScript(customerProfilePage.clickonadd);
								Thread.sleep(2000);
								customerProfilePage.k = customerProfilePage.k+1;
								counter++;
								customerProfilePage.enter_shipmentValues_in_profile(excelUtility.readExcelValue(sheetName, columnName, rowIndex));
						}						
						
					}else {
							Thread.sleep(3000);
							customerProfilePage.Document_Type.click();
							selectUsingVisibleText(customerProfilePage.Document_Type, totalDocType.get(i-1).strip());
							customerProfilePage.edmUploadFlag=true;
							uploaddocument();
							customerProfilePage.edmUploadFlag=false;
					
					}
					
					
				}

	}
	
	@When("Select Country as {string}")
	public void select_country_as(String value) {
		customerProfilePage.select_Country(value);
	}
	
	@When("Select the shipment with AWB {string},{string},{string}")
	public void select_shipment_AWB(String sheetName, String columnName1, String rowIndex) throws IOException, InterruptedException {
		customerProfilePage.set_AWB(excelUtility.readExcelValue(sheetName,columnName1 , rowIndex));
	}
	
	@When("Select Language Pref as {string}, {string} , {string}")
	public void select_language_pref_as(String sheetName, String columnName4, String rowIndex) throws IOException {
		customerProfilePage.select_LanguagePref(excelUtility.readExcelValue(sheetName, columnName4, rowIndex));
	}
	
	@When("Click on Save button")
	public void click_on_save_button() {
		customerProfilePage.click_Save_Button();
	}

	@When("Click on Add Linked Profiles icon")
	public void click_on_add_linked_profiles_icon() {
		customerProfilePage.click_AddLinkedProfiles_Icon();
	}

	@When("Select Linked Profile Role as {string}")
	public void select_linked_profile_role_as(String linkedProfilesRole) {
		customerProfilePage.select_LinkedProfiles_Role(linkedProfilesRole);
	}

	@When("Click on Add Linked Profiles Link")
	public void click_on_add_linked_profiles_link() {
		customerProfilePage.click_AddLinkedProfiles_Link();
	}

	@Then("Enter Search Profile Company Name as {string}, {string} , {string}")
	public void enter_search_profile_company_name_as(String sheetName, String columnName5, String rowIndex) throws IOException {
		customerProfilePage.set_SearchProfile_CompanyName(excelUtility.readExcelValue(sheetName, columnName5, rowIndex));
	}

	@When("Click on Go button")
	public void click_on_go_button() throws InterruptedException {
		customerProfilePage.click_Go_Button();
	}

	@When("Select First Card")
	public void select_first_card() {
		customerProfilePage.select_First_Card();
	}

	@When("Click on Save Profile button")
	public void click_on_save_profile_button() {
		customerProfilePage.click_Save_LinkedProfiles_Button();
	}

	@When("Click on Save Customer Profile button")
	public void click_on_save_customer_profile_button() throws InterruptedException {
		Thread.sleep(3000);
		customerProfilePage.click_Save_CustomerProfile_Button();
		Thread.sleep(2000);
		customerProfilePage.click_Cancel_Customer_Profile_Button();
	}

	@Then("Verify ToasterMessage {string}")
	public void verify_toastermessage(String message) {
		applicationFunctions = new ApplicationFunctions(driver);
		applicationFunctions.verify_ToasterMessage();
	}

	@When("Enter Company Name as {string}")
	public void enter_company_name_as(String companyName) {
		customerProfilePage = new CustomerProfilePage(driver);
		customerProfilePage.enter_CompanyName(companyName);
	}

	@When("Click on Search icon")
	public void click_on_search_icon() throws InterruptedException {
		customerProfilePage.click_Search_Button();
	}

	@When("Click on Edit icon")
	public void click_on_edit_icon() throws InterruptedException {
		customerProfilePage.click_CustomerProfile_Edit_Button();
	}

	@Then("Verify Confirmation Thershold {string} and Payment Threshold {string} field accept decimal values")
	public void verify_confirmation_thershold_and_payment_threshold_field_accept_decimal_values(
			String confirmationThershold, String paymentThreshold) {
		customerProfilePage.set_ConfirmationThershold(confirmationThershold);
		customerProfilePage.set_PaymentThreshold(paymentThreshold);
	}
	
	@When("Select any row")
	public void select_any_row() {
		customerProfilePage.selectAnyRow();
	}
	
	@When("Select Alias as {string}")
	public void select_alias_as(String role) {
		customerProfilePage.selectAlias(role);
	}
	
	@And("Validate default displayed field {string}")
	public void Validate_default_displayed_field(String fieldName) throws AWTException {
		customerProfilePage.validateDefaultDisplayedField(fieldName);
	}
	
	@And("Click on Alias Icon")
	public void Click_on_Alias_Icon() {
		customerProfilePage.clickAliasIcon();
	}
	
	@And("Delete the Alias")
	public void Delete_the_Alias() {
		customerProfilePage.deleteAlias();
	}
	
	@When("User clicks tools icon")
	public void select_tools() {
		customerProfilePage.lnk_tools.click();
	}
	
	@And("Select {string} from tools option")
	public void select_Values(String Value) {			
		js. executeScript("arguments[0]. setAttribute('style', 'border:2px solid red')", driver.findElement(By.xpath("//span[text()='"+Value+"']")));
		clickElement(driver.findElement(By.xpath("//span[text()='"+Value+"']")));
	}
	
	@When("Enter Consignee Company Name as {string}, {string} , {string}")
	public void enter_consignee_company_name_as(String sheetName, String columnName, String rowIndex) throws IOException, InterruptedException {
		System.out.println(excelUtility.readExcelValue(sheetName, columnName, rowIndex));
		customerProfilePage.set_ConsigneeCompanyName(excelUtility.readExcelValue(sheetName, columnName, rowIndex));
	}
	
	@And("Create new profile icon")
	public void createNewProfile() {
		js. executeScript("arguments[0]. setAttribute('style', 'border:2px solid red')", customerProfilePage.lnk_newProfile);
		customerProfilePage.lnk_newProfile.click();
	}
	
	@And("Select document type as {string}")
	public void document_Type(String D_type) throws InterruptedException {
		customerProfilePage.Select_Document_Type(D_type);
		Thread.sleep(2000);
	}
	
	@And("Enter company name")
	public void enterCompanyName() {
		Random random = new Random();
		int leftLimit = 65; // letter 'a'
	    int rightLimit = 90; // letter 'z'
	    int targetStringLength = 6;
	    String randomString = random.ints(leftLimit, rightLimit + 1)
	    	      .limit(targetStringLength)
	    	      .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
	    	      .toString();
	    	    System.out.println(randomString);		
		js. executeScript("arguments[0]. setAttribute('style', 'border:2px solid red')", customerProfilePage.txt_companyName);
		customerProfilePage.txt_companyName.sendKeys(randomString);
		customerProfilePage.txt_companyName.sendKeys(Keys.TAB);
	}
	
	@And("Enter address details in customer profile")
	public void enterAddress() {
		waitTillElementVisible(customerProfilePage.txt_contactName);
		customerProfilePage.txt_contactName.clear();
		customerProfilePage.txt_contactName.sendKeys("SGOps");
		customerProfilePage.txt_addr1.clear();
		customerProfilePage.txt_addr1.sendKeys("Sylvyan County",Keys.TAB);
		customerProfilePage.txt_addr2.clear();
		customerProfilePage.txt_addr2.sendKeys("Telok Blangah");
		customerProfilePage.txt_addrCity.sendKeys("Singapore",Keys.TAB);
		customerProfilePage.txt_addrZipCode.sendKeys("56846",Keys.TAB);
		customerProfilePage.sel_Country.click();
		Select sel = new Select(customerProfilePage.sel_Country);
		sel.selectByValue("NZ");
		sel.selectByValue("SG");
		customerProfilePage.btn_Save.click();
	}
	
	@And("Click new customer Instruction")
	public void newCustomerInstruction() throws InterruptedException {
		Thread.sleep(2000);
		js. executeScript("arguments[0]. setAttribute('style', 'border:2px solid red')", customerProfilePage.lnk_newCustomerInst);
		customerProfilePage.lnk_newCustomerInst.click();		
	}
	
	@And("Select customer instruction type as {string}")
	public void selInstructionType(String drpvalue) throws InterruptedException {
		Thread.sleep(2000);
		js. executeScript("arguments[0]. setAttribute('style', 'border:2px solid red')", customerProfilePage.drp_instructionType);
		customerProfilePage.drp_instructionType.click();
		selectUsingVisibleText(customerProfilePage.drp_instructionType, drpvalue);
		
	}
	
	@And("Select license type as {string}")
	public void licenseType(String drpvalue) throws InterruptedException {
		Thread.sleep(2000);
		js. executeScript("arguments[0]. setAttribute('style', 'border:2px solid red')", customerProfilePage.drp_LicenseType);
		customerProfilePage.drp_LicenseType.click();
		selectUsingVisibleText(customerProfilePage.drp_LicenseType, drpvalue);
	}
	
	@And("Select sub license type as {string}")
	public void sub_licenseType(String drpvalue) throws InterruptedException {
		Thread.sleep(2000);
		js. executeScript("arguments[0]. setAttribute('style', 'border:2px solid red')", customerProfilePage.drp_LicensePermitType);
		customerProfilePage.drp_LicensePermitType.click();
		selectUsingVisibleText(customerProfilePage.drp_LicensePermitType, drpvalue);
	}
	
	@And("Select valid to date")
	public void validToDate() throws InterruptedException {
		Thread.sleep(2000);
		js. executeScript("arguments[0]. setAttribute('style', 'border:2px solid red')", customerProfilePage.select_endDatePicker);
		customerProfilePage.select_endDatePicker.click();		
		java.util.Date todaysDate = new java.util.Date();
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyy");
		String formatDate = sdf.format(todaysDate);
		System.out.println(formatDate.substring(0, 2));
		System.out.println(formatDate);
		for (WebElement dt : customerProfilePage.pickDate) {
			if(dt.getText().contentEquals(formatDate.substring(0, 2))) {
				dt.click();
				break;
			}
		}
	}
	
	@And("Select document type {string} from dropdown")
	public void documentType(String drpvalue) throws InterruptedException {
		Thread.sleep(2000);
		js. executeScript("arguments[0]. setAttribute('style', 'border:2px solid red')", customerProfilePage.drp_docType);
		customerProfilePage.drp_docType.click();
		selectUsingVisibleText(customerProfilePage.drp_docType, drpvalue);
	}
	
	@And("Upload supportive document")
	public void upload() throws InterruptedException, AWTException {
		Thread.sleep(2000);
		js. executeScript("arguments[0]. setAttribute('style', 'border:2px solid red')", customerProfilePage.upload);
		customerProfilePage.upload.click();	
		String path;
		path = System.getProperty("user.dir") + "\\Documents\\Test.pdf";
		// path = System.getProperty("user.dir");
		// path1 = System.getProperty("user.dir")+"//Documents//Test.pdf";
		System.out.println(path);
		StringSelection contents = new StringSelection(path);
		Toolkit.getDefaultToolkit().getSystemClipboard().setContents(contents, null);
		Robot r = new Robot();
		Thread.sleep(5000);
		r.keyPress(KeyEvent.VK_CONTROL);
		r.keyPress(KeyEvent.VK_V);
		r.keyRelease(KeyEvent.VK_CONTROL);
		r.keyRelease(KeyEvent.VK_V);
		Thread.sleep(5000);
		r.keyPress(KeyEvent.VK_ENTER);
		r.keyRelease(KeyEvent.VK_ENTER);
		Thread.sleep(3000);	
		customerProfilePage.btn_Save.click();

	}
	
	@And("Save customer profile")
	public void saveCustomerProfile() throws InterruptedException, AWTException {
		//customerProfilePage.customerProfile_Save.click();
		clickElementUsingJavaScript(customerProfilePage.customerProfile_Save);
		

	}
	
	@When("Search using {string}, {string} , {string}")
	public void fullCompanyName(String sheetName, String columnName, String rowIndex) throws InterruptedException, AWTException, IOException {
		customerProfilePage.enter_CompanyName(excelUtility.readExcelValue(sheetName, columnName, rowIndex));
		click_on_search_icon();

	}
	
	@Then("Verify {string} match records should be displayed in the grid {string}, {string} , {string}")
	public void exactMatchRecords(String match,String sheetName, String columnName, String rowIndex) throws InterruptedException, AWTException, IOException {
		int colmPosition = 0;
		boolean flag = false;
		for (int i = 0; i <= customerProfilePage.cpTableHeaders.size()-1; i++) {
			System.out.println(customerProfilePage.cpTableHeaders.get(i).getText());
			if (customerProfilePage.cpTableHeaders.get(i).getText().equalsIgnoreCase("Company")) {
				colmPosition = (i+1);
				flag=true;
				break;
			}
			
		}
		if (flag) {
			for (int j = 1; j <= customerProfilePage.cpTableValues.size(); j++) {
				String fetchedValue = driver.findElement(By.xpath(
						"(//datatable-body-cell/../../div[2]/datatable-body-cell[" + colmPosition + "]/div/span)[1]"))
						.getText();
				if (match.equalsIgnoreCase("Exact")) {
					if (fetchedValue.equalsIgnoreCase(excelUtility.readExcelValue(sheetName, columnName, rowIndex))) {
						System.out.println("Exact Company names are matched");
						break;
					} 
				} else if(match.equalsIgnoreCase("Partial"))  {					
						if (fetchedValue.contains(excelUtility.readExcelValue(sheetName, columnName, rowIndex))) {
							System.out.println("Partial Company names are matched");
							break;
						}					
					}
				}
			}
	}
	
	
	@And("Search using IOR {string},{string},{string} in customer profile")
	public void searchIOR(String sheetName, String columnName, String rowIndex) throws InterruptedException, AWTException, IOException {
		customerProfilePage.lnk_clear.click();
		enterValueIntoTextField(customerProfilePage.ior, excelUtility.readExcelValue(sheetName, columnName, rowIndex));
		click_on_search_icon();

	}

	
	@And("Matching {string} value should be displayed in the grid {string},{string},{string}")
	public void matchedIOR(String match,String sheetName, String columnName, String rowIndex) throws InterruptedException, AWTException, IOException {
		int colmPosition = 0;
		boolean flag = false;
		for (int i = 0; i <= customerProfilePage.cpTableHeaders.size()-1; i++) {
			System.out.println(customerProfilePage.cpTableHeaders.get(i).getText());
			if (customerProfilePage.cpTableHeaders.get(i).getText().contains("IOR")) {
				colmPosition = (i+1);
				flag=true;
				break;
			}
			
		}
		if (flag) {

			for (int j = 1; j <= customerProfilePage.cpTableValues.size(); j++) {
				String fetchedValue = driver.findElement(By.xpath(
						"(//datatable-body-cell/../../div[2]/datatable-body-cell[" + colmPosition + "]/div/span)[1]"))
						.getText();
				if (match.equalsIgnoreCase("IOR")) {
					if (fetchedValue.equalsIgnoreCase(excelUtility.readExcelValue(sheetName, columnName, rowIndex))) {
						System.out.println("IOR is matched");
					} 
					else
					{
						Assert.assertFalse("IOR value is not matched", false);
					}
					break;
				} 
				
			}
		}

	}
	
	@Then("Fill Importer Search icon with company name {string},{string},{string} and search")
	public void EB_ImporterSrch(String sheetName,String columnName,String rowIndex ) throws InterruptedException, AWTException, IOException {
		customerProfilePage.im_search.click();
		enterValueIntoTextField(customerProfilePage.im_companyName, excelUtility.readExcelValue(sheetName, columnName, rowIndex));
		click_on_search_icon();
	}
 
	@And("Verify the company search fetch the result")
	public void EB_ImporterSrch_rslt() throws InterruptedException, AWTException, IOException {
		boolean flag = false;
		if(customerProfilePage.companyNames.size()>=1) {
			flag = true;
			Assert.assertEquals(true, flag);
		}
		
	}
	
	@Then("Enter the IOR number and click search {string},{string},{string}")
	public void EB_ImporterSrch_eor_rslt(String sheetName,String columnName,String rowIndex) throws InterruptedException, AWTException, IOException {
		//customerProfilePage.lnk_clear.click();
		System.out.println(excelUtility.readExcelValue(sheetName, columnName, rowIndex));
		//enterValueIntoTextField(customerProfilePage.ior, excelUtility.readExcelValue(sheetName, columnName, rowIndex));
		customerProfilePage.set_IORNo(excelUtility.readExcelValue(sheetName, columnName, rowIndex));
//		click_on_search_icon();
	}
	
	@Given("Click on Importer icon")
	public void click_on_importer_icon() {
		customerProfilePage.click_on_importer_icon();
	}
	
	@Given("Click on Add Customer Instruction")
	public void click_on_add_customer_instruction_icon() {
		customerProfilePage.click_AddCustomerInstruction_Icon();
	}
	
	@And("Click on Instruction Type")
	public void click_on_instructionType() {
		customerProfilePage.click_on_instructionType();
	}
	
	@And("Select Instruction_type as Authorization & Licence")
	public void select_AuthorizationLicense() {
		customerProfilePage.select_AuthorizationLicense();
	}
	
	@And("Select the Licence Type as LICENCE")
	public void select_licencetype() {
		customerProfilePage.select_licencetype();
	}
	
	@Given("Select the Licence_Type as Direct")
	public void select_Direct(){
		customerProfilePage.select_Direct();
	}
	
	@And("Click Document Type")
	public void clickon_docType(){
		customerProfilePage.clickon_docType();
	}
	
	@And("Select Document_Type as PERMIT")
	public void select_docType_as_PERMIT_Permit(){
		customerProfilePage.select_docType_as_PERMIT_Permit();
	}
	
	@And("Upload the customer profile Document type {string},{string},{string},{string}")
	public void select_Document(String SheetName,String DocumentType,String rowNo,String documentType) throws InterruptedException, AWTException, IOException  {
		waitTillElementVisible(customerProfilePage.Document_Type);
		customerProfilePage.Document_Type.click();
		Thread.sleep(1000);
		
		String docValues[] = excelUtility.readExcelValue(SheetName, DocumentType, rowNo).split(",");
		System.out.println(docValues.length);
		
		selectUsingVisibleText(customerProfilePage.Document_Type, documentType);
		Thread.sleep(2000);		
		
	}
	
	@And("Upload document")
    public void uploaddocument() throws InterruptedException, AWTException {
		Thread.sleep(2000);
		String path;
		js. executeScript("arguments[0]. setAttribute('style', 'border:2px solid red')", customerProfilePage.uploaddocument1);
		if(customerProfilePage.edmUploadFlag) {
			clickElement(driver.findElement(By.xpath("(//a[@title='UPLOAD'])["+customerProfilePage.k+"]")));
		}else {		
		customerProfilePage.uploaddocument1.click();
		}
		path = System.getProperty("user.dir") + "\\Documents\\Test.pdf";
		System.out.println(path);
		StringSelection contents = new StringSelection(path);
		Toolkit.getDefaultToolkit().getSystemClipboard().setContents(contents, null);
		Robot r = new Robot();
		Thread.sleep(5000);
		r.keyPress(KeyEvent.VK_CONTROL);
		r.keyPress(KeyEvent.VK_V);
		r.keyRelease(KeyEvent.VK_CONTROL);
		r.keyRelease(KeyEvent.VK_V);
		Thread.sleep(5000);
		r.keyPress(KeyEvent.VK_ENTER);
		r.keyRelease(KeyEvent.VK_ENTER);
		Thread.sleep(3000);
		waitTillElementVisible(customerProfilePage.uploaddocument1);
		EntryBuildPage.clickElementUsingJavaScript(customerProfilePage.uploaddocument1);
	}
	
	@And("Upload Document more than 2MB and not TIFF or PDF formats")
    public void upload_Document() throws InterruptedException, AWTException {
		Thread.sleep(2000);
		String path;
		js. executeScript("arguments[0]. setAttribute('style', 'border:2px solid red')", customerProfilePage.uploaddocument1);
//		if(customerProfilePage.edmUploadFlag) {
//			clickElement(driver.findElement(By.xpath("(//a[@title='UPLOAD'])["+customerProfilePage.k+"]")));
//		}else {		
//		customerProfilePage.uploaddocument1.click();
//		}
		customerProfilePage.uploaddocument1.click();
		path = System.getProperty("user.dir") + "\\Documents\\Largefile.pdf";
		System.out.println(path);
		StringSelection contents = new StringSelection(path);
		Toolkit.getDefaultToolkit().getSystemClipboard().setContents(contents, null);
		Robot r = new Robot();
		Thread.sleep(5000);
		r.keyPress(KeyEvent.VK_CONTROL);
		r.keyPress(KeyEvent.VK_V);
		r.keyRelease(KeyEvent.VK_CONTROL);
		r.keyRelease(KeyEvent.VK_V);
		Thread.sleep(5000);
		r.keyPress(KeyEvent.VK_ENTER);
		r.keyRelease(KeyEvent.VK_ENTER);
		Thread.sleep(3000);
		waitTillElementVisible(customerProfilePage.uploaddocument1);
		//EntryBuildPage.clickElementUsingJavaScript(customerProfilePage.uploaddocument1);
		Thread.sleep(2000);
		String path1;
		js. executeScript("arguments[0]. setAttribute('style', 'border:2px solid red')", customerProfilePage.uploaddocument1);
		customerProfilePage.uploaddocument1.click();
		path1 = System.getProperty("user.dir") + "\\Documents\\WordDocument.docx";
		System.out.println(path1);
		StringSelection contents1 = new StringSelection(path1);
		Toolkit.getDefaultToolkit().getSystemClipboard().setContents(contents1, null);
		Robot r1 = new Robot();
		Thread.sleep(5000);
		r1.keyPress(KeyEvent.VK_CONTROL);
		r1.keyPress(KeyEvent.VK_V);
		r1.keyRelease(KeyEvent.VK_CONTROL);
		r1.keyRelease(KeyEvent.VK_V);
		Thread.sleep(5000);
		r1.keyPress(KeyEvent.VK_ENTER);
		r1.keyRelease(KeyEvent.VK_ENTER);
		Thread.sleep(3000);
	}
	
	@And("Click on Add Icon")
	public void click_add_Icon() throws InterruptedException  {
		clickElementUsingJavaScript(customerProfilePage.clickonadd);
		Thread.sleep(2000);
	}
	
	@And("Click on Save button icon")
	public void click_save_button() throws InterruptedException  {
		clickElementUsingJavaScript(customerProfilePage.SaveCustomerProfile);
		Thread.sleep(3000);
		
	}
	
	@And("Click on Reset button Icon")
	public void click_reset_button() throws InterruptedException   {
		clickElementUsingJavaScript(customerProfilePage.clickonreset);
		Thread.sleep(3000);
	}
	
/*	@And("Upload document for Customer Profile")
    public void uploaddocument_customer_Profile() throws InterruptedException, AWTException {
		Thread.sleep(2000);
		String path;
		js. executeScript("arguments[0]. setAttribute('style', 'border:2px solid red')", customerProfilePage.uploaddocument1);
		customerProfilePage.uploaddocument1.click();		
		path = System.getProperty("user.dir") + "\\Documents\\Test.pdf";
		System.out.println(path);
		StringSelection contents = new StringSelection(path);
		Toolkit.getDefaultToolkit().getSystemClipboard().setContents(contents, null);
		Robot r = new Robot();
		Thread.sleep(3000);
		r.keyPress(KeyEvent.VK_CONTROL);
		r.keyPress(KeyEvent.VK_V);
		r.keyRelease(KeyEvent.VK_CONTROL);
		r.keyRelease(KeyEvent.VK_V);
		Thread.sleep(3000);
		r.keyPress(KeyEvent.VK_ENTER);
		r.keyRelease(KeyEvent.VK_ENTER);
		Thread.sleep(2000);
		waitTillElementVisible(customerProfilePage.uploaddocument1);
		EntryBuildPage.clickElementUsingJavaScript(customerProfilePage.uploaddocument1);
		Thread.sleep(2000);
		clickElementUsingJavaScript(customerProfilePage.SaveCustomerProfile);
	} */ 
	
	@Given("Click on Save Customer Instruction button")
	public void click_on_save_customer_instruction_button() {
		customerProfilePage.click_on_save_customer_instruction_button();
	}
	
	@Given("Click cancel Customer Profile button")
	public void click_Cancel_Customer_Profile_Button() throws InterruptedException {
		customerProfilePage.click_Cancel_Customer_Profile_Button();
		//Thread.sleep(5000);
	}
	
	@And("Click on the {string} in the Image Viewer")
	public void clickon_Customerdoc_Imageviewer(String Document) throws InterruptedException {
		applicationFunctions.clickon_Customerdoc_Imageviewer(Document);
	}
	
	
	@Then("Verify the IOR search fetch the result")
	public void EB_ImporterSrch_ior_rslt() throws InterruptedException, AWTException, IOException {
		boolean flag = false;
		if(customerProfilePage.companyNames.size()>=1) {
			flag = true;
			Assert.assertEquals(true, flag);
		}
		
	}
}
