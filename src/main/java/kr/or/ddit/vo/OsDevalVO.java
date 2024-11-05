package kr.or.ddit.vo;

import java.util.List;


import lombok.Data;

@Data
public class OsDevalVO {
	private String srvcNo;				//서비스 번호
	private String outordNo;			//외주 번호
	private String srvcLevelCd;			//서비스 수준
	private String srvcLevelNm;			//서비스 수준
	private String srvcTeamscaleCd;		//팀 코드
	private String srvcTeamscaleNm;		//팀 코드
	private String srvcJobpd;			//작업기간
	private String srvcJobpdNm;			//작업기간
	private String srvcUpdtnmtm;		//수정횟수	
	private String srvcUpdtnmtmNm;		//수정횟수	
	private String srvcFileprovdyn;		//파일제공여부
	private String srvcSklladit;		//기능추가
	

	private List<OsdeLangVO> osdeLangVOList;		//언어
	private List<OsdeDatabaseVO> osdeDatabaseVOList;		//데이터베이스
	private List<OsdeCludVO> osdeCludVOList;		//클라우드 
	
	private String[] srvcLangCd;
	private String[] srvcDatabaseCd;
	private String[] srvcCludCd;
	
	
}
