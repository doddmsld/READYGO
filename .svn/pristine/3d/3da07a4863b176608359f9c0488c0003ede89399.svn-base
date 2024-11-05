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
<title>면접관리</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/enter/intrvw.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/alert.css" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript">
//모달 제어
var Toast = Swal.mixin({
	toast: true,
	position: 'center',
	showConfirmButton: false,
	timer: 3000
	});

document.addEventListener("DOMContentLoaded", function() {
    var modal1 = document.getElementById("scoutModal1");
    var modal2 = document.getElementById("scoutModal2");
    var calButtons = document.querySelectorAll(".cal-btn");
    var closeBtn1 = document.querySelector(".close1");
    var closeBtn2 = document.querySelector(".close2");
    var cancelButton1 = document.querySelector(".cancel-btn1");
    var cancelButton2 = document.querySelector(".cancel-btn2");
//     var failedModal = document.getElementById("failedModal");
//     var failedclose = document.querySelector(".failedclose");
//  	var failedButton = document.querySelector(".failedcancel-btn");
    
 	
 	calButtons.forEach(function(button) {
        button.addEventListener("click", function() {
    		var intrvwtycdnm = $(this).closest('tr').find('.intrvwtycdnm').text();
    		console.log(intrvwtycdnm);
	    	if(intrvwtycdnm==='일반면접'){
	            modal1.style.display = "block";    		
	    	}else if(intrvwtycdnm==='화상면접'){
	            modal2.style.display = "block";    		
	    		
	    	}
        });
    });
 
    
    // 닫기 버튼 클릭 시 모달 닫기
    closeBtn1.onclick = function() {
        modal1.style.display = "none";
    }
 	// 닫기 버튼 클릭 시 모달 닫기
//     failedclose.onclick = function() {
//     	failedModal.style.display = "none";
//     }
    // 닫기 버튼 클릭 시 모달 닫기
    closeBtn2.onclick = function() {
    	$("#videoPost option:eq(0)").prop("selected", true);
        modal2.style.display = "none";
    }

    // 취소 버튼 클릭 시 모달 닫기
    cancelButton1.onclick = function() {
        modal1.style.display = "none";
    }
    // 취소 버튼 클릭 시 모달 닫기
//     failedButton.onclick = function() {
//     	failedModal.style.display = "none";
//     }
    // 취소 버튼 클릭 시 모달 닫기
    cancelButton2.onclick = function() {
    	$("#videoPost option:eq(0)").prop("selected", true);
        modal2.style.display = "none";
    }

    // 모달 외부 클릭 시 모달 닫기
    window.onclick = function(event) {
        if (event.target == modal1 ||event.target == modal2) {
            modal1.style.display = "none";
            modal2.style.display = "none";
//             failedModal.style.display = "none";
        }
    }
});
var day = new Date();
$(function(){
//    $(".interviewVal").each(function() {
//     // 각 요소에서 작성된 날짜 텍스트를 가져옴
//     var wrDate = $(this).text();
//     console.log("작성된 날짜:", wrDate);

//     // 현재 날짜를 구합니다.
//     var currentDate = new Date();
    
//     // 작성된 날짜를 Date 객체로 변환
//     var wrDateObj = new Date(wrDate);
//     console.log("작성된 날짜 객체:", wrDateObj);

//     // 현재 날짜의 시분까지만 남기고 초는 0으로 설정하여 비교
//     var currentDateAdjusted = new Date(currentDate.getFullYear(), currentDate.getMonth(), currentDate.getDate(), currentDate.getHours(), currentDate.getMinutes(), 0);
//     console.log("현재 날짜 조정:", currentDateAdjusted);

//     // 두 날짜를 비교합니다.
//     if (wrDateObj < currentDateAdjusted) {
//         console.log("작성된 날짜가 현재 날짜보다 이전입니다.");
//     } else if (wrDateObj.getTime() === currentDateAdjusted.getTime()) {
//         console.log("작성된 날짜와 현재 날짜가 같습니다.");
//     } else {
//         console.log("작성된 날짜가 현재 날짜보다 이후입니다.");
//     }
// });


// 	$('.interviewVal').each(function(){
// 		var btn = $(this).closest('tr').find('.cal-btn')
// 		var selectval = $(this).text();
// 		console.log(selectval);
// 		if(selectval==='-'){
// 			console.log("???");
// 			btn.prop('disabled',false);
			
// 		}else{
// 			console.log("?????");
// 			btn.prop('disabled',true);
// 		}
// 	})


    $('.interviewBtn').each(function() {
        
        // 해당 tr 안에 있는 appliBtn을 찾음
        var appliBtn = $(this).closest('tr').find('.appliBtn');
        
        // interviewBtn의 현재 선택된 값을 가져옴
        var selectedValue = $(this).val();
        
        // 'tsnt01'일 경우 appliBtn을 비활성화, 그 외는 활성화
        if (selectedValue === 'INST01' || selectedValue === 'INST02') {
            appliBtn.prop('disabled', true);
        }else {
            appliBtn.prop('disabled', false);
        }
    });

    // interviewBtn에서 값이 변경될 때 실행되는 이벤트
    $('.interviewBtn').change(function() {
        // 현재 선택된 interviewBtn이 속한 tr을 찾음
        var currentTr = $(this).closest('tr');
        
        // 해당 tr 안에 있는 appliBtn을 찾음
        var appliBtn = currentTr.find('.appliBtn');
        
        // interviewBtn에서 선택된 값이 있는지 확인
        var selectedValue = $(this).val();
        
        // 'tsnt01'일 경우 appliBtn을 비활성화, 그 외는 활성화
        if (selectedValue === 'INST01' || selectedValue === 'INST02') {
            appliBtn.prop('disabled', true);
        }else {
            appliBtn.prop('disabled', false);
        }
        
        let intrvwNo = $(this).closest('tr').find("#inNo").val();
        let intrvwSttus = $(this).val();
        console.log(intrvwNo);
        console.log(intrvwSttus);
        $.ajax({
	        url: '/enter/updateIntrvw',
	        type: 'POST',
	        data: {
	           intrvwNo: intrvwNo,
	           intrvwSttus: intrvwSttus
	        },
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
	        success: function(response) {
	        	console.log(response);
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
	        	console.log(error);
	        	Toast.fire({
					icon:'error',
					title:'상태 변경 실패'
				});
	        }
	    });
    });
    //지원자 상태
    $(".appliBtn").on('change',function(){
        let intrvwSttus = $(this).val();
//     	if(intrvwSttus ==='APST04'){
//     		failedModal.style.display = "block";  // 불합격일 경우 failedModal 열기
//     	}
    		let pbancNo = $(this).closest('tr').find(".pbancNo").val();
        	let mbrId = $(this).closest('tr').find("#mbrId").val();
            console.log(pbancNo);
            console.log(mbrId);
            console.log(intrvwSttus);
            $.ajax({
    	        url: '/enter/updateIntrvwPrcsStat',
    	        type: 'POST',
    	        data: {
    	        	pbancNo: pbancNo,
    	        	mbrId: mbrId,
    	        	intrvwSttus:intrvwSttus
    	        },
    			beforeSend:function(xhr){
    				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
    			},
    	        success: function(response) {
    	        	console.log(response);
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
    	        	console.log(error);
    	        	Toast.fire({
    					icon:'error',
    					title:'상태 변경 실패'
    				});
    	        }
    	    });
    	
    })    
    
    $("select[name='gubun']").on("change", function() {
		//this : <select name="gubun"
		let gubun = $(this).val();
		let entId = "${param.entId}"; //test01 또는 null

		console.log("gubun : ", gubun);
		console.log("entId : ", entId);

		// /enter/scout?entId=test01&gubun=new
		// param : entId=test01&gubun=new
		//요청URI를 새로 요청
		location.href = "/enter/intrvw?entId=" + entId + "&gubun=" + gubun;
	});
    
    $("select[name='gubunSt']").on("change", function() {
		let gubunSt = $(this).val();
		let entId = "${param.entId}"; //test01 또는 null
		console.log("gubunSt : ", gubunSt);
		console.log("entId : ", entId);
		location.href = "/enter/intrvw?entId=" + entId + "&gubunSt=" + gubunSt;	
	});
    
    $("select[name='gubunPbanc']").on("change", function() {
		let gubunPbanc = $(this).val();
		let entId = "${param.entId}"; //test01 또는 null
		location.href = "/enter/intrvw?entId=" + entId + "&gubunPbanc=" + gubunPbanc;	
	});
    
    $('.cal-btn').on('click',function(){
    	var btn = $(this).closest('tr').find('.inNo').val();
    	$('.intrvwNum').val(btn);
    	console.log(btn);
    	let pbancNo = $(this).closest('tr').find(".pbancNo").val();
    	console.log(pbancNo);
    	$.ajax({
	        url: '/enter/intrvwvideoPost',
	        type: 'POST',
	        data: {
	        	job : pbancNo,
	        },
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
	        success: function(response) {
	        	 let text="<option value='' disabled selected>화상방을 선택해주세요.</option>";
	            for(let i=0;i<response.length;i++){
	            	text+="<option value='"+response[i].vcrNo+"'>"+response[i].vcrTitle+"</option>";
	            }
	            
	            $('#videoPost').html(text);
	        },
	        error: function(error) {
	        	console.log(error);
	            alert('상태 저장 중 오류가 발생했습니다.', error);
	        }
	    });
    	
    	
    })
    
    $(".btnDel").on('click',function(){
    	intrvwNo = $(this).closest('tr').find('.inNo').val();
    	console.log(intrvwNo);
    	
    	Swal.fire({
    		  title: '삭제하시겠습니까?',
    		  icon: 'error',
    		  showCancelButton: true,
    		  confirmButtonColor: 'white',
    		  cancelButtonColor: 'white',
    		  confirmButtonText: '예',
    		  cancelButtonText: '아니오',
    		  reverseButtons: false, // 버튼 순서 거꾸로
    		}).then((result) => {
    		  if (result.isConfirmed) {
    			  $.ajax({
    			        url: '/enter/updateDateIntrvw',
    			        type: 'POST',
    			        data: {
    			        	intrvwNo : intrvwNo,
    			        },
    					beforeSend:function(xhr){
    						xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
    					},
    			        success: function(response) {
    			        	 console.log(response);
    			        	 Toast.fire({
    								icon:'success',
    								title:'삭제 성공',
    								 // 커스텀 클래스 추가
    							    customClass: {
    							        popup: 'my-custom-popup'  // CSS에서 정의한 클래스 이름
    							    }  
    							}).then(() => {
    				            	location.reload();
    							});
    			        },
    			        error: function(error) {
    			        	console.log(error);
    			        	Toast.fire({
    							icon:'error',
    							title:'상태 변경 실패'
    						});
    			        }
    			    });
    	          
    		  }
    		})
    })
    
    $(".pdfDownAlink").on("click", function() {
		let rsmNo = $(this).data("rsmNo");
		let mbrId = $(this).data("mbrId");
		let pbancNo = $(this).data('pbancNo');
		console.log(pbancNo);
		$("#resumeReadFormRsmNo").val(rsmNo);
		$("#resumeReadFormMbrId").val(mbrId);
	    var popup = window.open('', '이력서 보기', 'width=1200,height=1440,top=' + (screen.height/2 - 720) + ',left=' + (screen.width/2 - 460));
	    
	    // 폼 데이터를 전송
	    $("#resumeReadForm").attr("target", '이력서 보기'); // 새 창의 이름을 설정
	    $("#resumeReadForm").submit(); // 폼 제출
	});	
    
   
    
    
    
    
    
    $(document).on("click", "#submit-btn", function(event) {
    	event.preventDefault(); // 기본 폼 전송 방지
    	$("#scoutForm").attr("action", "/enter/intrvwFormPost2");

    	// Swal.fire 사용하여 수정 확인창 표시
    	Swal.fire({
    	    title: '등록하시겠습니까?',
    	    icon: 'question',
    	    showCancelButton: true,
    	    confirmButtonColor: 'white',
    	    cancelButtonColor: 'white',
    	    confirmButtonText: '예',
    	    cancelButtonText: '아니오'
    	}).then((result) => {
    	    if (result.isConfirmed) {
    	        // 수정 확인 시 폼 전송
    	        Toast.fire({
    	            icon: 'success',
    	            title: '등록 완료!',
					 // 커스텀 클래스 추가
				    customClass: {
				        popup: 'my-custom-popup'  // CSS에서 정의한 클래스 이름
				    }  
    	        }).then(() => {
    	        	$("#scoutForm").submit();
				});
    	    } else {
    	        // 수정 취소 시
    	        Toast.fire({
    	            icon: 'error',
    	            title: '등록 취소!'
    	        });
    	    }
    	});
    	});  
    
    
    
    $(document).on("click", "#submit-btn2", function(event) {
    	event.preventDefault(); // 기본 폼 전송 방지
    	$("#intrvwForm").attr("action", "/enter/intrvwFormPost");

    	// Swal.fire 사용하여 수정 확인창 표시
    	Swal.fire({
    	    title: '등록하시겠습니까?',
    	    icon: 'question',
    	    showCancelButton: true,
    	    confirmButtonColor: 'white',
    	    cancelButtonColor: 'white',
    	    confirmButtonText: '예',
    	    cancelButtonText: '아니오'
    	}).then((result) => {
    	    if (result.isConfirmed) {
    	        // 수정 확인 시 폼 전송
    	        Toast.fire({
    	            icon: 'success',
    	            title: '등록 완료!',
					 // 커스텀 클래스 추가
				    customClass: {
				        popup: 'my-custom-popup'  // CSS에서 정의한 클래스 이름
				    }  
    	        }).then(() => {
    	        	$("#intrvwForm").submit();
				});
    	    } else {
    	        // 수정 취소 시
    	        Toast.fire({
    	            icon: 'error',
    	            title: '등록 취소!'
    	        });
    	    }
    	});
    	});  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
})
</script>
</head>
<body>
	<form action="/member/resumeRead2" method="post" id="resumeReadForm">
		<input type="hidden" id="resumeReadFormRsmNo" name="rsmNo" value="" />
		<input type="hidden" id="resumeReadFormMbrId" name="mbrId" value="" />
		<sec:csrfInput />
	</form>
	<sec:authentication property="principal" var="prc" />
	<div class="announcement-container">
		<div
			style="display: flex; align-items: baseline; margin-bottom: 10px;">
			<div>
				<h2 style="margin: 0px 0px 0px;">면접관리</h2>
			</div>
			<div>
				<p class="total">
					전체 <b>${total}</b>
				</p>
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
						<option value="" disabled selected style="display: none;">신입/경력
							선택</option>
						<option value="">신입/경력</option>
						<option value="신입"
							<c:if test="${param.gubun eq '신입'}">selected</c:if>>신입</option>
						<option value="경력"
							<c:if test="${param.gubun eq '경력'}">selected</c:if>>경력</option>
					</select>
				</div>
				<div class="filter-dropdown">
					<select name="gubunPbanc" id="announcementSelect">
						<option value="" disabled selected style="display: none;">공고별
							지원자 조회 선택</option>
						<option value="">공고별 지원자</option>
						<c:forEach var="pbancVO" items="${pbancList}" varStatus="status">
							<option value="${pbancVO.pbancTtl}"
								<c:if test="${param.gubunPbanc eq pbancVO.pbancTtl}">selected</c:if>>${pbancVO.pbancTtl}</option>
						</c:forEach>
					</select>
				</div>
				<div class="filter-dropdown">
					<select name="gubunSt" class="aplct-sel">
						<option value="" disabled selected style="display: none;">면접
							상태 선택</option>
						<option value="">면접 상태</option>
						<c:forEach var="instVO" items="${instList}">
							<option value="${instVO.comCode}"
								<c:if test="${param.gubunSt eq instVO.comCode}">selected</c:if>>${instVO.comCodeNm}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<!-- 검색  -->
			<form action="/enter/intrvw" method="get">
				<div class="search">
					<input type="hidden" id="entId" name="entId"
						value="${prc.username}" /> <input type="text" id="keywordInput"
						name="keywordInput" placeholder="지원자명 입력"
						value="${param.keywordInput}" /> <input type="date" id="dateInput"
						name="dateInput" placeholder="면접일 선택" value="${param.dateInput}" />
					<button type="submit">검색</button>
					<sec:csrfInput />
				</div>
			</form>
			<!-- 검색 -->
		</div>

		<table>
			<thead>
				<a href="./excelAplcts.xls?entId=${prc.username}" class="excel-cls">
					<input type="hidden" id="entId" name="entId"
					value="${prc.username}"> <img
					src="../resources/icon/download.png" class="aplct-down-img" />excel
				</a>
				<tr style="background: #f3f3f3; border-top: 2px solid #232323;">
					<th style="width: 60px;">번호</th>
					<th style="width: 120px;">지원자</th>
					<th class="leftTitle">이력서/자소서</th>
					<th>면접종류</th>
					<th>면접일자</th>
					<th>면접 일정 등록</th>
					<th>면접 상태</th>
					<th>지원자 상태</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${not empty articlePage.content}">
					<c:forEach varStatus="stat" var="applicantVO"
						items="${articlePage.content}">
						<tr>

							<td style="text-align: center;"><input id="inNo"
								class="inNo" type="hidden" value="${applicantVO.intrvwNo}">
								<input class="pbancNo" type="hidden"
								value="${applicantVO.pbancNo}"> ${applicantVO.rnum}</td>
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
										<div id="mbrNm" name="mbrNm">${applicantVO.mbrNm}
											<input type="hidden" id="mbrId" name="mbrId"
												value="${applicantVO.mbrId}">
										</div>
										<div class="aplctTp">${applicantVO.rsmCareerCd}</div>
									</div>
								</div>
							</td>
							<td>

								<div class="title">
									<img class="rsmImg" src="../resources/icon/resume.png"
										alt="rsm" /><a class="pdfDownAlink"
										data-rsm-no="${applicantVO.rsmNo}"
										data-pbanc-no="${applicantVO.pbancNo}"
										data-mbr-id="${applicantVO.mbrId}">${applicantVO.rsmTtl}</a>
								</div>
								<div class="industry">
									<img class="skillImg" src="../resources/icon/skill.png"
										alt="skill" />
									<c:choose>
										<c:when test="${fn:length(applicantVO.skCd) > 25}">
							        ${fn:substring(applicantVO.skCd, 0, 25)}...
							    </c:when>
										<c:otherwise>
							        ${applicantVO.skCd}
							    </c:otherwise>
									</c:choose>
								</div>
							</td>





							<td class="intrvwtycd"
								style="text-align: center; padding-left: 25px;">
								<div class="intrvwtycdnm"
									style="text-align: center; width:75px ;height:30px;padding-left: 6px;padding-top: 5px;padding-bottom: 3px;padding-right: 6px;
					<c:if test="${applicantVO.intrvwTyCd eq '화상면접'}">display:flex; justify-content: center; border:none; border-radius: 15px; background-color: #b0e0e6;</c:if>
					<c:if test="${applicantVO.intrvwTyCd eq '일반면접'}">display:flex; justify-content: center; border:none; border-radius: 15px; background-color: #ffd9df;</c:if>
					">${applicantVO.intrvwTyCd}</div>
							</td>

							<td class="interviewVal" style="text-align: center;">${applicantVO.intrvwYmd}<c:if
									test="${applicantVO.intrvwYmd ne '-'}">
									<button type="button" class="btnDel" id="btnDel">
										<img class="del-btn" src="../resources/icon/del-btn.png" />
									</button>
								</c:if>
							</td>
							<td style="text-align: center;">
								<button class="cal-btn" type="button" value="면접 일정 등록"
									<c:if test="${applicantVO.intrvwYmd ne '-'}">disabled</c:if>>면접
									일정 등록</button>
							</td>
							<td style="text-align: center;">
								<div class="filter-dropdown">
									<select class="interviewBtn">
										<option value="" disabled selected>면접 상태</option>
										<c:forEach var="instVO" items="${instList}">
											<option value="${instVO.comCode}"
												<c:if test="${instVO.comCode eq applicantVO.intrvwSttusCd}">selected</c:if>>${instVO.comCodeNm}</option>
										</c:forEach>
									</select>
								</div>
							</td>
							<td style="text-align: center;">
								<div class="filter-dropdown">
									<select class="appliBtn">
										<option value="" disabled selected>지원자 상태</option>
										<c:forEach var="apstVO" items="${apstList}">
											<c:if test="${apstVO.comCode ne 'APST01'}">
												<option value="${apstVO.comCode}"
													<c:if test="${apstVO.comCode eq applicantVO.aplctPrcsStatCd}">selected</c:if>>${apstVO.comCodeNm}</option>
											</c:if>
										</c:forEach>
									</select>
								</div>
							</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty articlePage.content}">
					<tr>
						<td colspan="8">검색 조건이 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
			<tfoot>
				<tr style="border-bottom: 2px solid #232323;"></tr>
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
										href="/enter/intrvw?entId=${prc.username}&currentPage=1"
										aria-controls="example2" data-dt-idx="0" tabindex="0"
										class="page-link">&lt;&lt;</a></li>
								</c:if>

								<!-- 이전 페이지 버튼 -->
								<c:if test="${articlePage.startPage gt 1}">
									<li class="paginate_button page-item previous"
										id="example2_previous"><a
										href="/enter/intrvw?entId=${prc.username}&currentPage=${(articlePage.startPage - 1) lt 1 ? 1 : (articlePage.startPage - 1)}"
										aria-controls="example2" data-dt-idx="0" tabindex="0"
										class="page-link">&lt;</a></li>
								</c:if>

								<!-- 페이지 번호 -->
								<c:forEach var="pNo" begin="${articlePage.startPage}"
									end="${articlePage.endPage}">
									<li
										class="paginate_button page-item ${pNo == articlePage.currentPage ? 'active' : ''}">
										<a
										href="/enter/intrvw?entId=${prc.username}&currentPage=${pNo}"
										aria-controls="example2" class="page-link">${pNo}</a>
									</li>
								</c:forEach>

								<!-- 다음 페이지 버튼 -->
								<c:if test="${articlePage.endPage lt articlePage.totalPages}">
									<li class="paginate_button page-item next" id="example2_next">
										<a
										href="/enter/intrvw?entId=${prc.username}&currentPage=${articlePage.startPage+5}"
										aria-controls="example2" data-dt-idx="7" tabindex="0"
										class="page-link">&gt;</a>
									</li>
								</c:if>

								<!-- 맨 마지막 페이지로 이동 버튼 -->
								<c:if
									test="${articlePage.currentPage lt articlePage.totalPages}">
									<li class="paginate_button page-item last"><a
										href="/enter/intrvw?entId=${prc.username}&currentPage=${articlePage.totalPages}"
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

	<!-- 불합격시 모달 창 구조 -->
	<!-- 		<div id="failedModal" class="modal" style="display: none;"> -->
	<!-- 			<div class="modal-content"> -->
	<!-- 				<div -->
	<!-- 					style="display: flex; justify-content: space-between; margin-bottom: 30px;"> -->
	<!-- 					<h2>면접 일정 등록</h2> -->
	<!-- 					<span class="failedclose">&times;</span> -->
	<!-- 				</div> -->

	<!-- 				<form id="scoutForm" action="/enter/intrvwFormPost2" method="post"> -->
	<!-- 					<div> -->
	<!-- 						<input type="hidden" class="intrvwNum" name="intrvwNum" value=""> -->
	<%-- 						<input type="hidden" id="entId" name="entId" value="${prc.username}"> --%>
	<!-- 						<label for="date" class="scout-title">면접 일자asdfasdf</label> -->
	<!-- 						<input type="date" id="date" name="date"> -->
	<!-- 					</div> -->
	<!-- 					<div> -->
	<!-- 						<label for="date" class="scout-title">면접 시간</label> -->
	<!-- 						<input type="time" id="startdate" name="startdate"> -->
	<!-- 						~ -->
	<!-- 						<input type="time" id="enddate" name="enddate"> -->
	<!-- 					</div> -->
	<!-- 					<div -->
	<!-- 						style="display: flex; justify-content: space-evenly; margin-top: 50px;"> -->
	<!-- 						<button type="button" class="failedcancel-btn">취소</button> -->
	<!-- 						<button type="submit" id="submit-btn">등록</button> -->
	<!-- 					</div> -->
	<%-- 					<sec:csrfInput /> --%>
	<!-- 				</form> -->
	<!-- 			</div> -->
	<!-- 		</div> -->

	<!-- 일반면접 모달 창 구조 -->
	<div id="scoutModal1" class="modal" style="display: none;">
		<div class="modal-content">
			<div class="modal-header">
				<p class="fast-list">면접 일정 등록</p>
				<span class="close1">&times;</span>
			</div>

			<form id="scoutForm" action="/enter/intrvwFormPost2" method="post">
				<div class="scout-modal-div">
					<div>
						<input type="hidden" class="intrvwNum" name="intrvwNum" value="">
						<input type="hidden" id="entId" name="entId"
							value="${prc.username}"> <label for="date"
							class="scout-title">면접 일자</label> <input type="date" id="date"
							name="date">
					</div>
					<div>
						<label for="date" class="scout-title">면접 시간</label> <input
							type="time" id="startdate" name="startdate"> ~ <input
							type="time" id="enddate" name="enddate">
					</div>

					<div
						style="display: flex; justify-content: space-evenly; margin-top: 50px;">
						<button type="button" class="cancel-btn1">취소</button>
						<button type="submit" id="submit-btn">등록</button>
					</div>
				</div>
				<sec:csrfInput />
			</form>
		</div>
	</div>
	<!-- 화상면접 모달 창 구조2 -->
	<div id="scoutModal2" class="modal" style="display: none;">
		<div class="modal-content2">
			<div class="modal-header">
				<p class="fast-list">면접 일정 등록</p>
				<span class="close2">&times;</span>
			</div>

			<form id="intrvwForm" action="/enter/intrvwFormPost" method="post">
				<div class="scout-modal-div">
					<div>
						<input type="hidden" class="intrvwNum" name="intrvwNum" value="">
						<input type="hidden" id="entId" name="entId"
							value="${prc.username}">
					</div>
					<div id="videolist">
						<label for='videoPost' class='scout-title'>화상방 선택</label> <select
							id='videoPost' name='videoPost'>
							<option value='' disabled selected>화상방을 선택해주세요.</option>
						</select>
					</div>
					<div
						style="display: flex; justify-content: space-evenly; margin-top: 50px;">
						<button type="button" class="cancel-btn2">취소</button>
						<button type="submit" id="submit-btn2">등록</button>
					</div>
				</div>
				<sec:csrfInput />
			</form>
		</div>
	</div>
</body>
</html>
