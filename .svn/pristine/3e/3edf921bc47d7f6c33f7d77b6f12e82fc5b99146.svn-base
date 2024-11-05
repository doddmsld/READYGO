package kr.or.ddit.oustou.controller;


import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.mapper.UserMapper;
import kr.or.ddit.oustou.service.OutsouMainService;
import kr.or.ddit.service_DO.NotificationService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.CodeVO;
import kr.or.ddit.vo.NotificationVO;
import kr.or.ddit.vo.OutsouVO;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("/outsou")
public class OutsouMainController {

	@Inject
	OutsouMainService oustouMainService;
	
	//공통코드를 위한 
	@Autowired
	UserMapper userMapper;
	
	@Inject
	NotificationService notificationService;
	
	/*외주 메인*/
	@GetMapping("/main")
	public String main(Model model) {
		
		//공통 코드에서 중분류카테고리 가져오기
		List<OutsouVO> BestCategory = this.oustouMainService.getCategory();
		log.info("BestCategory -> " + BestCategory);


		
		//외주 목록에서 최신글 가져오기 (컴퓨터 현재날짜에서 최신 순 5개 )
		List<OutsouVO> NewList = this.oustouMainService.getnewList();
		log.info("NewList -> " + NewList);
		
		//외주목록에서 조회수높은거 가져오기(5개)
		List<OutsouVO> BestList = this.oustouMainService.getBestList();
		log.info("BestList -> " + BestList);
		
		//게시판에서 리뷰 목록 가져오기 3~5개 정보 (좋아요 많은 순 )
		List<BoardVO> reviewBest = this.oustouMainService.reviewBest();

		//웹소켓 알림설정 
	    // 로그인한 사용자 ID 가져오기
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    String loggedInUser = "anonymousUser";  // 기본 값 설정
	    // 게시판 제한 경고 및 비로그인 사용자 접근 가능
	    if (authentication != null && authentication.isAuthenticated() && !(authentication instanceof AnonymousAuthenticationToken)) {
	        loggedInUser = authentication.getName();
	        model.addAttribute("loggedInUser", loggedInUser);
            // 알림 목록 조회
            List<NotificationVO> alramList = notificationService.alramList(loggedInUser);

            // 알림 데이터 모델에 추가
            model.addAttribute("alramList", alramList);	        
	    };
	    
		model.addAttribute("BestCategory",BestCategory); // 카테고리  
		model.addAttribute("NewList",NewList); // 메인 게시글  new
		model.addAttribute("BestList",BestList); // 메인 게시글 Best
		model.addAttribute("reviewBest",reviewBest); // 리뷰
		
		return "outsou/main";
	}

	
	
