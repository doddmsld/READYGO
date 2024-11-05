package kr.or.ddit.enter.entcontroller;


import java.io.IOException;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLDecoder;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.enter.entservice.EnterService;
import kr.or.ddit.enter.entservice.EnterServiceS;
import kr.or.ddit.mapper.UserMapper;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.util.GetUserUtil;
import kr.or.ddit.vo.ApplicantVO;
import kr.or.ddit.vo.CodeVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.NotificationVO;
import kr.or.ddit.vo.PbancVO;
import kr.or.ddit.vo.UserAuthVO;
import kr.or.ddit.vo.VideoRoomVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/enter")
public class EnterMainController {
	
	@Inject
	EnterServiceS enterServiceS;
	
	@Inject
	EnterService enterService;
	
	@Inject
	UserMapper userMapper;
	
	@Inject
	GetUserUtil getUserUtil;
	
	/*기업 메인*/
	@GetMapping("/main")
	public String main(Model model,Principal principal
			) {
		if(principal!=null) {
//			
//			List<UserAuthVO> authVOList = getUserUtil.getMemVO().getUserAuthVOList();
//			for(UserAuthVO VO : authVOList) {
//				if(VO.getAuth().equals("ROLE_MEMBER")) {
//					return "/logout";
//				}
//			}
			String entId = principal.getName();
			int pbCount = this.enterServiceS.pbCount(entId); //공고 카운트
			int openCount = this.enterServiceS.openCount(entId); //입사 카운트
			int closeCount = this.enterServiceS.closeCount(entId);	//미열람 카운트
			int ppCount = this.enterServiceS.ppCount(entId);	//스카우트 카운트
			log.info("pbCount : "+pbCount);
			log.info("openCount : "+openCount);
			log.info("closeCount : "+closeCount);
			log.info("ppCount : "+ppCount);
			model.addAttribute("pbCount",pbCount);
			model.addAttribute("openCount",openCount);
			model.addAttribute("closeCount",closeCount);
			model.addAttribute("ppCount",ppCount);
			
			List<PbancVO> pbancList = this.enterServiceS.pbancList(entId);
			log.info("pbancList : "+pbancList);
			model.addAttribute("pbancList",pbancList);
			
			List<PbancVO> pbancCalendarList = this.enterServiceS.pbancCalendarList(entId);
			log.info("pbancCalendarList : "+pbancCalendarList);
			model.addAttribute("pbancCalendarList",pbancCalendarList);
		
			
		}
		//인제추천
		List<MemberVO> injaeNewList = this.enterServiceS.injaeNewList();
		model.addAttribute("injaeNewList",injaeNewList);
		log.info("injaeNewList : "+injaeNewList);
		List<MemberVO> injaeOldList = this.enterServiceS.injaeOldList();
		model.addAttribute("injaeOldList",injaeOldList);
		log.info("injaeOldList : "+injaeOldList);
		return "enter/main/main";
	}
	
	
	//알람 목록 컨트롤러
	@ResponseBody
	@PostMapping("/alarmList")
	public List<NotificationVO> alarmList(@RequestBody String entId) {
		
		log.info("alarmList -> entId : "+ entId);
		List<NotificationVO> notificationVOList = this.enterServiceS.alarmList(entId);
		log.info("alarmList -> notificationVO : " + notificationVOList);
		return notificationVOList;
		
	}
	
	/*지원자리스트 열람상태업데이트*/
	@PostMapping("/updateappstatus")
	@ResponseBody
	public int updateappstatus(@RequestParam("mbrId") String mbrId,
								  @RequestParam("pbancNo") String pbancNo) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mbrId", mbrId);
		map.put("pbancNo", pbancNo);
		int result = this.enterServiceS.updateappstatus(map);
		
