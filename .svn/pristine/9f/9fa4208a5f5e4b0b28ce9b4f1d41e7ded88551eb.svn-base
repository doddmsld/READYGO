<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!-- 기업정보수정css -->   
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/enter/edit.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/alert.css" />
<!-- daum주소 api -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> 
<!-- jquery -->
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<script>
//전역함수
//e : onchange 이벤트
var Toast = Swal.mixin({
toast: true,
position: 'center',
showConfirmButton: false,
timer: 3000
});

function handleImg(e){
	// e.target : <input type="file" id="uploadFile"..>
	let files = e.target.files; //선택한 파일들
	// fileArr = [a.jpg, b.jpg, c.jpg]
	let fileArr = Array.prototype.slice.call(files);
	// f : a.jpg객체
	let accumStr = "";
	fileArr.forEach(function(f){
		// 이미지가 아니면 
		if(!f.type.match("image.*")){ // MIME타입
//		if(!f.type.match("*.jpg")){ // JPG만
			alert("이미지 확정자만 가능합니다.")
			return; // 함수 자체가 종료됨
		}
		// 이미지가 맞다면
		let reader = new FileReader();
		// e : reader가 이미지 객체를 읽는 이벤트 
		
		reader.onload = function(e){
			accumStr += "<img src='"+e.target.result+"' style='width:20%;border:1px solid #D7DCE1;' />";		
			$("#pImg").html(accumStr);
		}
		reader.readAsDataURL(f);
	});
	//요소.append : 누적, 요소.html : 새로고침, 요소.innerHTML : J/S에서 새로고침
}
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
						title : '비밀번호를 다시 입력해주세요!',
						 // 커스텀 클래스 추가
					    customClass: {
					        popup: 'my-custom-popup'  // CSS에서 정의한 클래스 이름
					    }  
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
	

   /*우편번호,주소*/   
   $("#btnPost").on("click",function(){
      console.log("우편번호 검색!")
      new daum.Postcode({
         
         // 다음 창에서 검색이 완료되어 클릭하면 콜백함수에 의해
         // 결과 데이터(JSON string)가 data 객체로 들어온당
         oncomplete:function(data){
            //data{"zoncode":"12345", "address":"대전 중구", "buildingName":"123-123ㅁ"}
            $("#entZip").val(data.zonecode);
            $("#entAddr").val(data.address);
            $("#entAddrDetail").val(data.buildingName);
            // focus : 테두리와 커서 잡힘
            $("#entAddrDetail").focus();
         }
      }).open();
   });
   
