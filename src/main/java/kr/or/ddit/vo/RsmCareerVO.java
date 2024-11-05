package kr.or.ddit.vo;

import lombok.Data;

@Data
public class RsmCareerVO {
	private String careerNo; 
	private String rsmNo; 
	private String careerEntNm; // 경력 기업 명
	private String careerJncmpYmd;// 경력 입사 일자
	private String careerRetireYmd;// 경력 퇴사 일자
	private String careerDtyCd; // 경력직무 코드
	private String careerDept; // 경력 부서
	private String careerJbgdCd; // 경력직급 코드
	private String careerTask; // 경력 업무
	private int careerAnslry; // 경력 연봉
	private String careerWorkRgnCd; // 경력 근무 지역 코드
	
	private String careerDtyCdNm; // 경력직무 코드 이름
	private String careerJbgdCdNm; // 경력직급 코드 이름
	private String careerWorkRgnCdNm; // 경력 근무 지역 코드 이름
}
