package kr.or.ddit.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class MemberVO {
	private int rnum;
	private String mbrId;    	// 회원 아이디
	private String mbrPswd;  	// 회원 비밀번호
	private String mbrNm;	 	// 회원 이름
	private String mbrBrdt;		// 회원 생년월일
	private String mbrSexdstnCd;// 회원성별구분코드
	private String mbrEml;		// 회원 이메일
	private String mbrTelno;	// 회원 전화번호
	private String mbrZip;		// 회원 우편번호
	private String mbrAddr;		// 회원 주소
	private String mbrAddrDtl;	// 회원 주소 상세
	private String mbrJoinYmd;	// 회원 가입일자
	private String mbrWhdwlYmd;	// 회원 탈퇴일자	
	private String enabled;		// 회원 상태
	private int mbrWarnCo;		// 회원 경고 횟수
	private String mbrAcnutno;	// 회원 계좌번호
	private String userType;	// 회원 타입
	private String fileGroupSn; // 파일 그룹 번호
	private String limitPeriod;	// 제한 기간
	private Integer reaminDays;		// 제한 남은기간
	private String entId;		// 기업 아이디
	
	private List<UserAuthVO> UserAuthVOList;

	// 이미지 파일 객체(multiple)
	private MultipartFile[] uploadFile;
	
	// 회원(MEMBER) : 파일그룹(FILE_DT) = 1 : N
	private List<FileDetailVO> fileDetailVOList;
	
	private String gubun;
	private String rsmCareerCd; //경력신입코드
	private String skCd; //스킬
	
	private String mbrSexdstnCdNm; //성별
	private String tpbizSeNm; //업종명
	private String tpbizSeCd; //업종코드
	private String career; //신입/경력여부
	private String fileNm; //파일 명
}

