package kr.or.ddit.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data	
public class BoardVO {
	private String pstSn;			//게시글번호
	private String seNo;			//구분번호
	private String mbrId;			//회원 아이디
	private String pstTtl;			//게시글 제목
	private String pstOthbcscope;	//게시글 공개범위
	private String pstCn;			//게시글 내용
	private String pstWrtDt;		//게시글 작성일시
	private String pstMdfcnDt;		//게시글 수정일시
	private String pstDelYn;		//게시글 삭제여부
	private int pstInqCnt;			//게시글 조회수
	private String pstFile;			//게시글 파일
	private int etymanmttrSn;		//공지사항 순번
	private int pstGood;			//게시글 추천
	private int pstBad;				//게시글 비추천'
	
	private int replyCnt;//댓글개수
	private int rnum;
	private int displayNum;
	private String fileGroupSn;
	
	private String[] deleteFileIds;
	private MultipartFile[] pstFileFile;
	
	private List<FileDetailVO> fileDetailVOList; 
    private String fileGroupNo; //파일업로드
    
    
	private String outordNo; 			//외주 제목
	private String outordTtl; 			//외주 제목
	private BoardOsVO boardOsVO;		//외주 번호 
	private String outordMainFile;		//메인 파일 
}
