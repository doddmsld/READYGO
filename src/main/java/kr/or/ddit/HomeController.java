package kr.or.ddit;

import java.text.DateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.or.ddit.mapper.UserMapper;
import kr.or.ddit.service.PbancService;
import kr.or.ddit.service_DO.NotificationService;
import kr.or.ddit.util.GetUserUtil;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.NotificationVO;
import kr.or.ddit.vo.PbancVO;


/**
 * Handles requests for the application home page.
 */

@Controller
public class HomeController {
	
//	@Autowired
//	CookieManager cookieManager;
	@Autowired
	PbancService pbancService;
	@Inject
	GetUserUtil getUserUtil;
	@Inject
	UserMapper userMapper;
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@Inject
	NotificationService notificationService;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpServletRequest request) {
	    logger.info("Welcome home! The client locale is {}.", locale);

	    Date date = new Date();
	    DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
	    String formattedDate = dateFormat.format(date);
	    model.addAttribute("serverTime", formattedDate);

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
	        // 로그인한 사용자의 경고 횟수를 체크
	        MemberVO memVO = getUserUtil.getMemVO();
	        if (memVO != null && memVO.getMbrWarnCo() > 4) {
	        	Integer remain_days = this.userMapper.remainDays(memVO.getMbrId());
	        	 remain_days = (remain_days == null) ? 0 : remain_days;
	            if (remain_days > 0) {
	                // 경고 메시지를 매번 출력
	                model.addAttribute("alertMessage", "게시판 제한자입니다. " + remain_days + "일 남았습니다.");
	            } else {
	                // 제한 기간이 끝났을 때 경고 횟수 초기화 및 메시지 출력
	                this.userMapper.warnClear(memVO.getMbrId());
	                model.addAttribute("alertMessage", "게시판 제한 기간이 끝났습니다.<br>로그아웃 후 다시 이용해주세요!");
	            }
	        }
	    }
	    //메인페이지 채용공고
	    Map<String,Object> map = new HashMap<String, Object>();
	    int currentPage = 0;
	    String order = "pbancNo";
	    String[] selCity = new String[] {};
	    String[] selJob = new String[] {};
	    String keyword = "";
	    map.put("currentPage", currentPage);
		map.put("order", order);
		map.put("selCity", Arrays.asList(selCity));
		map.put("selJob", Arrays.asList(selJob));
		map.put("keyword", keyword);
	    List<PbancVO> pbancVOList = this.pbancService.list(map);
	    model.addAttribute("pbancVOList", pbancVOList);
	    return "home";
	}

}
