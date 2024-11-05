package kr.or.ddit.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.ToString;

@Data
public class PbancVO {
	/*공고*/
	private String pbancNo;            // 공고번호
	private String pbancSttus;         // 공고상태
	private String pbancPicNm;         // 공고담당자명
	private String pbancPicTelno;      // 공고담당자연락처
	private String pbancPicEml;        // 공고담당자이메일
	private String pbancRprsrgn;       // 공고대표지역
	private String pbancTtl;           // 공고제목
	private int pbancApntcpd;          // 공고수습기간
	private String pbancRcptPd;        // 공고접수기간
	private String pbancBgngDt;        // 공고시작일(date)
	private String pbancBgngDts;       // 공고시작일(String)
	private String pbancDdlnDt;        // 공고마감일(date)
	private String pbancDdlnDts;       // 공고마감일(String)
	private String pbancWrtDt;         // 공고작성일
	private String pbancMdfcnDt;       // 공고수정일
	private String pbancDelDt;         // 공고삭제일
	private int pbancScrapCo;          // 스크랩수
	private String pbancDelYn;         // 공고삭제여부
	private int pbancRdcnt;            // 공고 조회수
	private String pbancDlnDt;         // 마감일자 스트링타입
	private int pbancBeforeWrt;        // 공고등록일로부터 현재까지 일자 등록
	private String pbancAplctEdu;      // 졸업요건명
	private TbcIndutyVO tbcIndutyVO;   // 공고업종
	private String pbancRprsrgnNm;     // 근무지역명
	private String pbancCityNm;        // 근무도시명
	private String pbancImgFile;       // 이미지파일번호
	private String pbancImgFilePath;   // 이미지파일경로
	private String pbancCn;            // 공고내용
	private String pbancTpbizNm;       // 업종명
	private String pbancWorkstleNm;    // 근무형태
	
	
	private int rnum;                  // 번호
	private CodeVO codeVO;             // 코드
	private TbcRecruitmentVO tbcRecruitmentVO; // 경력 코드
	
	/*모집분야*/
	private String rcritNo;			   // 모집분야번호
	private String rcritNm;			   // 모집분야명
	private String rcritCnt;           // 모집인원
	private String rcritTask;          // 모집업무
	private String rcritDept;          // 모집부서
	private String rcritCareerNm;      // 경력 여부명
	
	/*복지및혜택*/
	private String favorCn;            // 혜택
	private List<String> favorList;    // 복지혜택리스트
//	private String[] favorList;// 복지혜택배열
	
	/*회원*/
	private String memNm;              // 회원명
	private String memId;              // 회원아이디
	private String memBrdt;            // 회원생년월일
	
	/*기업*/
	private EnterVO enterVO;
	private String entId; 			   // 기업아이디
	private String entNm;              // 기업명
	private String entEmpCnt;          // 사원수
	private String entFndnYmd;         // 설립일
	private String entLogo;            // 기업로고
	private String entHmpgUrl;         // 기업홈페이지URL
	private String entRprsntvNm;       // 대표자이름
	private String entFxnum;           // 팩스번호
	private String entImgFile;         // 이미지파일
	private String entAddr;            // 기업주소

	/*TBC...*/
	private String requiredCn;           //필수조건
	private List<String> requiredCnList; //필수조건
	private String preferCn;             //우대조건
	private List<String> preferCnList;   //우대조건
	
	
	/*공통코드*/
	private String tpbizCd;              //공고업종(1:N)
	private List<String> tpbizCdList;    //공고업종리스트
	 
	/*공통코드 Cd + Nm*/
	private String tpbizSeCd;          // 업종
	private String tpbizSeCdNm;        // 업종명
	private String entStleCd;          // 기업형태
	private String entStleCdNm;        // 기업 형태명
	private String entStleNm;          // 기업 형태명
	private String powkCd;             // 지역코드
	private String powkNm;             // 지역명
	private List<String> powkList;     // 지역명
	private String pbancCareerCd;      // 모집경력코드
	private String pbancCareerCdNm;    // 모집경력명
	private String rcritJbttlCd;       // 직급/직책코드
	private String rcritJbttlCdNm;     // 직급/직책명
	private String pbancAplctEduCd;    // 학력코드
	private String pbancAplctEduCdNm;  // 학력코드명
	private String pbancGenCd;         // 성별코드
	private String pbancGenCdNm;       // 성별명
	private String pbancAgeCd; 		   // 연령코드
	private String pbancAgeCdNm;       // 연령명
	private String pbancSalary;        // 연봉/급여코드
	private String pbancSalaryNm;      // 연봉/급여명
	private String pbancWorkstleCd;    // 근무형태코드	
	private String pbancWorkstleCdNm;  // 근무형태명
	private String pbancWorkDayCd;	   // 근무요일코드
	private String pbancWorkDayCdNm;   // 근무요일명
	private String pbancWorkHrCd;	   // 근무시간코드
	private String pbancWorkHrCdNm;	   // 근무시간명
	private String pbancRprsDty;       // 공고대표직무코드
	private String pbancRprsDtyNm;     // 공고대표직무명
	private String pbancRprsDtyCdNm;     // 공고대표직무명
	private String pbancRcptMthdCd;    // 지원접수방법코드
	private String pbancRcptMthdCdNm;  // 지원접수방법명
	private String pbancAppofeFormCd;  // 지원서양식코드	
	private String pbancAppofeFormCdNm;// 지원서양식명
	private String procssCd;	       // 전형절차코드
	private String procssCdNm;	       // 전형절차코드
	
	private List<ScrapVO> scrapVOList;
	private List<TbcAddrVO> tbcAddrVOList;
	
	private List<FileDetailVO> fileDetailVOList;
    private MultipartFile[] entPbancFile;   // 파일 업로드용
    private String fileGroupSn;             // 파일 그룹 번호 저장용
    private MultipartFile[] multipartFiles;	//파일업로드
} 