// 수정 버튼 클릭
    $("#edit").on("click", function() {
        
    	Swal.fire({
    		  title: '수정하시겠습니까?',
    		  icon: 'question',
    		  showCancelButton: true,
    		  confirmButtonColor: 'white',
    		  cancelButtonColor: 'white',
    		  confirmButtonText: '예',
    		  cancelButtonText: '아니오',
    		  reverseButtons: false, // 버튼 순서 거꾸로
    		}).then((result) => {
    		  if (result.isConfirmed) {    	
    	
    	$("#spn1").css("display", "none");
        $("#spn2").css("display", "flex");
        $("#btnPost").css("display", "block");

        $('.edit-control').removeAttr("readonly");

        // 업종 필드 제어
        $("#tpbizSeCd").css("display", "none");
        $("#tpbizSeCd").attr("disabled", true);
        $("#indutySelect").css("display", "block");

        // 기업형태 필드 제어
        $("#entStleCd").css("display", "none");
        $("#entStleCd").attr("disabled", true);
        $("#entStleCdSelect").css("display", "block");

        // 기업 로고 수정 필드 보이기
        $("#entLogo").css("display", "block");  // 파일 선택 필드 보이기
        
        // 기업사업자등록증 필드
        $(".input-group").css("display", "block");  
        $("#entBrFile").css("display", "none");  
        $("#entBrFileSelect").css("display", "block");

        // 기업아이디 readonly
        $("#entId").attr("readonly", "true");
        
       // 사원수 입력 필드에 숫자만 입력 가능하게 제어
       $("#entEmpCnt").on("keyup", function(e) {
           // 현재 입력된 값
           let value = $(this).val();

           // 숫자가 아닌 문자가 포함된 경우
           if (/[^0-9]/.test(value)) {
               // 알림 메시지
			Toast.fire({
				icon:'warning',
				title:'숫자만 입력 가능합니다.',
        	      customClass: {
            	        popup: 'my-custom-popup' // CSS에서 정의한 클래스 이름
            	      }
			});
               // 숫자가 아닌 문자를 제거
               $(this).val(value.replace(/[^0-9]/g, ''));
           }
       });
       // 데이터 백업
       pImg = $("img[name='pImg']").attr("src");
       console.log(pImg);
       entLogos = $("img[name='entLogos']").attr("src");
       console.log(entLogos);
       entNm = $("input[name='entNm']").val();
       entId = $("input[name='entId']").val();
//        entPswd = $("input[name='entPswd']").val();
       indutyVO = $("input[name='indutyVO']").val();
       entFndnYmd = $("input[name='entFndnYmd']").val();
       entEmpCnt = $("input[name='entEmpCnt']").val();
       entStleCd = $("input[name='entStleCd']").val(); // 기존 기업형태 값 백업
       entRprsntvNm = $("input[name='entRprsntvNm']").val();
       entHmpgUrl = $("input[name='entHmpgUrl']").val();
       entManagerTelno = $("input[name='entManagerTelno']").val();
       entFxnum = $("input[name='entFxnum']").val();
       entMail = $("input[name='entMail']").val();
       entZip = $("input[name='entZip']").val();
       entAddr = $("input[name='entAddr']").val();
       entAddrDetail = $("input[name='entAddrDetail']").val();
       entBrno = $("input[name='entBrno']").val();
       entBrFile = $("input[name='entBrFile']").val();

    	}
	})
 });

    // 취소 버튼 클릭
    $("#cancel").on("click", function() {
        $("#spn1").css("display", "flex");
        $("#spn2").css("display", "none");
        $("#btnPost").css("display", "none");
        $("#tpbizSeCd").css("display","block");

        $('.edit-control').attr("readonly", true);

        // 업종 필드 제어
        $("#tpbizSeCd").css("display", "block");
        $("#indutySelect").css("display", "none");

        // 기업형태 필드 제어
        $("#entStleCd").css("display", "block");
        $("#entStleCdSelect").css("display", "none");
       
        // 기업사업자등록증 필드 제어
        $("#entBrFile").css("display", "block");
        $("#entBrFileSelect").css("display", "none");
        $(".input-group").css("display", "none");  
        $("#pImg").css("display", "block");  

        // 기업 로고 수정 필드 숨기기
        $("#entLogo").css("display", "none");  // 파일 선택 필드 숨기기
        
       // 데이터 복구
       $("img[name='pImg']").attr("src",pImg);
       $("img[name='entLogos']").attr("src",entLogos);
       $("input[name='entNm']").val(entNm);
       $("input[name='entId']").val(entId);
       $("input[name='IndutyVO']").val(IndutyVO);
       $("input[name='entFndnYmd']").val(entFndnYmd);
       $("input[name='entEmpCnt']").val(entEmpCnt);
       $("input[name='entStleCd']").val(entStleCd);  // 기업형태 복구
       $("input[name='entRprsntvNm']").val(entRprsntvNm);
       $("input[name='entHmpgUrl']").val(entHmpgUrl);
       $("input[name='entManagerTelno']").val(entManagerTelno);
       $("input[name='entFxnum']").val(entFxnum);
       $("input[name='entMail']").val(entMail);
       $("input[name='entZip']").val(entZip);
       $("input[name='entAddr']").val(entAddr);
       $("input[name='entAddrDetail']").val(entAddrDetail);
       $("input[name='entBrno']").val(entBrno);
       $("input[name='entBrFile']").val(entBrFile);

   });
   //미리보기 기능 (FileReader API)
    $("#entLogo").on("change", function() {
        var file = this.files[0];  // 선택된 파일
        console.log(file);  // 콘솔에서 파일 확인

        if (file) {
            var reader = new FileReader();
            reader.onload = function(e) {
                $(".entLogos").attr("src", e.target.result);  // 새로운 이미지 미리보기
            };
            reader.readAsDataURL(file);  // 파일을 읽어서 DataURL로 변환
        }
    });


