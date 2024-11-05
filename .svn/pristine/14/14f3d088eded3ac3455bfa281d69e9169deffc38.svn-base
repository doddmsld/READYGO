<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<!-- 외주 css 파일 -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/outsou/main.css" />

<script type="text/javascript">
$(function(){
	
	//스크롤 이벤트를 감지하여 일정 높이 이상 스크롤되면 버튼 표시
	$(window).scroll(function() {
	    if ($(this).scrollTop() > 200) { // 200px 이상 스크롤 시 버튼 보이기
	        $('#topBtn').fadeIn();
	    } else {
	        $('#topBtn').fadeOut();
	    }
	});
	
	// Top 버튼 클릭 시 페이지 상단으로 부드럽게 이동
	$('#topBtn').click(function() {
	    $('html, body').animate({ scrollTop: 0 }, 'slow'); // 페이지 상단으로 이동
	    return false;
	});
});
</script>

<button id="topBtn" class="top-btn" style="display:none; position:fixed; bottom:80px; right:280px;">TOP ▲</button>
<div class="mainALL">

	<div class="oucatrgoryAll">
		<div id="ousttit">
			<p class="oust">추천 카테고리</p>
		</div>
		<div class="oucatrgory">
			<c:forEach var="BestCategory" items="${BestCategory}">
				<a href="/outsou/WebList?outordMlsfc=${BestCategory.outordMlsfc}">
					<div class="oucg">
						${BestCategory.outordMlsfcNm}
					</div>
				</a>
			</c:forEach>
		</div>
	</div>


	<div>
		<!-- 정렬 -->

	</div>

	<div class="newtboxAll"> 
    <div>
        <p class="oust">NEW</p>
    </div>

    <div class="newtbox">
        <!-- New 게시글 목록 -->
        <c:forEach var="outsouNewVO" items="${NewList}">
            <div class="item_box">
                <div class="plus"></div>
                <a class="item_thum" href="/outsou/detail?outordNo=${outsouNewVO.outordNo}">
                    <img src="${outsouNewVO.outordMainFile}" alt="${outsouNewVO.outordMainFile}" class="product-image" id="pImg" />
                </a> 
                <a class="item_tit" href="/outsou/detail?outordNo=${outsouNewVO.outordNo}">
                    ${outsouNewVO.outordTtl}
                </a>
                <div class="item_info_wrap clear">
                    <div class="item_info">
                        <hr class="outhr">
                        <p class="price"><fmt:formatNumber pattern="#,###"
										value="${outsouNewVO.outordAmt}" />원</p>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>


<div class="bestboxAll">
    <div>
        <p class="oust">BEST</p>
    </div>
    <div class="bestbox">
        <!-- Best 게시글 목록 -->
        <c:forEach var="outsouBestVO" items="${BestList}">
            <div class="item_box">
                <div class="plus"></div>
                <a class="item_thum" href="/outsou/detail?outordNo=${outsouBestVO.outordNo}">
                    <img src="${outsouBestVO.outordMainFile}" alt="${outsouBestVO.outordMainFile}" class="product-image" id="pImg" />
                </a> 
                <a class="item_tit" href="/outsou/detail?outordNo=${outsouBestVO.outordNo}">
                    ${outsouBestVO.outordTtl}
                </a>
                <div class="item_info_wrap clear">
                    <div class="item_info">
                        <hr class="outhr">
                        <p class="price"><fmt:formatNumber pattern="#,###"
										value="${outsouBestVO.outordAmt}" />원</p>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>


	<div class="review">
		<div>
		<p class="oust">REVIEW</p>
		</div>
		<c:forEach var="reviewBestVO" items="${reviewBest}">
				<div class="review_box">
			<div class="reimg">
				<a href="/outsou/reviewDetail?seNo=5&pstSn=${reviewBestVO.pstSn}"><img src="${reviewBestVO.outordMainFile}" alt="${reviewBestVO.outordMainFile}" class="reimg"></a>
			</div>

			<div class="recont">
				<p>${reviewBestVO.mbrId}</p>
				<p><a href="/outsou/reviewDetail?seNo=5&pstSn=${reviewBestVO.pstSn}">${reviewBestVO.pstTtl}</a></p>
			</div>
		</div>
		</c:forEach>


	</div>

</div>