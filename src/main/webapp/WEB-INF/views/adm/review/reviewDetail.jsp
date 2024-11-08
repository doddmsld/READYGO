<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/ckeditor5/ckeditor.js"></script>
<link rel="stylesheet" href="../../resources/assets/css/templatemo-cyborg-gaming.css">
<script type="text/javascript" src="/resources/js/sweetalert2.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/admAlert.css" />
<sec:authentication property="principal" var="prc"/>
<!-- 비로그인 또는 로그인한 사용자가 'admin'이 아닐 때 접근 금지 메시지를 표시하거나 리디렉션 -->
<sec:authorize access="!isAuthenticated() or principal.username != 'admin'">
    <script>
    Swal.fire({
        icon: 'warning',
        title: '접근 권한이 없습니다',
        showConfirmButton: false,
        timer: 2000 
    }).then(() => {
        window.location.href = "/"; 
    });
    </script>
</sec:authorize>
<!-- Spring Security 인증 정보를 가져오기 -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
<!-- 외주 css 파일 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/board/admReviewdetail.css" />
<script type="text/javascript">
$(document).ready(function(){
    // 로그인한 사용자 정보 가져오기
    var username = "${pageContext.request.userPrincipal != null ? pageContext.request.userPrincipal.name : 'anonymousUser'}";
    console.log("현재 사용자: " + username);

    // 댓글 등록 버튼 클릭 시
    $('#submitComment').on("click", function(event) {
        event.preventDefault(); // 기본 폼 제출 막기

        const commentContent = $('#commentContent').val();  // 댓글 내용
        const pstSn = $('#pstSn').val();  // 게시글 번호

        if (commentContent === "") {
            Swal.fire({
                icon: 'info',
                title: '댓글 내용을 작성해주세요',
            });
            return;
        }

        // 비로그인 사용자 확인
        if (username === 'anonymousUser') {
            Swal.fire({
                title: '로그인 후 댓글 작성할 수 있습니다.',
                text: "로그인 페이지로 이동하시겠습니까?",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: 'white',
    	        cancelButtonColor: 'white',
                confirmButtonText: '이동',
                cancelButtonText: '취소'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = "/security/login";
                }
            });
            return;
        }

        // Ajax로 댓글 등록 요청
        $.ajax({
            url: '/adm/review/registReplyPost',
            type: 'POST',
            data: {
                commentContent: commentContent,
                pstSn: pstSn
            },
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(response) {
                location.reload(); // 댓글 목록 갱신
            },
            error: function(xhr, status, error) {
                alert('댓글 등록 실패: ' + error);
            }
        });
    });
    const initialHeight = 510; 
    const increaseBy = 510; 
    let currentHeight = initialHeight; 

    // 더보기 버튼 클릭 시
    $('#loadMoreBtn').on('click', function() {
        currentHeight += increaseBy; 
        $('#commentsList').animate({ maxHeight: currentHeight + 'px' }, 500); 

        // 전체 댓글이 다 표시되면 더보기 버튼 숨기기
        if ($('#commentsList')[0].scrollHeight <= currentHeight) {
            $('#loadMoreBtn').hide();
        }
    });
    // 전체 댓글 개수가 5개 이하이면 "더보기" 버튼을 숨김
    if (totalComments <= commentsToShow) {
        $('#loadMoreBtn').hide();
    }
});
</script>
<style>
#commentsList {
    max-height: 350px; /* 기본 최대 높이 */
    overflow: hidden; /* 스크롤 숨김 */
    transition: max-height 0.5s ease-in-out; /* 높이 변화 애니메이션 */
}
</style>
<script type="text/javascript">
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
   <div class="registTitle">
        <h1>리뷰 게시판</h1>
    </div>
   <div class="reviewDetail-group">
      <div class="content-group">
         <form name="reviewDeletePost" id="reviewDeletePost"  action="/adm/review/reviewDeletePost" method="post">
            <div class="Content">
               <div class="rv-detail">
                <!-- 제목, 신고 버튼 -->
                  <div class="titlegroup">
                    <div class="left">
                         <p style="font-weight: bold;  font-size: 30px;"> ${boardVO.pstTtl}</p>
                    </div>
                  </div>
                    <!-- 작성자, 작성일, 조회수 -->
                    <div class="reviewWit">
                        <c:choose>
                            <c:when test="${boardVO.mbrId == 'admin'}">
                                <c:if test="${boardVO.pstMdfcnDt != null}">
                                    <div class="wit">
                                        <p>★관리자</p>
                                        <p>작성일&nbsp;:&nbsp;${boardVO.pstWrtDt}&nbsp;(수정됨)</p>
                                    </div>
                                </c:if>
                                <c:if test="${boardVO.pstMdfcnDt == null}">
                                    <div class="wit">
                                        <p>★관리자</p>
                                        <p>작성일&nbsp;:&nbsp;${boardVO.pstWrtDt}</p>
                                    </div>
                                </c:if>
                            </c:when>
                            <c:otherwise>
                                <c:if test="${boardVO.pstMdfcnDt != null}">
                                    <div class="wit">
                                        <p>작성자&nbsp;:&nbsp;${boardVO.mbrId}</p>
                                        <p>작성일&nbsp;:&nbsp;${boardVO.pstWrtDt}&nbsp;(수정됨)</p>
                                    </div>
                                </c:if>
                                <c:if test="${boardVO.pstMdfcnDt == null}">
                                    <div class="wit">
                                        <p>작성자&nbsp;:&nbsp;${boardVO.mbrId}</p>
                                        <p>작성일&nbsp;:&nbsp;${boardVO.pstWrtDt}</p>
                                    </div>
                                </c:if>
                                <div class="upDown">
                                    <p>조회수&nbsp;:&nbsp;${boardVO.pstInqCnt}</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <c:if test="${boardVO.pstFile != '2' }">
                        <c:forEach var="file" items="${fileDetails}">
                            <div class="filelist">
                                <a href="${file.filePathNm}" download="${file.orgnlFileNm}">
                                    <i class="fas fa-link mr-1" style="font-weight:600; font-size:14px;">${file.orgnlFileNm} (${file.fileFancysize})</i>
                                </a>
                            </div>
                        </c:forEach>
                    </c:if>
                    <div class="hr"></div>
                    <!-- 리뷰 내용 -->
                    <div class="pstCn">
                        ${boardVO.pstCn}
                    </div>
               </div>
            </div>
            <!-- 버튼 배치 -->
            <div class="button-container">
                <div id="editBox1">
                    <a href="/adm/review/reviewList"><input type="button" id="savebtn" value="목록" /></a>
                </div>
                <div class="button-group-right">
                            <div id="editBox">
                                <p>
                                    <input type="button" class="cancel" value="삭제" />
                                    <c:if test="${boardVO.mbrId == 'admin'}">
                                    	<button type="button" id="savebtn" onclick="location.href='/adm/review/reviewUpdate?seNo=${boardVO.seNo}&pstSn=${boardVO.pstSn}'">수정</button>
                                	</c:if>
                                </p>
                            </div>
                    <input type="hidden" id="pstSn" name="pstSn" value="${boardVO.pstSn}" />
                </div>
            </div>
            <sec:csrfInput />
         </form>
      </div>
   </div>

   <!-- 댓글 입력창 및 목록 섹션 -->
   <div class="comment-section">
      <!-- 댓글 입력창 -->
      <form name="replyRegistPost" id="replyRegistPost"
         action="/common/freeBoard/registReplyPost" method="post">
         <div class="comment-input">
            <input type="text" id="commentContent" name="commentContent" class="form-control ck-blurred" placeholder="댓글을 입력하세요" rows="5">
            <button type="submit" id="submitComment" class="btn btn-Regist">등록</button>
         </div>
         <sec:csrfInput />
         <input type="hidden" id="pstSn" name="pstSn" value="${boardVO.pstSn}" />
      </form>

      <!-- 댓글 목록 -->
      <div id="commentsList">
         <c:if test="${empty commentsList}">
            <p>댓글이 없습니다.</p>
         </c:if>
    <c:forEach var="comment" items="${commentsList}">
        <div class="comment-item" data-cmnt-no="${comment.cmntNo}">
            <p>
                <c:choose>
                    <c:when test="${comment.mbrId == 'admin'}">
                        <strong style="background-color: #FD5D6C;">★관리자</strong>(${comment.cmntRegDt})
                    </c:when>
                    <c:otherwise>
                        <strong>${comment.mbrId}</strong>(${comment.cmntRegDt})
                    </c:otherwise>
                </c:choose>
            </p>
            <div class="comment-content">${comment.cmntCn}</div>

            <c:if test="${prc.username == comment.mbrId || prc.username == 'admin'}">
                <div class="comment-buttons">
                 	<c:if test="${prc.username eq 'admin'}">
                    <button type="button" class="btn-delete-comment" data-id="${comment.cmntNo}">
                        <img src="${pageContext.request.contextPath}/resources/icon/Del_icon.png" alt="삭제" style="width: 20px; height: 20px;">
                    </button>
                    </c:if>
                    <c:if test="${prc.username eq comment.mbrId}">
                    <button type="button" class="btn-edit-comment" data-id="${comment.cmntNo}">
                        <img src="${pageContext.request.contextPath}/resources/icon/Edit_icon.png" alt="수정" style="width: 20px; height: 20px;">
                    </button>
                    </c:if>
                </div>
            </c:if>

            <!-- 댓글 수정 폼 -->
            <div class="edit-comment-form" style="display: none;">
                <input type="text" class="edit-comment-text" value="${comment.cmntCn}">
                <button type="button" class="btn btn-cancel-edit">취소</button>
                <button type="button" class="btn btn-save-edit">저장</button>
            </div>
        </div>
    </c:forEach>
