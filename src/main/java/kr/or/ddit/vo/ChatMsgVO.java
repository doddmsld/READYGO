package kr.or.ddit.vo;

import lombok.Data;
import java.sql.Timestamp;

@Data
public class ChatMsgVO {
    private int msgId;
    private String roomNo;
    private String senderUser;
    private String msgContent;
    private int readYn;
    private Timestamp  msgDate;  
}
