package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.ChatMsgVO;
import kr.or.ddit.vo.ChatRoomVO;

public interface ChatMapper {

    // 채팅방 생성
    public void createChatRoom(
                        @Param("senderUser") String senderUser, 
                        @Param("receiveUser") String receiveUser);
    
    // 채팅방 존재 여부 확인
    public ChatRoomVO findChatRoom(@Param("senderUser") String senderUser, 
                            @Param("receiveUser") String receiveUser);

    // 채팅방 로그인한유저 조회(마이페이지)
	public List<ChatRoomVO> memFindChatRoom(String mbrId);

	//히스토리불러오기
	public List<ChatMsgVO> memChatHistory(@Param("roomNo") String roomNo);
	
	//메시지 insert 해야겠지?
	public void insertChatMessage(ChatMsgVO chatMsgVO);

	//안읽은거 읽음처리
	public void readYn(Map<String, Object> params);

	public ChatMsgVO lastMsg(String roomNo);

	public int countUnreadMsg(String roomNo);

	public void byeChat(Map<String, Object> params);  
	
}
