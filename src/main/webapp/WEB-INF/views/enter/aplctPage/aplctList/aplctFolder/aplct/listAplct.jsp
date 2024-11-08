<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>지원자 리스트</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/enter/listAplct.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/alert.css" />
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
</head>
<body>
	<form action="/member/resumeRead2" method="post" id="resumeReadForm">
		<input type="hidden" id="resumeReadFormRsmNo" name="rsmNo" value="" />
		<input type="hidden" id="resumeReadFormMbrId" name="mbrId" value="" />
		<sec:csrfInput/>
	</form>	
	<sec:authentication property="principal" var="prc" />
	<div class="announcement-container">
		<div
			style="display: flex; align-items: baseline; margin-bottom: 10px;">
			<div>
				<h2 style="margin: 0px 0px 0px;">지원자 리스트</h2>
			</div>
			<div>
				<p class="total">전체  <b>${total}</b></p>
			</div>
		</div>
		<div>
				<p>*&nbsp;이력서 제목 클릭 시 이력서/자소서 PDF가 다운로드 됩니다.</p>
			</div>
		<div class="search-box">
			<!-- 셀렉트 박스 -->
			<div class="sel-cls">
				<div class="select-search">
					<select name="gubun" class="gubun-select">
						<option value="" disabled selected>신입/경력 선택</option>
						<option value="" >신입/경력</option>
						<option value="RSCA01">신입</option>
						<option value="RSCA02">경력</option>
					</select>
				</div>			
				<div class="filter-dropdown">
					<select name="gubunPbanc" id="announcementSelect">
					    <option value="" disabled selected>공고별 지원자 조회 선택</option>
					    <option value="" 
					        <c:if test="${param.gubunPbanc == ''}">selected</c:if>>공고별 지원자 전체 조회</option>
					    <c:forEach var="pbancVO" items="${entPbancList}" varStatus="status">
					        <option value="${pbancVO.pbancTtl}" 
					            <c:if test="${param.gubunPbanc == pbancVO.pbancTtl}">selected</c:if>>${pbancVO.pbancTtl}</option>
					    </c:forEach>
					</select>
				</div>
				<div class="filter-dropdown">
					<select name="gubunSt" class="aplct-sel">
						<option value="" disabled selected>지원자 상태 선택</option>
						<option value="">전체</option>
						<option value="APST01">미평가</option>
						<option value="APST02">서류합격</option>
						<option value="APST03">불합격</option>
					</select>
				</div>
			</div>
			<!-- 검색  -->
			<form action="/enter/listAplct" method="get">
				<div class="search">
					<input type="hidden" id="entId" name="entId"
						value="${prc.username}" />
					<input type="text" id="keywordInput" name="keywordInput"
						placeholder="지원자명 입력" />
					<div class="select-search">
						<select name="gubun1" class="gubun-select-date">
							<option value="" disabled selected>일자 선택</option>
							<option value="aplctAppymds">지원일자</option>
							<option value="intrvwYmd">면접일자</option>
						</select>
					</div>
					<input type="date" id="dateInput" name="dateInput"
						placeholder="면접일 선택" />
					<button type="submit">검색</button>
					<sec:csrfInput />
				</div>
			</form>
			<!-- 검색 -->
		</div>
	
		<table>
			<thead>
				<a href="./excelAplct.xls?entId=${prc.username}" class="excel-cls">
					<input type="hidden" id="entId" name="entId" value="${prc.username}">
					<img src="../resources/icon/download.png" class="aplct-down-img"/>excel
				</a>			
				<tr style="background: #f3f3f3; border-top: 2px solid #232323;">
					<th style="width: 60px;">번호</th>
					<th style="width: 120px;">지원자</th>
					<th class="leftTitle">이력서/자소서</th>
					<th>첨부파일</th>
					<th class="leftTitle">공고/마감일</th>
					<th>지원일자</th>
					<th>면접일자</th>
					<th>지원자 상태</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${not empty articlePage.content}">
				<c:forEach var="applicantVO" items="${articlePage.content}" varStatus="status">
						<c:if test="${fn:contains(proposalName, applicantVO.mbrId)}">
							<script>console.log("${applicantVO.mbrId}");
								console.log("${proposalName}");
							</script>
							<tr style="background: rgba(44, 207, 195, 0.11) !important;">
						</c:if>
						<c:if test="${!fn:contains(proposalName, applicantVO.mbrId)}">
							<tr>
						</c:if>
						<td style="text-align:center;">${applicantVO.rnum}</td>
						<td>
							<div class="aplctIN">
								<div class="aplctImg">
									<c:if test="${applicantVO.fileGroupSn eq null}">
										<img src="../resources/icon/인재.png" alt="img">									
									</c:if>
									<c:if test="${applicantVO.fileGroupSn ne null}">
										<img src="${applicantVO.fileGroupSn}" alt="img">									
									</c:if>
								</div>
								<div class="aplctName">
									<div class="title"><a href="/member/profile?mbrId=${applicantVO.mbrId}"
										target="_blank">${applicantVO.mbrNm}</a></div>
									<div class="sub">${applicantVO.rsmCareerCd}</div>
								</div>
							</div>
						</td>
						
						<td>
							<div class="title" style="width: 260px;">
								<img class="rsmImg" src="../resources/icon/resume.png" alt="rsm"/>
								<a class="pdfDownAlink" data-rsm-no="${applicantVO.rsmNo}" data-pbanc-no="${applicantVO.pbancNo}"
										data-mbr-id="${applicantVO.mbrId}">${applicantVO.rsmTtl}</a>
							</div>
							<div class="sub" style="width: 260px;"><img class="skillImg" src="../resources/icon/skill.png" alt="skill"/>${applicantVO.skCd}</div>
						</td>
						<td style="width: 150px; text-align: center;">
				        	<c:choose>
	                            <c:when test="${not empty applicantVO.aplctFile}">
	                                  <img class="fileImg" src="../resources/icon/attachfile.png" alt="file"/>  
	                                    <a href="/download?fileName=${applicantVO.aplctFile}">
						                    <span id="aplcont2">${applicantVO.aplctFileNm}</span>
						                </a>
	                            </c:when>
	                            <c:otherwise>
	                                <span id="aplcont2">-</span>
	                            </c:otherwise>
                       	    </c:choose>						
						</td>
						<td style="width: 320px;">
							<div class="title"><a href="/enter/pbancDetail?pbancNo=${applicantVO.pbancNo}">${applicantVO.pbancTtl}</a></div>
							<div class="ymds">${applicantVO.pbancDdlnDt}</div>
						</td>
						<td class="ymd" style="width: 120px">${applicantVO.aplctAppymds}</td>
						<td class="ymd" style="width: 120px">${applicantVO.intrvwYmd}</td>
						<td style="text-align: center;">
							<input type="hidden" value="${applicantVO.procssCd}" class="intrvwCd">
						    <div class="filter-dropdown">
						        <select onchange="saveApplicantStatus($(this),'${applicantVO.mbrId}', this.value,'${applicantVO.pbancNo}')" >
						            <option value="" disabled>지원자 상태</option>
						            <option value="APST01" ${applicantVO.aplctPrcsStatCd == 'APST01' ? 'selected' : ''}
						            ${applicantVO.aplctPrcsStatCd == 'APST02' ? 'disabled' : ''}
						            ${applicantVO.aplctPrcsStatCd == 'APST03' ? 'disabled' : ''}>미평가</option>
						            <option value="APST02" ${applicantVO.aplctPrcsStatCd == 'APST02' ? 'selected' : ''}>서류합격</option>
						            <option value="APST03" ${applicantVO.aplctPrcsStatCd == 'APST03' ? 'selected' : ''}>불합격</option>
						        </select>
						    </div>
						</td>
					</tr>
				</c:forEach>
				</c:if>
				<c:if test="${empty articlePage.content}">
					<tr><td colspan="7">검색 조건이 없습니다.</td></tr>
				</c:if>
			</tbody>
           <tfoot style="border-bottom: 2px solid #232323;">
           <tr>
           </tr>
			</tfoot>

		</table>
		<!-- 페이지네이션 -->
		<div class="card-body table-responsive p-0"
			style="display: flex; justify-content: center;">
			<table>
				<tr>
					<td class="pageTable" colspan="4" style="text-align: center;">
						<div class="dataTables_paginate" id="example2_paginate"
							style="display: flex; justify-content: center;">
							<ul class="pagination">

								<!-- 맨 처음 페이지로 이동 버튼 -->
								<c:if test="${articlePage.currentPage gt 1}">
									<li class="paginate_button page-item first"><a
										href="/enter/listAplct?entId=${prc.username}&currentPage=1"
										aria-controls="example2" data-dt-idx="0" tabindex="0"
										class="page-link">&lt;&lt;</a></li>
								</c:if>

								<!-- 이전 페이지 버튼 -->
								<c:if test="${articlePage.startPage gt 1}">
									<li class="paginate_button page-item previous"
										id="example2_previous"><a
										href="/enter/listAplct?entId=${prc.username}&currentPage=${(articlePage.startPage - 1) lt 1 ? 1 : (articlePage.startPage - 1)}"
										aria-controls="example2" data-dt-idx="0" tabindex="0"
										class="page-link">&lt;</a></li>
								</c:if>

								<!-- 페이지 번호 -->
								<c:forEach var="pNo" begin="${articlePage.startPage}"
									end="${articlePage.endPage}">
									<li
										class="paginate_button page-item ${pNo == articlePage.currentPage ? 'active' : ''}">
										<a
										href="/enter/listAplct?entId=${prc.username}&currentPage=${pNo}"
										aria-controls="example2" class="page-link">${pNo}</a>
									</li>
								</c:forEach>

								<!-- 다음 페이지 버튼 -->
								<c:if test="${articlePage.endPage lt articlePage.totalPages}">
									<li class="paginate_button page-item next" id="example2_next">
										<a
										href="/enter/listAplct?entId=${prc.username}&currentPage=${articlePage.startPage+5}"
										aria-controls="example2" data-dt-idx="7" tabindex="0"
										class="page-link">&gt;</a>
									</li>
								</c:if>

								<!-- 맨 마지막 페이지로 이동 버튼 -->
								<c:if
									test="${articlePage.currentPage lt articlePage.totalPages}">
									<li class="paginate_button page-item last"><a
										href="/enter/listAplct?entId=${prc.username}&currentPage=${articlePage.totalPages}"
										aria-controls="example2" data-dt-idx="7" tabindex="0"
										class="page-link">&gt;&gt;</a></li>
								</c:if>

							</ul>
						</div>
					</td>
				</tr>
			</table>
		</div>
		<!-- 페이지네이션 끝 -->
	</div>
