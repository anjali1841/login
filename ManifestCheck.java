package stepDefinitions;

import java.awt.AWTException;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.EncryptedDocumentException;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.openqa.selenium.By;
import org.openqa.selenium.ElementClickInterceptedException;
import org.openqa.selenium.ElementNotInteractableException;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;
import org.testng.Assert;

import com.FedEx.GeminiAutomationSG.PageObjects.ConveyancePage;
import com.FedEx.GeminiAutomationSG.PageObjects.EntryBuildPage;
import com.FedEx.GeminiAutomationSG.PageObjects.GlobalSearchPage;
import com.FedEx.GeminiAutomationSG.PageObjects.ManifestCheckPage;
import com.FedEx.GeminiAutomationSG.TestBase.BaseClass;
import com.FedEx.GeminiAutomationSG.Utilities.ApplicationFunctions;
import com.FedEx.GeminiAutomationSG.Utilities.ExcelUtility;
import com.FedEx.GeminiAutomationSG.Utilities.ScenarioContext;
import com.FedEx.GeminiAutomationSG.Utilities.ScenarioContext.Context;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

public class ManifestCheck extends BaseClass {
	
	ManifestCheckPage manifestCheckPage = new ManifestCheckPage(driver);
	ApplicationFunctions applicationFunctions = new ApplicationFunctions(driver);
	EntryBuildPage entryBuildPage = new EntryBuildPage(driver);
	GlobalSearchPage globalSearchPage = new GlobalSearchPage(driver);
	ConveyancePage cnvc = new ConveyancePage(driver);
	ExcelUtility excelUtility = new ExcelUtility();	
	String awbNumber;
	String selectionCode;
	static List<String> aList,aaList;
	String globalSearch,fetchedCol;
	String exeFile = System.getProperty("user.dir") + "\\Documents\\FileUpload.exe";
	String filePath = System.getProperty("user.dir") + "\\Documents\\Test.pdf";
	JavascriptExecutor js = (JavascriptExecutor)driver;
	
	@Given("User clicks on {string} competency")
	public void user_clicks_on_competency(String competency) {
		applicationFunctions.select_Competency(competency);
	}
	
	

	@And("click Search icon")
	public void clickSearch() {
		try {
			waitTillElementVisible(cnvc.conveyance_search);
			cnvc.conveyance_search.click();
		} catch (Exception e) {
			System.out.println("Conveyance Search Icon is not clicked");
			e.printStackTrace();
		}
	}
	
	@When("Select more than one teams as {string}")
	public void select_teams_as(String team) throws InterruptedException {
		applicationFunctions.select_Team(team);
		//applicationFunctions.Sel_Team(team);
	}

	@When("Select Team as {string}")
	public void select_team_as(String team) throws InterruptedException {
		//applicationFunctions.select_Team(team);
		applicationFunctions.Sel_Team(team);
	}
	
	@When("Disable Team {string}")
	public void disable_team_as(String team) throws InterruptedException {
		applicationFunctions.disable_Team(team);
	}
	
	/*@And("Filter using Clearance Status as {string}")
	public void filter_using_clearance_status_as(String clearanceStatus) throws InterruptedException {
		applicationFunctions.click_Filter_Icon("Clearance Status");
		applicationFunctions.set_Filter_Value(clearanceStatus);
		applicationFunctions.close_Filter();
		
	}

	@Given("Filter using Clearance Scheme as {string}")
	public void filter_using_clearance_scheme_as(String clearanceScheme) throws InterruptedException {
		applicationFunctions.click_Filter_Icon("Clearance Scheme");
		applicationFunctions.set_Filter_Value(clearanceScheme);
		applicationFunctions.close_Filter();		
	}*/
	
	@And("Filter using route as {string}")
	public void filter_using_route_as(String route) throws InterruptedException {
		applicationFunctions.click_Filter_Icon("Route");
		if(!route.equalsIgnoreCase("ks666")) {
			applicationFunctions.set_Filter_Value(route);
		}
		else
		{
			applicationFunctions.set_Filter_Value(route);
		}
		applicationFunctions.close_Filter();
	}


