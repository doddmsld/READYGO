<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<link rel="stylesheet" href="../../resources/assets/css/templatemo-cyborg-gaming.css">
<!-- css 파일 -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/board/faqList.css" />

<div class="faqrow">

    <div class="registTitle">
		<h2>FAQ 게시판</h2>
	</div>
	
<div class="faqListAll">
    <p class="main_text">
        무엇을 도와드릴까요? 자주 묻는 질문들로 정리 해봤습니다! 이외에 궁금한 사항은 문의 게시판을 이용해주세요.
    </p>
</div>
<div class="container2">
    <div class="smcont" id="accordion">
        <c:forEach var="boardVO" items="${boardVOList}">
            <form name="deletePost" id="deletePost" action="/adm/faqBoard/deletePost" method="post">
                <div class="faq-card-primary">
                    <a class="collapsed" data-toggle="collapse" href="#collapseOne${boardVO.pstSn}" aria-expanded="false">
                        <div class="faq-header" >
                            <p class="faq-title">Q.&nbsp;&nbsp;&nbsp;${boardVO.pstTtl}</>
                        </div>
                    </a>
                    <div id="collapseOne${boardVO.pstSn}" class="collapse" data-parent="#accordion">
                        <div class="cardBody">${boardVO.pstCn}</div>
                    </div>
                    <input type="hidden" id="pstSn" name="pstSn" value="${boardVO.pstSn}"/>
                    <input type="hidden" id="seNo" name="seNo" value="${boardVO.seNo}"/>
                </div>
                <sec:csrfInput/>
            </form>
        </c:forEach>
    </div>
</div>
</div>

	
	
