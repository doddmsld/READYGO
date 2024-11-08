package kr.or.ddit.controller_DO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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

import kr.or.ddit.mapper.AdminMapper;
import kr.or.ddit.mapper.UserMapper;
import kr.or.ddit.security.SocketHandler;
import kr.or.ddit.service_DO.FAQService;
import kr.or.ddit.service_DO.InquiryBoardService;
import kr.or.ddit.service_DO.NotificationService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.util.GetUserUtil;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.CodeVO;
import kr.or.ddit.vo.CommentVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.NotificationVO;
import lombok.extern.slf4j.Slf4j;


@RequestMapping("/common/inquiryBoard")
@Controller
@Slf4j
public class ComInquiryController {

	@Inject
	InquiryBoardService inquiryBoardService;
	
	@Autowired
	UserMapper userMapper;
	
	@Inject
	GetUserUtil getUserUtil;
	
	@Inject
	AdminMapper adminMapper;
	
	@Inject
	NotificationService notificationService;
	
    @Autowired
    private SocketHandler socketHandler;
    
	@RequestMapping(value="/inquiryList",method=RequestMethod.GET)
	public ModelAndView list(ModelAndView mav,
			@RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage,
			RedirectAttributes redirectAttributes) {
        
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		log.info("list->map : " + map);
		
		
		List<BoardVO> boardVOList = this.inquiryBoardService.list(map);
		int total = this.inquiryBoardService.getTotal();
		
        // JSP로 전달하기 위해 Model 객체에 boardVOList 저장
        mav.addObject("boardVOList", boardVOList);
		
		//페이지네이션 객체
		ArticlePage<BoardVO> articlePage = 
			new ArticlePage<BoardVO>(total, currentPage, 10, boardVOList, map);
		log.info("articlePage : " + articlePage);
		
		mav.addObject("articlePage", articlePage);
	    // 로그인한 사용자 ID 가져오기
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    String loggedInUser = "anonymousUser";  // 기본 값 설정

	    if (authentication != null && authentication.isAuthenticated() && !(authentication instanceof AnonymousAuthenticationToken)) {
	        loggedInUser = authentication.getName();
	        mav.addObject("loggedInUser", loggedInUser);
	        MemberVO memVO = getUserUtil.getMemVO();
            if(memVO == null) {
            	mav.setViewName("common/inquiryBoard/inquiryList");
            }else {
		       //알림 목록 조회
				List<NotificationVO> alramList = notificationService.alramList(loggedInUser);
	
				//알림 데이터 모델에 추가
				mav.addObject("alramList", alramList);
		        // 로그인한 사용자의 경고 횟수를 체크
		        memVO = getUserUtil.getMemVO();
		        if (memVO.getMbrWarnCo() > 4) {
		            redirectAttributes.addFlashAttribute("alertMessage", "게시판 제한자입니다");
		            return new ModelAndView("redirect:/"); // 루트 페이지로 리다이렉트
		        }
	        }
	    }

	    // 정상적인 경우 리스트 페이지로 이동
	    mav.setViewName("common/inquiryBoard/inquiryList");
		return mav;
	}	
	
	@GetMapping("/inquiryRegist")
	public String regist(Model model) {
	    List<CodeVO> codeVOList = userMapper.codeSelect("RNGE");
	    log.info("codeVOList", codeVOList);
	    
	    model.addAttribute("codeVOList", codeVOList);	
	  //웹소켓 알림설정 
	  //로그인한 사용자 ID 가져오기
	  Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	  String loggedInUser = "anonymousUser";  // 기본 값 설정

	  if (authentication != null && authentication.isAuthenticated() && !(authentication instanceof AnonymousAuthenticationToken)) {
			loggedInUser = authentication.getName();
			model.addAttribute("loggedInUser", loggedInUser);
			//알림 목록 조회
			List<NotificationVO> alramList = notificationService.alramList(loggedInUser);
					
			//알림 데이터 모델에 추가
			model.addAttribute("alramList", alramList);	        
	    };    	    
		return "common/inquiryBoard/inquiryRegist";
	}
	
	@PostMapping("/registPost")
	public String registPost(@ModelAttribute BoardVO boardVO) {
	    // 로그인한 사용자 정보 가져오기
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    String mbrId = authentication.getName();  // 로그인한 사용자 이름 (id)
	    
	    // boardVO의 작성자(writer) 필드에 로그인한 사용자 설정
	    boardVO.setMbrId(mbrId);
	    
	    log.info("registPost->boardVO : " + boardVO);
	    int result = this.inquiryBoardService.registPost(boardVO);
	    log.info("registPost->result : " + result);
	    
	    return "redirect:/common/inquiryBoard/inquiryDetail?seNo=4"+ "&pstSn=" + boardVO.getPstSn();
	}
	
