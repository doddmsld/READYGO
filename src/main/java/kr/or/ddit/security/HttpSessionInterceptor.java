package kr.or.ddit.security;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.socket.server.HandshakeInterceptor;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpSession;
import java.util.Map;

public class HttpSessionInterceptor implements HandshakeInterceptor {
	private static final Logger logger = LoggerFactory.getLogger(WebSocketHandler.class);
	
	@Override
	public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response,
	                               WebSocketHandler wsHandler, Map<String, Object> attributes) throws Exception {
	    HttpSession session = ((ServletServerHttpRequest) request).getServletRequest().getSession(false);

	    if (session != null) {
	        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	        
	        // 사용자 인증 정보 확인
	        if (authentication != null && authentication.getPrincipal() instanceof CustomUser) {
	            CustomUser customUser = (CustomUser) authentication.getPrincipal();
	            String username = customUser.getMemVO().getMbrId();
	            attributes.put("username", username);  // WebSocket 세션에 사용자 ID 저장
	            logger.info("WebSocket handshake 사용자 ID: " + username);
	        } else {
	            logger.warn("WebSocket handshake 사용자 정보가 없음");
	        }
	    } else {
	        logger.warn("HttpSession이 null입니다.");
	    }
	    return true;
	}




    @Override
    public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response,
                               WebSocketHandler wsHandler, Exception ex) {
        // afterHandshake는 추가 작업이 필요하지 않음
    }
}

