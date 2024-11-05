<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.memVO" var="priVO" />
</sec:authorize>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<meta charset="UTF-8">
<!-- 회원프로필css -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/member/profile.css" />
<!-- 스위트 alert css -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/alert.css" />
<!-- 구글 아이콘 -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20,200,0,0" />
<link href="https://fonts.googleapis.com/css2?family=Material+Icons"
	rel="stylesheet">

<!-- 인터페이스 아이콘 -->
<link rel='stylesheet'
	href='https://cdn-uicons.flaticon.com/2.6.0/uicons-solid-rounded/css/uicons-solid-rounded.css'>
<script type="text/javascript" src="/resources/js/sweetalert2.js"></script>
<script>
$(function(){
	var num = 10;
	function gl(){
		var num = 20;
		
		document.write(num);
		document.write(window.num);
	}
	gl();
})

</script>
