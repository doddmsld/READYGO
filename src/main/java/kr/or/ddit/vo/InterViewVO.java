package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

@Data
public class InterViewVO {
	private String intrvwNo; // 면접 번호
	private String pbancNo;	// 공고 번호
	private String mbrId;	// 면접자 아이디
	private String entId;  // 공고 담당자 아이디
	private String propseNo; //지원 절차 넘버
	private String vcrNo;  // 화상방 번호
	private String intrvwSttusCd;// 인터뷰 상태 코드
	private String intrvwTyCd; // 인터뷰 상태 코드 2
	private String intrvwYmd; // 몰루?
	private String intrvwStartDate; // 시작일
	private String intrvwEndDate; // 종료일
	private String intrvwStartDateNo; // 시작일
	private String intrvwEndDateNo; // 종료일
	private int rnum; //페이징
	
	// 공고 제목
	private String pbancTtl;
	private String entNm;
	
	// 화상 방
	private String vcrStartdate;
	private String vcrEnddate;
	private String vcrPasswd;
	private String vcrTitle;
	private String vcrRoomid;	
	
	// 인터뷰 상태 코드 이름
	private String intrvwSttusCdNm;
	private String intrvwTyCdNm;
}
//호시노 민구는 어디에나 존재한다