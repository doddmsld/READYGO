package kr.or.ddit.vo;

import lombok.Data;

@Data
public class OsAplyVO {

	private String outordNo;
	private String mbrId;
	private String osAplyYmd; //외주 신청 날자 
	private String osSmptnYmd; //외주 완료 날짜 
	private String outordAgryn; // 외주 수락 여부
	private int outordStlmAmt;  //외주 결제 금액 
	
}
