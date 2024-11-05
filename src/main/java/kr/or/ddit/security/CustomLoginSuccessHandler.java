package kr.or.ddit.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import kr.or.ddit.util.GetUserUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomLoginSuccessHandler extends 
	SavedRequestAwareAuthenticationSuccessHandler {
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request,
			HttpServletResponse response, Authentication auth)
			throws ServletException, IOException {
		//~했을때.로그인을.성공
		log.info("onAuthenticationSuccess");
		
		
	    User userDetail = (User) auth.getPrincipal();
		List<String> roleNames = new ArrayList<String>();
		auth.getAuthorities().forEach(authority->{
		roleNames.add(authority.getAuthority());
		});
		
		if (roleNames.contains("ROLE_ADMIN")) {
		    response.sendRedirect("/adm/main");
		    return; 
		} else if (roleNames.contains("ROLE_ENTER")) {
		    response.sendRedirect("/enter/main");
		    return;
		} else if (roleNames.contains("ROLE_MEMENTER")) {
		    response.sendRedirect("/enter/main");
		    return;
		} else if (roleNames.contains("ROLE_MEMBER")) {
		    response.sendRedirect("/");
		    return;
		}
		
		super.onAuthenticationSuccess(request, response, auth);
		
	}
	
}