/*기업탈퇴*/ 
    $("#btnDelete").on("click", function () {

    	  $("#editForm").attr("action", "/enter/edit");

    	  let data = $("#entIds").val();
		Swal.fire({
		  title: '정말로 탈퇴하시겠습니까?',
		  icon: 'question',
		  showCancelButton: true,
		  confirmButtonColor: 'white',
		  cancelButtonColor: 'white',
		  confirmButtonText: '예',
		  cancelButtonText: '아니오',
		  reverseButtons: false, // 버튼 순서 거꾸로
		}).then((result) => {
		  if (result.isConfirmed) {
    	  $.ajax({
    	    url: "/enter/deleteAjax",
    	    contentType: "application/json;charset=utf-8",
    	    data: data,
    	    type: "post",
    	    dataType: "json",
    	    beforeSend: function (xhr) {
    	      xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
    	    },
    	    success: function (result) {
    	      console.log("result : ", result);
        	  if (result > 0) { // true
          	    Toast.fire({
          	      icon: 'success',
          	      title: '탈퇴 성공!',
          	      customClass: {
          	        popup: 'my-custom-popup' // CSS에서 정의한 클래스 이름
          	      }
          	    }).then(() => {
      				location.href="/security/entLogin";
      				 document.getElementById('logoutBtn').submit();
          	    });
          	  } else { // false
          	    Toast.fire({
          	      icon: 'error',
          	      title: '탈퇴 실패!',
          	      customClass: {
          	        popup: 'my-custom-popup' // CSS에서 정의한 클래스 이름
          	      }
          	    }).then(() => {
          	      location.reload(); // 실패 시 즉시 페이지 리로드
          	    });
          	  }  

    		  }
    		})
    	      
    	    }
    	  });

    	});

})   
   
    // 전화번호 자동완성 함수
	function oninputPhone(target) {
	    target.value = target.value
	        .replace(/[^0-9]/g, '')
	        .replace(/(^02.{0}|^01.{1}|[0-9]{3,4})([0-9]{3,4})([0-9]{4})/g, "$1-$2-$3");
}   
   
//저장 버튼 sweetalert   
$(document).on("click", "#save", function(event) {
	event.preventDefault(); // 기본 폼 전송 방지
	$("#editForm").attr("action", "/enter/editPost?${_csrf.parameterName}=${_csrf.token}");

	// Swal.fire 사용하여 수정 확인창 표시
	Swal.fire({
	    title: '저장하시겠습니까?',
	    icon: 'question',
	    showCancelButton: true,
	    confirmButtonColor: 'white',
	    cancelButtonColor: 'white',
	    confirmButtonText: '예',
	    cancelButtonText: '아니오'
	}).then((result) => {
	    if (result.isConfirmed) {
	        Toast.fire({
	            icon: 'success',
	            title: '저장 완료!',
        	      customClass: {
            	        popup: 'my-custom-popup' // CSS에서 정의한 클래스 이름
            	      }
	        }).then(() => {
	                $("#editForm").submit(); // 3초 후에 폼 제출
	        });
	    } else {
	        Toast.fire({
	            icon: 'error',
	            title: '저장 실패!',
      	      customClass: {
      	        popup: 'my-custom-popup' // CSS에서 정의한 클래스 이름
      	      }
	        });
	    }
	});
});

</script>
<div hidden="hidden">
	<form id="logoutBtn" action="/logout" method="post">
        	<button type="submit">로그아웃</button>
         <sec:csrfInput />
      </form>
