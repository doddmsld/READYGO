package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

// 제안
@Data
public class ProposalVO { 
	private int rnum;           // 행의수
	private String propseNo;    // 제안 번호
	private String entId;       // 기업 아이디
	private String mbrId;       // 회원 아이디
	private String propseTtl;   // 제안 제목
	private String propseCn;    // 제안 내용
	private Date propseDate;    // 제안일 데이트형
	private String propseDates; //제안일 스트링형
	private String propseFile;  // 제안 첨부파일
	private String propsePbancTtl; // 제안 공고 제목
	
	private String mbrNm; // 회원 이름
	private String mbrBrdt; // 회원생년월일
	private String rsmCareerCd; //경력신입코드
	private String entNm; //기업 이름
	private String fileGroupSn; //파일그룹번호
	private String fileNm; //파일 이름
	
}
