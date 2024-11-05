<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/member/aplctList.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/security/loginForm.css" />
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/resources/js/jquery.min.js"></script>
<script src="/resources/js/sweetalert2.js"></script>
<script>
var Toast = Swal.mixin({
	toast: true,
    position: 'center',
    showConfirmButton: false,
    timer: 3000
});
$(function(){
    $("#warning").hide();  // 경고 메시지 숨김
	$("#clCn").on("input", function() {
        let currentLength = $(this).val().length;
        $("#charCount").text(currentLength);

        if (currentLength > 2000) {
            $("#warning").show();  // 경고 메시지 표시
            $(this).val($(this).val().substring(0, 2000));  // 글자 수 제한
            $("#charCount").text(2000);  // 100자까지만 표시
        } else {
            $("#warning").hide();  // 경고 메시지 숨김
        }

    });
    
    $("#cancelBtn").on("click", function(){
    	Swal.fire({
            icon: 'info',
            title: '자소서 작성 취소',
            text: '자소서 작성을 취소하시겠습니까?\n작성중인 글은 저장되지 않습니다.',
            showCancelButton: true,
            confirmButtonText: '예', 
            cancelButtonText: '아니오',
            confirmButtonColor: '#429f50',
            cancelButtonColor: '#d33',
        }).then(function(result){
            if (result.isConfirmed) {
                location.href = "/member/cover";
            } else if (result.isDismissed) {
            	return;
            }

        })
    });
    
    $("#submitBtn").on("click", function(){
    	if ($('#clTtl').val().trim() === "") {
	    	Toast.fire({
				icon:'warning',
				title:'제목을 입력해 주세요.'
			});
	        $('#clTtl').focus();
	        event.preventDefault();
	        return false;
	    }
    	if ($('#clCn').val().trim() === "") {
	    	Toast.fire({
				icon:'warning',
				title:'내용을 입력해 주세요.'
			});
	        $('#clCn').focus();
	        event.preventDefault();
	        return false;
	    }
	   
        let clStrgNo = $("#clStrgNo").val();
        let clTtl = $("#clTtl").val();
        let clCn = $("#clCn").val();
        
        let formData = new FormData();

        if($('#clStrgNo').val().trim() !== ""||$('#clStrgNo').val()!==null){
	        formData.append("clStrgNo", clStrgNo);
        }
        formData.append("clTtl", clTtl);
        formData.append("clCn", clCn);
		
        let pat = $(this).parents(".conBox");
        
        $.ajax({
            url: "/member/coverRegistPost",
            processData: false,
            contentType: false,
            data: formData,
            type: "post",
            dataType: "json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(result) {
            	if(result>0){
	                Toast.fire({
	                    icon: 'success',
	                    title: '자기소개서 저장 완료'
	                });
	                location.href="/member/cover"
            	}else{
	                Toast.fire({
	                    icon: 'warning',
	                    title: '자기소개서 저장 실패'
	                });
	                return;
            	}
            }
     	});
    })
})
</script>
<div class="mainCon row" style="justify-content: center;">
	<div>
		<div class="frameTitle"style="margin:50px 0px 20px 0px;">자기소개서 작성</div>
		<div class="frame">
			<div class="title form-group">
				<input type="hidden" id="clStrgNo" name="clStrgNo" value="${coverVO.clStrgNo }"/>
				<label class="lab" for="clTtl">제목*</label>
				<input type="text" placeholder="제목을 입력해 주세요." id="clTtl" name="clTtl" 
					class="form-control" value="${coverVO.clTtl }" />
			</div>
			<div class="content">
				<label class="lab" for="clTtl">내용*</label>
				<textarea rows="" cols="" class="form-control" id="clCn" name="clCn"
					style="height: 450px;" placeholder="
	내용을 입력해주세요.
						
					">${coverVO.clCn }</textarea>
			</div>
			<div style="display:flex; justify-content:  flex-end;">
	           <p id="countp">글자 수&nbsp;(&nbsp;<span id="charCount">0</span>&nbsp;/&nbsp;2000&nbsp;) 공백포함*</p>
		       <p id="warning">글자 수가 2000자를 넘었습니다!</p>
	        </div>
			<div class="content" style="display:flex; justify-content:  flex-end; margin-top: 30px;">
				<div>
				<button type="button" class="resetBtn deleteBtn" id="cancelBtn">취소</button>
				<button type="button" class="submitBtn editBtn" id="submitBtn">저장</button>
				</div>
			</div>
		</div>
	</div>
</div>
<style>
.frame{
	width: 930px;
	height: auto;
	padding: 0px 30px 30px 30px;
	border: 1px solid #80808038;
	border-top: 3px solid #24D59E;
	border-radius: 0px 0px 12px 12px;
}
.lab{
	position: relative;
	background-color: #ffffff;
	padding: 0px 5px 0px 5px;
	top: 22px;
    left: 20px;
}
.frameTitle{
	font-size: 32px;
	font-weight: 700;
}
#charCount{
color: #24D59E;
}
#countp{
color:#232323;
font-size: 14px;
}
#warning {
color: red;
display: none;
margin-left: 20px;
}
</style>