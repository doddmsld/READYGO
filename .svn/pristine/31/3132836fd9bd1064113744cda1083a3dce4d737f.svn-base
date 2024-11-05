package kr.or.ddit.util;



import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import kr.or.ddit.security.CustomUser;
import kr.or.ddit.vo.AdminVO;
import kr.or.ddit.vo.EnterVO;
import kr.or.ddit.vo.MemberVO;

@Component
public class GetUserUtil {
	
	public String getLoggedInUserId() {
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    if (authentication == null) {
	        return ""; // 또는 적절한 기본값을 반환
	    }

	    Object principal = authentication.getPrincipal();
	    String userId = "";

	    if (principal instanceof CustomUser) {
	        CustomUser userDetails = (CustomUser) principal;
	        userId = userDetails.getUsername(); // CustomUser에 mbrId 필드가 있다고 가정
	    } else if (principal instanceof String) {
	        userId = (String) principal; // principal이 String인 경우 직접 사용
	    }

	    return userId;
	}
	
	public MemberVO getMemVO() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUser userDetails = (CustomUser) authentication.getPrincipal();
		return userDetails.getMemVO(); // CustomUser에 mbrId 필드가 있다고 가정
	}
	public EnterVO getEntVO() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUser userDetails = (CustomUser) authentication.getPrincipal();
		return userDetails.getEntVO(); // CustomUser에 mbrId 필드가 있다고 가정
	}
	public AdminVO getAdsVO() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUser userDetails = (CustomUser) authentication.getPrincipal();
		return userDetails.getAdmVO(); // CustomUser에 mbrId 필드가 있다고 가정
	}
}
