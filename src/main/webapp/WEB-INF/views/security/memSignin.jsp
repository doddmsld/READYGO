<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="/resources/js/sweetalert2.js"></script>
<link rel="stylesheet" href="/resources/css/security/loginForm.css">

<style type="text/css">
.main{
	background-image: url("/resources/images/secucrity/login.png");	
}
.main .signFrom{
	border : solid 1px gray;
}
.idForm{
	justify-content: space-between;
	align-items: flex-end;
	max-width: 400px;
	margin-left: 0px;
}
.id{
	width: 260px;
}
.idForm .btn-sign{
margin-bottom: 4px;
}
.card{
	height: auto;
}
#authCount{
	color:#FF808C;
	position: absolute;
	right: 200px;
    bottom: 332px;
}
#pImg{
	width: 100px; 
	border:1px solid #D7D7D7;
}
.container-fluid{
	padding:0;
}
.content{
	padding:0;
}
.ddalkkack{
	font-size: 6px;
	width: 25px;
	height: 25px;
	border: 1px solid #24D59E;
	border-radius: 100%;
	background-color: #ffffff;
	color: #24D59E;
	margin-bottom: 10px;
}
</style>
<script type="text/javascript">

function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var fullAddr = data.address;
            var extraAddr = '';

            if (data.addressType === 'R') { 
                if (data.bname !== '') {
                    extraAddr += data.bname;
                }
                if (data.buildingName !== '') {
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                fullAddr += (extraAddr !== '' ? ' (' + extraAddr + ')' : '');
            }

            $('#mbrZip').val(data.zonecode);
            $('#mbrAddr').val(fullAddr);
            $('#mbrAddrDtl').focus();
        }
    }).open();
}
let saveNum;
let countTime = 0;
let intervalCall;
let memcon = "";
let chkNum = "";
var Toast = Swal.mixin({
	toast: true,
    position: 'center',
    showConfirmButton: false,
    timer: 3000
});
function handleImg(e){
	// 	e.target : <input type="file" class="custom-file-input" id="uploadFile" ... /> 
	let files = e.target.files; // 선택한 파일들
	// 파일들을 잘라서 배열로 만든다
	// fileArr = [토낑.gif,굿.gif,라쿤.gif]
	let fileArr = Array.prototype.slice.call(files);
	// f : 토낑.gif 객체
	let accumStr = ""; 
	fileArr.forEach(function(f){
		// 이미지가 아니면
		if(!f.type.match("image.*")){
			alert("이미지 확장자만 가능합니다");
			return; // 함수 자체가 종료됨
		}
		// 이미지가 맞다면 => 파일을 읽어주는 객체 생성
		let reader = new FileReader();
		// 파일을 읽자
		// e : reader가 이미지 객체를 읽는 이벤트
		reader.onload = function(e){// "+e.target+result+" - 이미지를 다 읽었으면 결과를 가져와라 -> 그것을 누적
			accumStr += "<img src='"+e.target.result+"'/>";  // 누적 String
			$("#pImg").html(accumStr);
		}
		reader.readAsDataURL(f);
		
	});
	// 요소.append : 누적, 요소.html : 새로고침, 요소.innerHTML : J/S에서 새로고침
}
$(function(){
	$("#imgBtn").on("click",function(){
		$("#uploadFile").click()
		$("#imgForm").attr("hidden", false);
	})
	// 파일 선택 후 이미지 미리보기
    $("#uploadFile").on("change", function(e) {
        let file = e.target.files[0];
        if(!file){
        	return;
        }
        
        if (!file.type.match("image.*")) {
            alert("이미지 파일만 업로드 가능합니다.");
            return;
        }

        let reader = new FileReader();
        reader.onload = function(e) {
            $("#pImg").attr("src", e.target.result);
        }
        reader.readAsDataURL(file);
    });
	
	$("#authChk").on("click", function(){
		if ($('#authCount').text().trim() === "0:00") {
			Toast.fire({
				icon:'question',
				title:'인증 시간이 만료 되었습니다.'
			});
	        $('#mbrTelno').focus();
	        event.preventDefault();
	        return false;
	    }
		if ($('#authNum').val().trim() !== chkNum) {
			Toast.fire({
				icon:'warning',
				title:'인증번호 불일치.'
			});
	        $('#mbrTelno').focus();
	        event.preventDefault();
	        return false;
	    }
		Toast.fire({
			icon:'success',
			title:'인증성공.'
		});
		$.closeTime();
		$("#authCount").css("color", "green");
		$("#authCount").text("인증성공");
		
	})
	
	
	$.time = function(time){
	    countTime = time;
	    intervalCall = setInterval(alertFunc, 1000);
	}
	
	$.closeTime = function(){
	    clearInterval(intervalCall);
	}
	
	function alertFunc() {
	    let min = Math.floor(countTime/60);
	    let sec = countTime - (60 * min);
	    if(sec > 9){
	        $('.certificationTime').text(min + ':' + sec + '');
	    }else {
	        $('.certificationTime').text(min + ':0' + sec + '');
	    }
	    if(countTime <= 0){
	        clearInterval(intervalCall);
	        $("#sendAuthNumBtn").prop("disabled", false);
            $("#sendAuthNumBtn").css({
                "opacity": "1",
                "cursor": "pointer"
            });
	    }
	    countTime--;
	};
	$("#sendAuthNumBtn").on("click", function(){
		function validatePhoneNumber(phoneNumber) {
		    // 11자리 숫자만 허용하는 정규식
		    const phoneNumberPattern = /^\d{11}$/;
		    return phoneNumberPattern.test(phoneNumber);
		}

		if ($('#mbrTelno').val().trim() === "") {
		    Toast.fire({
		        icon: 'warning',
		        title: '휴대폰 번호를 입력해 주세요.(-를 제외한 11자의 숫자)'
		    });
		    $('#mbrTelno').focus();
		    event.preventDefault();
		    return false;
		} else if (!validatePhoneNumber($('#mbrTelno').val().trim())) {
		    Toast.fire({
		        icon: 'warning',
		        title: '유효하지 않은 휴대폰 번호입니다. 11자리 숫자만 입력해 주세요.'
		    });
		    $('#mbrTelno').focus();
		    event.preventDefault();
		    return false;
		}
		$("#authNumForm").attr("hidden", false);
		$("#authCount").attr("hidden", false);
		$.time(179);
		let formData = new FormData();
		let memto = $("#mbrTelno").val();
		let memsend = "010-3067-4663";
// 		let memsend = "";
		chkNum = ""
		memcon = "인증번호는 [";
		for (let i = 0; i < 6; i++) {
			chkNum += Math.floor(Math.random() * 10);
		}
		console.log(chkNum);
		memcon += chkNum;
		memcon += "] 입니다.";
		
		
		formData.append("memto",memto);
		formData.append("memsend",memsend);
		formData.append("memcon",memcon);
		$.ajax({
	        url : "/api/sendOne",
	        processData:false,
	        contentType:false,
	        data:formData,
	        type:"post",
	        dataType:"text",
	        beforeSend:function(xhr){
	            xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	            // 버튼 비활성화
	            $("#sendAuthNumBtn").prop("disabled", true);
	        },
	        success : function(result) {
	            console.log("result : " + result);
	            Toast.fire({
	                icon:'success',
	                title:'인증번호가 전송 되었습니다.'
	            });
	            
	            // 선택적: 비활성화된 버튼의 스타일 변경
	            $("#sendAuthNumBtn").css({
	                "opacity": "0.5",
	                "cursor": "pointer"
	            });
	            
	        }
	    })
	})
	
	
	$("#idchk").on("click", function(){
		let mbrId = $("#mbrId").val();
		// 아이디 유효성 검사 함수
		function validateUsername(mbrId) {
		    // 5~20자의 영문 소문자, 숫자, 특수기호 _와 -만 허용하는 정규식
		    const usernamePattern = /^[a-z0-9_-]{5,20}$/;
		    return usernamePattern.test(mbrId);
		}

		if ($('#mbrId').val().trim() === "") {
		    Toast.fire({
		        icon: 'warning',
		        title: '아이디를 입력해 주세요. (5~20자의 영문 소문자, 숫자, 특수기호 _와 -만 허용)'
		    });
		    $("#idChkResult").html("유효하지 않은 아이디").css('color', 'red');
		    $('#mbrId').focus();
		    event.preventDefault();
		    return false;
		} else if (!validateUsername($('#mbrId').val().trim())) {
		    Toast.fire({
		        icon: 'warning',
		        title: '유효하지 않은 아이디입니다. 5~20자의 영문 소문자, 숫자, 특수기호 _와 -만 입력해 주세요.'
		    });
		    $("#idChkResult").html("유효하지 않은 아이디").css('color', 'red');
		    $('#mbrId').focus();
		    event.preventDefault();
		    return false;
		}
		$.ajax({
			url : "/security/idChkAjax",
			contentType:"text/plain;charset=utf-8", 
			data : mbrId,
			type : 'post',
			dataType : 'text',
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success : function(result) {
				if(result == 'true') {
                    $("#idChkResult").html("사용 가능").css('color', 'green');
                } if(result == 'false') {
                    $("#idChkResult").html("ID 중복 - 사용불가").css('color', 'red');
                }
				
			}
		})
	})

	$('#signinBtn').on('click', function(event){
	    var idchk = $('#idChkResult').html().trim();
	    if(idchk !== "사용 가능"){
			Toast.fire({
				icon:'warning',
				title:'ID 중복되거나 중복체크를 하지 않았습니다.'
			});
	        event.preventDefault();
	        return false;
	    }
	 // 비밀번호 유효성 검사 함수
	    function validatePassword(mbrPswd) {
	        // 8~16자의 영문 대/소문자, 숫자, 특수문자를 포함하는 정규식
	        const passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,16}$/;
	        return passwordPattern.test(mbrPswd);
	    }

	    if ($('#mbrPswd').val().trim() === "") {
	        Toast.fire({
	            icon: 'warning',
	            title: '비밀번호를 입력해 주세요. (8~16자의 영문 대/소문자, 숫자, 특수문자 포함)'
	        });
	        $('#mbrPswd').focus();
	        event.preventDefault();
	        return false;
	    } else if (!validatePassword($('#mbrPswd').val().trim())) {
	        Toast.fire({
	            icon: 'warning',
	            title: '유효하지 않은 비밀번호입니다. 8~16자의 영문 대/소문자, 숫자, 특수문자를 포함해 주세요.'
	        });
	        $('#mbrPswd').focus();
	        event.preventDefault();
	        return false;
	    }

	    if($("#mbrPswdChk").val().trim() === "" || $("#mbrPswd").val().trim() !== $("#mbrPswdChk").val().trim()){
	    	Toast.fire({
				icon:'warning',
				title:'비밀번호와 비밀번호 확인이 다릅니다. 다시 확인하세요.'
			});
	        $('#mbrPswd').focus();
	        event.preventDefault(); // 폼 제출을 막음
	        return false;   // 서버로 전송을 하지 않는다.
	    }
	 // 이름 유효성 검사 함수
	    function validateName(name) {
	        // 한글 또는 영문 대/소문자만 허용, 공백 및 특수기호는 허용하지 않는 정규식
	        const namePattern = /^[가-힣a-zA-Z]+$/;
	        return namePattern.test(name);
	    }

	    if ($('#mbrNm').val().trim() === "") {
	        Toast.fire({
	            icon: 'warning',
	            title: '이름을 입력해 주세요.'
	        });
	        $('#mbrNm').focus();
	        event.preventDefault();
	        return false;
	    } else if (!validateName($('#mbrNm').val().trim())) {
	        Toast.fire({
	            icon: 'warning',
	            title: '이름은 한글 또는 영문 대/소문자만 입력 가능합니다. (특수기호, 공백 사용 불가)'
	        });
	        $('#mbrNm').focus();
	        event.preventDefault();
	        return false;
	    }

	 // 생년월일 유효성 검사 함수
	    function validateBirthdate(birthdate) {
	        // 숫자 8자리만 허용하는 정규식 (YYYYMMDD 형식)
	        const birthdatePattern = /^\d{8}$/;
	        return birthdatePattern.test(birthdate);
	    }

	    if ($('#mbrBrdt').val().trim() === "") {
	        Toast.fire({
	            icon: 'warning',
	            title: '생년월일을 입력해 주세요.'
	        });
	        $('#mbrBrdt').focus();
	        event.preventDefault();
	        return false;
	    } else if (!validateBirthdate($('#mbrBrdt').val().trim())) {
	        Toast.fire({
	            icon: 'warning',
	            title: '유효하지 않은 생년월일입니다. 숫자 8자리로 입력해 주세요. (예: 19900101)'
	        });
	        $('#mbrBrdt').focus();
	        event.preventDefault();
	        return false;
	    }

	    if ($('#mbrSexdstnCd').val() == null) {
	    	Toast.fire({
				icon:'warning',
				title:'성별을 선택해 주세요.'
			});
	        $('#mbrSexdstnCd').focus();
	        event.preventDefault();
	        return false;
	    }
	 // 이메일 유효성 검사 함수
	    function validateEmail(email) {
	        // 이메일 형식을 검사하는 정규식
	        const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	        return emailPattern.test(email);
	    }

	    if ($('#mbrEml').val().trim() === "") {
	        Toast.fire({
	            icon: 'warning',
	            title: '이메일을 입력해 주세요.'
	        });
	        $('#mbrEml').focus();
	        event.preventDefault();
	        return false;
	    } else if (!validateEmail($('#mbrEml').val().trim())) {
	        Toast.fire({
	            icon: 'warning',
	            title: '유효하지 않은 이메일 형식입니다. 올바른 이메일 주소를 입력해 주세요. ex) test@test.com'
	        });
	        $('#mbrEml').focus();
	        event.preventDefault();
	        return false;
	    }

	 // 휴대폰 번호 유효성 검사 함수
	    function validatePhoneNumber(phoneNumber) {
	        // 숫자 11자리만 허용하는 정규식
	        const phoneNumberPattern = /^\d{11}$/;
	        return phoneNumberPattern.test(phoneNumber);
	    }

	    if ($('#mbrZip').val().trim() === "") {
	    	Toast.fire({
				icon:'warning',
				title:'우편번호를 입력해 주세요.'
			});
	        $('#mbrZip').focus();
	        event.preventDefault();
	        return false;
	    }
	    if ($('#mbrAddr').val().trim() === "") {
	    	Toast.fire({
				icon:'warning',
				title:'주소를 입력해 주세요.'
			});
	        $('#mbrAddr').focus();
	        event.preventDefault();
	        return false;
	    }
	    if ($('#mbrAddrDtl').val().trim() === "") {
	    	Toast.fire({
				icon:'warning',
				title:'상세 주소를 입력해 주세요.'
			});
	        $('#mbrAddrDtl').focus();
	        event.preventDefault();
	        return false;
	    }
	    if ($('#authCount').text().trim() !== "인증성공") {
	    	Toast.fire({
				icon:'warning',
				title:'휴대폰인증을 해주세요.'
			});
	        $('#authCount').focus();
	        event.preventDefault();
	        return false;
	    }

//	    if ($('#chk input[type="checkbox"]:not(:checked)').length > 0) {
//	        alert("이용 약관을 모두 동의 해주세요");
//	        event.preventDefault(); // 폼 제출을 막음
//	        return false;
// 	    }

	    let formData = new FormData();
		let mbrId = $("#mbrId").val();
		let mbrPswd = $("#mbrPswd").val();
		let mbrNm = $("#mbrNm").val();
		let mbrBrdt = $("#mbrBrdt").val();
		let mbrSexdstnCd = $("#mbrSexdstnCd").val();
		let mbrEml = $("#mbrEml").val();
		let mbrTelno = $("#mbrTelno").val();
		let mbrAddr = $("#mbrAddr").val();
		let mbrZip = $("#mbrZip").val();
		let mbrAddrDtl = $("#mbrAddrDtl").val();
		var uploadFile = $("#uploadFile")[0].files[0];
		formData.append("mbrId",mbrId);
		formData.append("mbrPswd",mbrPswd);
		formData.append("mbrNm",mbrNm);
		formData.append("mbrBrdt",mbrBrdt);
		formData.append("mbrSexdstnCd",mbrSexdstnCd);
		formData.append("mbrEml",mbrEml);
		formData.append("mbrTelno",mbrTelno);
		formData.append("mbrAddr",mbrAddr);
		formData.append("mbrZip",mbrZip);
		formData.append("mbrAddrDtl",mbrAddrDtl);
		if(uploadFile!=null){
			formData.append("uploadFile",uploadFile);
		}
		
		$.ajax({
			url : "/security/memSigninPostAjax",
			processData:false,
			contentType:false,
			enctype: 'multipart/form-data',
			data:formData,
			type:"post",
			dataType:"text",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success : function(result) {
				console.log("result : " + result);
				Toast.fire({
					icon:'success',
					title:'회원가입 되었습니다.'
				});
				
				// 3초 후에 이동
				setTimeout(function(){
					location.href="/security/login";
				},3000)
			}
		})
	})
	
	$("#mbrId").on("input", function(){
		$("#idChkResult").text("");
	})
	$("#mbrTelno").on("input", function(){
		let val = $("#authCount").text();
		if(val == "인증성공"){
			$("#authCount").text("");
		}		
	})
	
	$("#mg").on("click", function(){
		$("#mbrId").val("rlaalsrn123");
		$("#mbrPswd").val("Qwer!234");
		$("#mbrPswdChk").val("Qwer!234");
		$("#mbrNm").val("김민팔");
		$("#mbrBrdt").val("19990518");
		$("#mbrSexdstnCd").val("GEND01").attr("selected", true);
		$("#mbrEml").val("ijnplokm69@naver.com");
		$("#mbrTelno").val("01035298236");
		$("#mbrZip").val("34429");
		$("#mbrAddr").val("대전 대덕구 중리동 242-12");
		$("#mbrAddrDtl").val("타워펠리스 1004호");
	})
})
</script>
<div style="position:fixed;bottom: 0; right: 0; display: flex; flex-direction: column; padding: 20px;">
	<button class="ddalkkack" id="mg">딸깍</button>
