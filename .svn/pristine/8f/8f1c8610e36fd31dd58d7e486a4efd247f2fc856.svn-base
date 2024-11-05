<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<!-- 외주 css 파일 -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/outsou/list.css" />

<script type="text/javascript">
	$(document).ready(function() {

		var keyword = "${param.keyword}"; // JSP에서 설정한 keyword
		if (keyword) {
			var regex = new RegExp('(' + keyword + ')', 'gi'); // 키워드를 대소문자 구분 없이 찾기 위한 정규 표현식
	
			// highlightable 클래스를 가진 td에서 키워드 강조
			$('.highlightable').each(function() {
				var html = $(this).html();
				$(this).html(html.replace(regex,'<span style="background-color: rgba(44, 207, 195, 0.30);">$1</span>'));
			});
		}
});
</script>

<c:choose>
	<c:when test="${not empty articlePage2.content}">
		<div class="submainAll">
			<div class="catnm">
				<p>
					'<span>${param.keyword}</span>'에 대한 검색 결과입니다.
				</p>
			</div>
		</div>

		<div class="newtboxAll">
			<div class="newtbox">
				<!-- 게시글 목록 -->
				<c:forEach var="getscarchList" items="${articlePage2.content}">
					<div class="item_box">
						<div class="plus"></div>
						<a class="item_thum"
							href="/outsou/detail?outordNo=${getscarchList.outordNo}"> <img
							src="${getscarchList.outordMainFile}"
							alt="${getscarchList.outordMainFile}" class="product-image"
							id="pImg" />
						</a> <a class="item_tit"
							href="/outsou/detail?outordNo=${getscarchList.outordNo}">
							${getscarchList.outordTtl} </a>
						<div class="item_info_wrap clear">
							<div class="item_info">
								<hr class="outhr">
								<p class="price">
									<fmt:formatNumber pattern="#,###"
										value="${getscarchList.outordAmt}" />
									원
								</p>
							</div>
						</div>
					</div>

				</c:forEach>
			</div>
		</div>
	

<!-- 페이지 처리 -->
<!-- 페이지네이션 -->
<div class="card-body table-responsive p-0"
	style="display: flex; justify-content: center;">
	<table style="margin-bottom: 30px;">
		<tr>
			<td colspan="4" style="text-align: center;">
				<div class="dataTables_paginate" id="example2_paginate"
					style="display: flex; justify-content: center; margin-top: 20px;">
					<ul class="pagination">

						<!-- 맨 처음 페이지로 이동 버튼 -->
						<c:if test="${articlePage2.currentPage gt 1}">
							<li class="paginate_button page-item first"><a
								href="/outsou/searchList?keyword=${param.keyword}&currentPage=1"
								aria-controls="example2" data-dt-idx="0" tabindex="0"
								class="page-link">&lt;&lt;</a></li>
						</c:if>

						<!-- 이전 페이지 버튼 -->
						<c:if test="${articlePage2.startPage gt 1}">
							<li class="paginate_button page-item previous"
								id="example2_previous"><a
								href="/outsou/searchList?keyword=${param.keyword}&currentPage=${(articlePage2.startPage - 1) lt 1 ? 1 : (articlePage2.startPage - 1)}"
								aria-controls="example2" data-dt-idx="0" tabindex="0"
								class="page-link">&lt;</a></li>
						</c:if>

						<!-- 페이지 번호 -->
						<c:forEach var="pNo" begin="${articlePage2.startPage}"
							end="${articlePage2.endPage}">
							<li
								class="paginate_button page-item ${pNo == articlePage2.currentPage ? 'active' : ''}">
								<a
								href="/outsou/searchList?keyword=${param.keyword}&currentPage=${pNo}"
								aria-controls="example2" class="page-link">${pNo}</a>
							</li>
						</c:forEach>

						<!-- 다음 페이지 버튼 -->
						<c:if test="${articlePage2.endPage lt articlePage2.totalPages}">
							<li class="paginate_button page-item next" id="example2_next">
								<a
								href="/outsou/searchList?keyword=${param.keyword}&currentPage=${articlePage2.startPage+5}"
								aria-controls="example2" data-dt-idx="7" tabindex="0"
								class="page-link">&gt;</a>
							</li>
						</c:if>

						<!-- 맨 마지막 페이지로 이동 버튼 -->
						<c:if
							test="${articlePage2.currentPage lt articlePage2.totalPages}">
							<li class="paginate_button page-item last"><a
								href="/outsou/searchList?keyword=${param.keyword}&currentPage=${articlePage2.totalPages}"
								aria-controls="example2" data-dt-idx="7" tabindex="0"
								class="page-link">&gt;&gt;</a></li>
						</c:if>

					</ul>
				</div>
			</td>
		</tr>
	</table>
</div>
</c:when>
	<c:otherwise>
		<div class="catnm">
			<p>
				'<span>${param.keyword}</span>'에 대한 검색 결과가 없습니다.
			</p>
		</div>
	</c:otherwise>
</c:choose>











