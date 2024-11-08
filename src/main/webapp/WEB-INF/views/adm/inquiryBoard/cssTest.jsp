<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>  
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<link type="text/css" href="/resources/ckeditor5/sample/css/sample.css" rel="stylesheet" media="screen" />
<script type="text/javascript" src="/resources/ckeditor5/ckeditor.js"></script>
<script type="text/javascript">
document.querySelector('#registForm').addEventListener('submit', function(event) {
    const selectElement = document.querySelector('#pstOthbcscope');
    const selectedValue = selectElement.value;
    
    if (selectedValue === "") {
        alert('공개범위를 선택해주세요.');
        event.preventDefault(); // 폼 제출을 막습니다
    }
});


// e : onchange 이벤트
function handleImg(e){
    let files = e.target.files; // 선택한 파일들
    let fileArr = Array.prototype.slice.call(files);
    let accumStr = "";
    fileArr.forEach(function(f){
        if(!f.type.match("image.*")){ // MIME타입
            alert("이미지 확장자만 가능합니다.");
            return; // 함수 종료
        }
        let reader = new FileReader();
        reader.onload = function(e){
            accumStr += "<img src='"+e.target.result+"' style='width:20%;border:1px solid #D7DCE1;' />";
            $("#pImg").html(accumStr);
        }
        reader.readAsDataURL(f);
    });
}

$(function(){
    $("#uploadFile").on("change", handleImg);

    $(".ck-blurred").keydown(function(){
        $("#perDet").val(window.editor.getData());
    });

    $(".ck-blurred").focusout(function(){
        $("#perDet").val(window.editor.getData());
    });

    $("#custNum").on("change", function(){
        let custNum = $(this).val();
        let data = { "custNum": custNum };
        console.log("custNum : ", custNum);
        console.log("data : ", data);
        $.ajax({
            url:"/perSer/custCarList",
            contentType:"application/json;charset=utf-8",
            data:JSON.stringify(data),
            type:"post",
            dataType:"json",
            beforeSend:function(xhr){
                xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
            },
            success:function(result){
                console.log("result : ", result);
                let str = "";
                $("#carNum").html("<option value='' selected disabled>선택해주세요</option>");
                $.each(result.carVOList, function(idx, carVO){
                    str += "<option value='"+carVO.carNum+"'>"+carVO.carNum+"</option>";
                });
                $("#carNum").append(str);
            }
        });
    });
});
</script>
<style>
.content-wrapper {
    background-color: white;
    font-family: pretendard;
}

.ck-editor__main .ck-content {
    height: 450px;
    border: 1px solid #black; 
}

.btn-default {
    background-color: #24D59E;
    border-color: none;
    color: white;
    border-radius: 8px;
    transition: background-color 0.3s, color 0.3s, border-color 0.3s;
}

.btn-default:hover{
    background-color: white;
    color: #24D59E;
    border-color: #24D59E;
}

.btn-list {
    width: 116px;
    height: 40px;
    margin-right: auto; /* 왼쪽으로 정렬 */
}

.category {
    width: 110px; 
    font-size: 12px;
}

.btn-regist {
    width: 116px;
    height: 40px;
}

.form-group {
    border-color: black;
}

.input-group {
    display: flex;
    align-items: center;
    gap: 10px;
}

.button-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.form-actions {
    display: flex;
    align-items: center;
    gap: 10px;
}
.ck-placeholder {
    color: #aaa;
    white-space: pre-wrap; /* 줄바꿈을 처리합니다 */
    font-size: 12px;
}
.title {
    flex: 1; /* 남은 공간을 모두 차지하도록 설정 */
    font-size: 15px;
    border-radius: 8px; 
    border: 1px solid #D9D9D9; 
    height:50px;
}
.btn-file{
	width: 116px;
	height: 50px;
}
</style>

<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2 main" style="margin-left: 150px;">
            <div class="col-sm-6">
                <h1>문의 게시판<br></h1>
            </div>
        </div>
    </div>
</section>
<!-- 제목입력! -->
<div class="row">
    <div class="col-md-8 offset-md-2" style="display: flex; justify-content: center;">
    	<form name="registForm" id="registForm" action="/board/inquiryBoard/registPost"  method="post">
	        <form class="col-12" action="simple-results.html" style="margin:10px;">
	            <div class="input-group">
	                <input type="text" class="form-control form-control-lg" placeholder="제목을 작성해주세요" name="pstTtl" id="pstTtl"
	                	   style="font-size:15px; border-radius: 8px; border-color: #D9D9D9;" required>
	                <button type="button" class="btn btn-default btn-file">파일첨부</button>
	            </div>
	            <br>
	            <!-- 내용입력! -->
	            <div class="form-group" style="border-color: black;" id="pstCnTemp" name="pstCnTemp">
	                <textarea id="pstCn" name="pstCn"></textarea>
	            </div>
	            <div class="form-actions">	
	                <button type="button" class="btn btn-default btn-list" onclick="location.href='/board/inquiryBoard/inquiryList'">게시글 목록</button>
						<select class="form-control category" name="pstOthbcscope" id="pstOthbcscope" required>
						    <option value="" disabled selected hidden>공개범위</option>
						    <option value="공개">공개</option>
						    <option value="비공개">비공개</option>
						</select>
	                <button type="submit" class="btn btn-default btn-regist">게시글 등록</button>
	            </div>
            <sec:csrfInput/>
	        </form>
        </form>
    </div>
</div>

<script type="text/javascript">
ClassicEditor.create(document.querySelector('#pstCnTemp'), { 
//     ckfinder: { uploadUrl: '/image/upload?${_csrf.parameterName}=${_csrf.token}'},
    placeholder: '\n 내용을 작성해주세요 \n\n * 등록한 글은 사용자 아이디로 등록됩니다. \n * 문의 내용을 상세히 적어주시면 더 명확한 답변을 해드릴 수 있습니다.'
})
.then(editor => { 
    window.editor = editor;
    
    // 폼 제출 전 CKEditor의 내용을 textarea에 동기화
    document.querySelector('#registForm').addEventListener('submit', function(event) {
        document.querySelector('#pstCn').value = editor.getData();
    });
})
.catch(err => { console.error(err.stack); });
</script>
