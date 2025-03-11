package stepDefinitions;

import java.awt.AWTException;

import com.FedEx.GeminiAutomationSG.PageObjects.ReportsPage;
import com.FedEx.GeminiAutomationSG.TestBase.BaseClass;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

public class Reports extends BaseClass {

	ReportsPage reportsPage = new ReportsPage(driver);

	@Given("Verify Report Links are displayed")
	public void verify_report_links_are_displayed() throws InterruptedException {
		reportsPage.verify_Reports_Displayed();
	}

	@Given("Click on G7 Billing Report")
	public void click_on_g7_billing_report() throws AWTException, InterruptedException {
		reportsPage.click_G7BillingReport_Link();
		zoomOutUsingRobotClass();
		Thread.sleep(4000);
		reportsPage.select_Cycle();
		Thread.sleep(4000);
	}

	@Given("Click on High GST Verification Report")
	public void click_on_high_gst_verification_report() throws AWTException, InterruptedException {
		reportsPage.click_HighGSTVerification_Link();
		zoomOutUsingRobotClass();
		Thread.sleep(4000);
		reportsPage.select_Cycle();
		Thread.sleep(4000);
	}

	@When("Select Cycle Date range")
	public void select_cycle_date_range() throws InterruptedException {
		reportsPage.select_Date_Range();
		Thread.sleep(4000);
		
	}

	@When("Select Cycle Number")
	public void select_cycle_number() throws InterruptedException {
		reportsPage.select_Refresh();
		Thread.sleep(5000);
		reportsPage.select_CycleNumber();
	}

	@When("Select GST Threshold Value")
	public void select_gst_threshold_value() {

	}

	@Then("Verify Billing Report are displayed as Data Selected")
	public void verify_billing_report_are_displayed_as_data_selected() {
		reportsPage.verify_Reports_Data();
	}

	@Then("Click on Welcome Page")
	public void click_on_welcome_page() throws InterruptedException {
		reportsPage.click_WelcomePage_Link();
		Thread.sleep(4000);
	}

}