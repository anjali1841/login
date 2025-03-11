package stepDefinitions;

import java.awt.AWTException;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

import org.apache.poi.EncryptedDocumentException;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.testng.Assert;

import com.FedEx.GeminiAutomationSG.PageObjects.CustomerMatchingPage;
import com.FedEx.GeminiAutomationSG.PageObjects.EntryBuildPage;
import com.FedEx.GeminiAutomationSG.PageObjects.MaintenancePage;
import com.FedEx.GeminiAutomationSG.PageObjects.ManifestCheckPage;
import com.FedEx.GeminiAutomationSG.PageObjects.RestAssuredPage;
import com.FedEx.GeminiAutomationSG.TestBase.BaseClass;
import com.FedEx.GeminiAutomationSG.Utilities.ApplicationFunctions;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

public class Maintenance extends BaseClass {
	

	public static EntryBuildPage entryBuild;
	CustomerMatchingPage customermatchingpage= new CustomerMatchingPage(driver);
	ManifestCheckPage manifestCheckPage = new ManifestCheckPage(driver);
	MaintenancePage maintenancePage = new MaintenancePage(driver);
	ApplicationFunctions applicationFunctions = new ApplicationFunctions(driver);
	RestAssuredPage restAssuredPage = new RestAssuredPage(driver);

	@Given("User is in Customer Matching Competency with teamlist")
	public void user_is_in_customer_matching_competency_with_teamlist() throws InterruptedException {
		customermatchingpage = new CustomerMatchingPage(driver);
		customermatchingpage.click_CustomerMatching();
	}
	
	@Then("Search the shipment in Manifest Check {string}, {string}, {string}")
	public void search_the_shipment_in_manifest_check(String sheetName, String columnName, String rowIndex) throws InterruptedException {
		Thread.sleep(5000);
		entryBuild = new EntryBuildPage(driver);
		entryBuild.click_filterAWBMC();
		entryBuild.set_filter(readExcelValue(sheetName, columnName, rowIndex));
		entryBuild.click_filterClose();
	}
	
	@Given("Navigate to {string} Page")
	public void navigate_to_page(String maintenance) throws InterruptedException {
		applicationFunctions.navigate_To_Maintenance_Page(maintenance);
	}

	@Given("User clicks on Create Icon")
	public void user_clicks_on_create_icon() throws AWTException, InterruptedException {
		maintenancePage.click_Create_Button();
	}

	@Then("Select Clearance Scheme as {string}")
	public void select_clearance_scheme_as(String clearanceScheme) {
		maintenancePage.set_ClearanceScheme(clearanceScheme);
	}

	@Then("Select Sanity Group as {string}")
	public void select_sanity_group_as(String sanityGroup) {
		maintenancePage.set_SanityGroup(sanityGroup);
	}

	@Then("Select Valid From Date")
	public void select_valid_from_date() throws InterruptedException {
		maintenancePage.set_SanityRule_ValidFrom_Date();
		applicationFunctions.select_Date(-10);
	}

	@Then("Select Valid To Date")
	public void select_valid_to_date() throws InterruptedException {
		maintenancePage.set_SanityRule_ValidTo_Date();
		applicationFunctions.select_Date(2);
	}

	@Then("Select Status as {string}")
	public void select_status_as(String status) {
		maintenancePage.select_Status(status);
	}

	@Then("Enter Sanity Rule Name as {string}")
	public void enter_sanity_rule_name_as(String ruleName) {
		maintenancePage.set_SanityRuleName(ruleName);
		System.out.println("Rule Name: " + maintenancePage.get_SanityRuleName());
	}

	@Then("Enter Sanity Rule Description as {string}")
	public void enter_sanity_rule_description_as(String ruleDescription) {
		maintenancePage.set_SanityRuleDescription(ruleDescription);
	}

	@Then("Select Rule Condition as {string}")
	public void select_rule_condition_as(String ruleCondition) throws InterruptedException {
		maintenancePage.select_RuleCondition(ruleCondition);
	}

