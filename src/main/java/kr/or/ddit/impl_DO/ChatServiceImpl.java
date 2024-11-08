package kr.or.ddit.impl_DO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.ChatMapper;
import kr.or.ddit.service_DO.ChatService;
import kr.or.ddit.vo.ChatMsgVO;
import kr.or.ddit.vo.ChatRoomVO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ChatServiceImpl implements ChatService {

    @Inject
    ChatMapper chatMapper;

    @Override
    public void createChatRoom(String senderUser, String receiveUser) {
        // 이미 존재하는 채팅방인지 확인
        ChatRoomVO existingRoom = chatMapper.findChatRoom(senderUser, receiveUser);
        if (existingRoom == null) {
            // 방 번호 생성은 MyBatis의 SELECT KEY에서 처리
            chatMapper.createChatRoom(senderUser, receiveUser);
        } else {
            log.info("이미 존재하는 채팅방입니다.");
            throw new IllegalStateException("이미 존재하는 채팅방입니다.");
        }
    }
    
    @Override
    public List<ChatRoomVO> memFindChatRoom(String mbrId) {
        // 채팅방 목록 조회
        List<ChatRoomVO> chatRoomList = chatMapper.memFindChatRoom(mbrId);

        // 각 채팅방에 대해 마지막 메시지와 읽지 않은 메시지 수를 설정
        for (ChatRoomVO chatRoom : chatRoomList) {
            ChatMsgVO lastMessage = chatMapper.lastMsg(chatRoom.getRoomNo());
            int unreadCount = chatMapper.countUnreadMsg(chatRoom.getRoomNo());

            if (lastMessage != null) {
                // 마지막 메시지와 메시지 시간을 설정
                chatRoom.setLastMessage(lastMessage.getMsgContent());
                
                // 만약 lastMessage.getMsgDate()가 String이라면 Date로 변환해야 함
                chatRoom.setLastMessageDate(lastMessage.getMsgDate());
                chatRoom.setLastMessageSenderUser(lastMessage.getSenderUser());
            } else {
                // 채팅 메시지가 없을 경우 기본 메시지를 설정
                chatRoom.setLastMessage("채팅을 시작해주세요");
                chatRoom.setLastMessageDate(null); // 시간은 표시하지 않음
            }

            // 읽지 않은 메시지 수 설정
            chatRoom.setUnreadCount(unreadCount);
        }

        // 정렬: 안 읽은 메시지가 있는 채팅방을 먼저, 그다음 마지막 메시지 시간이 최신인 순서로
        chatRoomList.sort((a, b) -> {
            // 1. 안 읽은 메시지가 있는 채팅방을 위로 정렬
            if (a.getUnreadCount() > 0 && b.getUnreadCount() == 0) {
                return -1;
            } else if (a.getUnreadCount() == 0 && b.getUnreadCount() > 0) {
                return 1;
            }
            // 2. 안 읽은 메시지가 같은 경우, 마지막 메시지 시간이 최신인 순서로 정렬
            if (a.getLastMessageDate() != null && b.getLastMessageDate() != null) {
                return b.getLastMessageDate().compareTo(a.getLastMessageDate());
            }
            // 3. 둘 다 메시지가 없을 경우, 우선순위 없음 (변경 없음)
            return 0;
        });

        return chatRoomList; // 정렬된 채팅방 목록 반환
    }





    @Override
    public List<ChatMsgVO> memChatHistory(String roomNo) {
        return chatMapper.memChatHistory(roomNo);
    }
    
    @Override
    public void insertChatMessage(ChatMsgVO chatMsgVO) {
        chatMapper.insertChatMessage(chatMsgVO);
    }
    
    // 읽음 처리 추가
    @Override
    public void readYn(String roomNo, String username) {
        Map<String, Object> params = new HashMap<>();
        params.put("roomNo", roomNo);
        params.put("username", username);
        chatMapper.readYn(params);
    }

    @Override
    public void byeChat(String roomNo, String mbrId, String senderUser, String receiveUser) {
        Map<String, Object> params = new HashMap<>();
        params.put("roomNo", roomNo);
        params.put("mbrId", mbrId);
        params.put("senderUser", senderUser);
        params.put("receiveUser", receiveUser);

        chatMapper.byeChat(params);  // MyBatis 쿼리 호출
    }


    
}