	/*@And("Filter using CI Flag as {string}")
	public void filter_using_ci_flag_as(String value) throws InterruptedException {
		applicationFunctions.click_Filter_Icon("CI Flag");
		applicationFunctions.set_Filter_DropdownValue(value);
		applicationFunctions.close_Filter();
	}*/
	
	/*@And("Filter using Importer Company as {string}")
	public void filter_using_Importer_company_as(String value) throws InterruptedException {
		applicationFunctions.click_Filter_Icon("Importer Company");
		selectUsingVisibleText(applicationFunctions.clickdrop,value);		
		applicationFunctions.close_Filter();
		
	}*/
	
	@And("Filter using {string} as {string}")
	public void filter_using_Importer_company_as(String value1,String value2) throws InterruptedException {
		js.executeScript("document.querySelector(\"datatable-body\").scrollLeft=-1000");
		int ScrollValue=500;
		int i=1,k=0;
		boolean flag=false;
		for (i = 1; i <= entryBuildPage.tblHeaderlabels.size(); i++) {
			if(driver.findElement(By.xpath("((//datatable-header-cell/div/div)/table)["+ i +"]/tr/th[1]/span")).getText().equalsIgnoreCase(value1)){
			try {		
				applicationFunctions.click_Filter_Icon(value1);
			} catch (ElementNotInteractableException | TimeoutException e) {
				js.executeScript("document.querySelector(\"datatable-body\").scrollLeft=1000");
				applicationFunctions.click_Filter_Icon(value1);	
			}
			selectUsingVisibleText(applicationFunctions.clickdrop,value2);
			flag=true;
			if(value1.equalsIgnoreCase("Consignee Company")&& !(value2.equalsIgnoreCase("Blank Cells"))) {			
				enterValueIntoTextField(manifestCheckPage.filterValue, "a");
				flag=true;
				}
			}
			if(flag) {break;}
			if(i%5==0) {
				k+= 1;
				js.executeScript("document.querySelector(\"datatable-body\").scrollLeft="+(ScrollValue*k));
				Thread.sleep(2000);
			
			}

		}
		waitTillElementVisible(applicationFunctions.closeFilter_Btn);
		applicationFunctions.close_Filter();
	}
			
		
	
	
	/*@And("Filter using Consignee Company  as {string}")
	public void filter_using_consignee_company_as(String value) throws InterruptedException {
		applicationFunctions.click_Filter_Icon("Consignee Company");
		selectUsingVisibleText(applicationFunctions.clickdrop,value);
		if(value.equalsIgnoreCase("Contains")) {
			enterValueIntoTextField(manifestCheckPage.filterValue, "a");
			}
		waitTillElementVisible(applicationFunctions.closeFilter_Btn);
		applicationFunctions.close_Filter();
	
		
	}
	
	@And("Filter using Selection Codes as {string}")
	public void filter_using_selection_code(String value) throws InterruptedException {
		applicationFunctions.click_Filter_Icon("Selection Codes");
		enterValueIntoTextField(manifestCheckPage.filterValue, value);		
		applicationFunctions.close_Filter();
		
	}*/

	@Then("Search the shipment in {string}, {string}, {string}")
	public void search_the_shipment_in(String sheetName, String columnName, String rowIndex)
			throws InterruptedException, IOException {
		Thread.sleep(150000);
		js.executeScript("document.querySelector(\"datatable-body\").scrollLeft=1000");
		try {
			applicationFunctions.click_Filter_Icon(columnName);
		}catch (ElementNotInteractableException | TimeoutException e) {
			js.executeScript("document.querySelector(\"datatable-body\").scrollLeft=-1000");
			applicationFunctions.click_Filter_Icon(columnName);	

		}
		applicationFunctions.set_Filter_Value(excelUtility.readExcelValue(sheetName, columnName, rowIndex));
		entryBuildPage.click_acssShipmentsEntryBuild();
		entryBuildPage.click_acssShipmentsEntryBuild();
		applicationFunctions.close_Filter();
	}