	/* 외주 웹게시판 목록 */
//	@GetMapping("/list")
	// /outsou/WebList?outordMlsfc=OULC01-001&currentPage=1&srvcLevelCd=&srvcTeamscaleCd=&ord=rdcnt
	@RequestMapping(value="/WebList",method=RequestMethod.GET)
	public ModelAndView WebList(ModelAndView mav,
			@RequestParam(value = "outordMlsfc", required = false, defaultValue = "") String outordMlsfc, //리스트를 가져오기 우한 중분류 
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") Integer currentPage,   
			@RequestParam(value = "ord", required = false) String ord,   //정렬을 우위위한 
			@RequestParam(value = "srvcLevelCd", required = false) String srvcLevelCd, //옵션의 정보를 보내기 위한 
		    @RequestParam(value = "srvcTeamscaleCd", required = false) String srvcTeamscaleCd) {	
		
		log.info("srvcLevelCd : " + srvcLevelCd);
		log.info("srvcTeamscaleCd : " + srvcTeamscaleCd);
		
		//SRLE01_SRLE02_SRLE03
		// 기술 수준 값 처리
		List<String> srvcLevelCdList = new ArrayList<>();
		if (srvcLevelCd != null && !srvcLevelCd.isEmpty()) {
		    if (srvcLevelCd.contains(",")) {
		        srvcLevelCdList = Arrays.asList(srvcLevelCd.split(","));
		    } else {
		        srvcLevelCdList.add(srvcLevelCd); // 단일 값도 리스트에 추가
		    }
		}

		// 팀 규모 값 처리
		List<String> srvcTeamscaleCdList = new ArrayList<>();
		if (srvcTeamscaleCd != null && !srvcTeamscaleCd.isEmpty()) {
		    if (srvcTeamscaleCd.contains(",")) {
		        srvcTeamscaleCdList = Arrays.asList(srvcTeamscaleCd.split(","));
		    } else {
		        srvcTeamscaleCdList.add(srvcTeamscaleCd); // 단일 값도 리스트에 추가
		    }
		}
		
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		map.put("outordMlsfc", outordMlsfc);
		map.put("ord", ord);
		map.put("srvcLevelCdList", srvcLevelCdList);
		map.put("srvcTeamscaleCdList", srvcTeamscaleCdList);
		
		List<CodeVO> SrleList = oustouMainService.getSrleList(); // 기술수준 가져오기 
		List<CodeVO> SrteList = oustouMainService.getSrteList(); // 팀 규모 가져오기
		List<OutsouVO> getWebList = this.oustouMainService.getWebList(map); // 각 카테고리별 리스트 
		log.info("SrleList -> " + SrleList);
		log.info("SrteList -> " + SrteList);
		log.info("getWebList -> " + getWebList);
		
		
		int total = this.oustouMainService.getWebTotal(map); // 페이지네이션 전체 행의수

		// 페이지네이션 객체
		ArticlePage<OutsouVO> articlePage = new ArticlePage<OutsouVO>(total, currentPage, 10, getWebList, map);
		mav.addObject("SrleList", SrleList);// 기술수준 목록 가져오기
		mav.addObject("SrteList", SrteList);// 기술수준 목록 가져오기
		
		
		mav.addObject("articlePage", articlePage); //페이지네이션 + 언니거
		// 뷰 리졸버
		mav.setViewName("outsou/List/WebList");
		return mav;
	}
	
	
	/* 외주 프로그램게시판 목록 */
	@RequestMapping(value="/PGList",method=RequestMethod.GET)
	public ModelAndView PGList(ModelAndView mav,
			@RequestParam(value = "outordMlsfc", required = false, defaultValue = "") String outordMlsfc, //리스트를 가져오기 우한 중분류 
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") Integer currentPage,   
			@RequestParam(value = "ord", required = false) String ord,   //정렬을 우위위한 
			@RequestParam(value = "srvcLevelCd", required = false) String srvcLevelCd, //옵션의 정보를 보내기 위한 
		    @RequestParam(value = "srvcTeamscaleCd", required = false) String srvcTeamscaleCd) {	
		
		log.info("srvcLevelCd : " + srvcLevelCd);
		log.info("srvcTeamscaleCd : " + srvcTeamscaleCd);
		
		//SRLE01_SRLE02_SRLE03
		// 기술 수준 값 처리
		List<String> srvcLevelCdList = new ArrayList<>();
		if (srvcLevelCd != null && !srvcLevelCd.isEmpty()) {
		    if (srvcLevelCd.contains(",")) {
		        srvcLevelCdList = Arrays.asList(srvcLevelCd.split(","));
		    } else {
		        srvcLevelCdList.add(srvcLevelCd); // 단일 값도 리스트에 추가
		    }
		}

		// 팀 규모 값 처리
		List<String> srvcTeamscaleCdList = new ArrayList<>();
		if (srvcTeamscaleCd != null && !srvcTeamscaleCd.isEmpty()) {
		    if (srvcTeamscaleCd.contains(",")) {
		        srvcTeamscaleCdList = Arrays.asList(srvcTeamscaleCd.split(","));
		    } else {
		        srvcTeamscaleCdList.add(srvcTeamscaleCd); // 단일 값도 리스트에 추가
		    }
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		map.put("outordMlsfc", outordMlsfc);
		map.put("ord", ord);
		map.put("srvcLevelCd", srvcLevelCd);
		map.put("srvcTeamscaleCd", srvcTeamscaleCd);
		
		List<CodeVO> SrleList = oustouMainService.getSrleList(); // 기술수준 가져오기 
		List<CodeVO> SrteList = oustouMainService.getSrteList(); // 팀 규모 가져오기
		List<OutsouVO> getPGList = this.oustouMainService.getPGList(map); // 각 카테고리별 리스트 
		log.info("SrleList -> " + SrleList);
		log.info("SrteList -> " + SrteList);
		log.info("getPGList -> " + getPGList);
		
		
		int total = this.oustouMainService.getPGTotal(map); // 페이지네이션 전체 행의수
		
		// 페이지네이션 객체
		ArticlePage<OutsouVO> articlePage = new ArticlePage<OutsouVO>(total, currentPage, 10, getPGList, map);
		mav.addObject("SrleList", SrleList);// 기술수준 목록 가져오기
		mav.addObject("SrteList", SrteList);// 기술수준 목록 가져오기
		
		
		mav.addObject("articlePage", articlePage); //페이지네이션 + 언니거
		// 뷰 리졸버
		mav.setViewName("outsou/List/PGList");
		return mav;
	}
	
	
	/* 외주 데이터 게시판 목록 */
	@RequestMapping(value="/DataList",method=RequestMethod.GET)
	public ModelAndView DataList(ModelAndView mav,
			@RequestParam(value = "outordMlsfc", required = false, defaultValue = "") String outordMlsfc, //리스트를 가져오기 우한 중분류 
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") Integer currentPage,   
			@RequestParam(value = "ord", required = false) String ord,   //정렬을 우위위한 
			@RequestParam(value = "srvcLevelCd", required = false) String srvcLevelCd, //옵션의 정보를 보내기 위한 
		    @RequestParam(value = "srvcTeamscaleCd", required = false) String srvcTeamscaleCd) {	
		
		log.info("srvcLevelCd : " + srvcLevelCd);
		log.info("srvcTeamscaleCd : " + srvcTeamscaleCd);
		
		//SRLE01_SRLE02_SRLE03
		// 기술 수준 값 처리
		List<String> srvcLevelCdList = new ArrayList<>();
		if (srvcLevelCd != null && !srvcLevelCd.isEmpty()) {
		    if (srvcLevelCd.contains(",")) {
		        srvcLevelCdList = Arrays.asList(srvcLevelCd.split(","));
		    } else {
		        srvcLevelCdList.add(srvcLevelCd); // 단일 값도 리스트에 추가
		    }
		}

		// 팀 규모 값 처리
		List<String> srvcTeamscaleCdList = new ArrayList<>();
		if (srvcTeamscaleCd != null && !srvcTeamscaleCd.isEmpty()) {
		    if (srvcTeamscaleCd.contains(",")) {
		        srvcTeamscaleCdList = Arrays.asList(srvcTeamscaleCd.split(","));
		    } else {
		        srvcTeamscaleCdList.add(srvcTeamscaleCd); // 단일 값도 리스트에 추가
		    }
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		map.put("outordMlsfc", outordMlsfc);
		map.put("ord", ord);
		map.put("srvcLevelCd", srvcLevelCd);
		map.put("srvcTeamscaleCd", srvcTeamscaleCd);
		
		List<CodeVO> SrleList = oustouMainService.getSrleList(); // 기술수준 가져오기 
		List<CodeVO> SrteList = oustouMainService.getSrteList(); // 팀 규모 가져오기
		List<OutsouVO> getDataList = this.oustouMainService.getDataList(map); // 각 카테고리별 리스트 
		log.info("SrleList -> " + SrleList);
		log.info("SrteList -> " + SrteList);
		log.info("getDataList -> " + getDataList);
		
		
		int total = this.oustouMainService.getDataTotal(map); // 페이지네이션 전체 행의수
		
		// 페이지네이션 객체
		ArticlePage<OutsouVO> articlePage = new ArticlePage<OutsouVO>(total, currentPage, 10, getDataList, map);
		mav.addObject("SrleList", SrleList);// 기술수준 목록 가져오기
		mav.addObject("SrteList", SrteList);// 기술수준 목록 가져오기
		
		
		mav.addObject("articlePage", articlePage); //페이지네이션 + 언니거
		// 뷰 리졸버
		mav.setViewName("outsou/List/DataList");
		return mav;
	}
	
	
	/* 외주 AI 게시판 목록 */
	@RequestMapping(value="/AIList",method=RequestMethod.GET)
	public ModelAndView AIList(ModelAndView mav,
			@RequestParam(value = "outordMlsfc", required = false, defaultValue = "") String outordMlsfc, //리스트를 가져오기 우한 중분류 
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") Integer currentPage,   
			@RequestParam(value = "ord", required = false) String ord,   //정렬을 우위위한 
			@RequestParam(value = "srvcLevelCd", required = false) String srvcLevelCd, //옵션의 정보를 보내기 위한 
		    @RequestParam(value = "srvcTeamscaleCd", required = false) String srvcTeamscaleCd) {	
		
		log.info("srvcLevelCd : " + srvcLevelCd);
		log.info("srvcTeamscaleCd : " + srvcTeamscaleCd);
		
		//SRLE01_SRLE02_SRLE03
		// 기술 수준 값 처리
		List<String> srvcLevelCdList = new ArrayList<>();
		if (srvcLevelCd != null && !srvcLevelCd.isEmpty()) {
		    if (srvcLevelCd.contains(",")) {
		        srvcLevelCdList = Arrays.asList(srvcLevelCd.split(","));
		    } else {
		        srvcLevelCdList.add(srvcLevelCd); // 단일 값도 리스트에 추가
		    }
		}

		// 팀 규모 값 처리
		List<String> srvcTeamscaleCdList = new ArrayList<>();
		if (srvcTeamscaleCd != null && !srvcTeamscaleCd.isEmpty()) {
		    if (srvcTeamscaleCd.contains(",")) {
		        srvcTeamscaleCdList = Arrays.asList(srvcTeamscaleCd.split(","));
		    } else {
		        srvcTeamscaleCdList.add(srvcTeamscaleCd); // 단일 값도 리스트에 추가
		    }
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		map.put("outordMlsfc", outordMlsfc);
		map.put("ord", ord);
		map.put("srvcLevelCd", srvcLevelCd);
		map.put("srvcTeamscaleCd", srvcTeamscaleCd);
		
		List<CodeVO> SrleList = oustouMainService.getSrleList(); // 기술수준 가져오기 
		List<CodeVO> SrteList = oustouMainService.getSrteList(); // 팀 규모 가져오기
		List<OutsouVO> getAIList = this.oustouMainService.getAIList(map); // 각 카테고리별 리스트 
		log.info("SrleList -> " + SrleList);
		log.info("SrteList -> " + SrteList);
		log.info("getAIList -> " + getAIList);
		
		
		int total = this.oustouMainService.getAITotal(map); // 페이지네이션 전체 행의수
		
		// 페이지네이션 객체
		ArticlePage<OutsouVO> articlePage = new ArticlePage<OutsouVO>(total, currentPage, 10, getAIList, map);
		mav.addObject("SrleList", SrleList);// 기술수준 목록 가져오기
		mav.addObject("SrteList", SrteList);// 기술수준 목록 가져오기
		
		
		mav.addObject("articlePage", articlePage); //페이지네이션 + 언니거
		// 뷰 리졸버
		mav.setViewName("outsou/List/AIList");
		return mav;
	}
	
	
	
	
	/* 외주 직무직군 게시판 목록 */
	@RequestMapping(value="/JobList",method=RequestMethod.GET)
	public ModelAndView JobList(ModelAndView mav,
			@RequestParam(value = "outordMlsfc", required = false, defaultValue = "") String outordMlsfc, //리스트를 가져오기 우한 중분류 
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") Integer currentPage,   
			@RequestParam(value = "ord", required = false) String ord,   //정렬을 우위위한 
			@RequestParam(value = "srvcLevelCd", required = false) String srvcLevelCd, //옵션의 정보를 보내기 위한 
		    @RequestParam(value = "srvcTeamscaleCd", required = false) String srvcTeamscaleCd) {	
		
		log.info("srvcLevelCd : " + srvcLevelCd);
		log.info("srvcTeamscaleCd : " + srvcTeamscaleCd);
		
		//SRLE01_SRLE02_SRLE03
		// 기술 수준 값 처리
		List<String> srvcLevelCdList = new ArrayList<>();
		if (srvcLevelCd != null && !srvcLevelCd.isEmpty()) {
		    if (srvcLevelCd.contains(",")) {
		        srvcLevelCdList = Arrays.asList(srvcLevelCd.split(","));
		    } else {
		        srvcLevelCdList.add(srvcLevelCd); // 단일 값도 리스트에 추가
		    }
		}

		// 팀 규모 값 처리
		List<String> srvcTeamscaleCdList = new ArrayList<>();
		if (srvcTeamscaleCd != null && !srvcTeamscaleCd.isEmpty()) {
		    if (srvcTeamscaleCd.contains(",")) {
		        srvcTeamscaleCdList = Arrays.asList(srvcTeamscaleCd.split(","));
		    } else {
		        srvcTeamscaleCdList.add(srvcTeamscaleCd); // 단일 값도 리스트에 추가
		    }
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		map.put("outordMlsfc", outordMlsfc);
		map.put("ord", ord);
		map.put("srvcLevelCd", srvcLevelCd);
		map.put("srvcTeamscaleCd", srvcTeamscaleCd);
		
		List<CodeVO> SrleList = oustouMainService.getSrleList(); // 기술수준 가져오기 
		List<CodeVO> SrteList = oustouMainService.getSrteList(); // 팀 규모 가져오기
		List<OutsouVO> getJobList = this.oustouMainService.getJobList(map); // 각 카테고리별 리스트 
		log.info("SrleList -> " + SrleList);
		log.info("SrteList -> " + SrteList);
		log.info("getJobList -> " + getJobList);
		
		
		int total = this.oustouMainService.getJobTotal(map); // 페이지네이션 전체 행의수
		
		// 페이지네이션 객체
		ArticlePage<OutsouVO> articlePage = new ArticlePage<OutsouVO>(total, currentPage, 10, getJobList, map);
		mav.addObject("SrleList", SrleList);// 기술수준 목록 가져오기
		mav.addObject("SrteList", SrteList);// 기술수준 목록 가져오기
		
		
		mav.addObject("articlePage", articlePage); //페이지네이션 + 언니거
		// 뷰 리졸버
		mav.setViewName("outsou/List/JobList");
		return mav;
	}
	
	
	/* 외주 자기소개서 게시판 목록 */
	@RequestMapping(value="/SIList",method=RequestMethod.GET)
	public ModelAndView SIList(ModelAndView mav,
			@RequestParam(value = "outordMlsfc", required = false, defaultValue = "") String outordMlsfc, //리스트를 가져오기 우한 중분류 
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") Integer currentPage,   
			@RequestParam(value = "ord", required = false) String ord) {	
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		map.put("outordMlsfc", outordMlsfc);
		map.put("ord", ord);
		
		List<CodeVO> SrleList = oustouMainService.getSrleList(); // 기술수준 가져오기 
		List<CodeVO> SrteList = oustouMainService.getSrteList(); // 팀 규모 가져오기
		List<OutsouVO> getSIList = this.oustouMainService.getSIList(map); // 각 카테고리별 리스트 
		log.info("SrleList -> " + SrleList);
		log.info("SrteList -> " + SrteList);
		log.info("getSIList -> " + getSIList);
		
		
		int total = this.oustouMainService.getSITotal(map); // 페이지네이션 전체 행의수
		
		// 페이지네이션 객체
		ArticlePage<OutsouVO> articlePage = new ArticlePage<OutsouVO>(total, currentPage, 10, getSIList, map);
		mav.addObject("SrleList", SrleList);// 기술수준 목록 가져오기
		mav.addObject("SrteList", SrteList);// 기술수준 목록 가져오기
		
		
		mav.addObject("articlePage", articlePage); //페이지네이션 + 언니거
		// 뷰 리졸버
		mav.setViewName("outsou/List/SIList");
		return mav;
	}
	
	
	
	/* 검색 결과 페이지 */
	@RequestMapping(value="/searchList",method=RequestMethod.GET)
//	@GetMapping("/searchList")
	public ModelAndView searchList (ModelAndView mav,
			@RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage,
		    @RequestParam(value="keyword", required=false,defaultValue="") String keyword 
			) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		map.put("keyword", keyword);
	    
	    // 2024
	    log.info("currentPage: " + currentPage); // currentPage
	    map.put("keyword", keyword); // 키워드 추가
		
	    log.info("map : " + map);
	    //*******map : {currentPage=1, keyword=, order=pbancNo}
	    log.info("map : " + map);
		
		 //*** 외주 목록 List
	    List<OutsouVO> scarchList = this.oustouMainService.getscarchList(map); // 각 카테고리별 리스트 
		log.info("scarchList : " + scarchList);
		
		//*** 기업정보 총 행 갯수
		int total = this.oustouMainService.getscarchTotal(map); // 페이지네이션 전체 행의수
		log.info("list->total : " + total);
		
		log.info("total : " + total + ", currentPage : " + currentPage + ", scarchList : " + scarchList + ", map : " + map);
		
		//기업정보 페이징
		ArticlePage<OutsouVO> articlePage2 = new ArticlePage<OutsouVO>(total, currentPage, 10, scarchList, map);
		log.info("articlePage2 : " + articlePage2);
		mav.addObject("articlePage2", articlePage2);
		mav.addObject("keyword", keyword);
		mav.addObject("total", total);

		// /WEB-INF/view/common/commonList2.jsp
		mav.setViewName("outsou/searchList");
		
		return mav;
	}
	

}