</div>
<div class="main">
	<div class="login-box">
		<div class="card">
			<div class="login-logo row">
				<div>
					<p>Welcome to ReadyGo</p>
					<h2>회원가입</h2>
				</div>
				<div>
					<p>계정이 있으신가요?<br />
					<a id="signin" href="/security/login" style="font-size: 14px;">로그인</a></p>
				</div>
			</div>
			<div class="card-body login-card-body">
				<!-- 
				[스프링 시큐리티 로그인 폼 규칙]
				1. 아이디   : name속성값이 username
				2. 비밀번호 : name속성값이 password
				3. form태그의 action속성값이 /login, method속성값이 post
				4. csrf 처리
				5. submit 버튼
				 -->
				<form id="mf" action="/security/memSignInPost" method="post" enctype="multipart/form-data">
					<div class="row idForm">
						<div class="form-group mb-2 id">
							<label for="mbrId">아이디&nbsp;&nbsp;&nbsp;&nbsp;<span id="idChkResult"></span></label>
							<input type="text" class="form-control" 
								placeholder="아이디를 입력하세요." 
								name="mbrId" id="mbrId" required />
						</div>
						<div class="form-group mb-1">
							<button type="button" class="btn btn-block btn-sign" id="idchk">아이디 중복검사</button>
						</div>
					</div>
					<div class="form-group mb-3">
						<label for="mbrPswd">비밀번호</label>
						<input type="password" class="form-control" 
							placeholder="비밀번호를 입력하세요." 
							name="mbrPswd" id="mbrPswd" required />
					</div>
					<div class="form-group mb-3">
						<label for="mbrPswdChk">비밀번호 확인</label>
						<input type="password" class="form-control" 
							placeholder="비밀번호를 입력하세요." 
							name="mbrPswdChk" id="mbrPswdChk" required />
					</div>
					<div class="col-12" style="margin-bottom: 20px;">
						<button type="button" id="imgBtn" class="btn btn-block btn-login">프로필 사진 추가</button>
					</div>
					<div class="form-group nb" id="imgForm" hidden="hidden">
						<label for="pImg">프로필 사진</label><br />
						<img id="pImg" />
					</div>
					<div class="form-group nb" hidden="hidden">
						<input type="file" class="form-control"
							name="uploadFile" id="uploadFile" />
					</div>
					<div class="form-group nb">
						<label for="mbrNm">이름</label>
						<input type="text" class="form-control" 
							placeholder="이름을 입력하세요." 
							name="mbrNm" id="mbrNm" required />
					</div>
					<div class="row idForm">
						<div class="form-group nb">
							<label for="mbrBrdt" id="reg1label">생년월일</label>
							<input type="text" class="form-control" 
								placeholder="ex)19990518" 
								name="mbrBrdt" id="mbrBrdt" required />
						</div>
						<div class="form-group nb">
							<label for="mbrSexdstnCd" id="reg1label">성별</label>
							<select class="form-control" name="mbrSexdstnCd" id="mbrSexdstnCd">
								<option value="" disabled selected>성별선택*</option>
								<c:forEach var="codeVO" items="${codeVOList }" varStatus="stus">
									<option value="${codeVO.comCode}">${codeVO.comCodeNm}</option>
								</c:forEach>
							</select> 
						</div>
					</div>
					<div class="form-group mb-3">
						<label for="mbrEml">이메일</label>
						<input type="text" class="form-control" 
							placeholder="이메일을 입력하세요." 
							name="mbrEml" id="mbrEml" required />
					</div>
					<div class="row idForm">
						<div class="form-group mb-2 id">
							<label for="mbrTelno">휴대폰인증</label>
							<input type="text" class="form-control" 
								placeholder="전화번호를 입력하세요" 
								name="mbrTelno" id="mbrTelno" required />
						</div>
						<div class="form-group mb-1">
							<button type="button" class="btn btn-block btn-sign" id="sendAuthNumBtn">인증번호 전송</button>
						</div>
					</div>
					<div class="row idForm" id="authNumForm" hidden="hidden">
						<div class="form-group mb-2 id">
							<input type="text" class="form-control" 
								placeholder="인증번호를 입력하세요." 
								name="authNum" id="authNum" required />
							<span class="certificationTime" id="authCount">03:00</span>
						</div>
						<div class="form-group mb-1">
							<button type="button" class="btn btn-block btn-sign" id="authChk">확인</button>
						</div>
					</div>
					<div class="row idForm">
						<div class="form-group mb-2 id">
							<label for="mbrAddr">주소</label>
							
								<input type="text" class="form-control" 
								placeholder="우편번호" 
								name="mbrZip" id="mbrZip" readonly="readonly" required />
						</div>
						<div class="form-group mb-1">
							<button type="button" class="btn btn-block btn-sign" onclick="execDaumPostcode();">주소 찾기</button>
						</div>
					</div>
					<div class="form-group mb-3">
						<input type="text" class="form-control" 
								placeholder="기본 주소" 
								name="mbrAddr" id="mbrAddr" readonly="readonly" required />
					</div>
					<div class="form-group mb-3">
						<input type="text" class="form-control" 
							placeholder="상세 주소" 
							name="mbrAddrDtl" id="mbrAddrDtl" required />
					</div>
					<div class="col-12">
						<button type="button" id="signinBtn" class="btn btn-block btn-login">회원가입</button>
					</div>
					<!-- csrf : Cross Site(크로스 사이트) Request(요청) Forgery(위조) -->
					<sec:csrfInput/>
				</form>
			</div>
		</div>
	</div>
</div>