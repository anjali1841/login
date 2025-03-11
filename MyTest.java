package stepDefinitions;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

import org.apache.poi.EncryptedDocumentException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

public class MyTest {

	public static String readExcelValue(String sheetName, String rowIndex, String columnName) {
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

	public static void writeExcelValue(String sheetName, String columnName, String rowIndex, String firstRecordAWB) {
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
				Cell cell = sheet.getRow(Integer.parseInt(rowIndex)).getCell(i);
				cell.setCellValue(firstRecordAWB);
			}
		}
	}

	public static String[] splitString(String str) {
		return str.split(",");
	}

}