	@Then("Search the shipment {string}, {string}, {string}")
	public void search_the_shipment(String sheetName, String columnName, String rowIndex) throws InterruptedException, IOException
			{
		Thread.sleep(2000);
		js.executeScript("document.querySelector(\"datatable-body\").scrollLeft=-1000");
		try {
			applicationFunctions.click_Filter_Icon(columnName);
		}catch (NoSuchElementException|ElementClickInterceptedException | TimeoutException e) {
			js.executeScript("document.querySelector(\"datatable-body\").scrollLeft=1000");
			applicationFunctions.click_Filter_Icon(columnName);	
		}
		applicationFunctions.set_Filter_Value(excelUtility.readExcelValue(sheetName, columnName, rowIndex));
		applicationFunctions.close_Filter();
		
		
	}
	
	
	@Then("Search the Multiple shipment {string}, {string}, {string}")
	public void search_the_Multiple_shipment(String sheetName, String columnName, String rowIndex) throws InterruptedException, IOException
			{
		Thread.sleep(2000);
		js.executeScript("document.querySelector(\"datatable-body\").scrollLeft=-1000");
		try {
			applicationFunctions.click_Filter_Icon(columnName);
		}catch (NoSuchElementException|ElementClickInterceptedException | TimeoutException e) {
			js.executeScript("document.querySelector(\"datatable-body\").scrollLeft=1000");
			applicationFunctions.click_Filter_Icon(columnName);	
		}
		applicationFunctions.set_Filter_Multiple_Value(excelUtility.readExcelValue(sheetName, columnName, rowIndex));
		applicationFunctions.close_Filter();
		
		
	}
	
	

	@Then("Search the stored shipment")
	public void search_the_stored_shipment() throws InterruptedException, IOException {
		applicationFunctions.click_Filter_Icon("AWB Number");
		applicationFunctions.set_Filter_Value(ScenarioContext.getContext(Context.AWB).toString());
		applicationFunctions.close_Filter();
	}

	@When("Search the shipment {string}, {string}, {string} in Global Search")
	public void search_the_shipment_and_in_global_search(String sheetName, String rowIndex, String columnName)
			throws InterruptedException {
		globalSearchPage = new GlobalSearchPage(driver);
		globalSearchPage.enter_shipmentValue(readExcelValue(sheetName, columnName, rowIndex));
		globalSearchPage.click_entryShipmentSearch();
	}

	@When("Click on Assign to Me icon")
	public void click_on_assign_to_me_icon() throws InterruptedException {
		try {
			applicationFunctions.click_AssignToMe_Icon();
		} catch (Exception e) {
			System.err.println("Assign to me button is not present in the team list");
			e.printStackTrace();
		}
		Thread.sleep(2000);
	}

	@Then("Click on User List icon")
	public void click_on_user_list_icon() throws InterruptedException {
		System.err.println("***Waiting for 5 secs before user list is pulled***");
		Thread.sleep(5000);		
		applicationFunctions.click_UserList_Icon();
	}

	@Then("On Demand - Click on User List Icon")
	public void check_click_user_list() throws InterruptedException {
		System.err.println("***Waiting for 5 secs before user list is pulled***");
		Thread.sleep(4000);	
		manifestCheckPage.nullifyusericon();
	}
	
	@Then("Double click on the First Shipment")
	public void double_click_on_the_first_shipment() throws InterruptedException {
		applicationFunctions.doubleClick_Shipment();
	}

	@Then("Click on Override button")
	public void click_on_override_button() throws InterruptedException {
		manifestCheckPage.click_Override_Button();
	}

	@Then("Verify Toaster Message {string}")
	public void verify_toaster_message(String message) {
		applicationFunctions.verify_ToasterMessage();
	}

	@Then("Verify shipment is moved to other competency")
	public void verify_shipment_is_moved_to_other_competency() throws InterruptedException, Exception {
		//globalSearchPage.click_entryGlobalSearch();
		// globalSearchPage.enter_shipmentValue(excelUtility.readExcelValue(sheetName,
		// columnName, rowIndex));
		//globalSearchPage.enter_shipmentValue(ScenarioContext.getContext(Context.AWB).toString());
		verify_Shipment();
		
		globalSearchPage.click_entryShipmentSearchClose();
	}

