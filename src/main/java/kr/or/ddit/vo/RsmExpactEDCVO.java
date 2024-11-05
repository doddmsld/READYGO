package kr.or.ddit.vo;

import lombok.Data;

@Data
public class RsmExpactEDCVO {
	private String actNo; // 활동 번호
	private String rsmNo; // 이력서 번호
	private String actSeCd; // 활동 구분 코드
	private String actNm; // 활동 명
	private String actEngn; // 활동 기관
	private String actBeginYmd; // 활동_시작_일자
	private String actEndYmd; // 활동 종료 일자
	private String actCn; // 활동 내용
	
	private String actSeCdNm;
}
