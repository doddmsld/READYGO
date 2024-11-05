package kr.or.ddit.vo;


import lombok.Data;

//프로필_자격증
@Data
public class PrfCrtfctVO {
	private String crtfctNo;			// 자격번호
	private String mbrId;
	private String crtfctNm;			// 자격증명
	private String crtfctPblcnoffic;	// 발행처
	private String crtfctAcqsDate;		// 취득연월
}