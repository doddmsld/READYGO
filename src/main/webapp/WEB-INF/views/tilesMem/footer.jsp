<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<footer class="footer">
	<div id="footerDiv">
		<img src="/resources/icon/ReadyGo-로고(초록).png" style="margin-right: 10px;">
		<div id="textDiv">
		대덕인재개발원<br>
		Addr. 대전 중구 계룡로 846 4층<br>
		Tel. 042-222-8202 |  dditmedical@naver.com
		</div>
	</div>
</footer>
<style>
#footerDiv{
	display : flex;
	border-top : 1px solid #DCDCDC;
	padding-left : 20px;
	align-items: center; /* 세로 중앙 정렬 */
	height : 120px;
	padding : 10px 0 10px 100px;
}
#footerDiv img {
	width : 142px;
	height : 55px;
}
#textDiv{
	font-size: 12px;
	border-left :1px solid #666;
	padding-left : 20px;
}
</style>