	@GetMapping("/inquiryDetail")
	public String detail(@RequestParam("pstSn") String pstSn, Model model) {
	    log.info("detail=> getpstSn : "+pstSn);
	    

	    // 상세정보 가져오기
	    BoardVO boardVO = this.inquiryBoardService.detail(pstSn);
	    model.addAttribute("boardVO", boardVO);
	    
	    // 댓글 목록 가져오기
	    List<CommentVO> commentsList = this.inquiryBoardService.getComments(pstSn);
	    model.addAttribute("commentsList", commentsList);

	    // 로그인한 사용자 ID 가져오기
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    String loggedInUser = "anonymousUser";  // 기본 값 설정
	    
	    if (authentication != null && authentication.isAuthenticated() && !(authentication instanceof AnonymousAuthenticationToken)) {
	        loggedInUser = authentication.getName();
	        model.addAttribute("loggedInUser", loggedInUser);
	    }
	    
	    // 작성자와 로그인한 사용자 비교, 다를 경우에만 조회수 증가
	    if (!loggedInUser.equals(boardVO.getMbrId())) {
	        this.inquiryBoardService.InqCnt(pstSn);
	    }
	    
	    //게시판제한 경고 및 비로그인은 접근가능
	    if (authentication != null && authentication.isAuthenticated() && !(authentication instanceof AnonymousAuthenticationToken)) {
	        loggedInUser = authentication.getName();
	        model.addAttribute("loggedInUser", loggedInUser);
	        MemberVO memVO = getUserUtil.getMemVO();
	        if(memVO == null) {
	        	return "common/inquiryBoard/inquiryDetail";  
	        }else {
	  			//알림 목록 조회
	  			List<NotificationVO> alramList = notificationService.alramList(loggedInUser);
	  					
	  			//알림 데이터 모델에 추가
	  			model.addAttribute("alramList", alramList);	
		        // 로그인한 사용자의 경고 횟수를 체크
		        memVO = getUserUtil.getMemVO();
			    if(memVO.getMbrWarnCo() > 4) {
			    	model.addAttribute("alertMessage", "게시판 제한자입니다");
			    	return "home";
			    }
		    }
	    }
	    
	    return "common/inquiryBoard/inquiryDetail";    
	}
	
	@GetMapping("/inquiryUpdate")
	public String update(@RequestParam("pstSn") String pstSn, Model model) {
	    log.info("update => get pstSn : " + pstSn);
	    List<CodeVO> codeVOList = userMapper.codeSelect("RNGE");
	    log.info("codeVOList", codeVOList);
	    
	    
	    // 게시글 상세 정보 가져오기
	    BoardVO boardVO = this.inquiryBoardService.getPostDetails(pstSn);
	    model.addAttribute("boardVO", boardVO);
	    model.addAttribute("codeVOList", codeVOList);	
		  //웹소켓 알림설정 
		  //로그인한 사용자 ID 가져오기
		  Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		  String loggedInUser = "anonymousUser";  // 기본 값 설정

		  if (authentication != null && authentication.isAuthenticated() && !(authentication instanceof AnonymousAuthenticationToken)) {
	  			loggedInUser = authentication.getName();
	  			model.addAttribute("loggedInUser", loggedInUser);
		        // 게시글 작성자와 로그인한 사용자가 같은지 확인
		        if (!loggedInUser.equals(boardVO.getMbrId())) {
		            // 작성자가 아닌경우 List로 보내기
		            return "redirect:/common/inquiryBoard/inquiryList";  
		        }
	  			//알림 목록 조회
	  			List<NotificationVO> alramList = notificationService.alramList(loggedInUser);
	  					
	  			//알림 데이터 모델에 추가
	  			model.addAttribute("alramList", alramList);	        
  		    }else {
  		        // 비로그인 사용자 로그인창으로
  		        return "redirect:/security/login";  
  		    }    
	    return "common/inquiryBoard/inquiryUpdate";  // 수정 페이지로 이동
	}
	
	@PostMapping("/updatePost")
	public String updatePost(@ModelAttribute BoardVO boardVO) {
	    log.info("updatePost -> boardVO : " + boardVO);

	    // 수정된 데이터 업데이트
	    int result = this.inquiryBoardService.updatePost(boardVO);
	    
	    // 수정된 게시글의 세부정보 페이지로 리디렉션
	    return "redirect:/common/inquiryBoard/inquiryDetail?seNo=4&pstSn=" + boardVO.getPstSn();

	}
	
	@PostMapping("/deletePost")
	public String deletePost(@RequestParam("pstSn") String pstSn) {
	    log.info("deletePost -> getpstSn : " + pstSn);
	    
	    // 게시글 삭제
	    int result = inquiryBoardService.deletePost(pstSn);
	    if (result > 0) {
	        log.info("게시글 삭제 성공");
	    } else {
	        log.info("게시글 삭제 실패");
	    }
	    
	    return "redirect:/common/inquiryBoard/inquiryList"; // 삭제 후 목록 페이지로 리디렉션
	}
	@PostMapping("/registReplyPost")
	public String registReplyPost(@RequestParam("commentContent") String commentContent, @RequestParam("pstSn") String pstSn) {
	    // 로그인한 사용자 정보 가져오기
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    String mbrId = authentication.getName();  // 로그인한 사용자 이름 (id)

	    // 댓글 등록 VO 객체 생성
	    CommentVO commentVO = new CommentVO();
	    commentVO.setCmntCn(commentContent);
	    commentVO.setPstSn(pstSn);
	    commentVO.setMbrId(mbrId);
	    commentVO.setCmntDelYn("1");

	    // 댓글 등록
	    int result = this.inquiryBoardService.registComment(commentVO);
	    log.info("registReplyPost->result : " + result);

	    // 댓글 등록 후 상세로 이동
	    return "redirect:/common/inquiryBoard/inquiryDetail?pstSn=" + pstSn;
	}
    @PostMapping("/updateComment")
    @ResponseBody
    public String updateComment(@RequestBody CommentVO commentVO) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String mbrId = authentication.getName();

        // 댓글 수정 처리
        commentVO.setMbrId(mbrId);
        int result = this.inquiryBoardService.updateComment(commentVO);
        return result > 0 ? "success" : "fail";
    }

    @PostMapping("/deleteComment")
    @ResponseBody
    public String deleteComment(@RequestParam("cmntNo") String cmntNo, @RequestParam("pstSn") String pstSn) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String mbrId = authentication.getName();

        // 댓글 삭제 처리
        int result = this.inquiryBoardService.deleteComment(cmntNo, pstSn, mbrId);
        return result > 0 ? "success" : "fail";
    }
}
