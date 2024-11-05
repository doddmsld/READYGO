package kr.or.ddit.vo;

import lombok.Data;

// 프로필 업종
@Data
public class PrfBusinessVO {
	private String tpbizSeCd;	// 업종 구분 코드
	private String mbrId;		// 회원 아이디
	private String tpbizNm;		// 업종 분야 명
	
	// 업종 => 여러 개 받기 때문에 배열로 받아야 한다.
	private String[] business; 
	private String businessStr;	

}
