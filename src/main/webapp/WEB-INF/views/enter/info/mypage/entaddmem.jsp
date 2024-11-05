<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/enter/entaddmem.css" />
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/alert.css" />
<script type="text/javascript">
//전역함수
//e : onchange 이벤트
var Toast = Swal.mixin({
toast: true,
position: 'center',
showConfirmButton: false,
timer: 3000
});
$(function() {
	var auth = $("#authval").val();
    console.log("User Authorities: ", auth);

    if (auth.indexOf("ROLE_MEMBER") !== -1) {
        alert("회원으로 접근할 수 없습니다.");
        location.href="/";
    }else if (auth.indexOf("ROLE_ADMIN") !== -1) {
        alert("관리자로 접근할 수 없습니다.");
        document.getElementById('logoutBtn').submit();
    }
	
	
$("#detailChkBtn").on("click",function() {
	let formData = new FormData();
	let entId = $("#entId").val();
	let entPswds = $("#entPswds").val();
	console.log("entId : " + entId);
	console.log("entPswds : " + entPswds);
	formData.append("entId", entId);
	formData.append("entPswd", entPswds);
	$.ajax({
		url : "/enter/editChk",
		processData : false,
		contentType : false,
		data : formData,
		type : "post",
		dataType : "text",
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}",
					"${_csrf.token}");
		},
		success : function(result) {
			console.log("result : " + result);
			// success, error, warning, info, question
			if (result == "false") {
				Toast.fire({
					icon : 'error',
					title : '비밀번호를 다시 입력해주세요!'
				});
				return;
			}
			Toast.fire({
				icon : 'success',
				title : '비밀번호 일치!',
					 // 커스텀 클래스 추가
				    customClass: {
				        popup: 'my-custom-popup'  // CSS에서 정의한 클래스 이름
				    }    
				
			}).then(() => {
			    // 다음 작업 실행
			    console.log("SweetAlert가 끝났습니다. 다음 동작을 수행합니다.");
			$("#chkchk").attr("hidden", true);
			$(".all").attr("hidden", false);
			});
		}
	})
});
});