</div>

<!-- 더보기 버튼 -->
<button id="loadMoreBtn" class="btn btn-primary">더보기</button>
   </div>
</div>

<script type="text/javascript">
var Toast = Swal.mixin({
	   toast: true,
	    position: 'center',
	    showConfirmButton: false,
	    timer: 2000
	});
// 이미지 처리 함수 (기존 유지)
function handleImg(e){
    let files = e.target.files;
    let fileArr = Array.prototype.slice.call(files);
    let accumStr = "";
    fileArr.forEach(function(f){
        if(!f.type.match("image.*")){
            alert("이미지 확장자만 가능합니다");
            return;
        }
        let reader = new FileReader();
        reader.onload = function(e){
            accumStr += "<img src='"+e.target.result+"'/>";
            $("#pImg").html(accumStr);
        }
        reader.readAsDataURL(f);
    });
}

$(document).ready(function(){
	// 게시글 삭제
	$('.cancel').on('click', function(event) {
	    Swal.fire({
	        title: '게시글을 삭제하시겠습니까?',
	        icon: 'warning',
	        showCancelButton: true,
	        confirmButtonColor: 'white',
	        cancelButtonColor: 'white',
	        confirmButtonText: '삭제',
	        cancelButtonText: '취소'
	    }).then((result) => {
	        if (result.isConfirmed) {
	            // Toast.fire() 실행
	            Toast.fire({
	                icon: 'success',
	                title: '리뷰가 삭제되었습니다.'
	            });

	            // 바로 폼 제출
	            $('#reviewDeletePost').submit(); // 폼 제출
	        }
	    });
	});


    
    
    
    $('.btn-Regist').on('click', function(event) {
        var username = "${pageContext.request.userPrincipal != null ? pageContext.request.userPrincipal.name : 'anonymousUser'}";

        if (prcUsername === "anonymousUser") {
            event.preventDefault(); // 기본 폼 제출 막기
            Swal.fire({
                title: '로그인 후 작성 할 수 있습니다.?',
                text: "로그인 페이지로 이동하시겠습니까?",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: 'white',
                cancelButtonColor: 'white',
                confirmButtonText: '이동',
                cancelButtonText: '취소'
                
              }).then((result) => {
                if (result.isConfirmed) {
                  window.location.href = "/security/login"
                }
              })
            return;
        }
    });
    $(document).on("click", '.close', function() {
        $(this).closest('.modal').modal('hide');
    });

  // 댓글 수정 버튼 클릭 시
     $(document).on("click", '.btn-edit-comment', function() {
         const commentItem = $(this).closest('.comment-item');
         commentItem.find('.comment-content').hide(); // 댓글 내용 숨기기
         commentItem.find('.edit-comment-form').show(); // 수정 폼 표시하기
         commentItem.find('.btn-edit-comment').hide(); 
         commentItem.find('.btn-delete-comment').hide(); 
     });
     // 댓글 수정 취소 버튼 클릭 시
     $(document).on("click", '.btn-cancel-edit', function() {
         const commentItem = $(this).closest('.comment-item');
         commentItem.find('.comment-content').show(); // 댓글 내용 표시
         commentItem.find('.edit-comment-form').hide(); // 수정 폼 숨기기
         commentItem.find('.btn-edit-comment').show(); 
         commentItem.find('.btn-delete-comment').show(); 
     });

  // 댓글 수정 저장 버튼 클릭 시
     $(document).on("click", '.btn-save-edit', function() {
         const commentItem = $(this).closest('.comment-item');
         commentItem.find('.comment-content').show(); // 댓글 내용 표시
         commentItem.find('.edit-comment-form').hide(); // 수정 폼 숨기기
         commentItem.find('.btn-edit-comment').show(); 
         commentItem.find('.btn-delete-comment').show(); 
         const cmntNo = commentItem.data('cmnt-no');
         const pstSn = $('#pstSn').val();
         const cmntCn = commentItem.find('.edit-comment-text').val();

         $.ajax({
             url: '/adm/freeBoard/updateComment',
             type: 'POST',
             contentType: 'application/json',
             data: JSON.stringify({
                 cmntNo: cmntNo,
                 pstSn: pstSn,
                 cmntCn: cmntCn
             }),
             beforeSend: function(xhr) {
                 xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
             },
             success: function(response) {
                 if (response === "success") {
                     commentItem.find('.comment-content').text(cmntCn).show(); 
                     commentItem.find('.edit-comment-form').hide();
                     Toast.fire({
          				icon:'success',
          				title:'댓글이 수정되었습니다.'
          			});  
                 } else {
                     alert('댓글 수정 실패');
                 }
             },
             error: function(xhr, status, error) {
                 alert('댓글 수정 실패: ' + error);
             }
         });
     });

     // 댓글 삭제 버튼 클릭 시
     $(document).on("click", '.btn-delete-comment', function() {
    	    const cmntNo = $(this).data('id');
    	    const pstSn = $('#pstSn').val();
    	    
    	    // cmntNo 값 확인
    	    console.log("댓글 번호 (cmntNo):", cmntNo);
    	    console.log("게시글 번호 (pstSn):", pstSn);
    	    
    	    // SweetAlert로 확인 창 표시
    	    Swal.fire({
    	        title: '댓글을 삭제하시겠습니까?',
    	        icon: 'warning',
    	        showCancelButton: true,
    	        confirmButtonColor: 'white',
    	        cancelButtonColor: 'white',
    	        confirmButtonText: '삭제',
    	        cancelButtonText: '취소'
    	         // 버튼 순서 거꾸로
    	    }).then((result) => {
    	        if (result.isConfirmed) {
    	            // 삭제 요청 진행
    	            $.ajax({
    	                url: '/adm/review/deleteCommentAdm',
    	                type: 'POST',
    	                data: {
    	                    cmntNo: cmntNo,
    	                    pstSn: pstSn
    	                },
    	                beforeSend: function(xhr) {
    	                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
    	                },
    	                success: function(response) {
    	                    if (response === "success") {
                                Toast.fire({
                                    icon: 'success',
                                    title: '댓글이 삭제되었습니다.'
                                }).then(() => {
                                    location.reload(); // 댓글 삭제 후 목록 갱신
                                });
    	                    } else {
    	                        Swal.fire('삭제 실패', '댓글 삭제 중 오류가 발생했습니다.', 'error');
    	                    }
    	                },
    	                error: function(xhr, status, error) {
    	                    Swal.fire('삭제 실패', '댓글 삭제 중 오류가 발생했습니다.', 'error');
    	                }
    	            });
    	        }
    	    });
    	});


    });
</script>