	@Then("Select Parameter value as {string}")
	public void select_parameter_value_as(String parameter) {
		maintenancePage.select_Parameter(parameter);
	}
	
	@Then("Select Sortcode value as {string}")
	public void select_sortcode_value_as(String sortcode) {
		maintenancePage.select_Sortcode(sortcode);
	}

	@Then("Select Condition value as {string}")
	public void select_condition_value_as(String condition) {
		maintenancePage.select_Condition(condition);
	}

	@Then("Select or Enter value as {string}")
	public void select_or_enter_value_as(String value) {
		maintenancePage.set_Value(value);
	}

	@Then("Click on Submit")
	public void click_on_submit() {
		maintenancePage.click_Submit_Button();
	}

	@Then("Filter using Sanity Rule Name as {string}")
	public void filter_using_sanity_rule_name_as(String ruleName) throws InterruptedException {
		applicationFunctions.click_Filter_Icon("Rule Name");
		applicationFunctions.set_Filter_Value(ruleName);
		applicationFunctions.close_Filter();
	}
	
	@Then("Verify Sanity Rule Name is {string}")
	public void verify_sanity_rule_name_is(String ruleName) {
		verifyStringsAreEqual(maintenancePage.get_FirstRecordSanityRule(), ruleName);
	}

	@Then("Click on Edit Icon")
	public void click_on_edit_icon() throws InterruptedException {
		maintenancePage.click_Edit_Button();
	}

	@Then("Click on Cancel")
	public void click_on_cancel() {
		maintenancePage.click_Cancel_Button();
	}

	@Then("Click on Delete button")
	public void click_on_delete_button() {
		maintenancePage.click_Delete_Button();
	}

	// Team Rule Maintenance
	@Then("Enter Team Rule Name as {string}")
	public void enter_team_rule_name_as(String ruleName) {
		maintenancePage.set_Team_RuleName(ruleName);
	}

	@Then("Enter Team Rule Description as {string}")
	public void enter_team_rule_description_as(String ruleDescription) {
		maintenancePage.set_Team_RuleDescription(ruleDescription);
	}
	
	@Then("Filter using Team Rule Name as {string}")
	public void filter_using_team_rule_name_as(String ruleName) throws InterruptedException {
		applicationFunctions.click_Filter_Icon("Team Name");
		applicationFunctions.set_Filter_Value(ruleName);
		applicationFunctions.close_Filter();
	}

	@Then("Filter using sort code as {string}")
	public void filter_using_sort_code_as(String sortcode) throws InterruptedException {
		applicationFunctions.click_Filter_Icon("Sort Code");
		applicationFunctions.set_Filter_Value(sortcode);
		applicationFunctions.close_Filter();
	}
	
	@Then("Verify Team Rule Name is {string}")
	public void verify_team_rule_name_is(String ruleName) {
		verifyStringsAreEqual(maintenancePage.get_FirstRecordTeamRule(), ruleName);
	}

	@Then("Verify sort code Status is {string}")
	 public void verify_sort_code_Status__is(String sortcode) {
	 verifyStringsAreEqual(maintenancePage.get_FirstRecordsortcodeStatus(), sortcode);
	 }
	
	
	// User Maintenance
	@Then("Search for the User")
	public void search_for_user() throws AWTException, InterruptedException {
		maintenancePage.set_UserID();
	}

	@Then("Select Team as {string} and click on Assign button")
	public void select_team_as_and_click_on_assign_button(String string) throws InterruptedException {
		maintenancePage.select_All_Teams_Toggle();		
	}
	
	@Then("Toggle Off {string} in select teams")
	public void Toggle_off_the_seelected_team(String string) throws InterruptedException {
		maintenancePage.Toggle_off();		
	}

	@Then("Verify Team as {string} in Assigned Teams Panel")
	public void verify_team_as_in_assigned_teams_panel(String string) {
		System.out.println("Value: " + maintenancePage.get_phantomTeam());
		//maintenancePage.close_Phantom();
	}

