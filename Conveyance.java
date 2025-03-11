package stepDefinitions;

import java.io.IOException;

import com.FedEx.GeminiAutomationSG.PageObjects.ConveyancePage;
import com.FedEx.GeminiAutomationSG.TestBase.BaseClass;
import com.FedEx.GeminiAutomationSG.Utilities.ApplicationFunctions;
import com.FedEx.GeminiAutomationSG.Utilities.ExcelUtility;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;

public class Conveyance extends BaseClass {

	ConveyancePage conveyancePage = new ConveyancePage(driver);
	ApplicationFunctions applicationFunctions = new ApplicationFunctions(driver);
	ExcelUtility excelUtility = new ExcelUtility();

	
	
	@Given("Enter Conveyance Number {string}, {string}, {string}")
	public void enter_conveyance_number(String sheetName, String columnName, String rowIndex) throws IOException {
		conveyancePage.set_ConveyanceNumber(excelUtility.readExcelValue(sheetName, columnName, rowIndex));
	}

	@Given("Click on Search button")
	public void click_on_search_button() throws InterruptedException {
		conveyancePage.click_Search_Icon();
	}

	@Then("Click on Edit button")
	public void click_on_edit_button() {
		conveyancePage.click_Edit_Icon();
	}
	
	@And("Validated the conveyace location")
	public void conveyance_location() {
		conveyancePage.validate_presence_Conv_Location();
		
	}

	@Then("Select Origin Port")
	public void select_origin_port_as() {
		conveyancePage.select_OriginPort();
	}

	@Then("Select Origin Departing Location")
	public void select_origin_departing_location_as() throws InterruptedException {
		conveyancePage.select_OriginDepartingLocation();
	}

	@Then("Modify MAWB as {string}, {string}, {string}")
	public void modify_mawb_as(String sheetName, String columnName, String rowIndex) throws IOException {
		conveyancePage.set_MAWB(excelUtility.readExcelValue(sheetName, columnName, rowIndex));
	}

	@Then("Click on Submit button")
	public void click_on_submit_button() {
		waitTillElementVisible(conveyancePage.submit_Btn);
		conveyancePage.click_Submit_Button();
	}

	@Then("Verify Toaster Message")
	public void verify_toaster_message() {
		waitTillElementVisible(applicationFunctions.toaster_Message);
		applicationFunctions.verify_ToasterMessage();
	}

	@Given("Verify Date Type dropdown values")
	public void verify_date_type_dropdown_values() {
		conveyancePage.verify_DateType_Dropdown();
	}

	@Given("Select Date Type as {string}")
	public void select_date_type_as(String dateType) {
		conveyancePage.select_DateType(dateType);
	}

	@Given("Verify Date Format")
	public void verify_date_format() {
		conveyancePage.verify_DateFormat();
	}

	@Then("Modify the Flight Number {string}, {string}, {string}")
	public void modify_the_flight_number(String sheetName, String columnName, String rowIndex) throws IOException {
		conveyancePage.set_FlightNumber(excelUtility.readExcelValue(sheetName, columnName, rowIndex));
	}

	@Then("Modify the MAWB {string}, {string}, {string}")
	public void modify_the_mawb(String sheetName, String columnName, String rowIndex) throws IOException {
		conveyancePage.set_MAWB(excelUtility.readExcelValue(sheetName, columnName, rowIndex));
	}

	@Given("Filter using Conveyance Status {string}")
	public void filter_using_conveyance_status(String conveyanceStatus) throws InterruptedException {
		applicationFunctions.click_Filter_Icon("Conveyance Status");
		applicationFunctions.set_Filter_Value(conveyanceStatus);
		applicationFunctions.close_Filter();
	}

	@Given("Filter using Conveyance Number {string}")
	public void filter_using_conveyance_number(String value) throws InterruptedException {
		applicationFunctions.click_Filter_Icon("Conveyance Number");
		applicationFunctions.set_Filter_Value(value);
		applicationFunctions.close_Filter();
	}

	@Then("Select First Record from the Grid")
	public void select_first_record_from_the_grid() {
		conveyancePage.select_Row();
	}

	@Then("Verify fields displayed in Modify Conveyance Details popup")
	public void verify_fields_displayed_in_modify_conveyance_details_popup() {
		conveyancePage.verify_Fields_Displayed_Under_ModifyConveyanceDetails_PopUp();
	}

	@Then("Click on Logout button")
	public void click_on_logout_button() {
		applicationFunctions.clickLogoutButton();
	}

}
