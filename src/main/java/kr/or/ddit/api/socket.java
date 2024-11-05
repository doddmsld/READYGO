package kr.or.ddit.api;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class socket extends TextWebSocketHandler {
	private static final Logger logger = LoggerFactory.getLogger(WebSocketHandler.class);
	//소켓에 연결한 클라이언트 목록(로그인한 인원)
	private List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	
	//특정 사용자를 찾기 위한 map
	//특정 사용자의 id 값으로 메시지를 보내기 위해 사용된다
	private final Map<String, WebSocketSession> userSessionsMap = new ConcurrentHashMap<>();
	
	//소켓연결
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
	    String username = (String) session.getAttributes().get("username");
	    if (username != null) {
	        userSessionsMap.put(username, session);  // 세션을 맵에 저장
	        logger.info("WebSocket 연결 성공: 사용자 {}, 세션 {}", username, session.getId());
	    } else {
	        logger.warn("WebSocket 연결 중 사용자 정보 없음, 세션: {}", session.getId());
	    }
	    logger.info("현재 WebSocket 세션 목록: " + userSessionsMap.keySet());  // 세션 목록 출력
	    logger.info("현재 WebSocket 세션 목록: " + userSessionsMap);  // 세션 목록 출력
	    
	}


   public Map<String, WebSocketSession> getUserSessionsMap() {
        return userSessionsMap;
    }
	
	//현재 유저
	private String currentUserName(WebSocketSession session) {
	    // 세션에서 사용자 이름을 가져오는 로직
	    Map<String, Object> httpSession = session.getAttributes();
	    String username = (String) httpSession.get("username");  // "username"이라는 속성으로 사용자 정보 저장
	    if (username == null) {
	        username = session.getId();  // username이 없을 경우 세션 ID 사용
	    }
	    return username;
	}
	// 소켓 연결 해제
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
	    String username = (String) session.getAttributes().get("username");
	    if (username != null) {
	        userSessionsMap.remove(username);
	        logger.info("WebSocket 연결 해제: 사용자 {}, 세션 {}", username, session.getId());
	        logger.info("현재 등록된 세션 목록: " + userSessionsMap.keySet());  // 세션 해제 후 상태 출력
	    }
	}
}
