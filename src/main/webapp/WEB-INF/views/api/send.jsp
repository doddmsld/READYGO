<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
	<form action="/api/sendOne" method="post">
		발신번호<input type="text" id="memsend" name="memsend">
		수신번호<input type="text" id="memto" name="memto">
		내용<input type="text" id="memcon" name="memcon">
		<button type="submit">전송</button>
		<sec:csrfInput />
	</form>