	@Then("Click Save in User Maintenance page")
	public void click_save_in_user_maintenance_page() throws InterruptedException {
		maintenancePage.click_Save_Button();
		Thread.sleep(3000);
		maintenancePage.click_cancel_button();
		Thread.sleep(1000);
	
	}

	// API Validation using Rest Assured
	@Given("Sanity Rule API when GET request is submitted with Valid Data then verify Response Status Code is {string}")
	public void sanity_rule_api_when_get_request_is_submitted_with_valid_data_then_verify_response_status_code_is(
			String string) throws InterruptedException {
		restAssuredPage.verify_SanityRule_API();
	}

	@Given("Team Rule API when GET request is submitted with Valid Data then verify Response Status Code is {string}")
	public void team_rule_api_when_get_request_is_submitted_with_valid_data_then_verify_response_status_code_is(String string) throws InterruptedException {
		restAssuredPage.verify_TeamRule_API();
	}

	@Given("User Maintenance API when GET request is submitted with Valid Data then verify Response Status Code is {string}")
	public void user_maintenance_api_when_get_request_is_submitted_with_valid_data_then_verify_response_status_code_is(String string) throws InterruptedException {
		restAssuredPage.verify_UserMaintenance_API();
	}
	@Then("{string} value should be present in Parameter List")
	public void value_should_be_present_in_Parameter_List(String Value) throws InterruptedException {
		maintenancePage.verify_Parameter_Value_present(Value);
	}
	
