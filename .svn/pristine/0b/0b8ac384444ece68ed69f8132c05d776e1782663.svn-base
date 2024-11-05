package kr.or.ddit.api;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.springframework.web.servlet.view.document.AbstractPdfView;

import com.lowagie.text.Cell;
import com.lowagie.text.Document;
import com.lowagie.text.Font;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Table;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfWriter;

public class PdfView extends AbstractPdfView {

	@Override
	protected void buildPdfDocument(Map<String, Object> model,
			Document document, PdfWriter writer,
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		//데이터 가져오기
		List<String> list = (List<String>)model.get("oop");
		
		//데이터를 출력하기 위한 테이블 만들기
		//1열 4행
		Table table = new Table(1, list.size() + 1);
		table.setPadding(5);
		
		//한글 출력이 가능한 폰트 생성
		BaseFont bfKorean = 
			BaseFont.createFont(
				"/Users/a503_18/Documents/malgun.ttf",
				BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
		Font font = new Font(bfKorean);
		
		//제목 셀 만들기 - 폰트와 함께 출력 : 한글이 제대로 출력됨
		Cell cell = new Cell(new Paragraph("객체지향특징", font));
		cell.setHeader(true);
		table.addCell(cell);
		table.endHeaders();
		
		//리스트의 데이터 출력
		for(String str : list) {
			Cell temp = new Cell(new Paragraph(str, font));
			table.addCell(temp);
		}
		document.add(table);
		
	}
}