		return result;
	}
	
	
	
	/*기업 지원자 관리 - 일반면접*/
	@GetMapping("/intrvw")
	public String intrvw(Model model
			  , @RequestParam(value = "entId", required = false, defaultValue="") String entId
			  ,	@RequestParam(value = "currentPage", required = false, defaultValue="1") Integer currentPage
		      , @RequestParam(value ="keywordInput", required = false,defaultValue="") String keyword
	          , @RequestParam(value = "dateInput", required = false,defaultValue="") String date
	          , @RequestParam(value = "gubun", required = false,defaultValue="") String gubun
	          , @RequestParam(value = "gubunSt", required = false,defaultValue="") String gubunSt
	          , @RequestParam(value = "gubunPbanc", required = false,defaultValue="") String gubunPbanc
			) {
		gubunPbanc = gubunPbanc.replace("...", "");
		Map<String, Object> map = new HashMap<String, Object>(); 		
		map.put("currentPage", currentPage);
		map.put("entId", entId);        
		map.put("keyword", keyword);
		map.put("date", date);
		map.put("gubun", gubun);
		map.put("gubunSt", gubunSt);
		map.put("gubunPbanc", gubunPbanc);
		
		//밑에 리스트 뽑기
		//공고별 지원자 조회 
		List<ApplicantVO> applicantVOList = this.enterServiceS.intrvwList(map);
		log.info("applicantVOList : " + applicantVOList);
		
		model.addAttribute("applicantVOList",applicantVOList);
		//전체 행의 수
		int total = this.enterServiceS.getIntrvwTotal(map);
		model.addAttribute("total",total);
		ArticlePage<ApplicantVO> articlePage = new ArticlePage<ApplicantVO>(total, currentPage, 5, applicantVOList,map);
		model.addAttribute("articlePage",articlePage);
		//스카우트 제안 - 해당기업 공고 꺼내기
        List<PbancVO> pbancList = enterServiceS.pbancsList(entId);
        model.addAttribute("pbancList", pbancList);
		//면접상태 공통코드
		List<CodeVO> instList = this.userMapper.codeSelect("INST");
		log.info("instList : " + instList);
		model.addAttribute("instList",instList);
		//지원자 상태 공통코드
		List<CodeVO> apstList = this.userMapper.codeSelect("APST");
		log.info("apstList : " + apstList);
		model.addAttribute("apstList",apstList);
		
		
		
		
		return "enter/aplctPage/aplctList/aplctFolder/aplct/intrvw";
	}
	
	
	/* 면접관리 엑셀 저장 
	 * excelAplct.xls 요청을 처리하는 메소드 */
	@RequestMapping(value = "excelAplcts.xls", method = RequestMethod.GET)
	public void excelDownloadAplct(HttpServletResponse response,
								   @RequestParam(value = "entId", required = false, defaultValue = "") String entId) throws IOException {
		
		Map<String, Object> map = new HashMap<>();
		map.put("entId", entId);

		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-Disposition", "attachment; filename=\"Aplct_list.xls\"");

		try (Workbook workbook = new HSSFWorkbook(); OutputStream out = response.getOutputStream()) {

			Sheet sheet = workbook.createSheet("Aplct List");

			// 헤더 작성
			String[] headers = { "지원자", "신입/경력","이력서/자소서", "면접종류","면접일자","면접상태","지원자상태" ,"스킬" };
			Row headerRow = sheet.createRow(0);
			for (int i = 0; i < headers.length; i++) {
				Cell cell = headerRow.createCell(i);
				cell.setCellValue(headers[i]);
			}

			List<ApplicantVO> AplctListExcel = enterServiceS.AplctListExcel(map);

			// 데이터 작성
			int rowIndex = 1;
			for (ApplicantVO aplct : AplctListExcel) {
				Row row = sheet.createRow(rowIndex++);
				row.createCell(0).setCellValue(aplct.getMbrNm()); // 지원자
				row.createCell(1).setCellValue(aplct.getRsmCareerCd()); // 신입/경력
				row.createCell(2).setCellValue(aplct.getRsmTtl()); // 이력서/자소서
				row.createCell(3).setCellValue(aplct.getIntrvwTyCd()); // 면접종류
				row.createCell(4).setCellValue(aplct.getIntrvwYmd()); // 면접일자
				row.createCell(5).setCellValue(aplct.getIntrvwSttusCdNm()); // 면접상태
				row.createCell(6).setCellValue(aplct.getAplctPrcsStatCdNm()); // 지원자상태
				row.createCell(7).setCellValue(aplct.getSkCd()); // 스킬
			}

			// 엑셀 파일을 response의 OutputStream에 씀
			workbook.write(out);
			out.flush();
		}
	}
	
	/*면접 일정 삭제 업데이트*/
	@ResponseBody
	@PostMapping("/updateDateIntrvw")
	public int updateDateIntrvw(@RequestParam("intrvwNo") String intrvwNo) {
		int result = this.enterServiceS.updateDateIntrvw(intrvwNo);
		return result;
	}
	
	
	/*면접 관리 면접 상태 업데이트*/
	@ResponseBody
	@PostMapping("/updateIntrvw")
	public int updateIntrvw(@RequestParam("intrvwNo") String intrvwNo,
							@RequestParam("intrvwSttus") String intrvwSttus) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("intrvwNo", intrvwNo);
		map.put("intrvwSttus",intrvwSttus);
		
		int result = this.enterServiceS.updateIntrvw(map);
		return result;
	}
	
	@ResponseBody
	@PostMapping("/updateIntrvwPrcsStat")
	public int updateIntrvwPrcsStat(@RequestParam("pbancNo") String pbancNo
								, @RequestParam("mbrId") String mbrId
								, @RequestParam("intrvwSttus") String intrvwSttus) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pbancNo", pbancNo);
		map.put("mbrId",mbrId);
		map.put("intrvwSttus",intrvwSttus);
		
		int result = this.enterServiceS.updateIntrvwPrcsStat(map);
		return result;
	}
	
	/*기업 면접 관리 면접 등록 모달 화상방 조회*/
	@ResponseBody
	@PostMapping("/intrvwvideoPost")
	public List<VideoRoomVO> videointrvwPost(@RequestParam("job") String job ){
		
		log.info("job : " + job);
		
		List<VideoRoomVO> videolist = this.enterServiceS.videointrvwPost(job);
		log.info("list : "+videolist);
		return videolist;
		
	}
	
	/*기업 면접등록 모달 등록시 면접 일자 업데이트*/
	@PostMapping("/intrvwFormPost")
	public String intrvwFormPost(@RequestParam("intrvwNum") String intrvwNum,
								 @RequestParam("videoPost") String videoPost,
								 @RequestParam("entId")String entId) {
			log.info("intrvwNum : "+ intrvwNum );
			log.info("videoPost : " + videoPost);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("intrvwNum", intrvwNum);
			map.put("videoPost", videoPost);
			
		this.enterServiceS.intrvwFormPost(map);
		
		return "redirect:/enter/intrvw?entId="+entId;
	}
	
	/*기업 면접등록 모달 일반면접 일자 업데이트*/
	@PostMapping("/intrvwFormPost2")
	public String intrvwFormPost2(@RequestParam("entId")String entId,
								@RequestParam("date") String date,
								@RequestParam("startdate") String startdate,
								@RequestParam("enddate") String enddate,
								@RequestParam("intrvwNum") String intrvwNum){
		
		log.info("date : "+date );
		startdate = date+" "+startdate;
		enddate = date+" "+enddate;
		log.info("startdate : "+startdate );
		log.info("enddate : "+enddate );
		log.info("intrvwNum : "+intrvwNum );
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("date", date);
		map.put("startdate", startdate);
		map.put("enddate", enddate);
		map.put("intrvwNum", intrvwNum);
		this.enterServiceS.intrvwFormPost2(map);
		return "redirect:/enter/intrvw?entId="+entId;
	}
	
	
	/*기업 지원자 관리 - 화상면접방 생성*/
	@GetMapping("/videointrvw")
	public String videointrvw(Model model, String entId,
			@RequestParam(value = "currentPage", required = false, defaultValue="1") Integer currentPage
		      , @RequestParam(value ="keywordInput", required = false,defaultValue="") String keyword
		      , @RequestParam(value = "gubun", required = false,defaultValue="") String gubun
		      , @RequestParam(value="dateInput", required = false,defaultValue="") String dateInput
		      , @RequestParam(value="dataInputType", required = false,defaultValue="" ) String dataInputType
			  ) {
		log.info("currentPage : "+currentPage);
		log.info("keywordInput : "+keyword);
		log.info("gubun : "+gubun);
		log.info("dateInput : "+dateInput);
		log.info("dataInputType : "+dataInputType);
		Map<String, Object> map = new HashMap<String, Object>(); 		
		map.put("currentPage", currentPage);
		map.put("entId", entId);        
		map.put("keyword", keyword);
		map.put("gubun", gubun);
		map.put("dateInput", dateInput);
		map.put("dataInputType", dataInputType);
		
		//면접방 생성 - 해당기업 공고 꺼내기
        List<PbancVO> pbancList = enterServiceS.pbancsList(entId);
        model.addAttribute("pbancList", pbancList);
		//밑에 리스트 뽑기
		//공고별 지원자 조회 
		List<VideoRoomVO> videoRoomList = this.enterServiceS.videoRoomList(map);
		log.info("videoRoomList : " + videoRoomList);
		for(int i=0;i<videoRoomList.size();i++) {
			 try {
			// URL 디코딩
			String destDate = URLDecoder.decode(videoRoomList.get(i).getVcrStartdate(), "UTF-8");
			String deedDate =URLDecoder.decode(videoRoomList.get(i).getVcrEnddate(), "UTF-8");
			 // 원본 문자열을 변환할 SimpleDateFormat
			SimpleDateFormat Format = new SimpleDateFormat("EEE MMM dd yyyy HH:mm:ss Z", Locale.ENGLISH);
			// 디코딩된 문자열을 Date 객체로 변환
			Date sDate = Format.parse(destDate);
			Date eDate = Format.parse(deedDate);
			// 원하는 출력 형식으로 포맷팅할 SimpleDateFormat
			SimpleDateFormat desiredFormat = new SimpleDateFormat("MM'월' dd'일' hh'시' mm'분'", Locale.KOREAN);
			// 포맷된 날짜 출력
			String fsDate = desiredFormat.format(sDate);
			String feDate = desiredFormat.format(eDate);
			videoRoomList.get(i).setVcrStartdate(fsDate);
			videoRoomList.get(i).setVcrEnddate(feDate);
			 } catch (Exception e) {
		            e.printStackTrace();
		     }
		}
		log.info("videoRoomList : "+ videoRoomList);
		//전체 행의 수
		int total = this.enterServiceS.getvideoIntrvwTotal(map);
		model.addAttribute("total",total);
		ArticlePage<VideoRoomVO> articlePage = new ArticlePage<VideoRoomVO>(total, currentPage, 5, videoRoomList,map);
		model.addAttribute("articlePage",articlePage);
		
		
		return "enter/aplctPage/aplctList/aplctFolder/aplct/videointrvw";
	}
	
	//기업 마이페이지 멤버 추가(기업회원 추가)
	@GetMapping("/entaddmem")
	public String entaddmem(Model model, String entId,
						@RequestParam(value="keywordInput", required = false,defaultValue="") String keyword) {
		log.info("entId : " + entId);
		log.info("keywordInput" + keyword);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("entId", entId);
		map.put("keyword", keyword);
		log.info("map : " + map);
		List<MemberVO> memberList = this.enterServiceS.memberList(map);
		int total = this.enterServiceS.memberListTotal(map);
		model.addAttribute("total",total);
		model.addAttribute("memberList",memberList);
		return "enter/info/mypage/entaddmem";
	}
	
	// 기업회원초대 메일
	@ResponseBody
	@PostMapping("/sendMemAddEmail")
	public Map<String, Object> sendMemAddEmail(@RequestBody Map<String,Object> value) {
		Map<String, Object> response = new HashMap<>();  // 반환할 JSON 데이터
		Map<String, Object> map = new HashMap<>();
		map.put("mbrId", value.get("mbrId").toString());
		map.put("mbrNm", value.get("mbrNm").toString());
		map.put("mbrEml", value.get("mbrEml").toString());
		map.put("mbrTelno",value.get("mbrTelno").toString());
		map.put("entId",value.get("entId").toString());
		log.info("map : "+ map);
		try {
	        // recipientEmail을 사용하여 이메일 전송
	        int result = this.enterServiceS.sendMemAddEmail(map);
	        
	        if(result == 0) {
	            response.put("status", "fail");
	            response.put("message", "작성한 회원 정보가 일치하지 않거나 이미 기업회원 초대를 보냈습니다.");
	        } else {
	            response.put("status", "success");
	            response.put("result", result);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.put("status", "error");
	        response.put("message", e.getMessage());
	    }
		return response;
	}
	
	// 기업회원초대 메일
		@ResponseBody
		@PostMapping("/resendMemAddEmail")
		public Map<String, Object> resendMemAddEmail(@RequestBody Map<String,Object> value) {
			Map<String, Object> response = new HashMap<>();  // 반환할 JSON 데이터
			Map<String, Object> map = new HashMap<>();
			map.put("mbrId", value.get("mbrId").toString());
			map.put("mbrNm", value.get("mbrNm").toString());
			map.put("mbrEml", value.get("mbrEml").toString());
			map.put("mbrTelno",value.get("mbrTelno").toString());
			map.put("entId",value.get("entId").toString());
			log.info("map : "+ map);
			try {
		        // recipientEmail을 사용하여 이메일 전송
		        int result = this.enterServiceS.resendMemAddEmail(map);
		        
		        if(result == 0) {
		            response.put("status", "fail");
		            response.put("message", "작성한 회원 정보가 일치하지 않거나 이미 기업회원 초대를 보냈습니다.");
		        } else {
		            response.put("status", "success");
		            response.put("result", result);
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		        response.put("status", "error");
		        response.put("message", e.getMessage());
		    }
			return response;
		}
	
	
	// 스카우트 제안 메일
		@ResponseBody
		@PostMapping("/entaddmemDel")
		public int entaddmemDel(@RequestParam("mbrId") String mbrId,
								@RequestParam("entId") String entId) {
			Map<String, Object> map = new HashMap<>();
			map.put("mbrId", mbrId);
			map.put("entId",entId);
			log.info("map : "+ map);
			int result = this.enterServiceS.entaddmemDel(map);
			return result;
		}
	
	
}