</div>
<sec:authorize access="isAuthenticated()">
	    	<sec:authentication property="principal.authorities" var="userAuthorities" />
	    	<input id="authval" type="hidden" value="${userAuthorities}">
			<sec:authentication property="principal" var="prc"/>		           
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
				<input type="password" placeholder="비밀번호를 입력해주세요." id="entPswds"
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
<div class="all" hidden="hidden">
   <h2>기업정보 수정</h2>
	<div class="container1">
	   <br><br>
	   	<input type="hidden" id="entIds" value="${enterVO.entId}" />
	    <form name="editForm" id="editForm"  method="post" enctype="multipart/form-data">
	        <div class="row">
				<div class="col-left">
					 <c:if test="${enterVO.entLogo==null}">
	                        	<img src="/resources/images/member/기본프로필.png" alt="기본프로필.png" id="pImg" name="pImg"class="entLogos" />
			         </c:if>
					 <c:if test="${enterVO.entLogo!=null}">
	                        	<img src="${enterVO.entLogo}" alt="프로필사진" class="entLogos" name="entLogos" />
			         </c:if>
					<br>
					<!-- 수정 모드에서 보이는 파일 선택 -->
					<input type="file" id="entLogo" name="entLogoFile" style="display: none;"
						class="edit-control" />
					<div id="entNameParent">
						<p id="entName">
							<strong>${enterVO.entNm}</strong>
						</p>
					</div>
					<br>
					<br>
				</div>
				<div class="flexInfo">
					<div class="left">
						<div class="col-right">
							<h3>기본정보</h3>
							<br>
							<div class="form-group">
								<label for="entNm"><b>*</b> 기업명</label> <input type="text" id="entNm"
									name="entNm" class="edit-control" placeholder="기업명"
									value="${enterVO.entNm}" readonly required>
							</div>
			
							<div class="form-group">
								<label for="entId"><b>*</b> 아이디</label> <input type="text" id="entId"
									name="entId" class="edit-control" value="${enterVO.entId}"
									readonly placeholder="아이디">
							</div>
			
							<div class="form-group">
								<label for="IndutyVO"><b>*</b> 업종</label> <input type="text" id="tpbizSeCd"
									name="tpbizSeCd" class="edit-control" placeholder="업종"
									value="${enterVO.tpbizSeCd}" readonly>
			
								<!-- 수정 모드에서 보이는 업종 셀렉트 박스 -->
								<select id="indutySelect" name="tpbizSeCd"
									style="display: none;" class="edit-control" required>
									<c:forEach var="induty" items="${indutyList}">
										<option value="${induty.comCode}"
											<c:if test="${induty.comCodeNm eq enterVO.tpbizSeCd}">selected</c:if>
										>${induty.comCodeNm}</option>
									</c:forEach>
								</select>
							</div>
			
							<div class="form-group">
								<label for="entFndnYmd"><b>*</b> 설립일</label> <input type="date"
									id="entFndnYmd" name="entFndnYmd" class="edit-control"
									placeholder="설립일" value="${enterVO.entFndnYmd}" readonly required>
							</div>
							<div class="form-group">
								<label for="entRprsntvNm"><b>*</b> 대표자명</label> <input type="text"
									id="entRprsntvNm" name=entRprsntvNm class="edit-control"
									placeholder="대표자명" value="${enterVO.entRprsntvNm}" readonly required>
							</div>
			
							<div class="form-group">
								<label for="entEmpCnt">&nbsp;&nbsp;&nbsp;사원수</label> <input type="text"
									id="entEmpCnt" name="entEmpCnt" class="edit-control"
									placeholder="사원수" value="${enterVO.entEmpCnt}" readonly>
							</div>
			
							<div class="form-group">
								<label for="entStleCd">&nbsp;&nbsp;&nbsp;기업형태</label>
								<!-- 기존 기업형태 텍스트 -->
								<input type="text" id="entStleCd" name="entStleCd"
									class="edit-control" placeholder="기업형태"
									value="${enterVO.entStleCd}" readonly>
			
								<!-- 수정 모드에서 보이는 기업형태 셀렉트 박스 -->
								<select id="entStleCdSelect" name="entStleCd"
									style="display: none;" class="edit-control">
									<c:forEach var="entStleCd" items="${entStleCdList}">
										<option value="${entStleCd.comCode}"
											<c:if test="${entStleCd.comCodeNm eq enterVO.entStleCd}">selected</c:if>
										>${entStleCd.comCodeNm}</option>
									</c:forEach>
								</select>
							</div>
			
			
							<div class="form-group">
								<label for="entHmpgUrl">&nbsp;&nbsp;&nbsp;홈페이지 URL</label> 
								<input type="text"
									id="entHmpgUrl" name="entHmpgUrl" class="edit-control"
									placeholder="홈페이지 URL" value="${enterVO.entHmpgUrl}" readonly>
							</div>
						</div>
						<br>
						<br>
						<div class="right">
							<div class="form-group" style="margin-top: 60px;">
								<label for="entManagerTelno">&nbsp;&nbsp;&nbsp;담당자 연락처</label> <input type="text"
									class="edit-control" id="entManagerTelno" name="entManagerTelno"
									placeholder="담당자 연락처" oninput="oninputPhone(this)"
									value="${enterVO.entManagerTelno}" maxlength="14" readonly>
							</div>
			
							<div class="form-group">
								<label for="entFxnum"><b>*</b> 팩스번호</label> <input type="text" id="entFxnum"
									name="entFxnum" class="edit-control" placeholder="팩스번호"
									value="${enterVO.entFxnum}" readonly required>
							</div>
			
							<div class="form-group">
								<label for="entMail"><b>*</b> 이메일</label> <input type="text" id="entMail"
									name="entMail" class="edit-control" placeholder="이메일"
									value="${enterVO.entMail}" readonly required>
							</div>
			
							<div class="form-group">
								<label for="entZip"><b>*</b> 우편번호</label> <input type="text" id="entZip"
									name="entZip" class="edit-control" value="${enterVO.entZip}"
									readonly required> <input type="button" class="btn btn-primary"
									id="btnPost" placeholder="우편번호" value="우편번호 검색"
									style="display: none;"/>
							</div> 
			
							<div class="form-group">
								<label for="entAddr"><b>*</b> 주소</label> <input type="text" id="entAddr"
									name="entAddr" class="edit-control" placeholder="주소"
									value="${enterVO.entAddr}" readonly required>
							</div>
			
							<div class="form-group">
								<label for="entAddrDetail"><b>*</b> 상세주소</label> <input type="text"
									id="entAddrDetail" name="entAddrDetail" placeholder="상세주소"
									class="edit-control" value="${enterVO.entAddrDetail}" readonly required>
							</div>
			
							<div class="form-group" >
								<label for="entBrno"><b>*</b> 사업자 등록번호</label> 
								<input type="text"
									id="entBrno" name="entBrno" class="edit-control"
									placeholder="사업자 등록번호" value="${enterVO.entBrno}" readonly required>
							</div>
			
							<div class="form-group">
								<label for="entBrFile"><b>*</b> 사업자 등록증</label> 
								<input type="text"
									id="entBrFile" name="entBrFile" class="edit-control"
									placeholder="사업자 등록증" value="${enterVO.entBrFile}" readonly>
								
								<!-- 수정 모드에서 보이는 사업자등록증 파일박스 -->
								<div class="input-group" style="display: none; width: 170px; ">
									<div class="custom-file">
										<input type="file" id="entBrFileSelect" class="edit-control" name="entBrFileFile" 
											 placeholder="사업자 등록증" value="${enterVO.entBrFile}"
											 style="display: none;" required/> 
									</div>
								</div> 
							</div>	
									<div id="pImg" style="height: 80px; width: 60px; margin-left: 80px;"></div>
									
						</div>
					</div>
				</div>
				<!-- 폼 페이지에는 csrf써줘야함 -->
			</div>
			<!-- 일반 모드 시작 -->
			<div class="groupButton">
				<span id="spn1" class="button-group">
					<p>
						<div class="button1">
							<input type="button" id="edit" value="수정" />
						</div>
						<div class="button1">
							<input type="button" id="btnDelete" value="기업 탈퇴" />
						</div>
					</p>
				</span>
				<!-- 일반 모드 끝 -->
			
				<!-- 수정 모드 시작 -->
				<span id="spn2" class="button-group" style="display: none;">
					<p>
						<div class="button1">
							<input type="submit" id="save" value="저장" />
						</div>
						<div class="button1">
							<input type="button" id="cancel" value="취소" />
						</div>
					</p>
				</span>
			</div>
				        
	        <sec:csrfInput />
	    </form>
	</div>

	<div hidden="hidden">
		<form id="logoutBtn" action="/logout" method="post">
			<button type="submit">로그아웃</button>
			<sec:csrfInput />
		</form>
	</div>
</div>
