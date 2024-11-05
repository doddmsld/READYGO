package kr.or.ddit.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

// 프로필
@Data
public class PrfVO {
	private String mbrId;			// 회원 아이디
	private String proflContent;	// 프로필 소개
	private String mbrNm;			// 회원 이름
	private String mbrEml;			// 회원 이메일
	private String prtfolioAddr;	// 회원 주소
	private String prfRlsscopeCd;	// 입사 제안 여부(공통코드)
	
	private String careerNm;		// 경력명
	
	// PRF : PRF_CAREER = 1 : N
	private List<PrfCareerVO> prfCareerVOList;
	
	// 이미지 파일 객체(multiple)
	private MultipartFile[] uploadFile;
	
	// PRF : File_DT = 1 : N
	private List<FileDetailVO> fileDetailVOList;
}
