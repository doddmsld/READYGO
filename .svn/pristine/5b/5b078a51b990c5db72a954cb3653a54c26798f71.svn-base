package kr.or.ddit.controller_DO;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.security.SocketHandler;
import kr.or.ddit.service_DO.FAQService;
import kr.or.ddit.service_DO.NotificationService;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.NotificationVO;
import lombok.extern.slf4j.Slf4j;


@RequestMapping("/common/faqBoard")
@Controller
@Slf4j
public class ComFAQController {

	@Inject
	FAQService faqService;
	
	@Inject
	NotificationService notificationService;
	
	@GetMapping("/faqList")
	public String list(Model model) {
		List<BoardVO> boardVOList = this.faqService.admList();
		int total = this.faqService.getTotal();
		
	    // model을 통해 데이터를 JSP로 전달
	    model.addAttribute("boardVOList", boardVOList);
	    model.addAttribute("total", total);
	    log.info("boardVOList"+boardVOList);
	    log.info("boardVOList",boardVOList);
	    // 로그인한 사용자 ID 가져오기
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    String loggedInUser = "anonymousUser";  // 기본 값 설정

	    if (authentication != null && authentication.isAuthenticated() && !(authentication instanceof AnonymousAuthenticationToken)) {
	        loggedInUser = authentication.getName();
	        model.addAttribute("loggedInUser", loggedInUser);
	       //알림 목록 조회
			List<NotificationVO> alramList = notificationService.alramList(loggedInUser);

			//알림 데이터 모델에 추가
			model.addAttribute("alramList", alramList);
	    }	    
		return "common/faqBoard/faqList";
	}
}