</body>
<script>

var Toast = Swal.mixin({
	toast: true,
	position: 'center',
	showConfirmButton: false,
	timer: 3000
	});

$(function() {
	//<select name="gubun"
	$("select[name='gubun']").on("change", function() {
		//this : <select name="gubun"
		let gubun = $(this).val();
		let entId = "${param.entId}"; //test01 또는 null

		console.log("gubun : ", gubun);
		console.log("entId : ", entId);

		// /enter/scout?entId=test01&gubun=new
		// param : entId=test01&gubun=new
		//요청URI를 새로 요청
		location.href = "/enter/listAplct?entId=" + entId + "&gubun=" + gubun;
	});
	
	$("select[name='gubunSt']").on("change", function() {
		let gubunSt = $(this).val();
		let entId = "${param.entId}"; //test01 또는 null
		console.log("gubunSt : ", gubunSt);
		console.log("entId : ", entId);
		location.href = "/enter/listAplct?entId=" + entId + "&gubunSt=" + gubunSt;	
	});
	
	$("select[name='gubunPbanc']").on("change", function() {
	    let gubunPbanc = $(this).val();
	    let entId = "${param.entId}"; //test01 또는 null
	    console.log("선택한 공고: ", gubunPbanc);  // 선택한 값을 로그로 출력

	    location.href = "/enter/listAplct?entId=" + entId + "&gubunPbanc=" + gubunPbanc;
	});
	
});

