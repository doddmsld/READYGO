package kr.or.ddit.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.mapper.MemberMapper;
import kr.or.ddit.mapper.NotificationMapper;
import kr.or.ddit.security.UserService;
import kr.or.ddit.service.MemberService;
import kr.or.ddit.service_DO.NotificationService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.util.GetUserUtil;
import kr.or.ddit.vo.ApplicantVO;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.CodeVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.NotificationVO;
import kr.or.ddit.vo.OutsouVO;
import kr.or.ddit.vo.PbancVO;
import kr.or.ddit.vo.SearchVO;
import kr.or.ddit.vo.SettlementVO;
import lombok.extern.slf4j.Slf4j;

@CrossOrigin(origins = "http://localhost:3000") // 필요한 도메인 추가
@PreAuthorize("hasAnyRole('ROLE_MEMBER','ROLE_MEMENTER')")
@Controller
@Slf4j
@RequestMapping("/member")
public class MemberController {
    
    @Inject
    MemberService memberService;
    
    @Inject
    UserService userService;
    
    @Inject
    MemberMapper memberMapper;
    
    @Inject
    BCryptPasswordEncoder bCryptPasswordEncoder;
    
    @Inject
    GetUserUtil getUserUtil;

    @Inject
    NotificationService notificationService;
    

    // 회원 정보 수정 페이지 
    @GetMapping("/detail")
    public String detail(Model model) {
//    	회원에 대한 정보를 가져오고 model에 추가
        MemberVO memberVO = getUserUtil.getMemVO();
        model.addAttribute("memberVO", memberVO);
        return "member/mypage/detail";
    }
    
    // 회원 정보열람전에 비밀번호 확인 비동기 처리
    @ResponseBody
    @PostMapping("/detailChk")
    public boolean detailChk(@ModelAttribute MemberVO memberVO) {
    	boolean chk = false;
    	// 로그인한 회원의 비밀번호와 입력한 비밀번호가 일치하는지 확인후 불리언값 리턴
    	if(bCryptPasswordEncoder.matches(memberVO.getMbrPswd(), getUserUtil.getMemVO().getMbrPswd())) {
    		chk = true;
    	}
    	return chk;
    }
    
    @PostMapping("/editPost")
    public String editPost(@ModelAttribute MemberVO memberVO) {
    	// 로그인된 mbrId로 설정
        memberVO.setMbrId(getUserUtil.getLoggedInUserId());
        int result = this.memberService.editPost(memberVO);
        return "redirect:/member/detail?mbrId=" + memberVO.getMbrId();
    }
    
    // 회원 탈퇴
    @PostMapping("/deletePost")
    public String deletePost(HttpServletRequest request, HttpServletResponse response) {
        String mbrId = getUserUtil.getLoggedInUserId();
        int result = this.memberService.deletePost(mbrId);
        log.info("deletePost->result : " + result);
        
        // 로그아웃 처리
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            new SecurityContextLogoutHandler().logout(request, response, auth);
        }

