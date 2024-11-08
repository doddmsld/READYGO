<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/sweetalert2.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/admAlert.css" />
<sec:authentication property="principal" var="prc"/>
<!-- 비로그인 또는 로그인한 사용자가 'admin'이 아닐 때 접근 금지 메시지를 표시하거나 리디렉션 -->
<sec:authorize access="!isAuthenticated() or principal.username != 'admin'">
    <script>
    Swal.fire({
        icon: 'error',
        title: '접근 권한이 없습니다',
        showConfirmButton: false,
        timer: 2000 
    }).then(() => {
        window.location.href = "/"; 
    });
    </script>
</sec:authorize>
<style>
.card-body img {
    max-width: 1000px;
    height: auto;
}
body {
    margin: 0;
    padding: 0;
    font-family: pretendard;
    background-color: #fff;
}

.container2 {
    width: 80%;
    margin: 0 auto;
    margin-left: 400px;
}

h1 {
    font-size: 28px;
    font-weight: bold;
    text-align: left;
    padding-top: 20px;
}
.main_text{
	width: 80%;
	margin-top: 100px;
	border-bottom: 2px solid black;
	padding:20px;
}
.faq{
	position: relative;
	display: flex;
	flex-direction: column;
	min-width: 0;
	background-color: white;
	background-clip: border-box;
	border-radius: 25px;
	padding: 20px;
	width: 80%;
	margin: 0 auto;
}
.faq-header{
    background-color: transparent;
    border-bottom: 2px solid #D9D9D9;
    padding: .75rem 1.25rem;
    position: relative;
    color: black;
}
.faq-title{
	float: left;
    font-size: 1.1rem;
    font-weight: 400;
    margin: 0;
    color: black;
}
.faq-title:hover{
	text-decoration: underline;
}
.faq-btn{
	background: white;
	color: #FD5D6C;
	border: 1px solid #FD5D6C;
	width: 100px;
	transition: all 0.3s ease 0s;
    text-align: center;
  	padding: 8px 15px;
    border-radius: 5px;
}
.faq-btn:hover{
    background-color: #FD5D6C;
    color: white;
}
.find-btn{
	text-align: right;
}
.edit-btn, .del-btn{
	width: 100px;
}
.del-btn{
   width: 100px;
    background: white;
   color: #232323;
   border: 1px solid #B5B5B5;
   transition: all 0.3s ease 0s;
}
.del-btn:hover{
   background: #ECECEC;
   color: #232323;
   border: 1px solid #B5B5B5;
}
</style>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<div class="container2">
    <header>
        <h1>FAQ 게시판</h1>
    </header>
    <p class="main_text" style="border-bottom: 2px solid black; display: flex; justify-content: space-between; align-items: center;">
        무엇을 도와드릴까요? 자주 묻는 질문들로 정리 해봤습니다! 질문이 없으시다면 문의 부탁드립니다!
        <button type="button" class="faq-btn filter-button" onclick="location.href='/adm/faqBoard/admFaqRegist'">등록</button>
    </p>
</div>
<div class="row" style="justify-content: center;">
    <div class="col-8" id="accordion">
        <c:forEach var="boardVO" items="${boardVOList}">
            <form name="deletePost" id="deletePost" action="/adm/faqBoard/deletePost" method="post">
                <div class="faq card-primary">
                    <a class="d-block w-100 collapsed" data-toggle="collapse" href="#collapseOne${boardVO.pstSn}" aria-expanded="false">
                        <div class="faq-header" style="display: flex;">
                            Q.&nbsp;&nbsp;<h4 class="faq-title w-100" style="text-align: left;">${boardVO.pstTtl}</h4>
                        </div>
                    </a>
                    <div id="collapseOne${boardVO.pstSn}" class="collapse" data-parent="#accordion">
                        <div class="card-body">${boardVO.pstCn}</div>
                        <div class="find-btn">
                            <button type="button" class="faq-btn del-btn">삭제</button>
                            <button type="button" class="faq-btn edit-btn" onclick="location.href='/adm/faqBoard/admFaqUpdate?seNo=${boardVO.seNo}&pstSn=${boardVO.pstSn}'">수정</button>
                        </div>
                    </div>
                    <input type="hidden" id="pstSn" name="pstSn" value="${boardVO.pstSn}"/>
                    <input type="hidden" id="seNo" name="seNo" value="${boardVO.seNo}"/>
                </div>
                <sec:csrfInput/>
            </form>
        </c:forEach>
    </div>
</div>

<script type="text/javascript">
$(document).ready(function(){
    $('.del-btn').on('click', function() {
        Swal.fire({
            title: '게시글을 삭제하시겠습니까?',
            icon: 'error',
            showCancelButton: true,
            confirmButtonColor: 'white',
            cancelButtonColor: 'white',
            confirmButtonText: '예',
            cancelButtonText: '아니오',
        }).then((result) => {
            if (result.isConfirmed) {
                $('#deletePost').submit();
            }
        });
    });
});
</script>
	
