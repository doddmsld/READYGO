package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class OutsouVO {
	private String outordNo; 			//외주 번호
	private String outordTtl; 			//외주 제목
	private String outordLclsf; 		//외주 대분류
	private String outordLclsfNm; 		//외주 대분류 이름
	private String outordMlsfc; 		//외주 중분류
	private String outordMlsfcNm; 		//외주 중분류 이름
	private int outordAmt; 				//외주 금액
	private String outordAmtExpln;		//금액 설명
	private String outordExpln; 		//외주 서비스설명
	private String outordProvdprocss;	//제공절차
	private String outordRefndregltn;	//환불규정
	private String outordMainFile;		//메인 파일 
	private String outordDetailFile;	//상세파일 
	private String outordDmndmatter;	//요청사항
	private Date outordWrtde;			//작성일 	
	private Date outordUpdde;			//수정일 
	private Date outordDelde;			//삭제여부
	private int outordRdcnt;			//조회수
	private String mbrId;				//회원 아이디
	
	
	// 외주 : 외주개발서비스  1:1 
	private OsDevalVO osDevalVO;
	
	//외주 : 외주자소서서비스 1:1 
	private OsClVO osClVO;
	
	// 외주 키워드 N:1 관계 (키워드를 List로 받음)
	private List<OsKeywordVO> osKeywordVOList;
	private String[] kwrdNm;//검색 키워드
	
	// MultipartFile
    private MultipartFile[] mainFile; // 메인이미지
    private MultipartFile[] detailFile; // 상세이미지
    
    //OUTSOU : FILR_DETAIL = 1 : N
    private List<FileDetailVO> fileDetailVOList; 
    private String fileGroupNo; //파일업로드
    
    private List<CodeVO> codeVOList;//공통코드
    
    private List<OsAplyVO> osAplyVOList; //외주 신청 리스트
    
    //개인 프로필 사진 
    private String fileGroupSn;
    private String mbrNm; // 회원 이름
}