window.onload = function() {
	// date input과 gubun-select를 가져옵니다.
	var dateInput = document.getElementById('dateInput');
	var gubunSelect = document.querySelector('.gubun-select-date');

	// 초기에는 date input 비활성화
	dateInput.disabled = true;

	// gubun-select가 변경될 때 이벤트 처리
	gubunSelect.addEventListener('change', function() {
		if (gubunSelect.value) {
			dateInput.disabled = false; // 옵션이 선택되면 date input 활성화
		} else {
			dateInput.disabled = true; // 옵션이 선택되지 않으면 date input 비활성화
		}
	});

	// date input에 포커스가 갈 때 이벤트 처리
	dateInput.addEventListener('focus', function() {
		if (!gubunSelect.value) { // 옵션이 선택되지 않았다면
			alert('지원일자와 면접일자 옵션을 선택하세요.');
			gubunSelect.focus(); // gubun-select로 포커스 이동
		}
	});
}
	function saveApplicantStatus($selectElement,mbrId, status, pbancNo) {
	    console.log("mbrId: " + mbrId);
	    console.log("status: " + status);
	    console.log("pbancNo: " + pbancNo);
	    let entId = "${param.entId}";
	    let intrvwCd =  $selectElement.closest('td').find('.intrvwCd').val();
	    console.log(entId);
	    console.log(intrvwCd);
	    $.ajax({
	        url: '/enter/updateAplctSt',
	        type: 'POST',
	        data: {
	            mbrId: mbrId,
	            status: status,
	            pbancNo : pbancNo,
	            entId : entId,
	            intrvwCd:intrvwCd
	        },
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
	        success: function(response) {
	        	console.log("response : ", response);
				Toast.fire({
					icon:'success',
					title:'상태 변경 성공',
					 // 커스텀 클래스 추가
				    customClass: {
				        popup: 'my-custom-popup'  // CSS에서 정의한 클래스 이름
				    }  
				}).then(() => {
	            	location.reload();
				});
	        },
	        error: function(error) {
	        	Toast.fire({
					icon:'error',
					title:'상태 변경 실패'
				});
	        }
	    });
	}
	// 이력서 자소서 다운
	$(document).ready(function(){
	    $(".excel-cls").click(function(){
	        // 서버에 GET 요청을 보내서 엑셀 파일 다운로드
	        window.location.href = '/enter/excelAplct.xls?entId=${prc.username}';
	    });
	});
	
	$(".pdfDownAlink").on("click", function() {
		let rsmNo = $(this).data("rsmNo");
		let mbrId = $(this).data("mbrId");
		let pbancNo = $(this).data('pbancNo');
		console.log(pbancNo);
		$.ajax({
		        url: '/enter/updateappstatus',
		        type: 'POST',
		        data: {
		            mbrId: mbrId,
		            pbancNo : pbancNo,
		        },
				beforeSend:function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				dataType: 'text', // 서버에서 반환되는 데이터를 텍스트로 처리
		        success: function(response) {
		        	console.log("열람 확인")
		        },
		        error: function(error) {
		        	console.log(error);
		            alert('열람 상태 변경 오류', error);
		        }
		   });
		$("#resumeReadFormRsmNo").val(rsmNo);
		$("#resumeReadFormMbrId").val(mbrId);
	    var popup = window.open('', '이력서 보기', 'width=1200,height=1440,top=' + (screen.height/2 - 720) + ',left=' + (screen.width/2 - 460));
	    
	    // 폼 데이터를 전송
	    $("#resumeReadForm").attr("target", '이력서 보기'); // 새 창의 이름을 설정
	    $("#resumeReadForm").submit(); // 폼 제출
	});	
	
</script>
</html>