	@Given("Click on Create button") 
	public void Click_on_Create_button() throws AWTException, InterruptedException {
		maintenancePage.click_Create();
	}
	String readExcelValue(String sheetName, String columnName, String rowIndex) {
		String excelFilePath = "TestData/InputDataSG.xlsx";
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
	
	@When("Filter the column {string} with value {string}")
	public void filter_the_column_with_value(String ColName, String FilterVal) throws InterruptedException {
		applicationFunctions.click_Filter_Icon_Hidden(ColName);
		applicationFunctions.set_Filter_Value(FilterVal);
		applicationFunctions.close_Filter();
	}
	
	@And("Column {string} should be displayed with Value {string}")
	public void column_should_be_displayed_with_value(String ColName, String ColVal) {
		maintenancePage.verifyColumnValue_listGrid(ColName, ColVal);
	   
	}
	
	@Given("User is in Customer Matching Competency with Team Leader List")
	public void user_is_in_customer_matching_competency_with_team_leader_list() throws InterruptedException {
		customermatchingpage = new CustomerMatchingPage(driver);
		customermatchingpage.click_CustomerMatching();
		customermatchingpage.click_TeamLeaderList();
	}
	
	@When("Double Click on Arrival Date")
	public void double_click_on_arrival_date() throws InterruptedException {
		customermatchingpage.doubleClick_ArrivalDate();
	}
	
	@When("Click on Assigned To")
	public void click_on_assigned_to() throws InterruptedException {
		customermatchingpage.click_AssignedTo();
	}
	
	@When("Select the member\\(s) to reassign  {string}, {string}, {string}")
	public void select_the_member_s_to_reassign(String sheetName, String columnName, String rowIndex)
			throws InterruptedException {
		entryBuild = new EntryBuildPage(driver);
		String[] str1 = readExcelValue(sheetName, columnName, rowIndex).split(",");
		System.out.println("Length of the fedex user : "+str1.length);
		for(int i=0;i<=(str1.length)-1;i++) {
			System.out.println(str1[i]);
			entryBuild.set_Search_Value(str1[i]);
			manifestCheckPage.click_user();

		}
	}
	
	@Then("verify the shipment is in Team Leader List Assigned User ID {string},{string},{string},{string}")
	public void verify_the_shipment_is_in_team_leader_list_assigned_user_id(String sheetName, String columnName,
			String FedExId, String rowNo) throws InterruptedException {
		String readUserId = readExcelValue(sheetName, FedExId, rowNo);
		String[] splUserIds = readUserId.split(",");
		System.out.println("Total User Id's :"+splUserIds.length);
		entryBuild = new EntryBuildPage(driver);
		System.out.println("++++ Team Leader List ++++");
		String[] readAwbs = readExcelValue(sheetName, columnName, rowNo).split(",");
		
		for(int k=1;k<=splUserIds.length;k++) {		
			Thread.sleep(1000);
			for (int i = 0; i <readAwbs.length; i++) {
				//entryBuild.click_filterAWBMC();
				applicationFunctions.click_Filter_Icon(columnName);
				entryBuild.set_filter(readAwbs[i]);
				applicationFunctions.close_Filter();
				Thread.sleep(3000);
				String assUserId = customermatchingpage.txtAssignedUserIdRes.getText();
					if(assUserId.length()>0) {
						Assert.assertTrue(true, "Assigned User ID in team leader list is visible in the grid");
					}
					else
					{
						Assert.assertTrue(false, "Assigned User ID in team leader list is not visible in the grid");
					}
			if (assUserId.equals(splUserIds[k-1])) {
				System.out.println(
						"The AWBNumber " + readAwbs[i]+" is assigned to " + splUserIds[k-1]);
			}  else {
				System.err.println("The AWB Number " + readAwbs[i] + " is NOT assigned to "+ splUserIds[k-1]);
			}
			}
		}
	}
	
	@Then("verify the shipment is in User List {string},{string},{string}")
	public void verify_the_shipment_is_in_user_list(String sheetName, String columnName, String rowIndex)
			throws InterruptedException {
		ManifestCheckPage.userList.click();
		entryBuild = new EntryBuildPage(driver);
		String userName = customermatchingpage.txtUsername.getText();
		System.out.println("++++ User List ++++");
		/*for (int i = 1; i <= 5; i++) {
			entryBuild.click_filterAWBMC();
			entryBuild.set_filter(readExcelValue(sheetName, columnName + i, rowIndex));
			String readAwbNum = readExcelValue(sheetName, columnName + i, rowIndex);
			Thread.sleep(1000);
			if (ManifestCheckPage.AWBNumber.getText().equals(readAwbNum)) {
				System.out.println("The AWB Number " + readAwbNum + " is available for User Name (" + userName + ").");
			} else {
				System.out.println("The AWB Number " + readAwbNum + " is not available for User Name (" + userName + ").");
			}
			entryBuild.click_filterClose();
		}*/
		String[] readAwbs = readExcelValue(sheetName, columnName, rowIndex).split("\\s+");
		

			for (int i = 1; i <= 5; i++) {
				applicationFunctions.click_Filter_Icon("AWB Number");				
				entryBuild.set_filter(readAwbs[i]);
				applicationFunctions.close_Filter();
				Thread.sleep(2000);
				if (ManifestCheckPage.AWBNumber.getText().equals(readAwbs[i])) {
				System.out.println(
						"The AWBNumber " + readAwbs[i]+" is assigned to " + userName);
			}  else {
				System.out.println("The AWB Number " + readAwbs[i] + " is NOT assigned to any of the given User ID");
			}
			}
		
	}
	
	@When("the shipment is Unassigned {string},{string},{string}")
	public void the_shipment_is_unassigned(String sheetName, String columnName, String rowIndex)
			throws InterruptedException {
		entryBuild = new EntryBuildPage(driver);
		for (int i = 1; i <= 5; i++) {
			entryBuild.click_filterAWBMC();
			entryBuild.set_filter(readExcelValue(sheetName, columnName + i, rowIndex));
			String readAwbNum = readExcelValue(sheetName, columnName + i, rowIndex);
			Thread.sleep(1000);
			if (ManifestCheckPage.AWBNumber.getText().equals(readAwbNum)) {
				System.out.println("The AWB Number " + readAwbNum + " is available in the Team List");
				entryBuild.click_filterClose();
				customermatchingpage.click_unAssign();
				break;
			}
		}
	}

}