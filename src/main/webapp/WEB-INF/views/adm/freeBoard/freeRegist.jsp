<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>  
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<link type="text/css" href="/resources/ckeditor5/sample/css/sample.css" rel="stylesheet" media="screen" />
<script type="text/javascript" src="/resources/ckeditor5/ckeditor.js"></script>
<script type="text/javascript">
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
    $("#uploadFile").on("change",handleImg);
    
    $(".ck-blurred").keydown(function(){
        $("#perDet").val(window.editor.getData());
    });
    
    $(".ck-blurred").focusout(function(){
        $("#perDet").val(window.editor.getData());
    });
    
    $("#custNum").on("change",function(){
        let custNum = $(this).val();
        let data = { "custNum":custNum };
        console.log("custNum : ", custNum);
        console.log("data : ", data);
        /* $.ajax({
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
                $.each(result.carVOList,function(idx,carVO){
                    str += "<option value='"+carVO.carNum+"'>"+carVO.carNum+"</option>";
                });
                $("#carNum").append(str);
            }
        }); */
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

.btn-default:hover,
.btn-default:focus {
    background-color: white;
    color: #24D59E;
    border-color: #24D59E;
}

.btn-list, .btn-regist {
    height: 40px;
    border-radius: 8px;
}

.input-group {
    display: flex;
    align-items: center;
    gap: 10px; /* 선택 필드와 제목 입력 필드 사이의 간격 조정 */
    flex: 1; /* 제목 입력 필드의 길이에 따라 자동 조절 */
}

.cat_main .category{
    border-radius: 8px; /* border-radius 추가 */
    font-size: 15px;
    border: 1px solid #D9D9D9; /* border-color 수정 */
    padding: 10px ; /* padding 추가 */
    min-width: 120px; /* 최소 너비 설정 */
    flex-shrink: 0;
    height:50px;
    background-color: white;
}

.title {
    flex: 1; /* 남은 공간을 모두 차지하도록 설정 */
    font-size: 15px;
    border-radius: 8px; 
    border: 1px solid #D9D9D9; 
    height:50px;
}

.form-group {
    margin-top: 20px;
}

.button-container {
    display: flex;
    justify-content: space-between;
}
.category{
	width:100%;
	height:100%;
}
.ck-placeholder {
    color: #aaa;
    white-space: pre-wrap; /* 줄바꿈을 처리합니다 */
    font-size: 12px;
}
.btn-list{
    width: 116px;
    height: 40px;
    margin-right: auto; /* 왼쪽으로 정렬 */
}
</style>

<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2" style="margin-left: 150px;">
            <div class="col-sm-6">
                <h1>자유 게시판<br></h1>
            </div>
        </div>
    </div>
</section>

<!-- 제목입력! -->
<div class="row">
    <div class="col-md-8 offset-md-2">
        <form class="col-12" action="simple-results.html" style="margin:10px;">
            <div class="input-group">
                <div class="cat_main">
                    <select class="form-control category">
                        <option selected disabled hidden>카테고리 선택</option>
                        <option>option 1</option>
                        <option>option 2</option>
                        <option>option 3</option>
                        <option>option 4</option>
                        <option>option 5</option>
                    </select>
                </div>
                <input type="search" class="form-control form-control-lg title"
                    placeholder="제목을 작성해주세요">
            </div>
            <!-- 내용입력! -->
            <div class="form-group">
                <div id="perDetTemp"></div>
            </div>
            <div class="button-container">
                <button type="button" class="btn btn-default btn-list" onclick="location.href='/freeBoard/list'">목록</button>
                <button type="button" class="btn btn-default btn-regist">등록</button>
            </div>
        </form>
    </div>
</div>

<script type="text/javascript">
// CKEditor5 적용 및 데이터 넣기
ClassicEditor.create(document.querySelector('#perDetTemp'), { 
    ckfinder: { uploadUrl: '/image/upload?${_csrf.parameterName}=${_csrf.token}'},
    placeholder: '\n 내용을 작성해주세요 \n\n * 등록한 글은 사용자 아이디로 등록됩니다. \n * 저작권 침해, 음란, 청소년 유해물, 기타 위법 자료 등을 게시할 경우 게시글 삭제 및 작성자에게 경고 조치 됩니다.' //<-이거 추가
})
.then(editor => { window.editor = editor; })
.catch(err => { console.error(err.stack); });
</script>
