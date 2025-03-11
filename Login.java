package stepDefinitions;

import java.io.IOException;
import java.util.Map;
import java.util.ResourceBundle;
import org.openqa.selenium.Keys;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.interactions.Actions;
import com.FedEx.GeminiAutomationSG.PageObjects.GlobalSearchPage;
import com.FedEx.GeminiAutomationSG.PageObjects.LoginPage;
import com.FedEx.GeminiAutomationSG.PageObjects.ManifestCheckPage;
import com.FedEx.GeminiAutomationSG.TestBase.BaseClass;
import com.FedEx.GeminiAutomationSG.Utilities.ExcelUtility;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.After;
import io.cucumber.java.AfterStep;
import io.cucumber.java.Scenario;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

public class Login extends BaseClass {

	LoginPage loginPage;
	GlobalSearchPage globalSearchPage;
	ManifestCheckPage manifestCheckPage;
	ExcelUtility excelUtility = new ExcelUtility();

	@Given("User is in Gemini application login page")
	public void gemini_login_page() throws Throwable {
		setUp();
		loginPage = new LoginPage(driver);
		loginPage.set_Username(decodeBase64Value(resourceBundle.getString("Username")));
		loginPage.set_Password(decodeBase64Value(resourceBundle.getString("Password")));
		loginPage.click_Submit();
		loginPage.Push_notification();         // added this in SIT because of again asking the push Notification
		loginPage.click_Push();			
		for(int i=1;i<=3;i++) {			
				Thread.sleep(3000);
				try {
				if(loginPage.WelcomeScreen.isDisplayed()) {
					loginPage.swipeRight_Country();
					loginPage.select_Country();
					loginPage.click_Continue();
					break;
				}	
				else if(driver.getTitle().startsWith("PurpleID")) {
					driver.navigate().refresh();
//					loginPage.set_Username(decodeBase64Value(resourceBundle.getString("Username")));
//				loginPage.set_Password(decodeBase64Value(resourceBundle.getString("Password")));
//					loginPage.click_Submit();
					//loginPage.Push_notification(); 
					loginPage.click_Push();
						Thread.sleep(3000);
						try {
							waitTillElementVisible(loginPage.WelcomeScreen);
							if(loginPage.WelcomeScreen.isDisplayed()) {
								loginPage.swipeRight_Country();
								loginPage.select_Country();
								loginPage.click_Continue();
								break;
							}
							else {
								System.err.println("Context Selection Screen not appeared.retrying...");
								driver.navigate().refresh();
								driver.get(url+"context_selection/");				
							}
						} catch (NoSuchElementException e1) {
							System.err.println("Context Selection Screen not appeared.retrying...");
							driver.navigate().refresh();
							driver.get(url+"context_selection/");
						}
				}
				}catch (NoSuchElementException e1) {
					System.err.println("Context Selection Screen not appeared.retrying...");
					driver.get(url+"context_selection/");
				}
				
			}
		
	}
	
	@Given("^User login again Gemini application$")
	public void gemini_login_again() throws Throwable {
		resourceBundle = ResourceBundle.getBundle("config");
		if(resourceBundle.getString("UAT_URL").contains("staging")||resourceBundle.getString("REL_URL").contains("release")) {	


			if(driver.getTitle().startsWith("PurpleID")) {
					//contains("PurpleID - Sign In")) {			
				manifestCheckPage = new ManifestCheckPage(driver);
				waitTillElementVisible(manifestCheckPage.usernameLoginPage);
				Thread.sleep(2000);
				System.out.println(decodeBase64Value(resourceBundle.getString("Username")));
				//loginPage.set_Username(decodeBase64Value(resourceBundle.getString("Username")));
				manifestCheckPage.usernameLoginPage.sendKeys(decodeBase64Value(resourceBundle.getString("Username")));
				loginPage.set_Password(decodeBase64Value(resourceBundle.getString("Password")));
				loginPage.click_Submit();
				//loginPage.Push_notification(); 
				loginPage.click_Push();
				loginPage.swipeRight_Country();
				loginPage.select_Country();
				loginPage.click_Continue();	
				Thread.sleep(4000);				
			}			

			try {
				if(loginPage.WelcomeScreen.isDisplayed()) {
					loginPage.select_Country();
					loginPage.click_Continue();	

				}
			} catch (NoSuchElementException e) {
				System.out.println("Loading competency Screen..");
			}
		}
	}
		


	@Given("User clicks on Entry Build Competency with teamlist$")
	public void user_clicks_on_entry_build_competency_with_teamlist() throws Throwable {
		// entrybuildpage = new EntryBuildPage(driver);
		// entrybuildpage.click_entryBuild();
	}
	
	@When("Click on Global search")
	public void click_globalSearch_icon() throws Exception {
		globalSearchPage = new GlobalSearchPage(driver);
		globalSearchPage.click_entryGlobalSearch();
	}
//	@And("Select Dropdown as {string}")
//	public void select_dropdown_as_awb(String value) throws Exception {
//		globalSearchPage = new GlobalSearchPage(driver);
//		globalSearchPage.click_AWBdropdown(value);
//		
//	}

	@And("Search the shipment {string},{string},{string} in Global Search")
	public void global_search(String sheetName, String columnName, String rowIndex) throws InterruptedException, IOException {
		globalSearchPage.enter_shipmentValue(excelUtility.readExcelValue(sheetName, columnName, rowIndex));
		Thread.sleep(3000);
		globalSearchPage.click_entryShipmentSearch();
	}

	

	@When("Search the shipment with two or more AWB numbers$")
	public void Search_more_awbs(DataTable usercredentials) throws Throwable {
		for (Map<String, String> data : usercredentials.asMaps(String.class, String.class)) {
			globalSearchPage.enter_shipmentValue(data.get("AWB Numbers"));
		}
	}
	
	

	@And("Click on Shipment Search$")
	public void shipment_search() throws Throwable {
		globalSearchPage.click_entryShipmentSearch();
		Thread.sleep(2000);
	}

	@And("Performs CtrlA$")
	public void ctrlA() throws Throwable {
		Actions act = new Actions(driver);
		act.keyDown(Keys.CONTROL);
		act.sendKeys("a");
		act.perform();
		Thread.sleep(2000);
	}

	@Then("All the Shipments should be selected in Global search window$")
	public void select_all_shipments() throws Throwable {
		globalSearchPage.validate_ShipmentSelected();
		Thread.sleep(2000);
	}
	
	@Then("Close the global search window")
	public void close_globalSearch_window() throws Throwable {
		globalSearchPage.click_entryShipmentSearchClose();
	}

	
	@AfterStep
	public void as(Scenario scenario) throws IOException, InterruptedException {
		TakesScreenshot ts = (TakesScreenshot) driver;
		byte[] screenshot = ts.getScreenshotAs(OutputType.BYTES);
		scenario.attach(screenshot, "image/png", scenario.toString());
	}

	@After
	public void takeScreenShotOnFailedScenario(Scenario scenario) {
		System.out.println("This is from After hook");
		if ((scenario.isFailed())) {
			TakesScreenshot ts = (TakesScreenshot) driver;
			byte[] screenshot = ts.getScreenshotAs(OutputType.BYTES);
			scenario.attach(screenshot, "image/png", scenario.getName());
		}
		driver.quit();
	}

	
}
