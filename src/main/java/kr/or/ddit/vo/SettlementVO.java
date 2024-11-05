package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class SettlementVO {
	private String stlmNo;      //결제 번호(주문번호)
	private String outordNo;    //외주 번호
	private String mbrId;	    //회원 아이디 
	private String setleMn;		//결제수단
	private String setleYmd; 	//결제일자
	private String setleSttus;	//결제상태
	private int setleAmt;		//결제금액
	
	//외주 (outsou)
	private String outordTtl; 			//외주 제목
	private String outordLclsf; 		//외주 대분류
	private String outordLclsfNm; 		//외주 대분류 이름
	private String outordMlsfc; 		//외주 중분류
	private String outordMlsfcNm; 		//외주 중분류 이름
	private int outordAmt; 				//외주 금액
	private String outordAmtExpln;		//금액 설명
	private String outordExpln; 		//외주 서비스설명
	private String outordProvdprocss;	//제공절차
	private String outordRefndregltn;	//환불규정
	private String outordMainFile;		//메인 파일 
	private String outordDetailFile;	//상세파일 
	private String outordDmndmatter;	//요청사항
	private Date outordWrtde;			//작성일 	
	private Date outordUpdde;			//수정일 
	private Date outordDelde;			//삭제여부
	private int outordRdcnt;			//조회수
	
	
}
