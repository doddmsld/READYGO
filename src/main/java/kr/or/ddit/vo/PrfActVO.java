package kr.or.ddit.vo;

import lombok.Data;

// 프로필 활동 내역 조회
@Data
public class PrfActVO {
	private String actNo;			// 활동 번호
	private String mbrId;			// 회원 아이디
	private String actNm;			// 활동 명
	private String actAuspcengn;	// 주최 기관
	private String actBeginYm;		// 시작일자
	private String actEndYm;		// 종료일자
	private String actNc;			// 활동 설명
}
