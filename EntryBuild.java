package stepDefinitions;

import static org.junit.Assert.assertTrue;
import static org.testng.Assert.assertEquals;

import java.awt.AWTException;
import java.awt.Robot;
import java.awt.Toolkit;
import java.awt.datatransfer.StringSelection;
import java.awt.event.KeyEvent;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map.Entry;
import java.util.Random;
import java.util.ResourceBundle;

import org.json.simple.parser.JSONParser;
import org.openqa.selenium.By;
import org.openqa.selenium.ElementNotInteractableException;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.FindBy;
import org.testng.Assert;

import com.FedEx.GeminiAutomationSG.PageObjects.CustomerMatchingPage;
import com.FedEx.GeminiAutomationSG.PageObjects.EntryBuildPage;
import com.FedEx.GeminiAutomationSG.PageObjects.GlobalSearchPage;
import com.FedEx.GeminiAutomationSG.PageObjects.LoginPage;
import com.FedEx.GeminiAutomationSG.PageObjects.ManifestCheckPage;
import com.FedEx.GeminiAutomationSG.PageObjects.ReportsPage;
import com.FedEx.GeminiAutomationSG.PageObjects.RestAssuredPage;
import com.FedEx.GeminiAutomationSG.TestBase.BaseClass;
import com.FedEx.GeminiAutomationSG.Utilities.ApplicationFunctions;
import com.FedEx.GeminiAutomationSG.Utilities.ExcelUtility;
import com.FedEx.GeminiAutomationSG.Utilities.ScenarioContext;
import com.FedEx.GeminiAutomationSG.Utilities.ScenarioContext.Context;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.RestAssured;
import io.restassured.response.Response;

public class EntryBuild extends BaseClass {

	ManifestCheckPage manifestCheckPage = new ManifestCheckPage(driver);
	CustomerMatchingPage customerMatchingPage = new CustomerMatchingPage(driver);
	EntryBuildPage entryBuildPage = new EntryBuildPage(driver);
	ReportsPage reportsPage = new ReportsPage(driver);
	GlobalSearchPage globalSearchPage = new GlobalSearchPage(driver);
	ApplicationFunctions applicationFunctions = new ApplicationFunctions(driver);
	ExcelUtility excelUtility = new ExcelUtility();
	RestAssuredPage restAssuredPage = new RestAssuredPage(driver);
	JavascriptExecutor js = (JavascriptExecutor) driver;
	LoginPage loginPage = new LoginPage(driver);
	//public static Logger log;
	static List<String> awbList;
	private static boolean lblexistance = false;
	public static int TotalThumbnails_CustomerInvoice = 0;

	@Given("^User clicks on Manifest Check Competency with teamlist$")
	public void Click_Manifest_Competency() throws Throwable {
		manifestCheckPage.click_ManifestCheck();
	}

	@Given("^Select ACSS Shipments toggle$")
	public void select_ACCS_toggle() throws Throwable {
		manifestCheckPage.click_ACSSShipments();
	}

	@When("^Select ACSS Shipments toggle in team leader list$")
	public void select_ACCS_toggle_teamleader_list() throws Throwable {
		manifestCheckPage.click_ACSSShipmentsTeamleader();
	}

	@And("^Select the shipment with Clearance Scheme HY Consignee Company and Importer Company$")
	public void shipment_clearanceScheme_HY() throws Throwable {
		manifestCheckPage.click_FilterIconManifestCheck();
	}

	@When("Click Add Notification and add comment as {string}")
	public void add_notification(String value) throws Throwable {
		entryBuildPage.click_addNotification();

		entryBuildPage.set_comments(value);
	}

	@And("Click on Add Notification and add comment for all competencies as {string}")
	public void Add_Notofication(String value) throws InterruptedException {
		entryBuildPage.click_floatNotification();
		Thread.sleep(2500);
		entryBuildPage.set_comments(value);

	}

	@Then("click save button")
	public void save() throws Throwable {
		waitTillElementVisible(entryBuildPage.btnSave);
		entryBuildPage.click_save();
	}

	@Then("Click cancel button")
	public void close() throws Throwable {
		waitTillElementVisible(entryBuildPage.btnClose);
		entryBuildPage.click_close();
	}

	@And("Close the declartion page")
	public void close_declaration() throws Throwable {
		entryBuildPage.click_close();
		Thread.sleep(2000);
	}
	
	@And("Assign the shipment in the GlobalSearch")
	public void assigninGlobalSearch() throws InterruptedException   {
		customerMatchingPage.click_AssignedTo();
		Thread.sleep(2000);
		
	}

	@Then("Verify popup {string}")
	public void verify_popup(String data) throws Throwable {
		waitTillElementVisible(driver.findElement(By.xpath("//div[text()=' " + data + " ']")));
		String mesg = driver.findElement(By.xpath("//div[text()=' " + data + " ']")).getText();
		BaseClass.verifyStringsAreEqual(data.trim(), mesg);
	}

	@And("^Select the shipment with Clearance Scheme HY with blank filter$")
	public void shipment_clearanceScheme_HY_blank_filter() throws Throwable {
		manifestCheckPage.select_filter();
	}

	@And("^Select the shipment with Clearance Scheme XHIGH with blank filter$")
	public void shipment_clearanceScheme_with_XHIGH_blank_filter() throws Throwable {
		manifestCheckPage.select_filterXHIGH();
	}

	@And("^Click on Assign to me$")
	public void assignToMe() throws Throwable {
		manifestCheckPage.click_AssignToMe();
	}

	@And("^Click on Assign to me in TeamLeader List$")
	public void assignTo_teamleader_list() throws Throwable {
		manifestCheckPage.click_AssignToMeTeam();
	}

	@And("^Wait for page to retrieve the user list$")
	public void PageLoad_TeamLeaderList() throws Throwable {
		manifestCheckPage.pageLoader();
	}

	@Then("Select multiple user and submit")
	public void multipleUser() throws Throwable {
		scrollIntoViewUsingJavaScript(entryBuildPage.selectUser);
		for (int i = 1; i <= entryBuildPage.multipleUser.size(); i++) {
			Thread.sleep(2000);
			// entryBuildPage.multipleUser.get(i).click();
			clickElementUsingJavaScript(entryBuildPage.multipleUser.get(i));
			Thread.sleep(2000);
			if (i > 3)
				break;

		}
		waitTillElementVisible(entryBuildPage.btnSave);
		EntryBuildPage.clickElementUsingJavaScript(entryBuildPage.btnSave);
	}

	@And("{string} Alert should be displayed")
	public void _cp_match_alert_should_be_displayed(String alertvalue) throws Throwable {
		entryBuildPage.cpMatch_OverridableAlert(alertvalue);
	}

	@And("^Clear the text in Commodity Description$")
	public void _clear_the_text_in_commodity_description() throws Throwable {
		entryBuildPage.clear_commodityDescription();
	}

	@And("Select the Sort code {string} and unselect the sort code {string}")
	public void _Select_the_Sort_code(String value1, String value2) throws Throwable {
		entryBuildPage.select_sort_message_code(value1, value2);
	}

	@When("^Select TeamLeader List$")
	public void select_teamleader_list() throws Throwable {
		manifestCheckPage.click_TeamleaderList();
	}

	@And("Click on User List")
	public void user_list() throws Throwable {
		Thread.sleep(1000);
		manifestCheckPage.click_UserList();
		Thread.sleep(2000);
	}

	@Then("Get the total record count from the user list")
	public void userList_RecordCount() throws Throwable {
		entryBuildPage.userList_Record_Count();
	}

	@And("Click on team list")
	public void team_list() throws Throwable {
		Thread.sleep(3000);
		waitTillElementVisible(ManifestCheckPage.teamList);
		ManifestCheckPage.teamList.click();

	}

	@SuppressWarnings("static-access")
	@When("Click on team leader list")
	public void teamLeaderlists() throws Throwable {
		manifestCheckPage.teamleaderlist.click();
	}

	@Then("Search the user")
	public void search_user() throws Throwable {
		entryBuildPage.userName.getText();
		Thread.sleep(20000);
		System.out.println("User Name: " + entryBuildPage.userName.getText());
		scrollIntoViewUsingJavaScript(entryBuildPage.memberId);
		Thread.sleep(3000);
		entryBuildPage.memberId.click();
		String[] splitName = entryBuildPage.userName.getText().split(" ");
		entryBuildPage.memberId.clear();
		entryBuildPage.memberId.sendKeys(splitName[0].trim());
	}

	@Then("Select the user and submit")
	public void sel_user() throws Throwable {
		scrollIntoViewUsingJavaScript(entryBuildPage.selectUser);
		entryBuildPage.selectUser.click();
		Thread.sleep(3000);
		waitTillElementVisible(entryBuildPage.btnSave);
		EntryBuildPage.clickElementUsingJavaScript(entryBuildPage.btnSave);
	}

	@And("^User navigates to Customer Matching Competency$")
	public void click_customer_matching_competency() throws Throwable {
		customerMatchingPage.click_CustomerMatchingCompetency();
	}

	@When("Enter the user id to assign the shipment to the user")
	public void typeUser() throws Throwable {
		scrollIntoViewUsingJavaScript(entryBuildPage.memberId);
		entryBuildPage.memberId.clear();
		resourceBundle = ResourceBundle.getBundle("config");
		enterValueIntoTextField1(entryBuildPage.memberId, decodeBase64Value(resourceBundle.getString("Username")));
	}

	@Then("Download {string} document from Image viewer")
	public void TotalThumbnails(String documentName) throws Throwable {
		JavascriptExecutor js = (JavascriptExecutor) driver;
		TotalThumbnails_CustomerInvoice = entryBuildPage.listThumbnails.size();
		if (entryBuildPage.listThumbnails.size() >= 1) {
			for (int i = 0; i < entryBuildPage.listThumbnails.size(); i++) {
				Thread.sleep(2000);
				if (entryBuildPage.listThumbnails.get(i).getText().equalsIgnoreCase(documentName)) {
					WebElement ele = driver.findElement(By.xpath(
							"((//div[contains(@class,'ui-carousel-item')])[1]//following::a[contains(@class,'doc-image')])["
									+ (i + 1) + "]"));
					js.executeScript("arguments[0].click();", ele);
					Thread.sleep(2000);
					entryBuildPage.downloadIcon_ImageViewer.click();
					Thread.sleep(2000);
					break;
				}
			}
		} else {
			Assert.assertFalse(true, "No document available for download ");
		}
	}

	@Then("Delete {string} document from Image viewer")
	public void DeleteThumbnails(String documentName) throws Throwable {
		for (int i = 0; i < entryBuildPage.listThumbnails.size(); i++) {
			Thread.sleep(2000);
			if (entryBuildPage.listThumbnails.get(i).getText().equalsIgnoreCase(documentName)) {
				WebElement ele = driver.findElement(By.xpath(
						"((//div[contains(@class,'ui-carousel-item')])[1]//following::a[contains(@class,'doc-image')])["
								+ (i + 1) + "]"));
				js.executeScript("arguments[0].click();", ele);
				Thread.sleep(2000);
				entryBuildPage.delete_ImageIcon.click();
				waitTillElementVisible(entryBuildPage.ImageViewer_saveIcon);
				// entryBuildPage.ImageViewer_saveIcon.click();
				clickElementUsingJavaScript(entryBuildPage.ImageViewer_saveIcon);
				Thread.sleep(3000);
				manifestCheckPage.click_UserList();
			}
		}

	}

	@Then("Verify the file {string} is successfully downloaded")
	public void fileDownload(String param) throws Throwable {
		verifyDownloadedFile(param);
	}

	@And("^Click on Entry Build Icon$")
	public void click_entry_build_icon() throws Throwable {
		entryBuildPage.click_entry_Build();
	}

	@And("Fetch awb record from the application {string}, {string}, {string}")
	public void fetch_awb_no(String sheetName, String columnName, String rowIndex) throws Throwable {
		excelUtility.writeExcelValue(sheetName, columnName, rowIndex, entryBuildPage.fetchAWB());
	}

	@Given("^User is in Entry Build Module$")
	public void entry_build_module() throws Throwable {
		entryBuildPage.entryBuild_module();
	}

	@When("^Select ACSS Shipments toggle in Entry Build$")
	public void select_ACSS_shipemt_toggle_entry_build() throws Throwable {
		entryBuildPage.click_acssShipmentsEntryBuild();
	}

	@And("^Select ACSS Shipments toggle in EB$")
	public void _select_acss_shipment_toggle_in_eb() throws Throwable {
		entryBuildPage.click_acssShipmentsEB();
	}

	@And("^Filter the AWB number from the Team List which has been Sanity Check Overridden$")
	public void _filter_the_awb_number_from_the_team_list_which_has_been_sanity_check_overridden() throws Throwable {
		entryBuildPage.click_filterEntryBuildCustomerCompetency();
	}

	@And("^Filter the AWB number from the Team List in Customer Computency$")
	public void _filter_the_awb_number_from_the_team_list_in_customer_competency() throws Throwable {
		entryBuildPage.click_filterCustomerCompetency();
	}

	@Then("^The shipment should be in Entry Build page$")
	public void _the_shipment_should_be_in_entry_build_page() throws Throwable {
		entryBuildPage.click_shipmentInEntryBuild();
	}

	@And("^Select the shipment with Clearance Scheme XHIGH Consignee Company and Importer Company$")
	public void _select_the_shipment_with_clearance_scheme_xhigh_consignee_company_and_importer_company()
			throws Throwable {
		manifestCheckPage.click_FilterIconManifestCheckXhigh();
	}

	@And("^Select the shipment with Clearance Scheme LV with truck Consignee Company and Importer Company$")
	public void _select_the_shipment_with_clearance_scheme_lv_with_truck_consignee_company_and_importer_company()
			throws Throwable {
		manifestCheckPage.click_FilterIconManifestCheckLVWithTruck();
	}

	@And("^Select the shipment with Clearance Scheme LV with truck Consignee Company and Importer Company in Entry Build$")
	public void _select_the_shipment_with_clearance_scheme_lv_with_truck_consignee_company_and_importer_company_in_entry_build()
			throws Throwable {
		manifestCheckPage.click_EntryBuildLVWithTruck();
	}

	@And("^Select few shipments$")
	public void _select_few_shipments() throws Throwable {
		customerMatchingPage.select_multipleShipments();
	}

	@When("^Double click on the first shipment$")
	public void _double_click_on_the_first_shipment() throws Throwable {
		customerMatchingPage.doubleClick_shipment();
	}

	@When("^Double click on the first shipment in global Search$")
	public void double_click_on_the_first_shipment_global_Search() throws Throwable {
		customerMatchingPage.doubleClick_GS_shipment();
	}

	@When("^Double click on the first shipment in Global Search$")
	public void _double_click_on_the_first_shipment_in_global_search() throws Throwable {
		customerMatchingPage.doubleClick_shipmentGS();
	}

	@When("^Double click on the second shipment in Global Search$")
	public void _double_click_on_the_second_shipment_in_global_search() throws Throwable {
		customerMatchingPage.doubleClick_SecshipmentGS();
	}

	@And("^User search for Importer and click on the Link Importer icon for all shipments$")
	public void _user_search_for_importer_and_click_on_the_link_importer_icon_for_all_shipments() throws Throwable {
		customerMatchingPage.Link_importer();
	}

	@Then("^Verify message No Data Available once all the competency is updated$")
	public void _verify_message_no_data_available_once_all_the_competency_is_updated() throws Throwable {
		manifestCheckPage.click_UserList();
		Thread.sleep(20000);
		System.out.println("Waiting...");
		customerMatchingPage.text_noDataAvailable();
	}

	@And("^User search for Importer and click on the Multiple Link Importer icon for all shipments$")
	public void _user_search_for_importer_and_click_on_the_multiple_link_importer_icon_for_all_shipments()
			throws Throwable {
		customerMatchingPage.Link_importer_for_Multiple();
	}

	@Then("^Click cancel button of Declaration Page$")
	public void declaration_cancelButton() throws Throwable {
		scrollIntoViewUsingJavaScript(entryBuildPage.btnCancel);
		Thread.sleep(2000);
		entryBuildPage.click_cancel();
	}

	@Then("^Click next button of Declaration Page$")
	public void declaration_nextButton() throws Throwable {
		scrollDownUsingJavaScript();
		clickElementUsingJavaScript(entryBuildPage.nextShipment);
		Thread.sleep(2000);
	}

	@And("Verify next button is Enabled")
	public void enable_nextButton() throws Throwable {
		entryBuildPage.verify_nextButton();

	}

	@And("Verify Save button is Enabled")
	public void enable_saveButton() throws Throwable {
		entryBuildPage.verify_SaveButton();

	}

	@And("Verify next button is Disabled")
	public void disable_nextButton() throws Throwable {
		entryBuildPage.verify_nextButtonDisabled();

	}

	@Then("Validate the selection codes {string},{string} not in Declaration Page")
	public void validate_selection_codes(String data1, String data2) throws Throwable {
		entryBuildPage.selectioncodeNotExist(data1, data2);
	}