	public void verify_Shipment() throws InterruptedException {
		try {
			int loopCnt = 5;
			do {
				if (loopCnt > 5) {
					Thread.sleep(5000);
					globalSearchPage.click_entryShipmentSearch();					
				} else {
					break;
				}
				loopCnt--;
			} while (!manifestCheckPage.verify_Shipment_Is_Not_In_ManifestCheck_Competency());
			if (!manifestCheckPage.verify_Shipment_Is_Not_In_ManifestCheck_Competency()) {
				Assert.fail("Shipment not moved to other competency");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Then("Select Multiple Shipments and Assign")
	public void select_multiple_shipments_and_assign() throws InterruptedException {
		applicationFunctions.click_GEMINI_Image();
		applicationFunctions.select_Competency("MANIFEST_CHECK");
		applicationFunctions.select_Multiple_Shipments();
		applicationFunctions.click_AssignToMe_Icon();
	}

	@Then("Click on Modify Clearance Scheme button")
	public void click_on_modify_clearance_scheme_button() {
		manifestCheckPage.click_ModifyClearanceScheme_Button();
	}

	@Then("Modify Clearance Scheme to {string}")
	public void modify_clearance_scheme_to(String clrScheme) {
		manifestCheckPage.modify_ClearanceScheme(clrScheme);
	}

	@Then("Click on Sort Message icon from Floating Panel")
	public void click_on_sort_message_icon_from_floating_panel() {
		manifestCheckPage.select_SortMessage_Icon_From_FloatingPanel();
	}

	@Then("Select Selection Code as {string} and Save")
	public void select_selection_code_as_and_save(String selectionCode) {
		for (String selCode : excelUtility.splitString(selectionCode)) {
			manifestCheckPage.click_SelectionCode_Filter();
			manifestCheckPage.set_SelectionCode_Value(selCode);
			manifestCheckPage.click_First_Toggle_Button();
		}
		manifestCheckPage.click_Save_Button();
	}

	@Then("Click on Upload icon from Floating Panel")
	public void click_on_upload_icon_from_floating_panel() {
		applicationFunctions.select_Upload_Icon_From_FloatingPanel();
	}

	@Then("Select Document Type as {string}")
	public void select_document_type_as(String documentType) throws AWTException {
		applicationFunctions.select_DocumentType(documentType);
	}

	@Then("Upload the Document")
	public void upload_the_document() throws InterruptedException, IOException {
		Thread.sleep(5000);
		applicationFunctions.click_BrowseFiles_Link();
		uploadFileUsingAutoIT();// manifestCheckPage.click_floatUploadBrowseFile();//
		Thread.sleep(15000);
		applicationFunctions.click_Save_Button();
	}

	@Then("Verify {string} value is equal to {string}")
	public void verify_ci_flag_value_is_equal_to(String label,String value) throws InterruptedException {
		manifestCheckPage.verify_CIFlag_Value(label,value);
	}

	@Then("Click on Upload button from Floating icon")
	public void click_on_upload_button_from_floating_icon() throws InterruptedException {
		manifestCheckPage.clickUploadButtonFromFloatingPanel();
	}

	@Then("Verify CI Flag column value")
	public void verify_ci_flag_column_value() throws InterruptedException {
		manifestCheckPage.verifyCIFlagValue();
	}

	@Then("Toaster message should be displayed as {string}")
	public void Toaster_message_Validation(String strMsg) throws InterruptedException {
		manifestCheckPage.toasterMessageValidation(strMsg);
	}

	@Then("CI Document should not have duplicate image")
	public void CI_Document_should_not_have_duplicate_image() throws InterruptedException {
		manifestCheckPage.CIDocNoDuplicate();
	}

	@Then("Click on the new open in new tab in document section")
	public void Click_on_the_new_open_in_new_tab_in_document_section() throws InterruptedException {
		manifestCheckPage.clickOpenInNewTabIcon();
	}

	@Then("Document thumbnail should be in detached view in new tab")
	public void Document_thumbnail_should_be_in_detached_view() throws InterruptedException {
		manifestCheckPage.detachedDocuments();
	}

	// Menaka
	@Then("Select {int} number of shipments in the Grid")
	public void Select_number_of_shipments_in_the_Grid(int numberof) throws InterruptedException {
		manifestCheckPage.selectMultipleShipmentandSaveAWB(0, numberof);

	}

	@Then("Select next {int} number of shipments in the Grid")
	public void Select_next_number_of_shipments_in_the_Grid(int numberof) throws InterruptedException {
		manifestCheckPage.selectMultipleShipmentandSaveAWB(4, numberof);

	}

	@Then("Assigned To of selected shipments should be assigned User")
	public void assigned_to_fields_of_selected_shipments_should_be_assigned_user() throws InterruptedException {
		// applicationFunctions.click_GEMINI_Image();
		globalSearchPage.click_entryGlobalSearch();
		String AWBs;
		AWBs = manifestCheckPage.getAWBNoToSearch();
		globalSearchPage.enter_shipmentValue(AWBs);
		globalSearchPage.click_entryShipmentSearch();
		// memberid = entryBuildPage.getMemberId();
		manifestCheckPage.verifyColumnValue("Assigned User ID", awbNumber.trim());
		globalSearchPage.click_entryShipmentSearchClose();

	}

	@Then("Assigned To of selected {int} shipments should be assigned to user in round robin")
	public void assigned_to_fields_of_selected_shipments(int n) throws InterruptedException {
		manifestCheckPage.checkRoundRobin(n, awbNumber);
	}

	@Then("Assigned To of selected shipments should be Blank")
	public void assigned_to_fields_of_selected_shipments_should_be_blank() throws InterruptedException {
		globalSearchPage.click_entryGlobalSearch();
		globalSearchPage.enter_shipmentValue(manifestCheckPage.getAWBNoToSearch());
		globalSearchPage.click_entryShipmentSearch();
		manifestCheckPage.verifyColumnValue("Assigned User ID", "");
		globalSearchPage.click_entryShipmentSearchClose();
	}

	// Menaka
	@Then("Select any user and submit")
	public void sel_any_user() throws Throwable {
		awbNumber = entryBuildPage.SelectAnyUserforAssignment();

	}

	@Then("Select any {int} user and submit")
	public void sel_any_no_user(int noofShipment) throws Throwable {
		awbNumber = entryBuildPage.SelectAnyNoUserforAssignment(noofShipment);
		

	}
	
	@Then("Select only {int} user and submit")
	public void sel_only_one_user(int noofShipment) throws Throwable {
		awbNumber = entryBuildPage.SelectOnlyOneUserforAssignment(noofShipment);
	
	}

	@Then("Verify selected shipments assigned to Userlist {string},{string},{string}")
	public void verifySelectedShipments(String sheetName,String columnName,String RowNo) throws InterruptedException, IOException {
		manifestCheckPage.verifySelectedShipments(sheetName,columnName,RowNo);
	}

	@Then("Get all the Column Names to Verify Column Names is not duplicate")
	public void getAllColumnNames() throws InterruptedException {
		manifestCheckPage.getAllColumnHeaderNamesVerify();
	}

	@And("Get total count of Coulmn Names to Validate Column Count is {int}")
	public void getAllColumnNamesCount(int count) throws InterruptedException {
		manifestCheckPage.getAllColumnHeaderCountVerify(count);
	}

	@And("All columns in modal window are enabled")
	public void enableAllColumnNames() throws InterruptedException {
		manifestCheckPage.enableAllColumnNames();
	}

	@When("Few columns in modal window are enabled and few disable")
	public void editCloumnConfig() throws InterruptedException {
		manifestCheckPage.editCloumnConfig();
	}

	@And("Logout from the application")
	public void logoutApplication() throws InterruptedException {
		manifestCheckPage.logout();
	}

	@Then("validate the Saved column configuration")
	public void validateSavedColumnConfig() throws InterruptedException {
		manifestCheckPage.validateSavedColumnConfig();
	}

	
	@And("select the shipment")
	public void selectMultiplsShipment() throws InterruptedException {
		Actions action = new Actions(driver);
		for(int i=2;i<=5;i++) {
			Thread.sleep(2000);
			WebElement ele = driver
			.findElement(By.xpath("(//datatable-row-wrapper[contains(@class,'datatable-row-wrapper')])["
					+ i + "]/datatable-body-row/div[2]"));
		action.keyDown(Keys.CONTROL).click(ele);
		Thread.sleep(2000);
		
		}
		action.keyUp(Keys.CONTROL).build().perform();
	}

	

	String readExcelValue(String sheetName, String columnName, String rowIndex) {
		String excelFilePath = "src/test/resources/InputDataSG.xlsx";
		FileInputStream inputStream = null;
		try {
			inputStream = new FileInputStream(new File(excelFilePath));
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Workbook wb = null;
		try {
			wb = WorkbookFactory.create(inputStream);
		} catch (EncryptedDocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Sheet sheet = wb.getSheet(sheetName);
		Row row = sheet.getRow(0);
		int cellNum = row.getPhysicalNumberOfCells();
		for (int i = 0; i < cellNum; i++) {
			if ((row.getCell(i).toString()).equals(columnName)) {
				return sheet.getRow(Integer.parseInt(rowIndex)).getCell(i).toString();
			}
		}
		return "";
	}
	
	@Then("Read limited shipment AWB number {string},{string},{string}")
	public void readLimitedShipment(String data1,String data2,String data3) throws InterruptedException, IOException {
		int num=0;
		int i;
		js.executeScript("document.querySelector(\"datatable-body\").scrollLeft=-1000");
		String headerval=null, value=null;
		aList = new ArrayList<>();
		entryBuildPage.tblHeaderlabels.size();
		System.out.println("Header Size : " + entryBuildPage.tblHeaderlabels.size());

		for (i = 1; i < entryBuildPage.tblHeaderlabels.size(); i++) {
			headerval = driver
					.findElement(By.xpath("((//datatable-header-cell/div/div)/table)[" + i + "]/tr/th[1]/span"))
					.getText();
			if (headerval.trim().equalsIgnoreCase("AWB Number")) {
				System.out.println("Position of the AWB Number column is : "+i);
				num = i;
				break;
			}
		}		
		for (int k = 1; k <= 5;k++) {
			if (headerval.trim().equalsIgnoreCase("AWB Number")) {
			
				
				try {
					globalSearch = driver
								.findElement(By.xpath("(//datatable-row-wrapper[contains(@class,'datatable-row-wrapper')])["
										+ k + "]/datatable-body-row/div[2]/datatable-body-cell[" + num + "]"))
								.getText();						
						//Thread.sleep(3000);
						System.out.println("AWB No:"  + globalSearch);
						//aList.add(globalSearch);
						if(k==1)
							value = globalSearch;
							else
							value = value+","+globalSearch;
				} catch (NoSuchElementException e) {
					System.err.println("There is no enough data in the shipment table. However proceeding execution with the available shipment");
				}
				}			
		}
		//excelUtility.writeExcelValue(data1, data2, data3, aList.toString().replaceAll("\\W", " "));
		//System.out.println(aList.toString().replaceAll("\\W", " "));
		excelUtility.writeExcelValue(data1, data2, data3, value);
		
		
	}
	
	@Then("Read {int} shipment AWB number {string},{string},{string}")
	public void readTwoShipment(int stotal,String data1,String data2,String data3) throws InterruptedException, IOException {
		js.executeScript("document.querySelector(\"datatable-body\").scrollLeft=-1000");
		int num=0;
		int i;
		String  value=null,headerval=null;
		aList = new ArrayList<>();
		entryBuildPage.tblHeaderlabels.size();
		System.out.println("Header Size : " + entryBuildPage.tblHeaderlabels.size());

		for (i = 1; i < entryBuildPage.tblHeaderlabels.size(); i++) {
			headerval = driver
					.findElement(By.xpath("((//datatable-header-cell/div/div)/table)[" + i + "]/tr/th[1]/span"))
					.getText();
			if (headerval.trim().equalsIgnoreCase("AWB Number")) {
				System.out.println("Position of the AWB Number column is : "+i);
				num = i;
				break;
			}
		}		
		for (int k = 1; k <= stotal;k++) {
			try {
				if (headerval.trim().equalsIgnoreCase("AWB Number")) {				
					globalSearch = driver
								.findElement(By.xpath("(//datatable-row-wrapper[contains(@class,'datatable-row-wrapper')])["
										+ k + "]/datatable-body-row/div[2]/datatable-body-cell[" + num + "]"))
								.getText();	
					
					
						//Thread.sleep(3000);
					if(k==1) {
					value = globalSearch;
					}
					else {
						value = value+","+globalSearch;
					Actions builder = new Actions(driver);
					builder.keyDown(Keys.CONTROL).click(driver
							.findElement(By.xpath("(//datatable-row-wrapper[contains(@class,'datatable-row-wrapper')])["
									+ k + "]/datatable-body-row/div[2]/datatable-body-cell[" + k + "]"))).build().perform();
					}
				}
			} catch (NoSuchElementException e) {
					System.err.println("There are no AWB Number available to fetch");
			}			
		}
		excelUtility.writeExcelValue(data1, data2, data3, value);
		//excelUtility.writeExcelValue(data1, data2, data3, aList.toString().replaceAll("\\W", ""));
		//System.out.println(aList.toString().trim().replaceAll("\\W", ""));
		
	}
	
		
	@And("Enter multiple shipment value {string},{string},{string}")
	public void enterMultipleShipment(String sheetName,String columnName,String rowIndex) throws InterruptedException, IOException {
		globalSearchPage.enter_shipmentValue(excelUtility.readExcelValue(sheetName, columnName, rowIndex));
		Thread.sleep(3000);
		
	}
	
	@Then("Read the column {string} and verify the sorting is successful")
	public void readAllValues(String value) throws InterruptedException {
		int num=0;
		int i;
		String headerval=null;
		String allElement;
		aList = new ArrayList<>();
		aaList = new ArrayList<>();
		entryBuildPage.tblHeaderlabels.size();
		System.out.println("Header Size : " + entryBuildPage.tblHeaderlabels.size());
		for (i = 1; i < entryBuildPage.tblHeaderlabels.size(); i++) {
			headerval = driver
					.findElement(By.xpath("((//datatable-header-cell/div/div)/table)[" + i + "]/tr/th[1]/span"))
					.getText();
			if (headerval.trim().equalsIgnoreCase(value)) {
				System.out.println("Position of the "+value+" column is : "+i);
				num = i;
				break;
			}
		}	   	
		List<WebElement> elements = driver.findElements(By.xpath("(//datatable-row-wrapper[contains(@class,'datatable-row-wrapper')])"));
		for (int k = 1; k <=elements.size();k++) {
			if (headerval.trim().equalsIgnoreCase(value)) {				
					globalSearch = driver
							.findElement(By.xpath("(//datatable-row-wrapper[contains(@class,'datatable-row-wrapper')])["
									+ k + "]/datatable-body-row/div[2]/datatable-body-cell[" + num + "]"))
							.getText();
					System.out.println("Label Name:" + globalSearch);
					aList.add(globalSearch);

				}			
		}
		System.out.println("Before Sorting:"+ aList);
		
		driver.findElement(By.xpath("((//datatable-header-cell/div/div)/table)[" + i + "]/tr/th[1]/span")).click();
		List<WebElement> ele = driver.findElements(By.xpath("(//datatable-row-wrapper[contains(@class,'datatable-row-wrapper')])"));
		for (int k = 1; k <=ele.size();k++) {
			if (headerval.trim().equalsIgnoreCase(value)) {				
					globalSearch = driver
							.findElement(By.xpath("(//datatable-row-wrapper[contains(@class,'datatable-row-wrapper')])["
									+ k + "]/datatable-body-row/div[2]/datatable-body-cell[" + num + "]"))
							.getText();
					System.out.println("Label Name:" + globalSearch);
					aaList.add(globalSearch);

				}			
		}
		
				
		Assert.assertNotEquals(aList,aaList);
		
		
	}
	
	@And("Assign Multiple Shipments to User List")
	public void Assign_shipments_in_User_LIst() throws InterruptedException {
 		int numberof = 18;
 		for (int i = 0; i < 7; i++) {
			manifestCheckPage.selectMultipleShipmentandSaveAWB(0,numberof);
			manifestCheckPage.click_AssignToMe();
 		}
	}
	
	@And("Assign n shipment to user list")
	public void Assign_shipments_to_User_List() throws InterruptedException {
		String shipResult = "";
		/*System.out.println("Total shipment in user list: " + entryBuildPage.userList_Record_Count());

		shipResult = entryBuildPage.userList_count_label.getText().trim();
		String[] splitText = shipResult.replace(")", " ").split("/");
		System.out.println(Integer.parseInt(splitText[1].trim()));
		if (Integer.parseInt(splitText[1].trim()) > 101) {
			
			for(int i=1;i<=101-entryBuildPage.userList_Record_Count();i++) {
			entryBuildPage.select_first_shipment.click();
			manifestCheckPage.click_UserList();
			}
			
		}
 		
	}*/
		manifestCheckPage.click_UserList();
		int i,j,value;
		value = entryBuildPage.userList_Record_Count();
		waitTillElementVisible(ManifestCheckPage.teamList);
		ManifestCheckPage.teamList.click();
		entryBuildPage.ACCSShipments_module();
		Thread.sleep(5000);
		shipResult = entryBuildPage.userList_count_label.getText().trim();
		String[] splitText = shipResult.replace(")", " ").split("/");
		int teamListCount = Integer.parseInt(splitText[1].trim());
		if (teamListCount >= 101) {			
			for( i=1;i<=120-value;i++) {			
				for(j=1;j<=10;j++) {
					Thread.sleep(1000);
					driver.findElement(By.xpath("(//datatable-body-row[contains(@class,'datatable-body-row')])[1]")).click();
					/*Actions builder1 = new Actions(driver);
					WebElement option1 = driver.findElement(By.xpath("(//datatable-body-row[contains(@class,'datatable-body-row')])["+j+"]"));
					builder1.keyDown(Keys.CONTROL).click(option1).build().perform();*/
					Thread.sleep(1000);
					manifestCheckPage.click_AssignToMe();
			}				
				value += j;			
			}
			manifestCheckPage.click_UserList();			
		}
	}
	
	@And("Filter using columnname {string} as {string}")
	public void filter_using_Incoterm_as(String columnName,String value) throws ElementNotInteractableException, InterruptedException {		
		Thread.sleep(2000);
		int ScrollValue=500;
		int k=0,i=1;
		boolean flag=false;
		js.executeScript("document.querySelector(\"datatable-body\").scrollLeft=-1000");
		for (i = 1; i <= entryBuildPage.tblHeaderlabels.size(); i++) {
			if(driver.findElement(By.xpath("((//datatable-header-cell/div/div)/table)["+ i +"]/tr/th[1]/span")).getText().equalsIgnoreCase(columnName)){
				try {
					applicationFunctions.click_Filter_Icon(columnName);			
				} catch (ElementNotInteractableException | TimeoutException e) {
					js.executeScript("document.querySelector(\"datatable-body\").scrollLeft=1000");
					applicationFunctions.click_Filter_Icon(columnName);	
					flag=true;
				}
				applicationFunctions.set_Filter_Value(value);
				applicationFunctions.close_Filter();
				flag=true;
			}
			if(flag) {break;}
			if(i%5==0) {
				k+= 1;
				js.executeScript("document.querySelector(\"datatable-body\").scrollLeft="+(ScrollValue*k));
				Thread.sleep(2000);
			}
		}

	}
	

	
	@And("Fliter Arrival Date with latest shipment")
	public void fliter_arrival_date_with_latest_shipment() throws InterruptedException   {
		applicationFunctions.click_Filter_Icon("Arrival Date");
		manifestCheckPage.selectArrivaldate();
		Thread.sleep(2000);
		applicationFunctions.close_Filter();
	}
	
	@And("Verify document type name in invoice as {string}")
	public void Verify_document_type(String value)   {
		manifestCheckPage.labelname_image(value);
		
	}
	
	
	
	
	
	@Then("Click on the Download Icon")
	public void click_on_downloadIcon() throws InterruptedException {
		manifestCheckPage.downloadicon();
	}
}
