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
    position: 'top-end',
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
		$("#entBrFileFile").click()
		$("#brFileForm").attr("hidden", false);
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
	    }
	    countTime--;
	};
	$("#sendAuthNumBtn").on("click", function(){
		if ($('#entManagerTelno').val().trim() === "") {
			Toast.fire({
				icon:'warning',
				title:'휴대폰 번호를 입력해 주세요.'
			});
	        $('#entManagerTelno').focus();
	        event.preventDefault();
	        return false;
	    }
		$("#authNumForm").attr("hidden", false);
		$.time(179);
		let formData = new FormData();
		let memto = $("#entManagerTelno").val();
		let memsend = "01030674663";
		memcon = "인증번호는 [";
		chkNum +=Math.floor(Math.random()*10);
		chkNum += Math.floor(Math.random()*10);
		chkNum += Math.floor(Math.random()*10);
		chkNum += Math.floor(Math.random()*10);
		chkNum += Math.floor(Math.random()*10);
		chkNum += Math.floor(Math.random()*10);
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
			},
			success : function(result) {
				console.log("result : " + result);
				// success, error, warning, info, question
				Toast.fire({
					icon:'success',
					title:'인증번호가 전송 되었습니다.'
				});
			}
		})
	})
	
	$("#idchk").on("click", function(){
		let entId = $("#entId").val();
		console.log(entId);
		$.ajax({
			url : "/security/idChkAjax",
			contentType:"text/plain;charset=utf-8", 
			data : entId,
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
	    
	    if ($('#entBrno').val().trim() === "") {
	    	Toast.fire({
				icon:'warning',
				title:'사업자번호를 입력해 주세요.'
			});
	    	$('#entBrno').focus();
	    	event.preventDefault();
	    	return false;
	    }
	    if ($('#entNm').val().trim() === "") {
	    	Toast.fire({
				icon:'warning',
				title:'기업명을 입력해 주세요.'
			});
	    	$('#entNm').focus();
	    	event.preventDefault();
	    	return false;
	    }
	    if ($('#entFndnYmd').val().trim() === "") {
	    	Toast.fire({
				icon:'warning',
				title:'설립일을 입력해 주세요.'
			});
	    	$('#entFndnYmd').focus();
	    	event.preventDefault();
	    	return false;
	    }
	    if ($('#entEmpCnt').val().trim() === "") {
	    	Toast.fire({
				icon:'warning',
				title:'사원수를 입력해 주세요.'
			});
	    	$('#entEmpCnt').focus();
	    	event.preventDefault();
	    	return false;
	    }
	    if ($('#entStleCd').val().trim() === "") {
	    	Toast.fire({
				icon:'warning',
				title:'기업형태를 입력해 주세요.'
			});
	    	$('#entStleCd').focus();
	    	event.preventDefault();
	    	return false;
	    }
	    if ($('#entFxnum').val().trim() === "") {
	    	Toast.fire({
				icon:'warning',
				title:'팩스번호를 입력해 주세요.'
			});
	    	$('#entFxnum').focus();
	    	event.preventDefault();
	    	return false;
	    }
	    if ($('#entHmpgUrl').val().trim() === "") {
	    	Toast.fire({
				icon:'warning',
				title:'기업홈페이지를 입력해 주세요.'
			});
	    	$('#entHmpgUrl').focus();
	    	event.preventDefault();
	    	return false;
	    }
	    if ($('#entRprsntvNm').val().trim() === "") {
	    	Toast.fire({
				icon:'warning',
				title:'대표자이름을 입력해 주세요.'
			});
	    	$('#entRprsntvNm').focus();
	    	event.preventDefault();
	    	return false;
	    }
	    if(idchk !== "사용 가능"){
	    	Toast.fire({
				icon:'warning',
				title:'ID 중복되거나 중복체크를 하지 않았습니다.'
			});
	        event.preventDefault();
	        return false;
	    }
	    if($('#entPswd').val().trim() === "") {
	    	Toast.fire({
				icon:'warning',
				title:'비밀번호를 입력해 주세요.'
			});
	    	$('#entPswd').focus();
	    	event.preventDefault();
	    	return false;
	    }
	    if($("#entPswdChk").val().trim() === "" || $("#entPswd").val().trim() !== $("#entPswdChk").val().trim()){
	    	Toast.fire({
				icon:'warning',
				title:'비밀번호와 비밀번호 확인이 다릅니다. 다시 확인하세요.'
			});
	        event.preventDefault(); // 폼 제출을 막음
	        return false;   // 서버로 전송을 하지 않는다.
	    }
	    if ($('#entMail').val().trim() === "") {
	    	Toast.fire({
				icon:'warning',
				title:'기업 이메일을 입력해 주세요.'
			});
	        $('#entMail').focus();
	        event.preventDefault();
	        return false;
	    }
	    if ($('#entManagerTelno').val().trim() === "") {
	    	Toast.fire({
				icon:'warning',
				title:'담당자연락처를 입력해 주세요.'
			});
	    	$('#entManagerTelno').focus();
	    	event.preventDefault();
	    	return false;
	    }
	    if ($('#entAddr').val().trim() === "") {
	    	Toast.fire({
				icon:'warning',
				title:'기본주소를 입력해 주세요.'
			});
	        $('#entAddr').focus();
	        event.preventDefault();
	        return false;
	    }
	    if ($('#entAddrDetail').val().trim() === "") {
	    	Toast.fire({
				icon:'warning',
				title:'상세주소를 입력해 주세요.'
			});
	        $('#entAddrDetail').focus();
	        event.preventDefault();
	        return false;
	    }
	    if ($('#entZip').val().trim() === "") {
	    	Toast.fire({
				icon:'warning',
				title:'우편번호를 입력해 주세요.'
			});
	        $('#entZip').focus();
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
		let entBrno = $("#entBrno").val();
		let entNm = $("#entNm").val();
		let entFndnYmd = $("#entFndnYmd").val();
		let entEmpCnt = $("#entEmpCnt").val();
		let entStleCd = $("#entStleCd").val();
		let entFxnum = $("#entFxnum").val();
		let entHmpgUrl = $("#entHmpgUrl").val();
		let entRprsntvNm = $("#entRprsntvNm").val();
		let entId = $("#entId").val();
		let entPswd = $("#entPswd").val();
		let entMail = $("#entMail").val();
		let entManagerTelno = $("#entManagerTelno").val();
		let entAddr = $("#entAddr").val();
		let entAddrDetail = $("#entAddrDetail").val();
		let entZip = $("#entZip").val();
		
		formData.append("entBrno",entBrno);
		formData.append("entNm",entNm);
		formData.append("entFndnYmd",entFndnYmd);
		formData.append("entEmpCnt",entEmpCnt);
		formData.append("entStleCd",entStleCd);
		formData.append("entFxnum",entFxnum);
		formData.append("entHmpgUrl",entHmpgUrl);
		formData.append("entRprsntvNm",entRprsntvNm);
		formData.append("entId",entId);
		formData.append("entPswd",entPswd);
		formData.append("entMail",entMail);
		formData.append("entManagerTelno",entManagerTelno);
		formData.append("entAddr",entAddr);
		formData.append("entAddrDetail",entAddrDetail);
		formData.append("entZip",entZip);
		
		$.ajax({
			url : "/security/entSigninPostAjax",
			processData:false,
			contentType:false,
			data:formData,
			type:"post",
			dataType:"text",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success : function(result) {
				console.log("result : " + result);
				// success, error, warning, info, question
				Toast.fire({
					icon:'success',
					title:'회원가입 되었습니다.'+result
				});
				// 3초 후에 이동
				setTimeout(function(){
					location.href="/";
				},3000)
			}
		})
	})
})