<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>

<!-- Spring Security 인증 정보를 가져오기 -->
<sec:authentication property="principal" var="prc"/>

<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>

<script type="text/javascript">
var socket = null;
var username = "${prc.username}";

$(document).ready(function(){
    if(username !== "anonymousUser"){
        connectWs();
    }
});

function connectWs() {
    if (socket !== null) {
        console.log("이미 WebSocket이 연결되어 있습니다.");
        return;
    }

    console.log("WebSocket 연결 시작");
    var ws = new SockJS("/chat");

    ws.onopen = function() {
        console.log('WebSocket 연결 성공');
    };

    ws.onmessage = function(event) {
        console.log("서버로부터 메시지 받음: " + event.data);

        let $chatBox = $('#chat-box');
        
        // 받은 메시지를 채팅창에 추가
        var receivedMessage = event.data;
        var sender = receivedMessage.split(":")[0];  // 보낸 사람의 username
        var message = receivedMessage.split(":")[1];  // 실제 메시지 내용
        
        // 메시지를 본인이 보낸 것인지 상대방이 보낸 것인지 구분
        var messageHtml;
        if(sender === username) {
            messageHtml = '<div class="chat-message right">' + receivedMessage + '</div>';
        } else {
            messageHtml = '<div class="chat-message left">' + receivedMessage + '</div>';
        }

        $chatBox.append(messageHtml);

        // 스크롤을 아래로 자동 이동
        $chatBox.scrollTop($chatBox.prop("scrollHeight"));
    };

    ws.onclose = function() {
        console.log('WebSocket 연결 종료');
        socket = null;
    };

    socket = ws;
}

$(document).ready(function() {
    // 채팅 메시지 전송 버튼 클릭 이벤트
    $('#send-btn').on('click', function() {
        var message = $('#chat-input').val();
        if (message.trim() !== "") {
            socket.send(message);  // 서버로 메시지 전송
            $('#chat-input').val('');  // 입력 필드 초기화
        }
    });

    // Enter 키로 메시지 전송 처리
    $('#chat-input').on('keypress', function(e) {
        if (e.which === 13) {  // Enter 키
            $('#send-btn').click();
        }
    });
});
</script>

<div class="container">
    <div class="chat-container">
        <div id="chat-box"></div>
        <input type="text" id="chat-input" placeholder="메시지를 입력하세요" />
        <button id="send-btn">전송</button>
    </div>
</div>

<style>
body {
    margin: 0;
    padding: 0;
    font-family: 'Pretendard', sans-serif;
    background-color: #fff;
}

.container {
    width: 80%;
    margin: 0 auto;
    margin-left: 20%;
}

.chat-container {
    border: 1px solid #ddd;
    padding: 10px;
    width: 300px;
    margin-left: 20%;
}

#chat-box {
    height: 300px;
    border: 1px solid #ddd;
    overflow-y: scroll;
    padding: 10px;
    margin-bottom: 10px;
}

.chat-message {
    padding: 5px;
    margin-bottom: 5px;
}

.chat-message.left {
    text-align: left;
}

.chat-message.right {
    text-align: right;
    color: blue;
}

#chat-input {
    width: calc(100% - 70px);
    padding: 5px;
}

#send-btn {
    padding: 5px;
}
</style>
