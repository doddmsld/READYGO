package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

// 프로필 학력
@Data
public class PrfAcbgVO {
	private String mbrId;
	private String acbgNo;		// 학력 번호
	private String prseSeCd;	// 학력 구분 코드
	private String acbgSchlNm;	// 학력 학교 명
	private String acbgMjrNm;	// 학력 전공 명
	private String acbgMtcltnym;// 학력 입학년월
	private String acbgGrdtnym;	// 학력 졸업년월
	private String acspSeCd;	// 전공계열 구분 코드
	private String acdeSeCd;	// 학위항목 구분 코드

    private String prseSeNm;  // PRSE_SE_NM (학력 구분 코드명)
    private String acdeSeNm;  // ACDE_SE_NM (학위 구분 코드명)
    private String acspSeNm;  // ACSP_SE_CM (전공계열 항목 코드명)
    
    // PRF_ACBG : CODE = 1 : N
    private List<CodeVO> codeVOList;
    
}
