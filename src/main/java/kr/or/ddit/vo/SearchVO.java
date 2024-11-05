package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

@Data
public class SearchVO {
	
	private String searchNo;
	private String mbrId;
	private String searchNm;
	private Date searchDate;
}
