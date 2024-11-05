package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

@Data
public class VideoRoomVO {
	private String vcrNo;
	private String vcrTitle;
	private String vcrRoomurlid;
	private String vcrCalltype;
	private String vcrLivemode;
	private int vcrMaxjoincount;
	private int vcrLivemaxjoincount;
	private String vcrPasswd;
	private String vcrStartdate;
	private String vcrStartdateNo; //인코딩 안한 시작날짜
	private String vcrEnddate;
	private String vcrEnddateNo; //인코딩 안한 종료날짜
	private String vcrLayouttype;
	private String vcrSfuincludeall;
	private String vcrDate;
	private String vcrYn;
	private String pbancNo;
	private String vcrRoomid;
	
	private String entId;
	private int rnum;
	private String status;//완료,진행중
	private String pbancTtl; //공고 제목
	
	
	
}
