<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript" src="/resources/js/js.cookie.min.js"></script>
<link rel="stylesheet" href="/resources/css/security/loginForm.css">
<script type="text/javascript">
$(function(){
	if (Cookies.get('username') != null) {
        // 쿠키 값을 이용해 사용자 이름 입력 필드를 채우기
        let username = Cookies.get('username');
        $("#username").val(username);
        $("#remember_us").attr("checked", true);
    }else{
        $("#username").val();
    	
    }
	$("#loginBtn").on("click", function(){
		let username = $("#username").val();
        let password = $("#password").val();
		
        // 'remember me' 체크박스가 체크되어 있는지 확인
        if ($("input[name='remember_us']:checked").val()) {
            // 7일 동안 만료되는 쿠키 설정
            Cookies.set('username', username, { expires: 7});
            console.log("Username cookie set!");
        } else {
            // 'username' 쿠키 제거
            Cookies.remove('username');
            console.log("Username cookie removed!");
        }
		
        $("#login").submit();
	})
})
</script>
<style type="text/css">
.main{
background-image: url("/resources/images/secucrity/관리자 로그인.png");
    display: flex;
    justify-content: center;
    padding-top: 188px;
    min-height: 1100px;
    height: 100%;z
    width: 100%;
    margin-top: -100px;
}
.card{
	margin-top:80px;
	height: auto;
}
.container-fluid{
	padding:0;
}
.content{
	padding:0;
}
.btn-login {
    background-color: #f67f8a;
    color: #ffffff;
    box-shadow: 0 14px 28px rgba(0, 0, 0, 0.05), 0 10px 10px rgba(0, 0, 0, 0.05);
    transition: all 0.3s ease 0s;
    height: 50px;
    border-radius: 8px;
}
.btn-login:hover {
    background-color: #ffffff;
    border: 1px solid #f67f8a;
    color: #f67f8a;
    box-shadow: 0 14px 28px rgba(0, 0, 0, 0.05), 0 10px 10px rgba(0, 0, 0, 0.05);
    transition: all 0.3s ease 0s;
    height: 50px;
    border-radius: 8px;
}
</style>
<div class="main">
	<div class="login-box">
		<div class="card">
			<div class="login-logo row">
				<div>
					<p>Welcome to ReadyGo</p>
					<h2>관리자 로그인</h2>
				</div>
				<div>
				</div>
			</div>
			<div class="card-body login-card-body">
				<!-- 
				[스프링 시큐리티 로그인 폼 규칙]
				1. 아이디   : name속성값이 username
				2. 비밀번호 : name속성값이 password
				3. form태그의 action속성값이 /login, method속성값이 post
				4. csrf 처리
				5. submit 버튼
				 -->
				<form id="login" action="/login" method="post">
					<div class="form-group mb-3">
						<label for="username">Enter you ID</label>
						<input type="text" class="form-control" 
							placeholder="아이디" 
							name="username" id="username" value="" />
						<div class="form-group-append">
							<div class="form-group-text">
								<span class="fas fa-user"></span>
							</div>
						</div>
					</div>
					<div class="form-group mb-3" style="margin-bottom: 20px;">
						<label for="username">Enter you Password</label>
						<input type="password" class="form-control" 
							placeholder="비밀번호" 
							name="password" id="password" />
						<div class="form-group-append">
							<div class="form-group-text">
								<span class="fas fa-eye"></span>
							</div>
						</div>
					</div>
					<div class="col-12" style="margin-top: 40px;">
						<div class="col-12">
							<button type="button" class="btn btn-block btn-login" id="loginBtn">로그인</button>
						</div>
					</div>
					<!-- csrf : Cross Site(크로스 사이트) Request(요청) Forgery(위조) -->
					<sec:csrfInput/>
				</form>
			</div>
		</div>
	</div>
</div>