document.addEventListener("DOMContentLoaded", function() {
// 스카우트 폼 제출 처리
	document.getElementById('submit-btn').addEventListener('click', function(e) {
	    e.preventDefault();
		let mbrId = $('#mbrId').val();
		let mbrNm = $("#mbrNm").val();
		let mbrEml = $("#mbrEml").val();
		let mbrTelno = $("#mbrTelno").val();
		let entId = $("#entId").val();
	    var obj = {mbrId:mbrId,mbrNm:mbrNm,mbrEml:mbrEml,mbrTelno:mbrTelno,entId:entId}
		var jsonformData = JSON.stringify(obj);
		console.log(jsonformData);
		
		// Swal.fire 사용하여 수정 확인창 표시
		Swal.fire({
		    title: '기업회원을 추가하시겠습니까?',
		    icon: 'question',
		    showCancelButton: true,
		    confirmButtonColor: 'white',
		    cancelButtonColor: 'white',
		    confirmButtonText: '예',
		    cancelButtonText: '아니오'
		}).then((result) => {
		    if (result.isConfirmed) {
		    	 $.ajax({
		 	        url: '/enter/sendMemAddEmail',
		 	        type: 'POST',
		 	        data: jsonformData,
		 	        processData: false,
		 	        contentType: "application/json; charset=UTF-8",
		 	        beforeSend: function(xhr) {
		 	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		 	        },
		 	        success: function(response) {
		 	        	if(response.status==='fail'){
		 	        		alert(response.message);
		 	        	}else if(response.status==='success'){
		 	        		Toast.fire({
		 			            icon: 'success',
		 			            title: '기업회원 추가요청 완료!',
		 			           customClass: {
		 					        popup: 'my-custom-popup'  // CSS에서 정의한 클래스 이름
		 					    } 
		 			        }).then((result) => {
		 			        	location.reload();
		 			    	});
		 	        	}else{
		 	        		Toast.fire({
		 			            icon: 'error',
		 			            title: '기업회원 추가요청 실패!',
		 			           customClass: {
		 					        popup: 'my-custom-popup'  // CSS에서 정의한 클래스 이름
		 					    } 
		 			        }).then((result) => {
		 			        	location.reload();
		 			    	});
		 	        	}
		 	        	
		 	        },
		 	        error: function() {
		 	        	Toast.fire({
				            icon: 'error',
				            title: '기업회원 추가요청 실패!',
				            customClass: {
						        popup: 'my-custom-popup'  // CSS에서 정의한 클래스 이름
						    } 
				        });
		 	        }
		 	    });
		        
		    } else {
		        // 수정 취소 시
		        Toast.fire({
		            icon: 'error',
		            title: '기업회원추가 취소!',
		            customClass: {
				        popup: 'my-custom-popup'  // CSS에서 정의한 클래스 이름
				    } 
		        });
		    }
		});
		
	   
	});
	$(".resendbtn").on('click',function(){
		let mbrId = $(this).closest('tr').find('.mbrIdList').text();
		let mbrNm = $(this).closest('tr').find('.mbrNmList').text();
		let mbrEml = $(this).closest('tr').find('.mbrEmlList').text();
		let mbrTelno = $(this).closest('tr').find('.mbrTelnoList').text();
		let entId = $("#entId").val();
		var obj = {mbrId:mbrId,mbrNm:mbrNm,mbrEml:mbrEml,mbrTelno:mbrTelno,entId:entId}
		var jsonformData = JSON.stringify(obj);
		
		
		// Swal.fire 사용하여 수정 확인창 표시
		Swal.fire({
		    title: '이메일 재전송하시겠습니까?',
		    icon: 'question',
		    showCancelButton: true,
		    confirmButtonColor: 'white',
		    cancelButtonColor: 'white',
		    confirmButtonText: '예',
		    cancelButtonText: '아니오'
		}).then((result) => {
		    if (result.isConfirmed) {
		    	$.ajax({
			        url: '/enter/resendMemAddEmail',
			        type: 'POST',
			        data: jsonformData,
			        processData: false,
			        contentType: "application/json; charset=UTF-8",
			        beforeSend: function(xhr) {
			            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			        },
			        success: function(response) {
			        	if(response.status==='fail'){
			        		alert(response.message);
			        	}else if(response.status==='success'){
			        		Toast.fire({
		 			            icon: 'success',
		 			            title: '이메일 재전송 완료!',
		 			           customClass: {
		 					        popup: 'my-custom-popup'  // CSS에서 정의한 클래스 이름
		 					    } 
		 			        }).then((result) => {
		 			        	location.reload();
		 			    	});
			        	}else{
			        		Toast.fire({
		 			            icon: 'success',
		 			            title: '이메일 재전송 실패!',
		 			           customClass: {
		 					        popup: 'my-custom-popup'  // CSS에서 정의한 클래스 이름
		 					    }
		 			        }).then((result) => {
		 			        	location.reload();
		 			    	});
			        	}
			        },
			        error: function() {
			        	Toast.fire({
	 			            icon: 'success',
	 			            title: '이메일 재전송실패!',
	 			           customClass: {
	 					        popup: 'my-custom-popup'  // CSS에서 정의한 클래스 이름
	 					    }
	 			        });
			        }
			    });
		    } else {
		    	Toast.fire({
			            icon: 'error',
			            title: '이메일 재전송 취소!',
			            customClass: {
 					        popup: 'my-custom-popup'  // CSS에서 정의한 클래스 이름
 					    }
			        });
		    }
		});
		
	})
	
	
	$(".delbtn").on('click',function(){
		let mbrId = $(this).closest('tr').find('.mbrIdList').text();
		let entId = $("#entId").val();
		
		// Swal.fire 사용하여 수정 확인창 표시
		Swal.fire({
		    title: '삭제하시겠습니까?',
		    icon: 'error',
		    showCancelButton: true,
		    confirmButtonColor: 'white',
		    cancelButtonColor: 'white',
		    confirmButtonText: '예',
		    cancelButtonText: '아니오'
		}).then((result) => {
		    if (result.isConfirmed) {
		    	$.ajax({
			        url: '/enter/entaddmemDel',
			        type: 'POST',
			        data: {mbrId : mbrId,entId:entId},
			        beforeSend: function(xhr) {
			            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			        },
			        success: function(response) {
			        	console.log(response);
			        	Toast.fire({
			                icon: 'success',
			                title: '삭제 완료!',
			                customClass: {
	 					        popup: 'my-custom-popup'  // CSS에서 정의한 클래스 이름
	 					    }
			            }).then((result) => {
	 			        	location.reload();
	 			    	});
			        },
			        error: function() {
			        	Toast.fire({
			                icon: 'error',
			                title: '삭제 실패!',
			                customClass: {
	 					        popup: 'my-custom-popup'  // CSS에서 정의한 클래스 이름
	 					    }
			            });
			        }
			    });
		    } else {
		        // 수정 취소 시
		        Toast.fire({
		            icon: 'error',
		            title: '삭제 취소!',
		            customClass: {
					        popup: 'my-custom-popup'  // CSS에서 정의한 클래스 이름
					    }
		        });
		    }
		});
		
	})
});

</script>
<sec:authorize access="isAuthenticated()">
	    	<sec:authentication property="principal.authorities" var="userAuthorities" />
	    	<input id="authval" type="hidden" value="${userAuthorities}">
			<sec:authentication property="principal" var="prc"/>		           
			<sec:authentication property="principal" var="prc" />
</sec:authorize>

<div id="chkchk">
	<form action="/enter/editChk" method="post">
		<div>
			<div>
				<img class="chkImg" src="../resources/images/logo.png" />
				<p class="chkP">
					&nbsp;&nbsp;기업의 정보를 안전하게 보호하기 위해 <br>다시 한 번 인증을 진행해 주시기 바랍니다.
				</p>
			</div>
			<div>
				<input type="password" placeholder="비밀번호를 입력해주세요." id="entPswds" class="entPswds"
					name="entPswd" />
			</div>
			<div>
				<button type="button" class="chkbtn" id="detailChkBtn">확인</button>
			</div>
		</div>
		<sec:csrfInput />
	</form>
