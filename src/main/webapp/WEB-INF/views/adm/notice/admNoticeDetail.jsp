<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/sweetalert2.js"></script>
<script type="text/javascript" src="/resources/ckeditor5/ckeditor.js"></script>
<script type="text/javascript" src="/resources/js/sweetalert2.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/admAlert.css" />
<sec:authentication property="principal" var="prc"/>
<!-- 비로그인 또는 로그인한 사용자가 'admin'이 아닐 때 접근 금지 메시지를 표시하거나 리디렉션 -->
<sec:authorize access="!isAuthenticated() or principal.username != 'admin'">
    <script>
    Swal.fire({
        icon: 'error',
        title: '접근 권한이 없습니다',
        showConfirmButton: false,
        timer: 2000 
    }).then(() => {
        window.location.href = "/"; 
    });
    </script>
</sec:authorize>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/board/admDetail.css" />
<script type="text/javascript">
$(function(){
    // CKEditor 글 복제
    $(".ck-blurred").keydown(function(){
        $("#pstCn").val(window.editor.getData());
    });

    $("#uploadFile").on("change", handleImg);

    $(".ck-blurred").focusout(function(){
        $("#perDet").val(window.editor.getData());
    });

});
ClassicEditor.create(document.querySelector('#pstCnTemp'))
.then(editor => {
    editor.enableReadOnlyMode('#pstCnTemp');
    window.editor = editor;
    
    // 폼 제출 전 CKEditor의 내용을 textarea에 동기화
    document.querySelector('#registForm').addEventListener('submit', function(event) {
        document.querySelector('#pstCn').value = editor.getData();
    });
})
.catch(error => {
    console.error(error);
});

</script>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<div class="container2">
    <header class="registTitle">
        <h1>공지 게시판</h1>
    </header>
    <div class="title-group">
        <div class="content-group">
        <form name="deletePost" id="deletePost" action="/adm/notice/deletePost" method="post">
            <div class="Content">
			<div class="rv-detail">
				<!--  제목 -->
				<div class="titlegroup">            
	                <div class="left">
	                    <p style="font-weight: bold; font-size:30px; line-height:0;"><br>[${boardVO.pstOthbcscope}]&nbsp;${boardVO.pstTtl}</p>
	                </div>
                </div>
              	<!--  제목 -->
				<!-- 작성자, 작성일, 조회수 -->
				<div class="reviewWit">
					<c:if test="${boardVO.pstMdfcnDt != null}">
						<div class="wit">
							<p>작성자 : ★관리자
							<p>
							<p>작성일&nbsp;:&nbsp;${boardVO.pstMdfcnDt}&nbsp;(수정됨)</p>
						</div>
					</c:if>
					<c:if test="${boardVO.pstMdfcnDt == null}">
						<div class="wit">
							<p>작성자 : ★관리자
							<p>
							<p>작성일&nbsp;:&nbsp;${boardVO.pstWrtDt}</p>
						</div>
					</c:if>
					<div class="upDown">
						<p>조회수&nbsp;:&nbsp;${boardVO.pstInqCnt}</p>
					</div>
				</div>
				<!-- 작성자, 작성일, 조회수 -->
				<!-- 첨부 파일 다운로드 링크 -->
				<c:forEach var="file" items="${fileDetails}">
				    <div class="filedown" style="margin-left:20px;">
				        <a href="/download?fileName=${file.filePathNm}" download="${file.orgnlFileNm}">
				            <i class="fas fa-link mr-1">${file.orgnlFileNm} (${file.fileFancysize})</i>
				        </a>
				    </div>
				</c:forEach>	
				<!-- 첨부 파일 다운로드 링크 -->
				<div class="hr"></div>
				<!-- 리뷰내용 -->
				<div class="pstCn">${boardVO.pstCn}</div>
				</div>                        
            </div>
            <!-- 버튼 배치 -->
		    <div class="button-container">
		        <button type="button" class="btn btn-List" onclick="location.href='/adm/notice/admNoticeList'">목록</button>
		        <div class="button-group-right">
		            <button type="button" class="btn btn-Del">삭제</button>
		        	<button type="button" class="btn btn-Edit" onclick="location.href='/adm/notice/admNoticeUpdate?seNo=${boardVO.seNo}&pstSn=${boardVO.pstSn}'">수정</button>
        			<input type="hidden" id="pstSn" name="pstSn" value="${boardVO.pstSn}"/>
		        </div>
		    </div> 
            <sec:csrfInput/>
        </form>            
        </div>
    </div>
</div>
<script type="text/javascript">
$('.btn-Del').on('click', function() {
    Swal.fire({
        title: '게시글을 삭제하시겠습니까?',
        icon: 'error',
        showCancelButton: true,
        confirmButtonColor: 'white',
        cancelButtonColor: 'white',
        confirmButtonText: '예',
        cancelButtonText: '아니오',
        
    }).then((result) => {
        if (result.isConfirmed) {
            $('#deletePost').submit();
        }
    });
});
ClassicEditor.create(document.querySelector('#pstCnTemp'))
    .then(editor => {
        editor.enableReadOnlyMode('#pstCnTemp');
        window.editor = editor;
        
        // 폼 제출 전 CKEditor의 내용을 textarea에 동기화
        document.querySelector('#registForm').addEventListener('submit', function(event) {
            document.querySelector('#pstCn').value = editor.getData();
        });
    })
    .catch(error => {
        console.error(error);
    });
</script>