	@Then("Click on Sort Message on Floating Panel and select {string}")
	public void add_selectionCode_floatingPanel(String data1) {
		try {
			entryBuildPage.icon_fp();
			// entryBuildPage.icon_selectSelectionCode(data1, data2);
			try {
				if (entryBuildPage.declScreen.isDisplayed())
					entryBuildPage.selectSelectionCode_InDeclaration(data1);
			} catch (NoSuchElementException e) {
				entryBuildPage.selectSelectionCode(data1);
			}

		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}

	@Then("Click on Sort Message in Floating Panel and select {string}")
	public void add_selectionCode_in_floatingPanel(String data1) {
		try {
			entryBuildPage.icon_fp();
			// entryBuildPage.icon_selectSelectionCode(data1, data2);
			try {
				if (entryBuildPage.declScreen.isDisplayed())
					entryBuildPage.selectSelectionCode_InDeclaration(data1);
			} catch (NoSuchElementException e) {
				entryBuildPage.selectSelectionCode(data1);
			}

		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}

	@Then("Click notification from Floating Panel")
	public void add_notification_floatingPanel() {
		try {
			entryBuildPage.icon_fp_notification();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}

	@Then("Add comment as {string}")
	public void add_fp_notification_comment(String value) {
		try {
			entryBuildPage.set_comments(value);
		} catch (ElementNotInteractableException e) {
			entryBuildPage.set_fp_comments(value);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@And("^Select a shipment$")
	public void _select_a_shipment() throws Throwable {

		customerMatchingPage.select_shipment();
	}

	@When("^In Quick Search user click on CLEAR$")
	public void _in_quick_search_user_click_on_clear() throws Throwable {
		customerMatchingPage.clear_search();
	}

	@And("^User enters the Company Name Postal Code and Address then click on GO$")
	public void _user_enters_the_company_name_postal_code_and_address_then_click_on_go() throws Throwable {
		customerMatchingPage.enter_companypostalcode();
	}

	@And("User enters the Company name as {string} and click on GO")
	public void user_enters_the_company_name_as(String name) throws InterruptedException {
		customerMatchingPage.enter_CompanyName(name);

	}

	@Then("^Verify Consignee and Importer match with CP as per the search criteria$")
	public void _verify_consignee_and_importer_match_with_cp_as_per_the_search_criteria() throws Throwable {
		customerMatchingPage.result_consigneeimporter();
	}

	@And("^Modify the clearance mode as GF$")
	public void _modify_the_clearance_mode_as_gf() throws Throwable {
		entryBuildPage.modify_ClearanceSchemeGf();
	}

	@And("^Click on Validate$")
	public void _click_on_validate() throws Throwable {
		entryBuildPage.validate_Button();
	}
	
	@And("Click on the Override button in declaration screen")
	public void click_on_override_button_declaration() throws InterruptedException  {
		entryBuildPage.OverrideAlertsdeclscreen();
		
	}

	@And("^LV Truck G7 overridable alert should be displayed$")
	public void _lv_truck_g7_overridable_alert_should_be_displayed() throws Throwable {
		entryBuildPage.lvTruckG7_OverridableAlert();
	}

	@And("^Click on Team List and assign any XHigh shipment$")
	public void _click_on_team_list_and_assign_any_xhigh_shipment() throws Throwable {
		manifestCheckPage.click_XhighEntryBuild();
	}

	@And("^Select Clearance status as Unworked$")
	public void _select_clearance_status_as_unworked() throws Throwable {
		entryBuildPage.select_unworked();
	}

	@And("^Verify Shipment details$")
	public void _verify_shipment_details() throws Throwable {
		entryBuildPage.Shipment_details();
	}

	@And("^Update the total value$")
	public void _update_the_total_value() throws Throwable {
		entryBuildPage.update_totalValue();
	}

	@And("^Double Click on Commodity details$")
	public void _double_click_on_commodity_details() throws Throwable {
		entryBuildPage.DoubleClick_commodityDetails();
	}

	@And("^Verify if GST and CIF value is above$")
	public void _verify_if_gst_and_cif_value_is_above() throws Throwable {
		entryBuildPage.verify_GIFCIFValue();
	}

	@And("^CIF and GIF Alerts should be displayed$")
	public void _cif_and_gif_alerts_should_be_displayed() throws Throwable {
		entryBuildPage.cifgif_OverridableAlert();
	}

	@And("^Search some shipments from global search with comma separated$")
	public void _search_some_shipments_from_global_search_with_comma_seperated() throws Throwable {
		manifestCheckPage.read_shipments();
		manifestCheckPage.click_globalSearch();
		manifestCheckPage.entervalue_globalSearch();
		manifestCheckPage.click_globalSearchButton();
	}

	@Given("^Search some random shipments from global search with comma separated$")
	public void _search_some_random_shipments_from_global_search_with_comma_seperated() throws Throwable {
		manifestCheckPage.click_globalSearch();
		manifestCheckPage.click_globalSearchButton();
	}

	@And("^Click on the first shipment$")
	public void _click_on_the_first_shipment() throws Throwable {
		manifestCheckPage.select_firstshipment();
	}

	@And("^Click sort message$")
	public void _click_sort_message() throws Throwable {
		manifestCheckPage.click_SortMessage();
	}

	@And("^Click sort message in floating panel$")
	public void _click_sort_message_in_floating_panel() throws Throwable {
		manifestCheckPage.click_SortMessageConveyance();
	}

	@And("^Click on the sort Icon for Sort Description for Ascending and Descending order$")
	public void _click__on_the_sort_icon_for_sort_description_for_ascending_and_descending_order() throws Throwable {
		manifestCheckPage.click_SortDescriptionAscDes();
	}

	@And("^Save the AWB from the UserList$")
	public void _save_the_awb_from_the_userList() throws Throwable {
		entryBuildPage.save_AWB();
	}

	@And("Assign {string} sort codes to the shipment")
	public void _assign_invic_sort_codes_to_the_shipment(String SortCode) throws Throwable {
		manifestCheckPage.assign_invicSortCodes(SortCode);
	}

	
	@And("Assign Multiplesortcodes {string} sort codes to the shipment")
	public void _assign_multiple_sort_codes_to_the_shipment(String SortCode) throws Throwable {
		manifestCheckPage.assign_multipleSortCodes(SortCode);
	}
	@And("^Unselect all sort codes$")
	public void _unselect_all_sort_codes() throws Throwable {
		manifestCheckPage.Unselect_allsortcodes();
	}

	@And("^Click Sort Message Save button$")
	public void _click_sort_message_save_button() throws Throwable {
		manifestCheckPage.save_sortCodes();
	}

	@And("^User select all the shipments in Grid$")
	public void _user_select_all_the_shipments_in_grid() throws Throwable {
		manifestCheckPage.select_allShipmentsInGrid();
	}

	@And("^Unselect all the shipments in Grid$")
	public void _unselect_all_the_shipments_in_grid() throws Throwable {
		manifestCheckPage.unselect_allShipmentsInGrid();
	}

	@And("^Add multiple sort codes$")
	public void _add_multiple_sort_codes() throws Throwable {
		manifestCheckPage.add_multipleSortCodes();
	}

	@And("^Click on Add button in Sort Message$")
	public void _click_on_add_button_in_sort_message() throws Throwable {
		manifestCheckPage.add_sortCodes();
	}

	@And("^Click on Add button in Sort Message popup$")
	public void _click_on_add_button_in_sort_message_popup() throws Throwable {
		manifestCheckPage.add_sortCodesPopup();
	}

	@And("^Close Shipment Search$")
	public void _close_shipment_search() throws Throwable {
		manifestCheckPage.close_shipmentSearch();
		Thread.sleep(5000);
	}

	@And("^Verify the sort codes in Team List$")
	public void _verify_the_sort_codes_in_team_list() throws Throwable {
		entryBuildPage.verify_sortCodesInTeamList();
	}

	@Then("^Filter the AWB number and verify the sort codes are added$")
	public void _filter_the_awb_number_and_verify_the_sort_codes_are_added() throws Throwable {
		// entryBuildPage.verify_addedSortCodesInMC();
		String headerval = "";
		entryBuildPage.tblHeaderlabels.size();
		System.out.println("Header Size : " + entryBuildPage.tblHeaderlabels.size());
		for (int i = 1; i < entryBuildPage.tblHeaderlabels.size(); i++) {
			headerval = driver
					.findElement(By.xpath("((//datatable-header-cell/div/div)/table)[" + i + "]/tr/th[1]/span"))
					.getText();
			if (headerval.trim().equalsIgnoreCase("AWB Number")) {
				applicationFunctions.click_Filter_Icon("AWB Number");
				log.info(GlobalSearchPage.FirstAWBGS);
				applicationFunctions.set_Filter_Value(GlobalSearchPage.FirstAWBGS);
				applicationFunctions.close_Filter();
				// break;
			}
		}

	}

	@Then("^Filter the AWB number and verify the sort codes are added in entry build$")
	public void _filter_the_awb_number_and_verify_the_sort_codes_are_added_in_entry_build() throws Throwable {
		manifestCheckPage.verify_addedSortCodesInEB();
	}

	@Then("^Filter the AWB number in MC and verify the sort codes are added$")
	public void _filter_the_awb_number_in_MC_and_verify_the_sort_codes_are_added() throws Throwable {
		manifestCheckPage.verify_addedrandomSortCodesInMC();
	}

	@When("^Select ATFC Select Customers toggle$")
	public void _select_atfc_select_customers_toggle() throws Throwable {
		entryBuildPage.ATFCSelectCustomers_module();
	}

	@When("^Select ACCS Shipments toggle$")
	public void _select_accs_shipments_toggle() throws Throwable {
		entryBuildPage.ACCSShipments_module();
	}

	@When("^Select Company Audit toggle$")
	public void _select_company_audit_toggle() throws Throwable {
		entryBuildPage.CompanyAudit_module();
	}

	@When("^Select CDN toggle$")
	public void _select_cdn_toggle() throws Throwable {
		entryBuildPage.cdn_module();
	}

	@When("^Select EDI Ready toggle$")
	public void _select_edi_ready_toggle() throws Throwable {
		entryBuildPage.ediReady_module();
	}

	@When("^Select EDI Reject toggle$")
	public void _select_edi_reject_toggle() throws Throwable {
		entryBuildPage.ediReject_module();
	}

	@When("^Select EDI Complete toggle$")
	public void _select_edi_complete_toggle() throws Throwable {
		entryBuildPage.ediComplete_module();
	}

	@When("^Select High GST Team toggle$")
	public void _select_high_gst_team_toggle() throws Throwable {
		entryBuildPage.highGST_module();
	}

	@When("^Select SG toggle$")
	public void _select_sg_toggle() throws Throwable {
		entryBuildPage.SG_module();
	}

	@When("^Select ATFC toggle$")
	public void _select_atfc_toggle() throws Throwable {
		entryBuildPage.ATFC_module();
	}

	@When("^Select HVU Ready toggle$")
	public void _select_hvu_ready_toggle() throws Throwable {
		entryBuildPage.HVUReady_module();
	}

	@When("^Select TN Cage toggle$")
	public void _select_tn_cage_toggle() throws Throwable {
		entryBuildPage.TNCage_module();
	}

	@When("^Select MOW toggle$")
	public void _select_mow_toggle() throws Throwable {
		manifestCheckPage.mow_module();
	}

	@When("^Select PHANTOM NOT ETD toggle$")
	public void _select_phantom_not_etd_toggle() throws Throwable {
		manifestCheckPage.phantomNotETD_module();
	}

	@When("^Select Exception toggle$")
	public void _select_exception_toggle() throws Throwable {
		manifestCheckPage.Exception_module();
	}

	@When("^Select SG Select Customers toggle$")
	public void _select_sg_select_customers_toggle() throws Throwable {
		entryBuildPage.SGSelectCustomers_module();
	}

	@And("^Click on rework shipment$")
	public void _click_on_rework_shipment() throws Throwable {
		entryBuildPage.rework_Shipment();
	}

	@And("^Select all the shipments from the grid$")
	public void _select_all_the_shipments_from_the_grid() throws Throwable {
		entryBuildPage.Select_AllToggle();
	}

	@And("^Unselect Default toggle$")
	public void _unselect_default_toggle() throws Throwable {
		entryBuildPage.default_module();
	}

	@And("^Click on Global Search Icon$")
	public void _click_on_global_search_icon() throws Throwable {
		manifestCheckPage.click_globalSearch();
	}

	@And("Click on Global search icon")
	public void click_globalSearch_icon() throws Exception {
		globalSearchPage = new GlobalSearchPage(driver);
		globalSearchPage.click_entryGlobalSearch();
	}

	@Then("Search the shipment {string}, {string}, {string} in Global Search popup")
	public void global_search(String sheetName, String columnName, String rowIndex)
			throws InterruptedException, IOException {
		globalSearchPage.enter_shipmentValue(excelUtility.readExcelValue(sheetName, columnName, rowIndex));
		Thread.sleep(3000);
		globalSearchPage.click_entryShipmentSearch();
	}

	@And("Verify Scans is equal to N$")
	public void verify_scans_is_equal_to_n() throws Throwable {
		manifestCheckPage.verify_FailureReasonScans();
	}

	@And("^Select the shipment with HUAWEI Consignee Company$")
	public void _select_the_shipment_with_huawei_consignee_company() throws Throwable {
		entryBuildPage.click_FilterHUAWEI();
	}

	@And("^Scroll the page upwards$")
	public void _scroll_the_page_upwards() throws Throwable {
		entryBuildPage.scroll_up();
	}

	@And("Verify user is in userlist")
	public void verify_user_is_in_userlist() throws Throwable {
		Thread.sleep(1000);
		if (entryBuildPage.cancelDeclaration.isDisplayed()) {
			entryBuildPage.cancel_declaration();
		}
	}

	@And("Cancel the Decalaration$")
	public void cancel_the_declaration() throws Throwable {
		entryBuildPage.cancel_declaration();
	}

	@And("^Verify HS Code Multimatch Icon is displayed$")
	public void _verify_hs_code_multimatch_icon_is_displayed() throws Throwable {
		entryBuildPage.verify_HSCodeMultimatchIcon();
	}

	@And("Search and Link the Importer under Customer Information using company name {string}")
	public void _search_and_link_the_importer_under_customer_information_using_company_name(String CompanyName)
			throws Throwable {
		entryBuildPage.SearchImporter_LinkImporter(CompanyName);
	}

	@And("Search and Link the Consignee under Customer Information using company name {string}")
	public void _search_and_link_the_consignee_under_customer_information_using_company_name(String CompanyName)
			throws Throwable {
		entryBuildPage.SearchConsignee_LinkImporter(CompanyName);
	}

	@Then("^Verify image roles having prefix dev is added for all the SG roles$")
	public void _verify_image_roles_having_prefix_dev_is_added_for_all_the_sg_roles() throws Throwable {
		entryBuildPage.ContextMenu_dropdown();
	}

	@And("^Search and Link the Consignee under Customer Information$")
	public void _search_and_link_the_consignee_under_customer_information() throws Throwable {
		entryBuildPage.SearchConsignee_LinkImporter();
	}

	@And("^Input the HS code and Select the HS code through Search Icon$")
	public void _input_the_hs_code_and_select_the_hs_code_through_search_icon() throws Throwable {
		entryBuildPage.HSCode_Delete();
		entryBuildPage.InputHSCode_SearchHSCode();

	}

	@And("^Verify HS Code Match Icon$")
	public void _verify_hs_code_natch_icon() throws Throwable {
		entryBuildPage.verify_HSCodeMatchIcon();
	}

	@And("^Read all the AWB Numbers$")
	public void _read_all_the_awb_numbers() throws Throwable {
		entryBuildPage.Read_AWBNumbers();
	}

	@And("^Compare the AWB Numbers in Declaration Screen$")
	public void _compare_the_awb_numbers_in_declaration_screen() throws Throwable {
		entryBuildPage.Verify_AWBNumbers();
	}

	@And("Validate the AWB number {string}, {string}, {string} in Declaration screen")
	public void validate_AWB_in_declaration_page(String sheetName, String columnName, String rowIndex)
			throws InterruptedException, IOException {
		Thread.sleep(2500);
		String awbInScreen = entryBuildPage.AWBNumberDeclarationScreen.getText().split(" ")[1];
		String awbExpected = excelUtility.readExcelValue(sheetName, columnName, rowIndex);
		Assert.assertEquals(awbInScreen, awbExpected);

	}

	@Then("Save first AWB number from grid in {string}, {string}, {string}")
	public void save_first_AWBnumber_from_grid(String sheetName, String columnName, String rowIndex) throws Throwable {
		Thread.sleep(2500);
		String searchText = EntryBuildPage.firstRecordAWB.getText();
		System.out.println("searchText" + searchText);
		if (!searchText.equalsIgnoreCase(""))
			excelUtility.writeExcelValue(sheetName, columnName, rowIndex, searchText);
	}

	@Then("Save two AWB numbers from grid in {string}, {string}, {string}")
	public void save_first2_AWBnumbers_from_grid(String sheetName, String columnName, String rowIndex)
			throws Throwable {
		Thread.sleep(2000);
		String searchText = EntryBuildPage.firstRecordAWB.getText() + "," + EntryBuildPage.SecondRecordAWB.getText();
		System.out.println("searchText" + searchText);
		if (!searchText.equalsIgnoreCase(","))
			excelUtility.writeExcelValue(sheetName, columnName, rowIndex, searchText);
	}

	@And("^Verify if commodity description is same as previous shipment$")
	public void _verify_if_commodity_description_is_same_as_previous_shipment() throws Throwable {
		entryBuildPage.Verify_CommodityDescription();
	}

	@And("^Click Next in Commodity Description Page$")
	public void _click_next_in_commodity_description_page() throws Throwable {
		entryBuildPage.click_next();
	}

	@And("^Verify added and removed locations$")
	public void _verify_added_and_removed_locations() throws Throwable {
		entryBuildPage.COM_dropdownvalues();
	}

	@And("^Read the Clearance mode$")
	public void _read_the_clearance_mode() throws Throwable {
		entryBuildPage.Read_ClearanceMode();
	}

	@And("Validate Bill Duty to Account Location {string}")
	public void _validate_bill_duty_to_account_location(String AccountLocation) throws Throwable {
		entryBuildPage.verify_BillDuty(AccountLocation);
	}

	@And("Validate Bill Duty to Account Location is not {string}")
	public void _validate_bill_duty_to_account_location_is_not(String AccountLocation) throws Throwable {
		entryBuildPage.verify_NotBillDuty(AccountLocation);
	}

	@And("Validate Incoterm Field value {string}")
	public void _validate_incoterm_field_value(String IncoTerm) throws Throwable {
		entryBuildPage.verify_IncoTerm(IncoTerm);
	}

	@And("Verify the Clearance Mode in the dropdown as {string}")
	public void _verify_the_clearance_mode_in_the_dropdown_as(String ClearanceModeDD) throws Throwable {
		entryBuildPage.verify_ClearanceModeDD(ClearanceModeDD);
	}

	@And("Verify the Clearance Mode is updated changed after customer link")
	public void _verify_the_clearance_mode_is_updated_changed_after_customer_link() throws Throwable {
		entryBuildPage.verify_ClearanceModeafterChange();
	}

	@And("^Verify the Clearance Mode remains unchanged$")
	public void _verify_the_clearance_mode_remains_unchanged() throws Throwable {
		entryBuildPage.verify_ClearanceModeUnchanged();
	}

	@And("^Verify the Clearance Mode shoud be changed$")
	public void _verify_the_clearance_mode_should_be_changed() throws Throwable {
		entryBuildPage.verify_ClearanceModechanged();
	}

	@And("^Verify if Declaration Information text is displayed with purple color and bold letters$")
	public void _verify_if_declaration_information_text_is_displayed_with_purple_color_and_bold_letters()
			throws Throwable {
		entryBuildPage.verify_DeclarationInformationText();
	}

	@And("^Validate Importer Instructions text field in Declaration information section$")
	public void _validate_importer_instructions_text_field_in_declaration_information_section() throws Throwable {
		entryBuildPage.verify_ImporterInstructionsTextField();
	}

	@And("^Validate Shipment Description text field in Declaration information section$")
	public void _validate_shipment_description_text_field_in_declaration_information_section() throws Throwable {
		entryBuildPage.verify_ShipmentDescriptionTextField();
	}

	@And("^Validate Clearance mode drop down in Declaration information section$")
	public void _validate_clearance_mode_dropdown_in_declaration_information_section() throws Throwable {
		entryBuildPage.verify_ClearanceModeDropdown();
	}

	@And("^Validate Clearance Scheme drop down in Declaration information section$")
	public void _validate_clearance_scheme_dropdown_in_declaration_information_section() throws Throwable {
		entryBuildPage.verify_ClearanceSchemeDropdown();
	}

	@And("^Validate Incoterm drop down in Declaration information section$")
	public void _validate_incoterm_drop_down_in_declaration_information_section() throws Throwable {
		entryBuildPage.verify_IncotermDropdown();
	}

	@And("^Validate Total Value text field in Declaration information section$")
	public void _validate_total_value_text_field_in_declaration_information_section() throws Throwable {
		entryBuildPage.verify_TotalValue();
	}

	@And("^Validate Currency drop down in Declaration information section$")
	public void _validate_currency_drop_down_in_declaration_information_section() throws Throwable {
		entryBuildPage.verify_CurrencyDropDown();
	}

	@And("^Validate Weight text field in Declaration information section$")
	public void _validate_weight_text_field_in_declaration_information_section() throws Throwable {
		entryBuildPage.verify_WeightTextField();
	}

	@And("^Validate Bill duty to Code in Declaration information section$")
	public void _validate_bill_duty_to_code_in_declaration_information_section() throws Throwable {
		entryBuildPage.verify_BillDutyToCode();
	}

	@And("^Validate Transport Bill to Code in Declaration information section$")
	public void _validate_transport_bill_to_code_in_declaration_information_section() throws Throwable {
		entryBuildPage.verify_Transport();
	}

	@And("^Validate Xrate in Declaration information section$")
	public void _validate_xrate_in_declaration_information_section() throws Throwable {
		entryBuildPage.verify_XRateField();
	}

	@And("^Validate CIF in Declaration information section$")
	public void _validate_cif_in_declaration_information_section() throws Throwable {
		entryBuildPage.verify_CIFField();
	}

	@And("^Validate GST in Declaration information section$")
	public void _validate_gst_in_declaration_information_section() throws Throwable {
		entryBuildPage.verify_GSTField();
	}

	@And("^Validate PKG in Declaration information section$")
	public void _validate_pkg_in_declaration_information_section() throws Throwable {
		entryBuildPage.verify_pkgField();
	}

	@And("^Validate Insurance in Declaration information section$")
	public void _validate_insurance_in_declaration_information_section() throws Throwable {
		entryBuildPage.verify_InsuranceField();
	}

	@And("^Validate Freight in Declaration information section$")
	public void _validate_freight_in_declaration_information_section() throws Throwable {
		entryBuildPage.verify_FreightField();
	}

	@And("^Validate Selection Code in Declaration information section$")
	public void _validate_selection_code_in_declaration_information_section() throws Throwable {
		entryBuildPage.verify_SelectionCodeField();
	}

	@And("^Validate the location information field whether field number and mode of transport are displaying$")
	public void _validate_the_location_information_field_whether_field_number_and_mode_of_transport_are_displaying()
			throws Throwable {
		entryBuildPage.verify_LocationInformation();
	}

	@And("^Verify Total Value field value and the text box are highlighed with different colour$")
	public void _verify_total_value_field_value_and_the_text_box_are_highlighted_with_different_colour()
			throws Throwable {
		entryBuildPage.verify_TotalValueField();
	}

	@And("Enter Commodity Description {string}")
	public void _enter_commodity_description(String CommodityDescription) throws Throwable {
		entryBuildPage.Enter_CommodityDescription(CommodityDescription);
	}

	@And("^Select the shipment with EDI Ready Clearance Status$")
	public void _select_the_shipment_with_edi_ready_clearance_status() throws Throwable {
		entryBuildPage.click_FilterEDIReady();
	}

	@And("Select the shipment with {string} Clearance Status")
	public void _select_the_shipment_with_clearance_status(String ClearanceStatusUserList) throws Throwable {
		entryBuildPage.click_FilterEDIReady(ClearanceStatusUserList);
	}

	@And("Verify Clearance Status as {string}")
	public void _verify_clearance_status_as(String ClearanceStatus) throws Throwable {
		entryBuildPage.verify_ClearanceStatus(ClearanceStatus);
	}

	@And("Verify Consignee Company Name contains {string}")
	public void verify_consignee_company_name_contains(String ConsigneeCompany) throws Throwable {
		entryBuildPage.verify_ConsigneeCompany(ConsigneeCompany);
	}

	@And("Verify Consignee Company Name$")
	public void verify_consignee_company_name() throws Throwable {
		entryBuildPage.verify_ConsigneeCompanySG();
	}

	@And("Close Global Search Window$")
	public void _close_global_search_window() throws Throwable {
		entryBuildPage.globalSearch_close();
	}

	@And("Verify Consignee Company Name does not contain {string}")
	public void verify_consignee_company_name__does_not_contain(String ConsigneeCompany) throws Throwable {
		entryBuildPage.verify_ConsigneeCompanyNot(ConsigneeCompany);
	}

	@And("Verify Clearance Scheme is not equal to {string}")
	public void verify_clerance_scheme_is_not_equal_to(String ClearanceScheme) throws Throwable {
		entryBuildPage.verify_ClearanceSchemeNot(ClearanceScheme);
	}

	@And("Verify Clearance location is equal to {string}")
	public void verify_clerance_location_is_equal_to(String ClearanceLocation) throws Throwable {
		entryBuildPage.verify_ClearanceLocation(ClearanceLocation);
	}

	@And("Verify Clearance Mode is not equal to {string}")
	public void verify_clearance_mode_is_not_equal_to(String ClearanceMode) throws Throwable {
		entryBuildPage.verify_ClearanceModeNot(ClearanceMode);
	}

	@And("Verify Clearance Mode is equal to {string}")
	public void verify_clearance_mode_is_equal_to(String ClearanceMode) throws Throwable {
		entryBuildPage.verify_ClearanceMode(ClearanceMode);
	}

	@And("Verify Selection Code is equal to {string}")
	public void _verify_selection_code_is_equal_to(String SelectionCode) throws Throwable {
		entryBuildPage.verify_SelectionCode(SelectionCode);
	}

	@And("Verify Team is equal to {string}")
	public void _verify_team_is_equal_to(String team) throws Throwable {
		entryBuildPage.verify_EDI_CompleteTeam(team);
	}

	@And("Verifying Teamname is equal to {string}")
	public void _verify_team_is_equal_to_DTQ(String team) throws Throwable {
		entryBuildPage.verify_DTQ_Assigned(team);
	}
	
	@And("Verify Auto EDI Flag is equal to {string}")
	public void _verify_auto_edi_flag_is_equal_to(String EDIFlag) throws Throwable {
		entryBuildPage.verify_AutoEDIFlag(EDIFlag);
	}

	@And("Verify Selection Code is not equal to {string}")
	public void verify_selection_code_is_not_equal_to(String SelectionCode) throws Throwable {
		entryBuildPage.verify_SelectionCodeNot(SelectionCode);
	}

	@And("Verify Commodity category is equal to {string}")
	public void verify_commodity_group_is_equal_to(String CommodityGroup) throws Throwable {
		entryBuildPage.verify_CommodityGroup(CommodityGroup);
	}

	@When("^User click Column Configuration$")
	public void _user_click_column_configuration() throws Throwable {
		entryBuildPage.ColumnConfiguration_threeDots();
	}

	@And("^Click on Consignee Company MDE$")
	public void _click_on_consignee_company_mde() throws Throwable {
		entryBuildPage.ConsigneeCompany_MDE();
	}

	@And("^Click on IOR in Column Configuration$")
	public void _click_on_ior_in_column_configuration() throws Throwable {
		entryBuildPage.Column_IOR();
	}

	@And("^Click on Save button in Column Configuration$")
	public void _click_on_save_button_in_column_configuration() throws Throwable {
		entryBuildPage.click_save();
	}

	@Then("^Verify Consignee Company MDE in shipment results$")
	public void _verify_consignee_company_mde_in_shipment_results() throws Throwable {
		entryBuildPage.ConsigneeCompanyMDE_ShipmentResults();
	}

	@Then("Verify FedEx Account for Charges in shipment result")
	public void _verify_Fedex_Account_for_Charges_in_shipment_results() throws Throwable {
		entryBuildPage.FedExAccountforChargesShipmentResults();
	}
	
	@Then("^Verify column IOR in shipment results$")
	public void _verify_column_ior_in_shipment_results() throws Throwable {
		entryBuildPage.IOR_ShipmentResults();
	}

	@When("^User click on Team Leader List$")
	public void _user_click_on_team_leader_list() throws Throwable {
		manifestCheckPage.click_TeamleaderList();
	}

	@And("^Unassign the Shipment$")
	public void _unassign_the_shipment() throws Throwable {
		entryBuildPage.unassign_shipment();
		Thread.sleep(5000);
	}

	@Then("Click on Unassign icon but shipments should be display")
	public void click_on_unassign_but_shipments_should_display() throws InterruptedException {
		entryBuildPage.Verify_shipmentsDisplayed();

	}

	@And("Click on all Icons in the Grid")
	public void click_on_all_icons_grid() throws InterruptedException {
		entryBuildPage.Click_grid_Icons();
		Thread.sleep(3000);

	}

	@Then("^ROAD option should not be displayed in Clearance Mode$")
	public void ROAD_Option() throws Throwable {
		entryBuildPage.clearanceMode_validate();
	}

	@And("Select the Clearance Mode in Decalaration as {string}")
	public void Select_the_Clearance_Mode(String Value) throws InterruptedException {
		entryBuildPage.select_ClearanceMode(Value);
	}

	@And("Mode of transport in Declaration is {string}")
	public void Mode_of_transport_in_Declaration(String Value) throws InterruptedException {
		entryBuildPage.mode_of_transport(Value);
	}

	@And("Max Length of OVR Registration No. should be {string}")
	public void Length_of_OVR_Registration(String Value) throws InterruptedException {
		entryBuildPage.OVRRegsitation_length(Value);
	}

	@And("Verify OVR Registration No. is retrieved")
	public void Verify_OVR_Registratio_No_retrieved() throws InterruptedException {
		entryBuildPage.verify_OVR_Registration();

	}

	@Then("OVR Registration No. should be enabled")
	public void OVR_Registration_No_Enabled() throws InterruptedException {
		entryBuildPage.OVR_enabled("yes");
	}

	@Then("OVR Registration No. should be disabled")
	public void OVR_Registration_No_disabled() throws InterruptedException {
		entryBuildPage.OVR_enabled("no");
	}

	@Then("GST Paid should be enabled")
	public void GST_Paid_enabled() throws InterruptedException {
		entryBuildPage.GSTPaid_enabled("yes");
	}

	@Then("GST Paid should be disabled")
	public void GST_Paid_diabled() throws InterruptedException {
		entryBuildPage.GSTPaid_enabled("no");
	}

	@Then("Previous Value of GST Paid should be Retained")
	public void Previous_Value_of_GST() throws InterruptedException {
		entryBuildPage.GSTPaid_previousValue();
	}

	@Then("No Alert should be displayed in Declaration screen")
	public void No_Alert() throws InterruptedException {
		entryBuildPage.no_alert_validation();
	}

	@And("^Create new commodity details")
	public void _create_new_commodity_details() throws Throwable {
		entryBuildPage.create_and_modify_new_Commodity_details();

	}

	@And("Add the sort code {string} and save it succesfully in Declaration Page")
	public void AddSort_Declaration(String srtCodes) throws InterruptedException {
		// try {
		// entryBuildPage.icon_fp();
		try {
			if (entryBuildPage.declScreen.isDisplayed())
				;

			boolean blnSortCodeAdded = entryBuildPage.add_sortCode_declaration_page(srtCodes, "add");

		} catch (NoSuchElementException e) {
			entryBuildPage.add_sortCode_declaration(srtCodes, "add");
		}
		/*
		 * if (blnSortCodeAdded) { manifestCheckPage.verifyToasterMessage(); }
		 */
		// }
		catch (InterruptedException e) {
			e.printStackTrace();
		}
	}

	@And("Remove the sort code {string} and save it succesfully in Declaration Page")
	public void RemoveSort_Declaration(String srtCodes) throws InterruptedException {
		/*boolean blnSortCodeAdded = entryBuildPage.add_sortCode_declaration(srtCodes, "remove");
		
		 * if (blnSortCodeAdded) { manifestCheckPage.verifyToasterMessage(); }
		 */
	}

	@And("Toggle sort code {string} from floating panel and save it")
	public void Toggle_sort_code_from_floating_panel(String srtCodes) throws InterruptedException {
		boolean blnSortCodeAdded = entryBuildPage.add_sortCode_declaration(srtCodes, "no");
		if (blnSortCodeAdded) {
			manifestCheckPage.verifyToasterMessage();
		}
	}

	@And("Check the GST is {string} than {string}")
	public void CheckGST(String GreaterLesserEqual, String GSTValue) throws InterruptedException {
		entryBuildPage.check_GST_declaraion(GreaterLesserEqual, GSTValue);
	}

	@And("Select the consignee in declaration as {string}")
	public void Select_Consignee(String Name) throws InterruptedException {
		entryBuildPage.addConsigneeInDeclaration(Name);
		// manifestCheckPage.verifyToasterMessage();
	}

	@And("Select the importer in declaration as {string}")
	public void Select_Importer(String Name) throws InterruptedException {
		entryBuildPage.addImporterInDeclaration(Name);
		// manifestCheckPage.verifyToasterMessage();
	}

	@Then("Clear the Overridable Alerts")
	public void Overridale_Alert() throws InterruptedException {
		entryBuildPage.clearOverideAlerts();
	}

	@And("{string} Team Toggle Should be {string}")
	public void ToggleCheck(String teamName, String ONOFF) throws InterruptedException {
		entryBuildPage.checkToggleofTeam(teamName, ONOFF);
	}

	@Then("Cycle Date and Cycle Number should be generated for the record")
	public void Validate_Cycle_Record_Present() throws InterruptedException {
		AddColumn_InGrid("Cycle Number,Cycle Date");
		entryBuildPage.cycleDataPresent();
	}

	@And("Clear HSCode required alert")
	public void Clear__HSCODE_Alert() throws InterruptedException {
		entryBuildPage.clearHSCodeAlert();
	}

	@And("Clear CAGE Mode Required Alert")
	public void CAGE_Mode_Required_Alert() throws InterruptedException {
		boolean blndisplayed = false;
		blndisplayed = entryBuildPage.clearCAGEModelert();
		if (blndisplayed) {
			manifestCheckPage.verifyToasterMessage();
		}
	}

	@And("Click on the Submit HVU Shipment")
	public void Click_HVU_Submit() throws InterruptedException {
		entryBuildPage.clickHVUSubmit();

	}

	/*
	 * @Then ("Clearance Status in declaration screen should be {string}") public
	 * void Toaster_message_Validation(String strValue) throws InterruptedException
	 * { entrybuild.clearanceStatusInDeclaraion(strValue); }
	 */
	@And("Add the Column {string} in the grid")
	public void AddColumn_InGrid(String srtCodes) throws InterruptedException {
		boolean blnColumnAdded = entryBuildPage.addColumn_InCC(srtCodes);
		if (blnColumnAdded) {
			manifestCheckPage.verifyToasterMessage();
		}
	}

	@And("Click on Activity log in floating panel")
	public void Click_Activity_log() throws InterruptedException {
		entryBuildPage.click_floatActivityLog();

	}

	@And("Click on activity log and download")
	public void Click_activity_download() throws InterruptedException {
		entryBuildPage.click_floatActivityLog();
		entryBuildPage.Activity_download();

	}

	@And("Click on Activity log")
	public void click_on_Activity_log() throws InterruptedException {
		entryBuildPage.click_ActivityLog();
	}

	@And("Click on Activity log in Declaration page")
	public void click_on_Activity_log_in_Declaration_page() throws InterruptedException {
		entryBuildPage.click_ActivityLogDecl();
	}

	@And("Close the activity log popup")
	public void Close_Activity_log() throws InterruptedException, AWTException {
		entryBuildPage.closefloatActivityLog();
	}

	@And("Verify the activity log is displyed with {string}")
	public void Verify_Activity_log(String activityVal) throws InterruptedException {
		entryBuildPage.activityLogCheck(activityVal);
	}

	@And("Verify the activity log is displyed with sort code {string}")
	public void verify_Activity_log_is_displayed_with_sort_code(String activityVal) throws InterruptedException {
		entryBuildPage.activityLog(activityVal);
	}

	@And("Unassign all the shipments in user list")
	public void Unassign_All_Shipments() throws InterruptedException {
		// boolean blnUnassigned = entryBuildPage.unassignAllShipment();
		entryBuildPage.unassignAllShipment();
		Thread.sleep(1000);
		/*
		 * if (blnUnassigned) { manifestCheckPage.verifyToasterMessage(); }
		 */
	}

	@And("Click on Cycle changes")
	public void CycleChange_Click() throws InterruptedException {
		entryBuildPage.clickCycleChanges();
	}

	@SuppressWarnings("static-access")
	@And("Click on teamlist")
	public void teamlist_click() throws InterruptedException {
		clickElementUsingJavaScript(manifestCheckPage.teamList);

	}
	

	@When("Set the Cycle Date and select the Cycle number {string}")
	public void set_the_cycle_date_incremented_by_and_select_the_cycle_number(String strCycNum)
			throws InterruptedException {
		entryBuildPage.setCycleDate(1);
		entryBuildPage.selectCycleNumber(strCycNum);
		Thread.sleep(2000);
	}

	@And("Click on Save Cycle Changes")
	public void click_on_save_cycle_changes() throws InterruptedException {
		entryBuildPage.click_floatUploadSave();
	}

	@Then("Click on Save in Cycle Change")
	public void click_on_save_cycle_changes_new() throws InterruptedException {
		entryBuildPage.click_floatUploadSaveNew();
	}

	@And("Cycle changes button should be disabled in the floating panel")
	public void cycle_changes_button_should_be_disabled() throws InterruptedException {
		entryBuildPage.CycleChangeDisabled();
	}

	@And("Select EDI Ready toggle in team leader list$")
	public void _select_edi_ready_toggle_in_team_leader_list() throws Throwable {
		entryBuildPage.click_EDIReadyTeamleader();
	}

	@And("Click on Cycle changes in the floating panel")
	public void CycleChange_Click_floasting_panel() throws InterruptedException {
		entryBuildPage.clickCycleChangesFloatingPanel();
	}

	@And("Select the Shipment in team leader list")
	public void select_shipment_team_leader_list() throws InterruptedException {
		entryBuildPage.selectShipmentTeamLeaderList();
	}

	@And("Click on the Console Submission")
	public void Click_Console_Submission() throws InterruptedException {
		entryBuildPage.clickConsoleSubmission();
	}

	@When("Select Cycle Date and select the record with cycle Date {string}")
	public void Select_cycle_date_incremented_by(String cycleDate) throws InterruptedException {
		entryBuildPage.setCycleDate(1);
		entryBuildPage.selectRecConsoleSubmissionwithCycleNumber(cycleDate);
	}

	@When("Verify the HAWB is greater than {int}")
	public void verify_HAWB_Count(int count) throws InterruptedException {
		entryBuildPage.verifyHAWBCount(count);
	}

	@And("Submit the Console Submission")
	public void Submit_Console_Submission() throws InterruptedException {
		entryBuildPage.submitDeclaration();
	}

	@And("Toaster message should be displayed with cycle Date and Cycle number")
	public void Toaster_For_Console_Submit() throws InterruptedException {
		manifestCheckPage.toasterMessageValidation("Selected cycle date " + entryBuildPage.CycleDate + " and cycle no. "
				+ entryBuildPage.CycleNo + " is successfully sent.");
	}

	@And("Click Cancel on Console Submission")
	public void Click_Cancel_on_Console_Submission() throws InterruptedException {
		entryBuildPage.cancelConsoleSubmission();
	}

	@And("Select all shipments in the grid")
	public void Select_shipments_in_the_filtered() throws InterruptedException {
		entryBuildPage.selectMultipleShipments();
	}

	@Then("Verify HS Code is Blank and Orange Harmonized Code Match Icon is present")
	public void verify_hs_code_is_blank_and_orange_harmonized_code_match_icon_is_present() throws InterruptedException {
		entryBuildPage.HSCode_noMatch();
	}

	@Then("Verify HS Code is Blank and red Harmonized Code Match Icon is present")
	public void verify_hs_code_is_blank_and_red_harmonized_code_match_icon_is_present() throws InterruptedException {
		entryBuildPage.HSCode_noMatch_Red();
	}

	@Then("Enter the HS Code {string}")
	public void enter_the_hs_code(String enterVal) throws InterruptedException {
		entryBuildPage.enter_HSCode(enterVal);
	}

	@Then("Verify HS Code is Filled and Green Harmonized Code Match Icon is present")
	public void verify_hs_code_is_filled_and_green_harmonized_code_match_icon_is_present() throws InterruptedException {
		entryBuildPage.HSCode_Match();
	}

	@When("Click on the first Commodity")
	public void click_on_the_first_commodity() throws InterruptedException {
		entryBuildPage.clickCommodity();
	}

	@When("Enter the Quantity of commodity as {string}")
	public void enter_the_quantity_of_commodity_as(String strQuantity) {
		entryBuildPage.enterQuantityCommodity(strQuantity);
	}

	@When("Alert message should be displayed as {string}")
	public void alert_message_should_be_displayed_as(String strMsg) {
		entryBuildPage.alertMessageVerification(strMsg);
	}

	@When("Enter the total Value as {string}")
	public void enter_the_total_value_as(String strTotVal) {
		entryBuildPage.enterTotalValue(strTotVal);
	}

	@Then("The Decl Value of new commodity should be total value minus the first commodity")
	public void the_decl_value_of_new_commodity_should_be_total_value_minus_the_first_commodity() {
		entryBuildPage.verfiyNewCommodityDeclVal();
	}

	@Then("CIF Field of commodity is not editable")
	public void cif_field_of_commodity_is_not_editable() {
		entryBuildPage.CIFEditable();
	}

	@Then("The CIF of new commodity should be total CIF minus the first commodity")
	public void the_cif_of_new_commodity_should_be_total_cif_minus_the_first_commodity() {
		entryBuildPage.verfiyNewCommodityCIF();
	}

	@Then("GST of the Commodity should be {string} of CIF")
	public void gst_of_the_commodity_should_be_of_cif(String strVal) {
		entryBuildPage.verfiyNewCommodityGST(strVal);
	}

	@Then("Country of the commodity should be selected by default")
	public void country_of_the_commodity_should_be_selected_by_default() {
		entryBuildPage.verfiyNewCommodityCountry();
	}

	@Then("Commodity description should be auto populated by HS Code")
	public void commodity_description_should_be_auto_populated_by_hs_code() {
		entryBuildPage.verfiyNewCommodityDesc();
	}

	@Then("Branded value of the commodity should be {string}")
	public void branded_value_of_the_commodity_should_be(String val) {
		entryBuildPage.verfiyNewCommodityBranded(val);
	}

	@Then("Product value of the commodity should be {string}")
	public void product_value_of_the_commodity_should_be(String val) {
		entryBuildPage.verfiyNewCommodityProduct(val);
	}

	@Then("CIF, GST, Exchange Rate, Auto FC & Insurance should be autocalculated and displayed")
	public void cif_gst_exchange_rate_auto_fc_insurance_should_be_autocalculated_and_displayed() {
		entryBuildPage.verifyShipmentFields();
	}

	@Then("Enter the Clearance scheme as {string}")
	public void enter_the_clearance_scheme_as(String val) {
		entryBuildPage.enterClearanceScheme(val);
	}

	@Then("Enter the Currency as {string}")
	public void enter_the_currency_as(String val) {
		entryBuildPage.enterCurrency(val);
	}

	@Then("Enter the Gross Weight of the shipment as {string}")
	public void enter_the_gross_weight_of_the_shipment_as(String val) {
		entryBuildPage.enterGrossWeight(val);
	}

	@Then("Enter the Incoterm as {string}")
	public void enter_the_incoterm_as(String val) {
		entryBuildPage.enterIncoterm(val);
	}

	@Then("Enter the Shipment Description as {string}")
	public void enter_the_shipment_description_as(String val) {
		entryBuildPage.enterShipmentDescription(val);
	}

	@And("^Click on Second Commodity")
	public void _Click_on_Second_Commodity() throws Throwable {
		entryBuildPage.clickNewCommodity();
	}

	/******** Gomathi *******/
//Customer Matching
	@And("Create new Consignee and Consignee is same as Importer {string}")
	public void Create_new_Consignee_and_Consignee_is_same_as_Importer(String toggleStatus)
			throws InterruptedException {
		customerMatchingPage.createNewConsigneeAndSameAsImporter(toggleStatus);
	}

	@Then("^Verify Consignee and Importer details match with as per CM linked$")
	public void Verify_Consignee_and_Importer_details_match_with_as_per_CM_linked() throws InterruptedException {
		entryBuildPage.verifyConsigneeAndImporterInEntryBuild();
	}

	/****** Gomathi *****/
	@Then("Verify Orgin Country as {string}")
	public void verifyOrginCountry(String strCountry) {
		entryBuildPage.verifyOrginCountry(strCountry);
	}

	@And("Verify COM Alerts")
	public void Verify_COM_Value() throws InterruptedException {
		entryBuildPage.validateCOMalerts();
	}

	@And("Verify clearnce mode should not be {string}")
	public void verifyClearenceMode(String clearanceModeValue) {
		entryBuildPage.validateClearanceModeValueShouldNotBe(clearanceModeValue);
	}

	@Then("Validate Transport Bill Account Number")
	public void verify_Transport_Bill_Account_Number() {
		entryBuildPage.validateTransportBillAccountNumber();
	}

	@And("^CP Match Alerts should be displayed$")
	public void _cp_match_alert_should_be_displayed() throws Throwable {
		entryBuildPage.cpMatch_OverridableAlert();
	}

	@And("^User search for Consignee and click on the Link Importer icon$")
	public void _user_search_for_consignee_and_click_on_the_link_importer_icon() throws Throwable {
		entryBuildPage.LinkSearch_consignee();
	}

	@And("^User search for Importer and click on the Link Importer icon$")
	public void _user_search_for_importer_and_click_on_the_link_importer_icon() throws Throwable {
		entryBuildPage.LinkSearch_importer();
	}

	@And("User link the importer icon name as {string}")
	public void user_link_the_importer_icon(String companyNameDesc) {
		entryBuildPage.Link_importor_Desc(companyNameDesc);

	}

	@And("Calculate the GST and Advancement Fee")
	public void calculate_GST_and_Advancement() throws InterruptedException {
		js.executeScript("document.querySelector(\"datatable-body\").scrollLeft=-1000");
		String GST = "", AdFee = "", tp = "";
		String totalHeader = "";
		int rowValue = 2, k = 0, ScrollValue = 500;
		entryBuildPage.tblHeaderlabels.size();
		System.out.println("Header Size : " + entryBuildPage.tblHeaderlabels.size());
		for (int i = 1; i < entryBuildPage.tblHeaderlabels.size(); i++) {
			rowValue++;

			totalHeader = driver
					.findElement(By.xpath("((//datatable-header-cell/div/div)/table)[" + i + "]/tr/th[1]/span"))
					.getText();
			System.out.println(totalHeader);
			if (totalHeader.trim().equalsIgnoreCase("GST")) {
				Thread.sleep(2000);
				GST = driver.findElement(By.xpath(
						"(//datatable-body-cell[contains(@class,'datatable-body-cell')])[" + rowValue + "]/div/span"))
						.getText();
				System.out.println("GST Value is :" + GST);
			} else if (totalHeader.trim().equalsIgnoreCase("Advancement Fee")) {
				Thread.sleep(2000);
				AdFee = driver.findElement(By.xpath(
						"(//datatable-body-cell[contains(@class,'datatable-body-cell')])[" + rowValue + "]/div/span"))
						.getText();
				System.out.println("AdFee Value is :" + AdFee);
			} else if (totalHeader.trim().equalsIgnoreCase("Total Payment")) {
				Thread.sleep(2000);
				tp = driver.findElement(By.xpath(
						"(//datatable-body-cell[contains(@class,'datatable-body-cell')])[" + rowValue + "]/div/span"))
						.getText();
				System.out.println("Tp Value is :" + tp);

			}
			if (i % 5 == 0) {
				k += 1;
				js.executeScript("document.querySelector(\"datatable-body\").scrollLeft=" + (ScrollValue * k));
				Thread.sleep(2000);
			}

			if (GST.length() > 0 && AdFee.length() > 0 && tp.length() > 0) {
				break;

			}
			
		}

		float calculateAdFee = (Float.parseFloat(GST) * 5) / 100;
		calculateAdFee = calculateAdFee <= 20 ? 20 : Float.parseFloat(AdFee);
		boolean x = calculateAdFee == 0.00 ? true : false;
		if (x) {
			System.err.println("GST & Advertisement Fee are NOT matched");
			Assert.assertFalse(true);
		}

		float totalFee = Float.parseFloat(GST) + Float.parseFloat(AdFee);
		boolean val = totalFee == Float.parseFloat(tp) ? true : false;
		if (val) {
			System.out.println("Total Fee values are Matched");
		}
	}

	@And("Importer Instruction displays the CP instruction value as {string}")
	public void importer_instruction_displays_CP_instruction(String x) throws InterruptedException {
		entryBuildPage.Check_Importer_Instruction(x);
	}

	@And("^HS code Description alerts should be displayed$")
	public void _HS_code_Description_alerts_should_be_displayed() throws Throwable {
		entryBuildPage.hsCode_OverridableAlert();
		entryBuildPage.commodity_DescriptionAlert();
	}

	@And("Enter the description {string}")
	public void _Enter_the_description_details(String enterVal) throws Throwable {
		entryBuildPage.enter_Description(enterVal);
	}

	@Then("^Clear data of Package weight branded$")
	public void _clear_data_of_Package_weight_branded() throws Throwable {
		entryBuildPage.clearWeightPackageBranded();
//	entrybuild.clearBranded();
		Thread.sleep(4000);
		_click_on_validate();
	}

	@Then("^Validate package weight branded alerts$")
	public void _validate_package_weight_alert() throws Throwable {
		entryBuildPage.package_alert();
		entryBuildPage.weight_Alert();
		entryBuildPage.branded_Alert();
	}

	@And("Change Clearance Scheme {string}")
	public void _Change_Clearance_Schemee(String changeValue) throws Throwable {
		entryBuildPage.update_clearance_Scheme(changeValue);
	}

	@And("^DEMIN LV and Check Clearance Scheme Alerts should be displayed$")
	public void _demin_LV_and_Check_Clearance_Scheme_Alerts_should_be_displayed() throws Throwable {
		entryBuildPage.deminLVClearanceScheme_OverridableAlert();
	}

	@And("Change Clearance Mode {string}")
	public void __Change_Clearance_Mode(String changeValue) throws Throwable {
		entryBuildPage.update_clearance_Mode(changeValue);
	}

	@And("^UEN Failed Alert should be displayed$")
	public void _UEN_Failed_Alerts_should_be_displayed() throws Throwable {
		entryBuildPage.uenFailed_Alert();
	}

	@Then("^Check LV ROAD Clearance Mode Alerts should be displayed")
	public void _Check_LV_ROAD_Clearance_Mode_Alerts_should_be_displayed() throws Throwable {
		entryBuildPage.CheckLVRoadClearanceMode_Alert();
	}

	@And("Select the Sort code {string}")
	public void _Select_the_Sort_code(String selectValue) throws Throwable {
		entryBuildPage.select_sort_message_code(selectValue);
	}

	@And("^Check Cage Code Required Alert should be displayed$")
	public void _Check_Cage_Code_Required_Alert_should_be_displayed() throws Throwable {
		entryBuildPage.cageCode_Alert();
	}

	@And("^Check Caged Mode Required Alert should be displayed$")
	public void _Check_Caged_Mode_Required_Alert_should_be_displayed() throws Throwable {
		entryBuildPage.cagedMode_Alert();
	}

	@And("^Validate CIF and GST Value$")
	public void Validate_CIF_and_GST_Value() throws InterruptedException {
		entryBuildPage.validateCIFAndGST();
	}

	@And("Submit the Declaration")
	public void Submit_the_Declaration() throws InterruptedException {
		entryBuildPage.submitDeclaraion();
		Thread.sleep(5000);
	}

	@And("^Click on PST Check button$")
	public void Click_on_PST_Check_button() throws Throwable {
		entryBuildPage.click_PSTCheck();
	}

	@Then("Clearance Status in declaration screen should be {string}")
	public void Clearance_Status_in_declaration_screen_should_be(String strValue) throws InterruptedException {
		entryBuildPage.clearanceStatusInDeclaraion(strValue);
	}

	@And("^Validate ADT sort code is not Added$")
	public void Validate_ADT_sort_code_is_not_Added() throws InterruptedException {
		entryBuildPage.verifySelectionCode();
	}

	@And("Select ACSS Shipments toggle in Entry Build TeamLederList")
	public void Select_ACSS_Shipments_toggle_in_Entry_Build_TeamLederList() throws InterruptedException {
		entryBuildPage.ACCSShipments_InEntryBuildTeamLeaderList();
	}

//@And("Verify COM Alerts")
//public void Verify_COM_Value() throws InterruptedException {
//	entrybuild.validateCOMalerts();
//}

	@And("Assign To member in Entry Build")
	public void Click_on_Assign_To_in_Entry_Build() {
		entryBuildPage.assignShipmentFromEntryBuildTeamLeaderList();
	}

	@And("Click on Upload button in floating panel")
	public void click_on_upload_button() throws InterruptedException {
		entryBuildPage.icon_fp_upload();
	}

	@And("Select location as {string} and type as {string} and upload sample file")
	public void Select_Location_as(String location, String type) throws InterruptedException, AWTException {
		try {
			waitTillElementVisible(entryBuildPage.location);
			entryBuildPage.location.click();
			selectUsingVisibleText(entryBuildPage.dpdn_Location, location);
			waitTillElementVisible(entryBuildPage.docType);
			entryBuildPage.docType.click();
			selectUsingVisibleText(entryBuildPage.docType, type);

		} catch (NoSuchElementException | ElementNotInteractableException | TimeoutException e) {
			e.getMessage();
			waitTillElementVisible(ManifestCheckPage.pageSpinner);
			Actions action = new Actions(driver);
			Thread.sleep(2000);
			action.keyDown(Keys.CONTROL).click(manifestCheckPage.staticText_upload).keyUp(Keys.CONTROL).build()
					.perform();
			waitTillElementVisible(entryBuildPage.location);
			entryBuildPage.location.click();
			selectUsingVisibleText(entryBuildPage.dpdn_Location, location);
			waitTillElementVisible(entryBuildPage.docType);
			entryBuildPage.docType.click();
			selectUsingVisibleText(entryBuildPage.docType, type);
		}
		// waitTillElementInVisible(ManifestCheckPage.pageSpinner, 20);

	}

	@And("Select file to upload")
	public void uploadFile() throws InterruptedException, AWTException {
		String path;
		EntryBuildPage.clickElementUsingJavaScript(entryBuildPage.browseFile);
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
		waitTillElementVisible(entryBuildPage.submit_upload);
		EntryBuildPage.clickElementUsingJavaScript(entryBuildPage.submit_upload);
	}

	@And("Select file to upload and cancel button")
	public void uploadFile_cancel_button() throws InterruptedException, AWTException {
		String path;
		EntryBuildPage.clickElementUsingJavaScript(entryBuildPage.browseFile);
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
		waitTillElementVisible(entryBuildPage.cancelbutton);
		EntryBuildPage.clickElementUsingJavaScript(entryBuildPage.cancelbutton);
	}

	@And("Upload the Document and Submit Floating panel")
	public void upload_the_document_and_submit_floating_panel() throws InterruptedException, IOException, AWTException {
		Thread.sleep(5000);
		manifestCheckPage.clickBrowseFiles();
		System.out.println("Auto IT Script Started");
		applicationFunctions.uploadFileUsingAutoIT();
		System.out.println("Auto IT Script Ended");
//	manifestCheckPage.uploadFileUsingRobotClass(filePath);
		Thread.sleep(15000);
		manifestCheckPage.clickFileUploadingSaveButton();
		Thread.sleep(15000);

	}

	@And("Click on download button in floating panel")
	public void click_on_download_button() {
		entryBuildPage.clickDownloadButton();
	}

	// Select the HSCode

	@And("Click on Commodity details for Exact Match$")
	public void click_on_commodity_details_exactMatch() throws Throwable {
		entryBuildPage.click_commodityDetails();
	}

	@And("Click on Commodity details for No Match$")
	public void click_on_commodity_details_noMatch() throws Throwable {
		entryBuildPage.click_commodityDetailsNoMatch();
	}

	@And("Click on Commodity details for Multiple Match$")
	public void click_on_commodity_details_multiMatch() throws Throwable {
		entryBuildPage.click_commodityDetailsMultiMatch();
	}

	// ======================================================================================================

	// Click on Multiple match icon - Orange color
	@And("Select the HS Code with multiple match$")
	public void click_hscode_multiplematch_selection_icon() throws Throwable {
		entryBuildPage.click_commodity_MultiMatch_Edit();
	}

	// Click on icon with exact match icon - green color
	@And("Select the HS Code with exact match$")
	public void click_hscode_exactmatch_selection_icon() throws Throwable {
		entryBuildPage.click_commodity_Matched_Edit();
	}

	// Click on icon with no match icon - Red color
	@And("Select the HS Code with no match$")
	public void click_hscode_nomatch_selection_icon() throws Throwable {
		entryBuildPage.click_commodity_NoMatch_Edit();
	}
	// =============================================================================================================

	@And("Click tick icon to select HS code$")
	public void click_tick_icon_to_select_HScode() throws Throwable {
		entryBuildPage.click_cmdSelect();
	}
	

	@And("Click on tick icon to submit$")
	public void click_tick_icon_to_submit_HScode() throws Throwable {
		entryBuildPage.click_btnSubmit();
	}

	@And("HSCode predictable table should be displayed$")
	public void verifyHSCode_exists() throws Throwable {
		entryBuildPage.verifyHdCodeTblforConfidenceColumn();
	}

	@And("select the HS code and verify commodity details$")
	public void select_the_hs_code_and_verify_commodity_details() throws Throwable {
		entryBuildPage.searchHScode();
	}

	@And("Enter valid HS code and verify filters$")
	public void enter_valid_hs_code_and_verify_filters() throws Throwable {
		entryBuildPage.verify_filters();
	}

	@And("Verify scroll up and down$")
	public void verify_scroll_up_and_down() throws Throwable {
		entryBuildPage.verify_scrollupdown();
	}

	@And("Enter valid HS code and submit$")
	public void enter_valid_hs_code_and_submit() throws Throwable {
		entryBuildPage.enter_ValidHSCode();
	}

	@And("HSCode predictable table should not be displayed$")
	// public void verifyHSCode_Notexists(boolean hsCodeDisplayed) throws Throwable
	public void _verifyHSCode_Notexists() throws Throwable {
		entryBuildPage.verifyHdCodeTblExists();
	}

	@And("Verify Confidence column is removed$")
	public void ConfidenceColExists() throws Throwable {
		entryBuildPage.ConfidenceColExists();
	}

	@And("Verify prediction popup for columns exists$")
	public void PredicationPupupColumnsExists() throws Throwable {
		entryBuildPage.predictPopupColumnsExists();
	}

	@And("Click on cancel button under Commodity details$")
	public void _click_cancel_icon_to_cancel_HScode_Assignment() throws Throwable {
		entryBuildPage.click_btnCancelAssign();
	}

	// Navigating to Recurring Rules Maintenance page
	@And("Navigate to Recurring Rules Maintenance$")
	public void click_RecurringRulesMaintenance() throws Throwable {
		entryBuildPage.recurring_RuleMaintenance_Navigate();
	}

	// Navigating to "Create Rule" popup page
	@And("Click the create icon to navigate to Create Rule$")
	public void click_CreateRuleIcon() throws Throwable {
		entryBuildPage.navigateToCreateRulePopup();
	}

	// Verify Sort code name
	@And("Verify Sort code name for URG$")
	public void verifySortCodeExists() throws Throwable {
		entryBuildPage.verifyListforsortCode();
	}

	// Close CreateRule Popup
	@And("Close the Create Rule popup$")
	public void closeCreateRulePopup() throws Throwable {
		entryBuildPage.cancel_CreateRulePopup();
	}

	// Search for HScode under commodity details
	@And("Search for HSCode under commodity details$")
	public void searchHSCodeinCommodityDetails() throws Throwable {
		entryBuildPage.typeHSCode();
		entryBuildPage.clickHSCodeSearch();

	}

	String[] splitString(String str) {
		return str.split(",");
	}

	void verifyStringContainsAnother(String firstString, String secondString) {
		System.out.println(firstString + "<contains ?" + secondString);
		Assert.assertTrue(firstString.contains(secondString));
	}

	@Then("Validate the selection codes {string} in Declaration Page")
	public void validate_the_selection_codes_in_declaration_page(String selectionCodesInput) {
		String selectionCodes = entryBuildPage.get_sortMessages();
		for (String selCode : splitString(selectionCodesInput)) {
			verifyStringContainsAnother(selectionCodes, selCode);
		}
	}

	// Verify HSCodePredication table, scroll horizontally to the column "Levy Code"
	// and then to "WCO Tariff"
	@And("Verify HSCodePredication table for horizontal scroll$")
	public void horrizontalScrollHsCodeTable() throws Throwable {
		entryBuildPage.scrollHsCodeTable();
	}

	// Close the HSCode Predictable table
	@And("Close the HSCode Predicable table$")
	public void closelHsCodeTable() throws Throwable {
		entryBuildPage.cancel_PrdictionTbl();
	}

	@Then("Validate the selection codes are added {string} in Declaration Page")
	public void add_sortCode(String data1) throws Throwable {
		entryBuildPage.verify_sortCodeExistance(data1);
	}

	@Then("Validate the selection code is added {string} in Declaration Page")
	public void validate_selection_code(String data1, String data2) throws Throwable {
		Thread.sleep(2000);
		if (entryBuildPage.get_sortMessages().contains(data1)) {
			assertTrue(true);
		}
	}

	@And("Fetch the AWBNo {string},{string},{string}")
	public void fetch_AWBNo(String data1, String data2, String data3) throws Throwable {
		Thread.sleep(2000);
		js.executeScript("document.querySelector(\"datatable-body\").scrollLeft=-1000");
		String number = null;
		entryBuildPage.tblHeaderlabels.size();
		System.out.println("Header Size : " + entryBuildPage.tblHeaderlabels.size());
		for (int i = 1; i < entryBuildPage.tblHeaderlabels.size(); i++) {
			String headerval = driver
					.findElement(By.xpath("((//datatable-header-cell/div/div)/table)[" + i + "]/tr/th[1]/span"))
					.getText();
			if (headerval.trim().equalsIgnoreCase("AWB Number")) {
				i = i + 2;
				Thread.sleep(3000);
				number = driver
						.findElement(By.xpath(
								"(//datatable-body-cell[contains(@class,'datatable-body-cell')])[" + i + "]/div/span"))
						.getText();
				break;
			} else if (headerval.trim().equalsIgnoreCase("Conveyance Number")) {
				// i = i + 1;
				Thread.sleep(3000);
				number = driver
						.findElement(By.xpath(
								"(//datatable-body-cell[contains(@class,'datatable-body-cell')])[" + i + "]/div/span"))
						.getText();
				break;
			}
		}
		System.out.println("AWB | Conveyane # is : " + number);
		excelUtility.writeExcelValue(data1, data2, data3, number);
		Thread.sleep(3000);
	}

	@And("Importer company should not display as Personal Shipment")
	public void importer_company_should_not_display() throws InterruptedException {
		Thread.sleep(2000);
		int k = 0;
		int ScrollValue = 500;
		js.executeScript("document.querySelector(\"datatable-body\").scrollLeft=-1000");
		String number = null;
		String text = "PersonalShipment";
		entryBuildPage.tblHeaderlabels.size();
		System.out.println("Header Size : " + entryBuildPage.tblHeaderlabels.size());
		for (int i = 1; i < entryBuildPage.tblHeaderlabels.size(); i++) {
			String headerval = driver
					.findElement(By.xpath("((//datatable-header-cell/div/div)/table)[" + i + "]/tr/th[1]/span"))
					.getText();
			js.executeScript("document.querySelector(\"datatable-body\").scrollLeft=-1000");
			if (headerval.trim().equalsIgnoreCase("Importer Company")) {
				i = i + 2;
				Thread.sleep(3000);
				number = driver
						.findElement(By.xpath(
								"(//datatable-body-cell[contains(@class,'datatable-body-cell')])[" + i + "]/div/span"))
						.getText();
				break;

			}

			if (i % 5 == 0) {
				k += 1;
				js.executeScript("document.querySelector(\"datatable-body\").scrollLeft=" + (ScrollValue * k));
				Thread.sleep(2000);
			}

		}
		if (number != text) {

			Assert.assertTrue(true, "Importer company shouldn't diplay personal shipment");
		} else {
			Assert.assertTrue(false, "Importer company should diplay the personal shipment");
		}

	}

	@And("Store the AWB number")
	public void Store_AWBNo() throws Throwable {
		String number = null;
		entryBuildPage.tblHeaderlabels.size();
		System.out.println("Header Size : " + entryBuildPage.tblHeaderlabels.size());
		for (int i = 1; i < entryBuildPage.tblHeaderlabels.size(); i++) {
			String headerval = driver
					.findElement(By.xpath("((//datatable-header-cell/div/div)/table)[" + i + "]/tr/th[1]/span"))
					.getText();
			if (headerval.trim().equalsIgnoreCase("AWB Number")) {
				i = i + 2;
				Thread.sleep(3000);
				number = driver
						.findElement(By.xpath(
								"(//datatable-body-cell[contains(@class,'datatable-body-cell')])[" + i + "]/div/span"))
						.getText();
				break;
			} else if (headerval.trim().equalsIgnoreCase("Conveyance Number")) {
				i = i + 1;
				Thread.sleep(3000);
				number = driver
						.findElement(By.xpath(
								"(//datatable-body-cell[contains(@class,'datatable-body-cell')])[" + i + "]/div/span"))
						.getText();
				break;
			}
		}
		System.out.println("AWB | Conveyane # is : " + number);
		// excelUtility.writeExcelValue(data1, data2, data3, number);
		ScenarioContext.setContext(Context.AWB, number);
		Thread.sleep(3000);
	}

	@And("Filter using Image Flag as {string},{string},{string},{string}")
	public void fetch_CIFlag(String value, String data1, String data2, String data3) throws Throwable {
		String headerval = "";
		entryBuildPage.tblHeaderlabels.size();
		System.out.println("Header Size : " + entryBuildPage.tblHeaderlabels.size());
		for (int i = 1; i < entryBuildPage.tblHeaderlabels.size(); i++) {
			headerval = driver
					.findElement(By.xpath("((//datatable-header-cell/div/div)/table)[" + i + "]/tr/th[1]/span"))
					.getText();
			if (headerval.trim().equalsIgnoreCase("CI Flag")) {
				applicationFunctions.click_Filter_Icon("CI Flag");
				applicationFunctions.set_Filter_Value(value);
				applicationFunctions.close_Filter();
				break;
			}
		}
		for (int j = 1; j < entryBuildPage.tblHeaderlabels.size(); j++) {
			headerval = driver
					.findElement(By.xpath("((//datatable-header-cell/div/div)/table)[" + j + "]/tr/th[1]/span"))
					.getText();
			if (headerval.trim().equalsIgnoreCase("AWB Number")) {
				j = j + 2;
				String awb = driver
						.findElement(By.xpath(
								"(//datatable-body-cell[contains(@class,'datatable-body-cell')])[" + j + "]/div/span"))
						.getText();
				System.out.println("AWB # is : " + awb);
				excelUtility.writeExcelValue(data1, data2, data3, awb);
				break;
			}
		}

	}

	@SuppressWarnings("unused")
	@And("Capture customer invoice label")
	public void invoice_label() throws Throwable {
		String lblValue1;
		String lblValue2;
		waitTillElementVisible(entryBuildPage.invoice_label);
		if (!lblexistance) {
			lblValue1 = entryBuildPage.invoice_label.getText();
		}
		if (lblexistance) {
			lblValue2 = entryBuildPage.invoice_label.getText();
		}
		lblexistance = true;
	}

	@Then("^Verify Image Flag in the Shipments Grid$")
	public void _verify_image_flag_in_the_shipments_grid() throws Throwable {
		entryBuildPage.ImageFlag_Displayed();
	}

	@Then("^Verify Route in the Global Search Grid$")
	public void _verify_route_global_search_grid() throws Throwable {
		entryBuildPage.Route_Displayed();
	}

	@And("Select filter option for Image flag as {string},{string}")
	public void filter_option_value(String value1, String value2) throws Throwable {
		applicationFunctions.click_Filter_Icon(value1);
		entryBuildPage.selectText.click();
		selectUsingVisibleText(entryBuildPage.selectText, value2);
		applicationFunctions.close_Filter();
	}

	@Then("Validate the Image flag {string} assigned for the shipment")
	public void validate_flag_availability(String value1) throws Throwable {
		entryBuildPage.tblHeaderlabels.size();
		System.out.println("Header Size : " + entryBuildPage.tblHeaderlabels.size());
		for (int i = 1; i < entryBuildPage.tblHeaderlabels.size(); i++) {
			String headerval = driver
					.findElement(By.xpath("((//datatable-header-cell/div/div)/table)[" + i + "]/tr/th[1]/span"))
					.getText();
			if (headerval.trim().equalsIgnoreCase("Image Flag")) {
				i = i + 2;
				String ci = driver
						.findElement(By.xpath(
								"(//datatable-body-cell[contains(@class,'datatable-body-cell')])[" + i + "]/div/span"))
						.getText();
				assertEquals("Y", ci);
			}

		}
	}

	@Then("Validate CI flag is removed from the shipment")
	public void validate_flag_removed() throws Throwable {
		Thread.sleep(4000);
		entryBuildPage.tblHeaderlabels.size();
		System.out.println("Header Size : " + entryBuildPage.tblHeaderlabels.size());
		for (int i = 1; i < entryBuildPage.tblHeaderlabels.size(); i++) {
			String headerval = driver
					.findElement(By.xpath("((//datatable-header-cell/div/div)/table)[" + i + "]/tr/th[1]/span"))
					.getText();
			if (headerval.trim().equalsIgnoreCase("CI Flag")) {
				i = i + 2;
				String ci = driver
						.findElement(By.xpath(
								"(//datatable-body-cell[contains(@class,'datatable-body-cell')])[" + i + "]/div/span"))
						.getText();
				if (ci.length() == 0) {
					Assert.assertTrue(true, "CI flag value Y is removed from the shipment");
					break;
				} else {
					Assert.assertTrue(false, "CI flag value Y is still exist for the shipment");
				}
			}

		}
	}

	@Then("Verify the uploaded document in customer invoice {string}")
	public void doc_Image_Name(String columnName) throws InterruptedException {
		Thread.sleep(3000);
		scrollIntoViewUsingJavaScript(driver.findElement(By.xpath("//span[text()='" + columnName + "']")));
		waitTillElementVisible(driver.findElement(By.xpath("//span[text()='" + columnName + "']")));
		int tsize = driver.findElements(By.xpath("//span[text()='" + columnName + "']")).size();
		assertEquals(columnName,
				driver.findElement(By.xpath("(//span[text()='" + columnName + "'])[" + tsize + "]")).getText());
		Thread.sleep(3000);
	}

	@When("Disable the columns in modal window")
	public void disable_columns() throws InterruptedException {
		waitTillElementVisible(entryBuildPage.tripple_dot);
		Thread.sleep(3000);
		clickElementUsingJavaScript(entryBuildPage.tripple_dot);
		// List<WebElement> ele =
		// driver.findElements(By.xpath("((//div[@class='modal-content']//following::div[contains(@class,'drag-and-drop-list')]//following::genius-toggle-switch)[@ng-reflect-is-toggle-switched='true'])"));
		for (int i = 1; i < entryBuildPage.modal_window_disabled.size(); i++) {
			driver.findElement(By.xpath(
					"((//div[@class='modal-content']//following::div[contains(@class,'drag-and-drop-list')]//following::genius-toggle-switch)[@ng-reflect-is-toggle-switched='true'])["
							+ i + "]//following-sibling::label/span"))
					.click();
		}
		entryBuildPage.save_modal_window.click();
		Thread.sleep(3000);
	}

	@Then("Enable the required columns in modal window")
	public void enable_columns() throws InterruptedException {
		waitTillElementVisible(entryBuildPage.tripple_dot);
		clickElementUsingJavaScript(entryBuildPage.tripple_dot);
		String var[] = { "Commodity Category", "Assigned User ID", "Image Flag", "Currency", "Clearance Scheme",
				"Clearance Status", "Teams", "Route", "Selection Codes", "Importer Company", "Consignee Company",
				"Clearance Mode", "Clearance Location", "Service Code", "Special handling code", "Incoterm", "IOR",
				"Commitment Date", "Arrival Date", "Matches", "Duty Bill", "Payment Option", "GST", "Advancement Fee",
				"DOPS Status", "Payment Option", "DOPS Response Time", "Total Payment", "FedEx Account for D&T Charges","Competency" };
		System.out.println("Total Columns to be enabled:" + var.length);
		// ele =
		// driver.findElements(By.xpath("((//div[@class='modal-content']//following::div[contains(@class,'drag-and-drop-list')]//following::genius-toggle-switch)[@ng-reflect-is-toggle-switched='false'])"));
		HashMap<Integer, String> map = new HashMap<>();
		for (int i = 1; i < entryBuildPage.modal_window_enabled.size(); i++) {
			map.put(i, driver.findElement(By.xpath(
					"(//div[@class='modal-content']//following::div[contains(@class,'drag-and-drop-list')]//following::genius-toggle-switch)["
							+ i + "]//following-sibling::label/span"))
					.getText());
		}
		System.out.println(map);

		for (Entry<Integer, String> entrySet : map.entrySet()) {
			for (int j = 0; j <= var.length - 1; j++) {
				// txt =
				// driver.findElement(By.xpath("(//div[@class='modal-content']//following::div[contains(@class,'drag-and-drop-list')]//following::genius-toggle-switch)["+entrySet.getKey()+"]//following-sibling::label/span")).getText();
				if (var[j].trim().equalsIgnoreCase(entrySet.getValue())) {
					try {
						driver.findElement(By.xpath(
								"((//div[@class='modal-content']//following::div[contains(@class,'drag-and-drop-list')]//following::genius-toggle-switch)[@ng-reflect-is-toggle-switched='false'])["
										+ (entrySet.getKey() - 1) + "]//following-sibling::label/span"))
								.click();
					} catch (NoSuchElementException e) {
						driver.findElement(By.xpath(
								"((//div[@class='modal-content']//following::div[contains(@class,'drag-and-drop-list')]//following::genius-toggle-switch)[@ng-reflect-is-toggle-switched='false'])["
										+ (entrySet.getKey()) + "]//following-sibling::label/span"))
								.click();
					}
					break;
				}
			}

		}

		entryBuildPage.save_modal_window.click();
		Thread.sleep(3000);

	}

	@When("Disable the columns in the conveyance window")
	public void Conv_disable_columns() throws InterruptedException {
		waitTillElementVisible(entryBuildPage.tripple_dot);
		Thread.sleep(3000);
		clickElementUsingJavaScript(entryBuildPage.tripple_dot);
		// List<WebElement> ele =
		// driver.findElements(By.xpath("((//div[@class='modal-content']//following::div[contains(@class,'drag-and-drop-list')]//following::genius-toggle-switch)[@ng-reflect-is-toggle-switched='true'])"));
		for (int i = 1; i < entryBuildPage.modal_window_disabled.size(); i++) {
			driver.findElement(By.xpath(
					"((//div[@class='modal-content']//following::div[contains(@class,'drag-and-drop-list')]//following::genius-toggle-switch)[@ng-reflect-is-toggle-switched='true'])["
							+ i + "]//following-sibling::label/span"))
					.click();
		}
		entryBuildPage.save_modal_window.click();
		Thread.sleep(3000);
	}

	@Then("Enable the required columns in the conveyance window")
	public void conv_enable_columns() throws InterruptedException {
		waitTillElementVisible(entryBuildPage.tripple_dot);
		clickElementUsingJavaScript(entryBuildPage.tripple_dot);
		String var[] = { "Flight Number", "Status", "MAWB", "Mode of Transport", "Total Shipments", "Conveyance Status",
				"Conveyance Date", "Origin Port", "Origin Departing Location", "Overage Count - Potential" };
		// ele =
		// driver.findElements(By.xpath("((//div[@class='modal-content']//following::div[contains(@class,'drag-and-drop-list')]//following::genius-toggle-switch)[@ng-reflect-is-toggle-switched='false'])"));
		HashMap<Integer, String> map = new HashMap<>();
		for (int i = 1; i < entryBuildPage.modal_window_enabled.size(); i++) {
			map.put(i, driver.findElement(By.xpath(
					"(//div[@class='modal-content']//following::div[contains(@class,'drag-and-drop-list')]//following::genius-toggle-switch)["
							+ i + "]//following-sibling::label/span"))
					.getText());
		}
		System.out.println(map);

		for (Entry<Integer, String> entrySet : map.entrySet()) {
			for (int j = 0; j <= var.length - 1; j++) {
				// txt =
				// driver.findElement(By.xpath("(//div[@class='modal-content']//following::div[contains(@class,'drag-and-drop-list')]//following::genius-toggle-switch)["+entrySet.getKey()+"]//following-sibling::label/span")).getText();
				if (var[j].trim().equalsIgnoreCase(entrySet.getValue())) {
					driver.findElement(By.xpath(
							"((//div[@class='modal-content']//following::div[contains(@class,'drag-and-drop-list')]//following::genius-toggle-switch)[@ng-reflect-is-toggle-switched='false'])["
									+ (entrySet.getKey() - 1) + "]//following-sibling::label/span"))
							.click();
					break;
				}
			}

		}

		entryBuildPage.save_modal_window.click();
		Thread.sleep(3000);

	}

	@And("Click the Route Refresh Information$")
	public void ClickTheRouteRefreshInformation() throws Throwable {
		entryBuildPage.clickRouteRefreshInformationButton();
	}

	@When("Select ACCS Shipments radio button")
	public void select_acss_shipments_radio_button() throws InterruptedException {
		manifestCheckPage.click_ACCSShipmentsRadio();
	}

	@When("Select multiple shipments in Shipment Result\\(s)")
	public void select_multiple_shipments_in_shipment_result_s() throws InterruptedException {
		manifestCheckPage.selectMultipleShipments();
	}

	@When("Select multiple shipment from global search results")
	public void select_multiple_shipments_in_globalSearch() throws InterruptedException {
		manifestCheckPage.selectMultipleShipmentsInGlobalSearch();
	}

	@When("Write the AWBNo {string},{string},{string}")
	public void write_the_awb_no(String sheetName, String columnName, String rowIndex)
			throws IOException, InterruptedException {
		String awbNum = null;
		for (int i = 1; i <= 5; i++) {
			awbNum = driver.findElement(By.xpath("(//*[contains(@id,'AWB-Number')]//ancestor::span)[" + i + "]"))
					.getText();
			Thread.sleep(1000);
			awbList = new ArrayList<>();
			awbList.add(awbNum);
		}
		System.out.println(awbList.size());
		System.out.println(awbList.addAll(Arrays.asList(awbNum)));
		excelUtility.writeExcelValue(sheetName, columnName, rowIndex, awbList.toString());
	}

	@When("Click on Assign To")
	public void click_on_assign_to() throws InterruptedException {
		manifestCheckPage.click_AssignTo();
	}

	@When("Click on Save")
	public void click_on_save() throws InterruptedException {
		manifestCheckPage.click_Save();
	}

	@Then("{string} Toaster message is displayed")
	public void toaster_message_is_displayed(String string) throws InterruptedException {
		customerMatchingPage.text_shipmentAssignedSuccess();
	}

	@Then("{string} Toaster message should be displayed")
	public void toaster_message_should_be_displayed(String string) throws InterruptedException {
		customerMatchingPage.text_shipmentUnassignedSuccess();
	}

	@Given("update the shipment details$")
	public void updatetheShipmentdetails() throws Throwable {
		restAssuredPage.changeDescription_InRestAssured();
	}

	@Given("Update the Swagger details in RestAssured$")
	public void updatetheSwaggerDetailsInRestAssured() throws Throwable {
		restAssuredPage.postSwaggerAPI();
	}

	@And("Refresh the application")
	public static void refreshBrowser() {
		((BaseClass) driver).refreshWebPage();
	}

	@Then("{string} should be displayed as {string}")
	public void the_competency_should_be_displayed_as_entry_build(String value1, String value2)
			throws InterruptedException {
		int ScrollValue = 500;
		int i = 1, k = 0;
		boolean flag = false;
		for (i = 1; i <= entryBuildPage.tblHeaderlabels.size(); i++) {
			if (driver.findElement(By.xpath("((//datatable-header-cell/div/div)/table)[" + i + "]/tr/th[1]/span"))
					.getText().equalsIgnoreCase(value1)) {
				entryBuildPage.text_verifyEntryBuild(i, value2);
				globalSearchPage.click_entryShipmentSearchClose();
				flag = true;

			}
			if (flag) {
				break;
			}

			if (i % 5 == 0) {
				k += 1;
				js.executeScript("document.querySelector(\"datatable-body\").scrollLeft=" + (ScrollValue * k));
				Thread.sleep(2000);

			}
		}

	}

	@Then("{string} name should be displayed as {string}")
	public void the_team_name_should_be_displayed_as_entry_build_userlist(String value1, String value2)
			throws InterruptedException {
		int ScrollValue = 500;
		int i = 1, k = 0;
		boolean flag = false;
		for (i = 1; i <= entryBuildPage.tblHeaderlabels.size(); i++) {
			if (driver.findElement(By.xpath("((//datatable-header-cell/div/div)/table)[" + i + "]/tr/th[1]/span"))
					.getText().equalsIgnoreCase(value1)) {
				entryBuildPage.text_verifyEntryBuild_userlist(i, value2);
				flag = true;

			}
			if (flag) {
				break;
			}

			if (i % 5 == 0) {
				k += 1;
				js.executeScript("document.querySelector(\"datatable-body\").scrollLeft=" + (ScrollValue * k));
				Thread.sleep(2000);

			}
		}

	}

	@And("Filter using clearance scheme as {string},{string},{string},{string}")
	public void fetch_clearanceScheme(String value, String data1, String data2, String data3) throws Throwable {
		String headerval = "";
		entryBuildPage.tblHeaderlabels.size();
		System.out.println("Header Size : " + entryBuildPage.tblHeaderlabels.size());
		for (int i = 1; i < entryBuildPage.tblHeaderlabels.size(); i++) {
			headerval = driver
					.findElement(By.xpath("((//datatable-header-cell/div/div)/table)[" + i + "]/tr/th[1]/span"))
					.getText();
			if (headerval.trim().equalsIgnoreCase("Clearance Scheme")) {
				applicationFunctions.click_Filter_Icon("Clearance Scheme");
				applicationFunctions.set_Filter_Value(value);
				applicationFunctions.close_Filter();
				break;
			}
		}
		for (int j = 1; j < entryBuildPage.tblHeaderlabels.size(); j++) {
			headerval = driver
					.findElement(By.xpath("((//datatable-header-cell/div/div)/table)[" + j + "]/tr/th[1]/span"))
					.getText();
			if (headerval.trim().equalsIgnoreCase("AWB Number")) {
				j = j + 2;
				String awb = driver
						.findElement(By.xpath(
								"(//datatable-body-cell[contains(@class,'datatable-body-cell')])[" + j + "]/div/span"))
						.getText();
				System.out.println("AWB # is : " + awb);
				excelUtility.writeExcelValue(data1, data2, data3, awb);
				break;
			}
		}

	}

	@And("Fetch the teams and value from global search")
	public void fetch_TeamName_Value() throws Throwable {
		String team = null;
		entryBuildPage.tblHeaderlabels.size();
		System.out.println("Header Size : " + entryBuildPage.tblHeaderlabels.size());
		for (int i = 1; i < entryBuildPage.tblHeaderlabels.size(); i++) {
			String headerval = driver
					.findElement(By.xpath("((//datatable-header-cell/div/div)/table)[" + i + "]/tr/th[1]/span"))
					.getText();
			if (headerval.trim().equalsIgnoreCase("Teams")) {
				i = i + 2;
				Thread.sleep(3000);
				team = driver
						.findElement(By.xpath(
								"(//datatable-body-cell[contains(@class,'datatable-body-cell')])[" + i + "]/div/span"))
						.getText();
				System.out.println("Team Name : " + team);
				entryBuildPage.close_globalSearch.click();
				Thread.sleep(2000);
				customerMatchingPage.click_CustomerMatchingCompetency();
				String[] splitTeam = team.split(",");
				for (int j = 0; j < splitTeam.length; j++) {
					applicationFunctions.select_Team(splitTeam[j]);
					Thread.sleep(3000);
				}
				break;
			}
		}

		// excelUtility.writeExcelValue(data1, data2, data3, number);
		Thread.sleep(3000);
	}

	@And("Click toggle to select all available shipment")
	public void clickToggletoSelectAllShipment() throws InterruptedException {
		clickElementUsingJavaScript(entryBuildPage.selectAllToggle);
		Thread.sleep(3000);
	}

	@And("Verify the thumnails are matched")
	public void thumbnailsMatched() throws InterruptedException {
		if (TotalThumbnails_CustomerInvoice == entryBuildPage.listThumbnails.size()) {
			Assert.assertTrue(true, "Thumbnails Matched");
		} else {
			Assert.assertTrue(false, "Thumbnails not matched");
		}
	}

	@Then("Enable all columns in modal window")
	public void enable_Allcolumns() throws InterruptedException {
		waitTillElementVisible(entryBuildPage.tripple_dot);
		clickElementUsingJavaScript(entryBuildPage.tripple_dot);
		for (int j = 1; j <= entryBuildPage.modal_window_enabled.size(); j++) {
			driver.findElement(By.xpath(
					"((//div[@class='modal-content']//following::div[contains(@class,'drag-and-drop-list')]//following::genius-toggle-switch)[@ng-reflect-is-toggle-switched='false'])["
							+ j + "]//following-sibling::label/span"))
					.click();
		}

		entryBuildPage.save_modal_window.click();

	}

	@Then("Read all header names in the global search")
	public void readHeaderNames() throws InterruptedException {
		Thread.sleep(3000);
		int ScrollValue = 500;
		js.executeScript("document.querySelector(\"datatable-body\").scrollLeft=-1000");
		int k = 0;
		ArrayList<String> arrayList = new ArrayList<String>();
		for (int i = 0; i < entryBuildPage.globalSearch_HeaderLabels.size(); i++) {
			System.out.println(entryBuildPage.globalSearch_HeaderLabels.get(i).getText());
			arrayList.add(entryBuildPage.globalSearch_HeaderLabels.get(i).getText());
			if ((i + 1) % 5 == 0) {
				k += 1;
				js.executeScript("document.querySelector(\"datatable-body\").scrollLeft=" + (ScrollValue * k));
				Thread.sleep(2000);
			}
		}
		System.out.println("Total available column size i global search is :" + arrayList.size());
		log.info("Total available column size i global search is :" + arrayList.size());
	}

	@Then("Change the order of the column")
	public void changeColumnOrder() throws InterruptedException {
		waitTillElementVisible(entryBuildPage.tripple_dot);
		clickElementUsingJavaScript(entryBuildPage.tripple_dot);
		for (int i = 2; i < 5; i++) {
			WebElement ele1 = driver.findElement(By.xpath(
					"((//div[@class='modal-content']//following::div[contains(@class,'drag-and-drop-list')]//following::genius-toggle-switch)[@ng-reflect-is-toggle-switched='false'])["
							+ (i + 1) + "]//following-sibling::label/span"));
			WebElement ele2 = driver.findElement(By.xpath(
					"((//div[@class='modal-content']//following::div[contains(@class,'drag-and-drop-list')]//following::genius-toggle-switch)[@ng-reflect-is-toggle-switched='false'])["
							+ (i + 2) + "]//following-sibling::label/span"));

			Actions action = new Actions(driver);
			// action.clickAndHold(ele2).moveToElement(ele1).release().build().perform();

			action.dragAndDrop(ele2, ele1).build().perform();
			Thread.sleep(3000);

		}

	}

	@Then("Change the total value to {string}")
	public void updateTotalValue(String value) throws InterruptedException {
		enterValueIntoTextField(entryBuildPage.decln_totalValue, value);

	}

	@Then("Update currency in declaration screen {string}")
	public void updateCurrency(String currency) throws InterruptedException {
		entryBuildPage.decln_currency.click();
		selectUsingVisibleText(entryBuildPage.decln_currency, currency);
	}

	@Then("Update clearance scheme in declaration screen {string}")
	public void updateClearanceSch(String value) throws InterruptedException {
		entryBuildPage.decln_clnsch.click();
		selectUsingVisibleText(entryBuildPage.decln_clnsch, value);
		Thread.sleep(5000);
	}

	@Then("Expand the commodity details")
	public void exxpandCommodityDetails() throws InterruptedException {
		scrollIntoViewUsingJavaScript(entryBuildPage.commoditySlno);
		Thread.sleep(3000);
		entryBuildPage.commoditySlno.click();
	}

	@Then("Verify CIF value is {string}")
	public void calculateCif(String value) throws InterruptedException {
		Thread.sleep(5000);
		String cifTxt = null;
		for (int i = 1; i <= entryBuildPage.comm_dtl_header.size(); i++) {
			System.out.println(entryBuildPage.comm_dtl_header.get(i).getText());
			if (entryBuildPage.comm_dtl_header.get(i).getText().contains("CIF")) {
				for (int j = 1; j <= entryBuildPage.comm_dtl_row.size(); j++) {
					cifTxt = driver.findElement(By.xpath("//table[contains(@class,'commodity-table table')]/tbody/tr["
							+ j + "]/td[" + (i + 1) + "]")).getText();

				}

				System.out.println("Value is :" + value);
				System.out.println("CIF Value is:" + cifTxt.replace(",", ""));
				if (value.equals(cifTxt.replace(",", ""))) {
					// if(value.replace(",", "").equals(String.format(cifTxt, "%.2f"))) {
					// if(value.equals(String.format(cifTxt, "%.2f"))) {
					// if(Double.parseDouble(value)==sumVal) {
					Assert.assertEquals(value.equals(cifTxt.replace(",", "")), true);
				} else {
					Assert.assertEquals(false, true);
				}
				break;
			}

		}

	}

	@When("Display all alerts")
	public void HS_Code_Required_Alert() {

		List<WebElement> s1 = driver.findElements(By
				.xpath("((//span[text()='Declaration Requirement'])[1]/..//following::ul)[1]//following-sibling::li"));
		for (int i = 1; i <= s1.size(); i++) {

			if (driver.findElement(By.xpath(
					"(((//span[text()='Declaration Requirement'])[1]/..//following::ul)[1]//following-sibling::li)[" + i
							+ "]//span[2]"))
					.getText().trim().equalsIgnoreCase("HSCode Required")) {
				System.out.println(driver.findElement(By.xpath(
						"(((//span[text()='Declaration Requirement'])[1]/..//following::ul)[1]//following-sibling::li)["
								+ i + "]//span[2]"))
						.getText().trim());
				break;
			} else {
				System.out.println("HS Code Alert not found");
			}
		}
	}

	@Then("Select two user and submit")
	public void twoUser() throws Throwable {
		scrollIntoViewUsingJavaScript(entryBuildPage.selectUser);
		for (int i = 1; i <= entryBuildPage.multipleUser.size(); i++) {
			Thread.sleep(2000);
			entryBuildPage.multipleUser.get(i).click();
			Thread.sleep(2000);
			if (i > 2) {
				System.out.println("You cannot assign same shipment to  multiple members ");
				break;
			}

		}
		waitTillElementVisible(entryBuildPage.btnSave);
		EntryBuildPage.clickElementUsingJavaScript(entryBuildPage.btnSave);
		Thread.sleep(3000);
	}

	@When("enable all the teams")
	public void select_ALL_Teams() throws InterruptedException {
		List<WebElement> s1 = driver.findElements(
				By.xpath("//genius-radio-button[@uiformcontrolname='selectedTLLTeam']//following::label"));
		for (int i = 1; i <= s1.size(); i++) {
			driver.findElement(By.xpath(
					"(//genius-radio-button[@uiformcontrolname='selectedTLLTeam']//following::label)[" + i + "]/div"))
					.click();
			Thread.sleep(5000);
			// System.out.println("Team is :"+s1.get(i).getText());
			if (!(driver.findElement(By.xpath("//*[@id=\"cycleChanges-icon\"]")).getAttribute("ng-reflect-ng-class")
					.contains("disabled"))) {
				System.out.println("Cycle changes is enabled:" + driver.findElement(By.xpath(
						"(//genius-radio-button[@uiformcontrolname='selectedTLLTeam']//following::label)[1]/input"))
						.getText());
				break;
			}

			else {
				boolean s4 = driver.findElement(By.xpath("//*[@id=\"cycleChanges-icon\"]"))
						.getAttribute("ng-reflect-ng-class").contains("disabled");
				System.out.println("Cycle changes is NOT enabled:" + driver.findElement(By.xpath(
						"(//genius-radio-button[@uiformcontrolname='selectedTLLTeam']//following::label)[1]/input"))
						.getText());
			}
		}

	}

	@When("Moveover to commintmentdate and  Arrivaldate {string},{string},{string}")
	public void fetch_Dates(String data1, String data2, String data3) throws Throwable {
		int ScrollValue = 500;
		int k = 0;
		Thread.sleep(2000);
		boolean cflag = false, aflag = false;
		js.executeScript("document.querySelector(\"datatable-body\").scrollLeft=-1000");
		String commitment_date = null, Arrival_Date = null;
		entryBuildPage.tblHeaderlabels.size();
		System.out.println("Header Size : " + entryBuildPage.tblHeaderlabels.size());
		for (int i = 1; i <= entryBuildPage.tblHeaderlabels.size(); i++) {
			int x = 0;
			Actions act = new Actions(driver);
			String headerval = driver
					.findElement(By.xpath("((//datatable-header-cell/div/div)/table)[" + i + "]/tr/th[1]/span"))
					.getText();
			System.out.println(headerval);
			if (headerval.trim().equalsIgnoreCase("Commitment Date")) {
				x = i + 2;
				commitment_date = driver.findElement(By
						.xpath(("(//datatable-body-cell[contains(@class,'datatable-body-cell')])[" + x + "]/div/span")))
						.getAttribute("title");
				Thread.sleep(3000);
				act.moveToElement(driver.findElement(By.xpath(
						("(//datatable-body-cell[contains(@class,'datatable-body-cell')])[" + x + "]/div/span"))))
						.perform();
				Thread.sleep(3000);
				cflag = true;
				System.out.println("The commitment date is :" + commitment_date);
			} else if (headerval.trim().equalsIgnoreCase("Arrival Date")) {
				x = i + 2;
				Arrival_Date = driver.findElement(By
						.xpath(("(//datatable-body-cell[contains(@class,'datatable-body-cell')])[" + x + "]/div/span")))
						.getAttribute("title");
				Thread.sleep(3000);
				act.moveToElement(driver.findElement(By.xpath(
						("(//datatable-body-cell[contains(@class,'datatable-body-cell')])[" + x + "]/div/span"))))
						.perform();
				Thread.sleep(3000);
				aflag = true;
				System.out.println("The Arrival date is: " + Arrival_Date);
			}
			if (cflag && aflag) {
				break;
			}
			if (i % 5 == 0) {
				k += 1;
				js.executeScript("document.querySelector(\"datatable-body\").scrollLeft=" + (ScrollValue * k));
				Thread.sleep(2000);
			}
		}

//		if(commitment_date.length()>0 && Arrival_Date.length()>0)
//		{
//			Assert.assertEquals(commitment_date, Arrival_Date);
//			
//		}
//		else
//		{
//		Assert.assertFalse(false);
//		}
	}

	@Then("Disable the required columns in modal window")
	public void Requireddisable_columns() throws InterruptedException {
		waitTillElementVisible(entryBuildPage.tripple_dot);
		clickElementUsingJavaScript(entryBuildPage.tripple_dot);
		String var[] = { "Commodity Category", "Assigned User ID", "CI Flag", "Currency", "Clearance Scheme",
				"Clearance Status", "Teams", "Route", "Selection Codes", "Importer Company", "Consignee Company",
				"Clearance Mode", "Clearance Location", "Service Code", "Special handling code", "Incoterm", "IOR" };
		System.out.println("Total Columns to be enabled:" + var.length);
		// ele =
		// driver.findElements(By.xpath("((//div[@class='modal-content']//following::div[contains(@class,'drag-and-drop-list')]//following::genius-toggle-switch)[@ng-reflect-is-toggle-switched='true'])"));
		HashMap<Integer, String> map = new HashMap<>();

		for (int i = 1; i < entryBuildPage.modal_window_disabled.size(); i++) {
			map.put(i, driver.findElement(By.xpath(
					"(//div[@class='modal-content']//following::div[contains(@class,'drag-and-drop-list')]//following::genius-toggle-switch)["
							+ i + "]//following-sibling::label/span"))
					.getText());
		}
		System.out.println(map);

		for (Entry<Integer, String> entrySet : map.entrySet()) {
			for (int j = 0; j <= var.length - 1; j++) {
				// txt =
				// driver.findElement(By.xpath("(//div[@class='modal-content']//following::div[contains(@class,'drag-and-drop-list')]//following::genius-toggle-switch)["+entrySet.getKey()+"]//following-sibling::label/span")).getText();
				if (var[j].trim().equalsIgnoreCase(entrySet.getValue())) {
					try {
						Thread.sleep(3000);
						driver.findElement(By.xpath(
								"((//div[@class='modal-content']//following::div[contains(@class,'drag-and-drop-list')]//following::genius-toggle-switch)[@ng-reflect-is-toggle-switched='true'])["
										+ (entrySet.getKey() - 1) + "]//following-sibling::label/span"))

								.click();
					} catch (NoSuchElementException e) {
						driver.findElement(By.xpath(
								"((//div[@class='modal-content']//following::div[contains(@class,'drag-and-drop-list')]//following::genius-toggle-switch)[@ng-reflect-is-toggle-switched='true'])["
										+ (entrySet.getKey()) + "]//following-sibling::label/span"))
								.click();
					}
					break;
				}
			}

		}

		entryBuildPage.save_modal_window.click();
		Thread.sleep(3000);

	}

	@Then("verify the download icon in Activity log")
	public void downloadinfloatingpanel() throws InterruptedException {

		entryBuildPage.downloadiconfloatingpanel();
		List<WebElement> findElements = driver.findElements(By.xpath("//*[@id=\"fx-gn-ci-print-icon\"]"));
		System.out.println(findElements.size());
		for (WebElement s1 : findElements) {
			if (findElements.size() == 1) {
				Thread.sleep(1000);
				// entryBuildPage.downloadiconfloatingpanel();
				clickElementUsingJavaScript(driver.findElement(By.xpath("//*[@id=\"fx-gn-ci-print-icon\"]")));
				System.out.println("document was successfully downloaded");

			}

		}

	}

	@And("Verify the selected {string} document is downloaded successfully")
	public void downloaddocument(String document) throws InterruptedException {

		js.executeScript("arguments[0]. setAttribute('style', 'border:2px solid red')",
				driver.findElement(By.xpath("//span[text()='" + document
						+ "']//ancestor::div[@class='document-details ng-star-inserted']//a[starts-with(@class,'fx-gn-thumnail__doc-image')]")));
		clickElement(driver.findElement(By.xpath("//span[text()='" + document
				+ "']//ancestor::div[@class='document-details ng-star-inserted']//a[starts-with(@class,'fx-gn-thumnail__doc-image')]")));
		List<WebElement> findElements = driver.findElements(By.xpath("//span[text()='" + document
				+ "']//ancestor::div[@class='document-details ng-star-inserted']//a[starts-with(@class,'fx-gn-thumnail__doc-image')]"));
		System.out.println(findElements.size());

		for (WebElement webElement : findElements) {
			if (findElements.size() >= 1) {

				manifestCheckPage.downloaddocument();
				break;
			}
		}

	}

	@Then("search thumbnail match with {string} document and delete document")
	public void search_thumbnail_match_with_document(String document) throws InterruptedException {
		js.executeScript("arguments[0]. setAttribute('style', 'border:2px solid red')",
				driver.findElement(By.xpath("//span[text()='" + document
						+ "']//ancestor::div[@class='document-details ng-star-inserted']//a[starts-with(@class,'fx-gn-thumnail__doc-image')]")));
		clickElement(driver.findElement(By.xpath("//span[text()='" + document
				+ "']//ancestor::div[@class='document-details ng-star-inserted']//a[starts-with(@class,'fx-gn-thumnail__doc-image')]")));
		List<WebElement> findElements = driver.findElements(By.xpath("//span[text()='" + document
				+ "']//ancestor::div[@class='document-details ng-star-inserted']//a[starts-with(@class,'fx-gn-thumnail__doc-image')]"));
		System.out.println(findElements.size());

		for (WebElement webElement : findElements) {
			if (findElements.size() >= 1) {

				manifestCheckPage.deletedocument();
				break;
			}
		}
	}

	@And("Verify CI Document visible in Image Viewer")
	public void Verify_CI_Document_visible_in_Image_Viewer() throws InterruptedException {
		entryBuildPage.Verify_CI_Document_visible_in_Image_Viewer();
	}

	@And("Click Close Global search")
	public void Click_CloseGlobalSearch() throws Throwable {
		entryBuildPage.Click_CloseGlobalSearch();
	}

	@And("Click the Route Refresh Information In GlobalSearch")
	public void Click_the_route_refresh_in_globalsearch() throws InterruptedException {
		entryBuildPage.Retrieve_Route();
		Thread.sleep(3000);

	}

	@And("search thumbnail match with {string} document and  click on refresh button")
	public void search_thumbnail_and_click_on_refresh_button(String document) throws InterruptedException {
		if (!document.contains("CI")) {
			js.executeScript("arguments[0]. setAttribute('style', 'border:2px solid red')",
					driver.findElement(By.xpath("//span[text()='" + document
							+ "']//ancestor::div[@class='document-details ng-star-inserted']//a[starts-with(@class,'fx-gn-thumnail__doc-image')]")));
			clickElement(driver.findElement(By.xpath("//span[text()='" + document
					+ "']//ancestor::div[@class='document-details ng-star-inserted']//a[starts-with(@class,'fx-gn-thumnail__doc-image')]")));
			List<WebElement> findElements = driver.findElements(By.xpath("//span[text()='" + document
					+ "']//ancestor::div[@class='document-details ng-star-inserted']//a[starts-with(@class,'fx-gn-thumnail__doc-image')]"));
			System.out.println(findElements.size());

			for (WebElement webElement : findElements) {
				if (findElements.size() >= 1) {

					clickElementUsingJavaScript(driver.findElement(By.xpath("//a[@class='image-refresh-icon']")));
					Thread.sleep(4000);
					break;
				}
			}
		}
	}

	@Then("Verify Customer Invoice Icons displayed with {string}, {string} , {string}")
	public void customer_invoice_icons_displayed(String sheetName, String widgets, String rowIndex) throws Throwable {
		System.out.println(excelUtility.readExcelValue(sheetName, widgets, rowIndex));
		entryBuildPage.Verify_invoice(excelUtility.readExcelValue(sheetName, widgets, rowIndex));

	}

	@And("Click on the Duplicate Tab")
	public void click_on_the_duplicate_tab() throws InterruptedException {
		entryBuildPage.click_Duplicate();
		Thread.sleep(4000);
	}

	@And("Switch to the Last Window {string}")
	public void switch_to_new_window(String windowName) throws InterruptedException {
		entryBuildPage.switchToLastWindow(windowName);
		Thread.sleep(3000);

	}

	@And("Call the webservice to verify submitTeam is {string},{string},{string},{string}")
	public void call_the_webservices_to_submitTeam(String sheetName, String ColumnName, String rowIndex, String team)
			throws InterruptedException, NumberFormatException, IOException {

		Response response = RestAssured.given().header("Authorization", restAssuredPage.generateOktaToken()).when().get(
				"https://gemini-inbound-shipment-data-service-release.app.singdev1.paas.fedex.com/import-shipment/awb/"
						+ excelUtility.readExcelValue(sheetName, ColumnName, rowIndex));
		// .get("https://gemini-inbound-shipment-data-service-staging.app.singbo1.paas.fedex.com/import-shipment/awb/"+excelUtility.readExcelValue(sheetName,
		// ColumnName, rowIndex));
		System.out.println(response.prettyPrint());
		System.out.println("Submit Team is :" + response.jsonPath().getString("[0].submitTeam"));

		if (team.equalsIgnoreCase(response.jsonPath().getString("[0].submitTeam")))
			Assert.assertTrue(true);
		else
			Assert.assertTrue(false);
	}

	@And("Call the webservices to verify the class version id for awb {string},{string},{string} is greaterthanOrEqual to {string}")
	public void verifyClassVersionId(String sheetName, String ColumnName, String rowIndex, String num)
			throws Throwable {
		boolean flag = false;
		long awb = Long.parseLong(excelUtility.readExcelValue(sheetName, ColumnName, rowIndex));
		Response response = RestAssured.given().header("Authorization", restAssuredPage.generateOktaToken()).when().get(
				"https://gemini-inbound-shipment-data-service-release.app.singdev1.paas.fedex.com/import-shipment/awb/"
						+ awb);
		// .get("https://gemini-inbound-shipment-data-service-staging.app.singbo1.paas.fedex.com/import-shipment/awb/"+awb);

		System.out.println(response.prettyPrint());
		System.out.println("class Version Id is :" + response.jsonPath().getString("[0].classVersionId"));
		System.out.println("Submit Team is :" + response.jsonPath().getString("[0].submitTeam"));

		for (int k = 1; k <= 5; k++) {
			if (response.jsonPath().getString("[0].classVersionId") != null
					&& response.jsonPath().getString("[0].classVersionId").length() > 0) {
				if (Integer.parseInt(response.jsonPath().getString("[0].classVersionId")) == Integer.parseInt(num)) {
					flag = true;
					break;

				} else {
					applicationFunctions.click_AssignToMe_Icon();
					fetch_AWBNo(sheetName, ColumnName, rowIndex);
					verifyClassVersionId(sheetName, ColumnName, rowIndex, num);
				}

			}

		}
		if (flag == true)
			Assert.assertEquals(flag, true);
		else
			Assert.assertEquals(flag, true);

	}
	/* to write the json into a file*/
	
	public Response WriteAJsonFile(String sheetName, String ColumnName, String rowIndex)
			throws Throwable {
		long awb = Long.parseLong(excelUtility.readExcelValue(sheetName, ColumnName, rowIndex));
		Response response = RestAssured.given().header("Authorization", restAssuredPage.generateOktaToken()).when().get(
				"https://gemini-inbound-shipment-data-service-release.app.singdev1.paas.fedex.com/import-shipment/awb/"
						+ awb);
	//	System.out.println("class Version Id is :" + response.jsonPath().getString("[0].classVersionId"));

		/********************
		 * creating TestData/jsonFile.txt
		 *********************************/

		try {
			FileWriter file = new FileWriter("TestData/jsonFile.txt");
			file.write("{ \"persistFlag\": \"Y\",\r\n" + "  \"shipmentList\":" + response.prettyPrint() + "}");
			file.close();
		} catch (IOException e) {
			e.printStackTrace();

		} 
		return response;
	}
	
	/* to post to webservices*/
	public void callTheProcessFlow() throws Throwable
	{
		System.out.println("in pay load to trigger the POST");
		JSONParser jsonParser = new JSONParser();

		Object jsonObject = jsonParser.parse(new FileReader("TestData/jsonFile.txt"));
		String jsonBody = jsonObject.toString();
		String BarerToken = restAssuredPage.generateOktaToken();
		//System.out.println(BarerToken);
		Response payload = RestAssured.given().header("Authorization", BarerToken)
				.header("Content-Type", "application/json").body(jsonBody)
				//.baseUri("https://gemini-inbound-shipment-data-service-release.app.singdev1.paas.fedex.com").when()     // Rel Env
				.baseUri("https://gemini-inbound-shipment-data-service-development.app.singdev1.paas.fedex.com").when()   // Dev Env
				.post("/import-shipment/save-shipment");

		System.out.println("Status Code of changeDescription : " + payload.getStatusCode());
	}
	
	/* To fetch the JSON************** for use in 74 to 77 TCs */
	Random random = new Random();
	int randomNumber = random.nextInt(9999);
	String randomNumberStr = Integer.toString(randomNumber);
	
	@And("Call the webservices to fetch the JSON from the seelcted awb {string},{string},{string} is greaterthanOrEqual to {string},{string},{string}")
	public void fetchjson(String sheetName, String ColumnName, String rowIndex, String num, String ConsigneeComp, String setCompanyValue)
			throws Throwable {
		Response response =	WriteAJsonFile( sheetName,  ColumnName,  rowIndex) ;

		/********************
		 * reading from the TestData/jsonFile.txt
		 *********************************/
		

		File log = new File("TestData/jsonFile.txt");
		String awbSearch = response.jsonPath().getString("[0].awbNbr");
		System.out.println("Source AWB :"+awbSearch);

		/*
		 * System.out.println("Generated 4-digit random number as string: " +
		 * randomNumberStr); 
		 * System.out.println("awbSearch===>" + awbSearch);
		 * System.out.println("randomNumberStr ====> " + randomNumberStr);
		 *
		 */ 

		
		String companyNameSearch = "", companyNameReplace = "";

		for (int sr = 0; sr <= 7; sr++) {
			if (response.jsonPath().getString("[0].customers.role[" + sr + "]").contains("C")
					&& response.jsonPath().getString("[0].customers.sourceType[" + sr + "]").contains("MDE"))

			{
				System.out.println("IN IF >>>>> Role[" + sr + "]"
						+ response.jsonPath().getString("[0].customers.role[" + sr + "]") + "\n >>>>>> Source Type : ["
						+ sr + "]" + response.jsonPath().getString("[0].customers.sourceType[" + sr + "]"));
				companyNameSearch = response.jsonPath().getString("[0].customers.companyName[" + sr + "]");
				 System.out.println(" companyNameSearch >>>>>[" + sr +"]" +companyNameSearch);
                if(companyNameSearch!=null)
				companyNameReplace = companyNameSearch.replace(companyNameSearch, setCompanyValue);
			}
			/* This is place holder for Source Type = MDE */
			
			  else if(response.jsonPath().getString("[0].customers.role["+
			  sr+"]").contains("C") &&
			  response.jsonPath().getString("[0].customers.sourceType["+sr+"]").contains(
			  "GENIUS"))
			  
			  
			  { 
			  System.out.println(" IN ELSE >>>>> Role["+ sr
			  +"]"+response.jsonPath().getString("[0].customers.role["+ sr+"]")
			  +"\n >>>>>> Source Type : ["+sr +"]"
			  +response.jsonPath().getString("[0].customers.sourceType["+sr+"]"));
			  companyNameSearch= response.jsonPath().getString("[0].customers.companyName["+sr+"]");
			  System.out.println(" companyNameSearch >>>>>[" + sr +"]" +companyNameSearch);
			 // roleSearch= response.jsonPath().getString("[0].customers.role["+sr+"]");
			  companyNameReplace= companyNameSearch.replace(companyNameSearch, setCompanyValue);
			  break; 
			  }
			 
		}
		String awbReplace = response.jsonPath().getString("[0].awbNbr")
				.replace(response.jsonPath().getString("[0].awbNbr").substring(4,8), randomNumberStr);
		String shipOidNbrSearch = response.jsonPath().getString("[0].shipOidNbr");
		String shipOidNbrRepleace = shipOidNbrSearch.replace(shipOidNbrSearch.substring(4,8), randomNumberStr);
		System.out.println("awbSearch===>" + awbSearch);
		System.out.println("shipOidNbrSearch =====>"+shipOidNbrSearch);
		System.out.println("Gereated AWB : " +awbReplace);
		System.out.println("Gereated shipOidNbr : " +shipOidNbrRepleace);
        
		try {
			FileReader fr = new FileReader(log);
			String s;
			String totalStr = "";
			try (BufferedReader br = new BufferedReader(fr)) {

				while ((s = br.readLine()) != null) {
					totalStr += s + String.format("%n");
				}
				totalStr = totalStr.replaceAll(awbSearch, awbReplace);
				totalStr = totalStr.replaceAll(shipOidNbrSearch, shipOidNbrRepleace);
				totalStr = totalStr.replace(companyNameSearch, companyNameReplace);
				FileWriter fw = new FileWriter(log);
				fw.write(totalStr);
				fw.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

			callTheProcessFlow(); // To post the AWB in RestAssured  ( instead of manual SOAP steps) 

		
		/****************Assert for the validation based on new shipments********************/
		globalSearchPage.click_entryGlobalSearch();
		globalSearchPage.enter_shipmentValue(awbReplace);
		globalSearchPage.click_entryShipmentSearch();
		
		//Assert.assertEquals(driver.findElement(By.xpath("//datatable-body-cell[@class='datatable-body-cell sort-active']/div/span[@id='Consignee-Company-0']")).getText(), companyNameReplace);
	
		/************************************/
	}
	
	@And("Creating mulitple Shipments with different event sequence number from the selected awb {string},{string},{string}")
	  public void LoadNewAWBs(String sheetName, String ColumnName, String rowIndex)
				throws Throwable {
	  for(int ab=0;ab<18;ab++) {
		  int randomNumber1 = random.nextInt(9999);
		Response response =	WriteAJsonFile( sheetName,  ColumnName,  rowIndex) ;
		String randomNumberStr1 = Integer.toString(randomNumber1);
		/********************
		 * reading from the TestData/jsonFile.txt
		 *********************************/


		File log = new File("TestData/jsonFile.txt");
		String awbSearch = response.jsonPath().getString("[0].awbNbr");
		System.out.println("Source AWB :"+awbSearch);


		String awbReplace = response.jsonPath().getString("[0].awbNbr")
				.replace(response.jsonPath().getString("[0].awbNbr").substring(4,8), randomNumberStr1);
		String shipOidNbrSearch = response.jsonPath().getString("[0].shipOidNbr");
		String shipOidNbrRepleace = shipOidNbrSearch.replace(shipOidNbrSearch.substring(4,8), randomNumberStr1);
		String eventsequencenumber = response.jsonPath().getString("[0].evntSeqNbr");
		String EventSequenceReplace = eventsequencenumber.replace(eventsequencenumber.substring(4,8), randomNumberStr1);
		System.out.println("awbSearch===>" + awbSearch);
		System.out.println("shipOidNbrSearch =====>"+shipOidNbrSearch);
		System.out.println("Generated AWB : "+ab + "<<<<>>>>" +awbReplace);
		System.out.println("Generated shipOidNbr : " +shipOidNbrRepleace);
		System.out.println("eventsequencenumber===>" + eventsequencenumber);
		System.out.println("Generated EventSequence : " +EventSequenceReplace);
		try {
			FileReader fr = new FileReader(log);
			String s;
			String totalStr = "";
			try (BufferedReader br = new BufferedReader(fr)) {

				while ((s = br.readLine()) != null) {
					totalStr += s + String.format("%n");
				}
				totalStr = totalStr.replaceAll(awbSearch, awbReplace);
				totalStr = totalStr.replaceAll(shipOidNbrSearch, shipOidNbrRepleace);
				FileWriter fw = new FileWriter(log);
				fw.write(totalStr);
				fw.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

			callTheProcessFlow(); // To post the AWB in RestAssured  ( instead of manual SOAP steps)

}
	  }		
	
	@And("Call the webservices for the AWBNo for MAWB {string},{string},{string},{string}")
	public void AWBNo_for_MAWB(String sheetName, String ColumnName, String rowIndex, String TcNum) throws Throwable 
	{
		LocalDate currentDate = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyymmdd");
        String routeDateRequired = currentDate.format(formatter);  //routeDate="20240904"
        
        String evntSeqNbr="", awbNbr="" , shipOidNbr="",shipOidNbrRepleace="", masterAWBNbr="" ,routeNbr="scenario based",routeNbrReplace="", mstrAWB="",evntSeqNbrReplace="",awbReplace="" ; 
        
		Response response =	WriteAJsonFile( sheetName,  ColumnName,  rowIndex) ;

        /*
         * TCP001_ Verify MAWB updated when Removed (MAWB null)
         * TCP002_ Verify exisitng MAWB updated to New shipment with same conveyance records (evntSeqNbr, awbNbr , shipOidNbr, MAWB null)
         * TCP003_Verify exisitng MAWB  changed to exisitng shipment with  same conveyance records (dates:" has to set to today,route number,	 MAWB =null)
         * TCP004_Verify New MAWB updated to exisiting shipment when conveyance details are updated ( {evntSeqNbr, awbNbr , shipOidNbr, route number}=new itself, MAWB null)
         */
		File log = new File("TestData/jsonFile.txt");
		
     mstrAWB =response.jsonPath().getString("[0].masterAWBNbr");
     evntSeqNbr=response.jsonPath().getString("[0].evntSeqNbr");
     evntSeqNbrReplace=evntSeqNbr.replace(evntSeqNbr.substring(4,8), randomNumberStr);
     awbNbr=response.jsonPath().getString("[0].awbNbr");
     awbReplace = awbNbr.replace(awbNbr.substring(4,8), randomNumberStr);		 
     shipOidNbr = response.jsonPath().getString("[0].shipOidNbr");
	 shipOidNbrRepleace = shipOidNbr.replace(shipOidNbr.substring(4,8), randomNumberStr);
	 routeNbr= response.jsonPath().getString("[0].routeNbr");
	 routeNbrReplace = routeNbr.replace(routeNbr.substring(2,3), randomNumberStr); // Check the count of the random for 2

		
		try {
			FileReader fr = new FileReader(log);
			String s;
			String totalStr = "";
			String nullmstr=null;
			try (BufferedReader br = new BufferedReader(fr)) {

				while ((s = br.readLine()) != null  ) {
					totalStr += s + String.format("%n");
				}
				
				
				//TCP001_ Verify MAWB updated when Removed (MAWB null)
				if(TcNum=="TCP001") {
				totalStr = totalStr.replace(mstrAWB,"\bnull"+"\b" );
				//totalStr = totalStr.replace("null",null );// supposed to be null not "null"
				}
				
				//TCP002_ Verify existing MAWB updated to New shipment with same conveyance records (evntSeqNbr, awbNbr , shipOidNbr, MAWB null)
		        
				if(TcNum=="TCP002") {
					//totalStr = totalStr.replace(MstrAWB, null);
					}
				//TCP003_Verify existing MAWB  changed to existing shipment with  same conveyance records (dates:" has to set to today,route number,	 MAWB =null)
				if(TcNum=="TCP003") {
					totalStr = totalStr.replace(mstrAWB, "null");
					totalStr = totalStr.replaceAll(response.jsonPath().getString("[0].routeDate"), routeDateRequired);
					}		          
			  //TCP004_Verify New MAWB updated to existing shipment when conveyance details are updated ( {evntSeqNbr, awbNbr , shipOidNbr, route number}=new itself, MAWB null)
				if(TcNum=="TCP004") {
					totalStr = totalStr.replace(mstrAWB, "null");
					totalStr = totalStr.replace(evntSeqNbr, evntSeqNbrReplace);
					totalStr = totalStr.replace(awbNbr, awbReplace);
					totalStr = totalStr.replace(shipOidNbr, shipOidNbrRepleace);
					totalStr = totalStr.replace(routeNbr, routeNbrReplace);
					 
					
					
					}		          		         	

				FileWriter fw = new FileWriter(log);
				fw.write(totalStr);
				fw.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	//	callTheProcessFlow(); // To post the AWB in RestAssured  ( instead of manual SOAP steps) 

		
		
	
	}

	@Then("{string} text should be displayed")
	public void response_should_be_displayed_as_dops_response_time(String value1) throws InterruptedException {
		System.out.println(">>>>>>>>>>>>>>>>>>>>>DOPS Response Time "
				+ driver.findElement(By.xpath("//span[@id='DOPS-Response-Time-0']")).getText());

	}
	
	@Then("Write the AWB to file")
	
	public void store_awb() throws Exception
	{
		Thread.sleep(2000);
		js.executeScript("document.querySelector(\"datatable-body\").scrollLeft=-1000");
		String number = null;
		entryBuildPage.tblHeaderlabels.size();
		System.out.println("Header Size : " + entryBuildPage.tblHeaderlabels.size());
		for (int i = 1; i < entryBuildPage.tblHeaderlabels.size(); i++) {
			String headerval = driver
					.findElement(By.xpath("((//datatable-header-cell/div/div)/table)[" + i + "]/tr/th[1]/span"))
					.getText();
			if (headerval.trim().equalsIgnoreCase("AWB Number")) {
				i = i + 2;
				Thread.sleep(3000);
				number = driver
						.findElement(By.xpath(
								"(//datatable-body-cell[contains(@class,'datatable-body-cell')])[" + i + "]/div/span"))
						.getText();
				break;
			} else if (headerval.trim().equalsIgnoreCase("Conveyance Number")) {
				// i = i + 1;
				Thread.sleep(3000);
				number = driver
						.findElement(By.xpath(
								"(//datatable-body-cell[contains(@class,'datatable-body-cell')])[" + i + "]/div/span"))
						.getText();
				break;
			}
		}
		System.out.println("AWB | Conveyane # is : " + number);
		
		/********************
		 * creating TestData/AWBforDOPs.txt
		 *********************************/
 
		try {
			FileWriter file = new FileWriter("TestData/AWBforDOPs.txt");
			file.write(number);
			file.close();
		} catch (IOException e) {
			e.printStackTrace();
 
		}
	}
	
	  @Then("Search the shipment from text file")
	   public void fetch_shipment_from_text_file() throws Exception
	   {    
	       String FilePath="TestData/AWBforDOPs.txt";
	       DopsPaymentAWBsFile(FilePath);
	   }
	  
	  @Then("Search the payment failed shipment from text file")
	   public void fetch_payment_failed_shipment_from_text_file() throws Exception
	   {       
	 
	       String FilePath="TestData/AWBForDOPsFailurePayment.txt";
	       DopsPaymentAWBsFile(FilePath);
	   }
	  
	  public void DopsPaymentAWBsFile(String FilePath) throws Exception
	  {
	       try {
	           BufferedReader br = new BufferedReader(new FileReader(FilePath));
	           String line;
	           while ((line = br.readLine()) != null) {
	        	   globalSearchPage.enter_shipmentValue(line);
	           }
	 
	           br.close();
	       }
	       catch (IOException e) {
	           System.err.println("Error reading the file: " + e.getMessage());
	       }
  
	  }

	  @And("Click on Duty bill account search icon {string}")
		public void click_on_duty_bill_account_search(String accnum) throws InterruptedException {
		 entryBuildPage.Clickdutybillaccountsearch();
		 Thread.sleep(2000);
		 entryBuildPage.enterdutyaccountnumber(accnum);
		 Thread.sleep(2000);
		 entryBuildPage.gobutton();
//		 Thread.sleep(1000);
		 
		 
		 }
	  
	  @And("Check for Duty bill account search icon disabled")
	  public void click_on_duty_bill_account_search_disabled() throws InterruptedException {

			 Assert.assertEquals(entryBuildPage.Clickdutybillaccountsearch.isEnabled() , false);

			 if(entryBuildPage.Clickdutybillaccountsearch.isEnabled() == false )
			 {
				 System.out.println("found disabled");

			 }
			 			 
			 }
	  
//	  @And("Enter Active account number")
//		public void enter_active_account_number() throws InterruptedException{
//			entryBuildPage.enterdutyaccountnumber();
//				
//		}
//	  @Then("Click on go")
//		public void Click_on_go() throws InterruptedException {
//			entryBuildPage.gobutton();
//			
//		}
	  @Then("Click on Link")
		public void Click_on_Link() throws InterruptedException {
			entryBuildPage.linkbutton();
		}
		////////////////////////////////////////////////////////
		
		@And("Sort using columnname {string}")
		public void Sort_using_Incoterm_as(String columnName) throws ElementNotInteractableException, InterruptedException {		
			Thread.sleep(2000);
			int ScrollValue=500;
			int k=0,i=1;
			boolean flag=false;
			Actions actions = new Actions(driver);
			js.executeScript("document.querySelector(\"datatable-body\").scrollLeft=-1000");
			for (i = 1; i <= entryBuildPage.tblHeaderlabels.size(); i++) {
				if(driver.findElement(By.xpath("((//datatable-header-cell/div/div)/table)["+ i +"]/tr/th[1]/span")).getText().equalsIgnoreCase(columnName)){
					try {
							
						
						 WebElement hoverElement = driver.findElement(By.xpath("((//datatable-header-cell/div/div)/table)["+ i +"]/tr/th[1]/span"));
						 actions.moveToElement(hoverElement).perform();
						 js. executeScript("arguments[0]. setAttribute('style', 'border:2px solid red')",driver.findElement(By.xpath("((//datatable-header-cell/div/div)/table)["+ i +"]/tr/th[3]/span/a")));
						 driver.findElement(By.xpath("((//datatable-header-cell/div/div)/table)["+ i +"]/tr/th[3]/span/a")).click();
						Thread.sleep(2000);
						applicationFunctions.click_Filter_Icon(columnName);
					} catch (ElementNotInteractableException | TimeoutException e) {
						js.executeScript("document.querySelector(\"datatable-body\").scrollLeft=1000");
						//applicationFunctions.click_Filter_Icon(columnName);	
						flag=true;
					}
					//applicationFunctions.set_Filter_Value(value);
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
		
		////////////////////////////////////////////////////////	

}
