package kr.or.ddit.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class RsmPortfolioVO {
	private String prtNo;
	private String rsmNo;
	private String prtFile;
	private String prtUrl;
	private String prtTtl;
	private String prtSeCd;
	
	private String prtSeCdNm;
	
	// 이미지 파일 객체(multiple)
	private MultipartFile[] uploadFile;
	
	// 회원(MEMBER) : 파일그룹(FILE_DT) = 1 : N
	private List<FileDetailVO> fileDetailVOList;
	
}
