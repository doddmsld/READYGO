package kr.or.ddit.kakaoLogin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/security")
public class SecurityController {

    @Autowired
     KakaoLoginService kakaoLoginService;  // 이메일을 비교하기 위한 서비스

    @PostMapping("/kakaoLogin")
    @ResponseBody
    public MemberVO kakaoLogin(@RequestParam("email") String email, Model model) {
    	// DB에서 해당 이메일을 가진 사용자가 있는지 확인
        MemberVO memberVO = kakaoLoginService.getMemEmail(email);
        log.info("kakaoLogin -->> " + memberVO);
       
        if (memberVO != null) {
            // 이메일이 일치하면 로그인 처리 (세션 설정)
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            if (auth != null && auth.isAuthenticated()) {
                return memberVO;  // 이메일이 일치하면 로그인 성공 응답
            }
        }
        
       
        return memberVO;  // 이메일이; 일치하지 않으면 로그인 실패 응답
    }
    
    
    
}