</div>
<br>
<div hidden="hidden">
	<form id="logoutBtn" action="/logout" method="post">
        	<button type="submit">로그아웃</button>
         <sec:csrfInput />
      </form>
</div>
<div class="all" hidden="hidden">
<input type="hidden" id="entId" value="${param.entId}" />
	<h2>기업회원 조회</h2>
    <div class="container1">
    	<div class="memAdd">
	    		<div>
	    			<h4 class="addTitle">기업회원 초대</h4>
	    		</div>
    		<form id="addMemForm">
		    	<div class="member-form">
		    		<div class="form-div" id="idTitle">
			            <div class="form-label">
			            	<img class="iconImg" src="../resources/icon/check.png" alt="check"/>
			                <label for="name">아이디<b class="required">필수</b></label>
			            </div>
			            <div>
				            <input type="text" id="mbrId" name="mbrId" class="form-input" placeholder="아이디 입력" />
				            <input type="hidden" id="entId" name="entId" value="${prc.username}">
			            </div>
			        </div>
			        <div class="form-div">
			            <div class="form-label">
			            	<img class="iconImg" src="../resources/icon/person.png" alt="person"/>
			                <label for="name">이름<b class="required">필수</b></label>
			            </div>
			            <div>
				            <input type="text" id="mbrNm" name="mbrNm"class="form-input" placeholder="이름 입력" />
			            </div>
			        </div>
					
			        <div class="form-div">
			            <div class="form-label">
			            	<img class="iconImg" src="../resources/icon/email.png" alt="email"/>
			                <label for="email">이메일<b class="required">필수</b></label>
			            </div>
			            <div>
			            	<input type="email" id="mbrEml" name="mbrEml" class="form-input" placeholder="이메일 입력" />
			            </div>
			        </div>
			
			        <div class="form-div">
			            <div class="form-label">
			                <img class="iconImg" src="../resources/icon/phone.png" alt="phone"/>
			                <label for="phone">휴대폰</label>
			            </div>
			            <div>
			            	<input type="tel" id="mbrTelno" name="mbrTelno" class="form-input" placeholder="휴대폰번호 입력" />
			            </div>
			        </div>
			        <div class="form-row">
					    <button type="submit" id="submit-btn" class="submit-button">
					    <img class="plus-icon" src="../resources/icon/personadd.png" alt="personadd"/>기업회원 추가</button>
					</div>
		        </div>

	        </form>
        </div>
        <div>
        <div class="search">
	        <div>
    		    <p class="total">전체  <b>${total}</b></p>
    	    </div>
	  		<div>
	  			<form action="/enter/entaddmem" method="get">
	  				<input type="hidden" name="entId" value="${param.entId }">
			  		<input type="text" id="keyword" name="keywordInput" placeholder="검색어를 입력하세요."value="${keyword}"/>
		  			<button type="submit">검색</button>
	  			</form>
	  		</div>
        </div>
       		 <div class="alltable" style="overflow-y:scroll; height: 350px;">
        	<table>
				<thead>
					<tr class="trtr">
						<th class="th-center" id="id">아이디</th>
						<th class="th-center" id="name">이름</th>
						<th id="email">이메일</th>
						<th class="th-center">휴대폰</th>
						<th class="th-center">가입일</th>
						<th class="th-center">삭제/재발송</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${not empty memberList}">
					<c:forEach var="memberVO" items="${memberList}">
						<tr>
							<td class="th-center"><p class="mbrIdList">${memberVO.mbrId}</p></td>
							<td class="th-center"><p class="mbrNmList">${memberVO.mbrNm}</p></td>
							<td><p class="mbrEmlList">${memberVO.mbrEml}</p></td>
							<td class="th-center"><p class="mbrTelnoList">${memberVO.mbrTelno}</p></td>
							<td class="th-center"><p class="mbrJoinList">${memberVO.mbrJoinYmd}</p></td>
							<td class="th-center">
								 <button class="delbtn "type="button">
								 	<img class="iconImgbtn" src="../resources/icon/personremove.png" alt="remove"/>삭제
								 </button>
								 <c:if test="${memberVO.entId eq null}">
								 <button class="resendbtn "type="button">
								 	<img class="iconImgbtn" src="../resources/icon/sendemail.png" alt="mail"/>재발송
								 </button>
								 </c:if>
							 </td>
						</tr>
					</c:forEach>
					</c:if>
					<c:if test="${empty memberList}">
						<tr>
							<td colspan="6">검색 조건이 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
	           <tfoot>
	           		<tr>
	           		</tr>
				</tfoot>
			</table>
				</div>
        </div>
    </div>
    <div>
    </div>
</div>
