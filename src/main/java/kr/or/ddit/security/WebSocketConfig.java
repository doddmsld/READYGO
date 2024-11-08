package kr.or.ddit.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import kr.or.ddit.api.socket;

@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        registry.addHandler(socketHandler(), "/alarm")  // new socket() 대신 socketHandler() 사용
                .addInterceptors(httpSessionInterceptor())
                .withSockJS();
        
        registry.addHandler(chatHandler(), "/chat")
                .addInterceptors(httpSessionInterceptor())
                .withSockJS();
    }

    @Bean
    public ChatHandler chatHandler() {
        return new ChatHandler();  // ChatHandler를 Bean으로 등록
    }
    
    @Bean
    public HttpSessionInterceptor httpSessionInterceptor() {
        return new HttpSessionInterceptor();  // 인터셉터를 Bean으로 등록
    }
    
    @Bean
    public SocketHandler socketHandler() {
        return new SocketHandler();  // SocketHandler를 Bean으로 등록
    }
}