        return "redirect:/"; 
    }
    
    //회원 검색기록 불러오기
    @GetMapping("/searchHistory")
    public ResponseEntity<List<SearchVO>> searchHistory(
    		@RequestParam(value = "mbrId", required = false) String mbrId) {
        
    	List<SearchVO> searchList = this.memberService.searchHistory(mbrId);
        log.info("searchHistory->searchList : " + searchList);
        
        return ResponseEntity.ok(searchList);
    }
    
    //회원 검색기록 저장하기
    @GetMapping("/searchInsert")
    public ResponseEntity<Integer> searchInsert(
    		@RequestParam(value = "searchNm", required = false) String searchNm,
    		@RequestParam(value = "mbrId", required = false) String mbrId) {
    	
    	Map<String,Object> map = new HashMap<String, Object>();
		map.put("searchNm", searchNm);
		map.put("mbrId", mbrId);
        
    	int result = this.memberService.searchInsert(map);
        log.info("searchInsert->result : " + result);
        
        // 결과에 따라 HTTP 상태 코드를 설정
        if (result > 0) {
            return ResponseEntity.ok(result); // 성공
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result); // 실패
        }
    }
    
    //회원 검색기록 선택 삭제
    @GetMapping("/searchDelete")
    public ResponseEntity<Integer> searchDelete(
    		@RequestParam(value = "searchNo", required = false) String searchNo) {
    	log.info("searchNo : " + searchNo);
    	
    	int result = this.memberService.searchDelete(searchNo);
        log.info("searchDelete->result : " + result);
        
        // 결과에 따라 HTTP 상태 코드를 설정
        if (result > 0) {
            return ResponseEntity.ok(result); // 성공
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result); // 실패
        }
    }
    
    //회원 검색기록 전체 삭제
    @GetMapping("/searchDeleteAll")
    public ResponseEntity<Integer> searchDeleteAll(
    		@RequestParam(value = "mbrId", required = false) String mbrId) {
    	log.info("mbrId : " + mbrId);
    	
    	int result = this.memberService.searchDeleteAll(mbrId);
        log.info("searchDeleteAll->result : " + result);
        
     // 결과에 따라 HTTP 상태 코드를 설정
        if (result > 0) {
            return ResponseEntity.ok(result); // 성공
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result); // 실패
        }
    }
    
    
    
    // 회원 비밀번호 변경
    @PostMapping("/updatePswd")
    public String updatePswd(@ModelAttribute MemberVO memberVO, Model model) {
    	
    	String encodePWd = bCryptPasswordEncoder.encode(memberVO.getMbrPswd());
    	memberVO.setMbrPswd(encodePWd);
    	
    	int result = this.memberService.updatePswd(memberVO);
    	 if (result > 0) {
    	        model.addAttribute("message", "비밀번호가 성공적으로 변경되었습니다.");
    	        return "redirect:/";
    	    } else {
    	        model.addAttribute("message", "비밀번호 변경에 실패했습니다.");
    	        return "member/changePassword";
    	    }

    }
    
    // 마이페이지 등록한 외주 목록
    @GetMapping("/memOutsouList")
    public ModelAndView memoutsouList(ModelAndView mav,
    		@RequestParam(value = "currentPage", required = false, defaultValue="1") Integer currentPage,
    		@RequestParam(value="dateInput1",required=false, defaultValue="") String dateInput1,
			@RequestParam(value="dateInput2",required=false, defaultValue="") String dateInput2,
			@RequestParam(value="keywordInput",required=false, defaultValue="")String keywordInput) {
    		
    	String mbrId = getUserUtil.getLoggedInUserId();
    	
    	Map<String, Object> map = new HashMap<String,Object>();
    	map.put("mbrId", mbrId);
    	map.put("currentPage", currentPage);
        map.put("keywordInput", keywordInput);
        map.put("dateInput1", dateInput1);
        map.put("dateInput2", dateInput2);
    	
    	List<OutsouVO> outsouVOList = this.memberService.memOutsouList(map);
    	int total = this.memberService.getOutsouTotal(map);	// 결제한 외주 전체 행의 수
    	
    	// 페이지네이션 객체
    	ArticlePage<OutsouVO> articlePage = new ArticlePage<OutsouVO>(total, currentPage, 5, outsouVOList, map);
    	
    	mav.addObject("mbrId",mbrId);
    	mav.addObject("articlePage",articlePage);
    	mav.addObject("outsouVOList",outsouVOList);
    	
    	mav.setViewName("member/mypage/memOutsouList");
    	
    	return mav;
    }
    
 // 마이페이지 결제한 외주 목록
    @GetMapping("/setleList")
    public ModelAndView setleList(ModelAndView mav,
    		@RequestParam(value = "currentPage", required = false, defaultValue="1") Integer currentPage,
			@RequestParam(value="dateInput1",required=false, defaultValue="") String dateInput1,
			@RequestParam(value="dateInput2",required=false, defaultValue="") String dateInput2,
			@RequestParam(value="keywordInput",required=false, defaultValue="")String keywordInput) {
    		
    	String mbrId = getUserUtil.getLoggedInUserId();
    	
        Map<String, Object> map = new HashMap<String,Object>();
        map.put("mbrId", mbrId);
        map.put("currentPage", currentPage);
        map.put("keywordInput", keywordInput);
        map.put("dateInput1", dateInput1);
        map.put("dateInput2", dateInput2);
        
        List<SettlementVO> setleVOList = this.memberService.setleList(map);
    	int total = this.memberService.getSetleTotal(map);	// 결제한 외주 전체 행의 수
    	
    	// 페이지네이션 객체
        ArticlePage<SettlementVO> articlePage = new ArticlePage<SettlementVO>(total, currentPage, 5, setleVOList, map);
    	
    	mav.addObject("mbrId",mbrId);
    	mav.addObject("articlePage",articlePage);
    	mav.addObject("setleVOList",setleVOList);
    	
    	mav.setViewName("member/mypage/setleList");
    	
    	return mav;
    }
    
    // 최근 본 공고 리스트
    @GetMapping("/recentViewList")
    public String recentViewList() {
    	
    	return "member/mypage/recentViewList";
    }

    
    // 최근 본 공고 
    @PostMapping("/getPbancRecent")
    @ResponseBody
    public List<PbancVO> getPbancRecent(@RequestBody List<String> pbancNoList){
        System.out.println("pbancNoList received from client: " + pbancNoList);
        if (pbancNoList == null || pbancNoList.isEmpty()) {
            return Collections.emptyList();
        }
        List<PbancVO> pbancVOList = this.memberService.getPbancRecent(pbancNoList);
        System.out.println("Retrieved pbancList: " + pbancVOList);
        return pbancVOList; 
    }
    
    @RequestMapping(value="/memAlram", method=RequestMethod.GET)
    public ModelAndView admList(ModelAndView mav,
            @RequestParam(value="currentPage", required=false, defaultValue="1") int currentPage) {

        // 로그인한 사용자 ID 가져오기
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String mbrId = authentication.getName(); // 로그인된 사용자 ID

        Map<String, Object> map = new HashMap<>();
        map.put("currentPage", currentPage);
        map.put("commonId", mbrId); // 로그인한 사용자 ID

        // 알림 리스트 가져오기
        List<NotificationVO> alramVOList = this.notificationService.memAlramList(map);

        // 알림 전체 개수 가져오기
        int total = this.notificationService.alramTotal(map);

        // ArticlePage로 페이징 객체 생성
        ArticlePage<NotificationVO> articlePage = new ArticlePage<>(total, currentPage, 7, alramVOList);

        // Model에 필요한 정보 추가
        mav.addObject("articlePage", articlePage);  // 페이징 정보
        mav.addObject("alramList", alramVOList);    // 알림 리스트
        mav.addObject("mbrId", mbrId);              // 로그인한 사용자 ID
        mav.setViewName("member/mypage/memAlram");

        return mav;
    }


    
 // 자유게시판 작성글 관리
    @GetMapping("/myFreeBoard")
    public ModelAndView myFreeBoard(ModelAndView mav,
    		@RequestParam(value="currentPage",required=false, defaultValue="1")Integer currentPage,
    		@RequestParam(value="dateInput1",required=false, defaultValue="") String dateInput1,
    		@RequestParam(value="dateInput2",required=false, defaultValue="") String dateInput2,
    		@RequestParam(value="keywordInput",required=false, defaultValue="")String keywordInput) {
    	
    	String mbrId = getUserUtil.getLoggedInUserId();
    	String board = "3";
        Map<String, Object> map = new HashMap<String,Object>();
        map.put("mbrId", mbrId);
        map.put("currentPage", currentPage);
        map.put("keywordInput", keywordInput);
        map.put("dateInput1", dateInput1);
        map.put("dateInput2", dateInput2);
        map.put("board", board);
        
        // 자유게시판 내가 쓴 글 목록
        List<BoardVO> boardVOList = this.memberService.boardVOList(map);

        // 전체 행의 수
        int total = this.memberService.getTotal(map);
        
        // 페이지네이션 객체
        ArticlePage<BoardVO> articlePage = new ArticlePage<BoardVO>(total, currentPage, 7, boardVOList, map);
        
        
        mav.addObject("mbrId", mbrId);
        mav.addObject("articlePage", articlePage);
        // 뷰 리졸버
        mav.setViewName("member/mypage/myFreeBoard");
        
        return mav;
    }
    
    // 문의게시판 작성글 관리
    @GetMapping("/myInquiryBoard")
    public ModelAndView myInquiryBoard(ModelAndView mav,
    		@RequestParam(value="currentPage",required=false, defaultValue="1")Integer currentPage,
    		@RequestParam(value="dateInput1",required=false, defaultValue="") String dateInput1,
    		@RequestParam(value="dateInput2",required=false, defaultValue="") String dateInput2,
    		@RequestParam(value="keywordInput",required=false, defaultValue="")String keywordInput) {
    	
    	String mbrId = getUserUtil.getLoggedInUserId();
    	String board = "4";
        Map<String, Object> map = new HashMap<String,Object>();
        map.put("mbrId", mbrId);
        map.put("currentPage", currentPage);
        map.put("keywordInput", keywordInput);
        map.put("dateInput1", dateInput1);
        map.put("dateInput2", dateInput2);
        map.put("board", board);
        
        // 문의게시판 내가 쓴 글 목록
        List<BoardVO> boardVOList = this.memberService.boardVOList(map);

        // 전체 행의 수
        int total = this.memberService.getTotal(map);
        
        // 페이지네이션 객체
        ArticlePage<BoardVO> articlePage = new ArticlePage<BoardVO>(total, currentPage, 7, boardVOList, map);
        
        
        mav.addObject("mbrId", mbrId);
        mav.addObject("articlePage", articlePage);
        // 뷰 리졸버
        mav.setViewName("member/mypage/myInquiryBoard");
        
        return mav;
    }
}
