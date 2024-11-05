package kr.or.ddit.api;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.web.servlet.view.document.AbstractXlsView;

public class ExcelView extends AbstractXlsView {
	
	//model이 넘어온 데이터
	//workebook이 엑셀 파일 
	@Override
	protected void buildExcelDocument(Map<String, Object> model, Workbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		//데이터 가져오기 - Controller에서 저장한 이름을 가지고 찾아오기
		List<String> list = (List<String>)model.get("oop");
		
		//시트 만들기
		Sheet sheet = workbook.createSheet();
		//시트 이름 만들기
		workbook.setSheetName(0, "객체지향");
		//시트 너비 설정 
		sheet.setColumnWidth(0, 256*20);
		
		//제목 셀 만들기 
		Row firstRow = sheet.createRow(0);
		Cell firstCell = firstRow.createCell(0);
		firstCell.setCellValue("객체 지향 언어의 3대 특징");
		
		//데이터 출력 
		int rownum = 1;
		for(String str : list) {
			Row row = sheet.createRow(rownum);
			rownum = rownum + 1;
			Cell cell = row.createCell(0);
			cell.setCellValue(str);
		}
	}
}

