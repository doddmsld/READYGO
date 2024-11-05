<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/ckeditor5/ckeditor.js"></script>
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
<style>
body {
    margin: 0;
    padding: 0;
    font-family: pretendard;
    background-color: #fff;
}

.container {
    width: 80%;
    margin: 0 auto;
    margin-left: 400px;
}

table {
    width: 80%;
    border-collapse: collapse;
    margin-top: 20px;
}

h1 {
    font-size: 28px;
    font-weight: bold;
    text-align: left;
    padding-top: 20px;
}

.search-container {
    display: flex;
    justify-content: center;
    margin: 40px 0 30px;
}

input[type="text"] {
    width: 200px;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    margin-bottom: 10px;
}

.search-button,
.filter-button {
    padding: 10px 20px;
    border: 1px solid #FD5D6C;
    border-radius: 5px;
    cursor: pointer;
    background-color: white;
    color: #FD5D6C;
    transition: background-color 0.3s, color 0.3s; 
}

.filter-button:hover {
    background-color: #FD5D6C;
    color: white;
    border: 1px solid #FD5D6C; 
}

table thead {
	background-color: rgba(253, 93, 108, 0.7);
	color: white;
}

table thead th, table tbody td {
    padding: 10px;
    font-size: 14px;
    border-bottom: 1px solid #ddd;
}

.pagination {
    display: inline-flex;
    padding-left: 0;
    list-style: none;
    border-radius: 0.25rem;
}

.pagination .page-item {
    margin: 0 5px;
}

.pagination .page-link {
    color: #FD5D6C;
    background-color: white;
    border: 1px solid #FD5D6C;
    padding: 8px 12px;
    text-decoration: none;
    transition: background-color 0.3s, color 0.3s;
    border-radius: 5px;
}

.pagination .page-item.active .page-link {
    background-color: #FD5D6C;
    color: white;
}

.pagination .page-link:hover {
    background-color: #FD5D6C;
    color: white;
}

.pagination .page-item.disabled .page-link {
    background-color: #f3f3f3;
    color: #ccc;
    cursor: not-allowed;
}

.pagination .page-item:first-child .page-link,
.pagination .page-item:last-child .page-link {
    border-radius: 5px;
}


.button-container {
    text-align: right;
    margin-top: 20px;
}

.page-item.active .page-link {
    color: #FD5D6C;
    background-color: rgba(253, 93, 108, 0.11);
    border-radius: 7px;
    border-color: #FD5D6C;
}
.report-Del,.limit-btn{
    padding: 10px 20px;
    border: 1px solid #B5B5B5;
    border-radius: 5px;
    cursor: pointer;
    background-color: white;
    color: #232323;
    transition: background-color 0.3s, color 0.3s; 
}
.report-Del:hover,.limit-btn:hover{
   background: #ECECEC;
   color: #232323;
   border: 1px solid #B5B5B5;
}
table tbody tr:hover {
    background-color: rgba(253, 93, 108, 0.1);
    transition: background-color 0.3s ease;
}
.pagination-wrapper tbody tr:hover {
    background-color: initial;
}
</style>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
	<header>
		<h1>신고 커뮤니티 관리</h1>
	</header>
	<table>
		<colgroup>
		    <col style="width: 7%;">
		    <col style="width: 7%;">
		    <col style="width: 10%;">
		    <col style="width: 10%;">
		    <col style="width: 23%;">
		    <col style="width: 13%;">
		    <col style="width: 8%;">
		    <col style="width: 10%;">
		    <col style="width: 10%;">
		</colgroup>
		<thead>
			<tr>
				<th style="text-align: center; font-size:18px;">분류</th>
				<th style="text-align: center; font-size:18px;">작성자</th>
				<th style="text-align: center; font-size:18px;">날짜</th>
				<th style="text-align: center; font-size:18px;">신고분류</th>
				<th style="text-align: center; font-size:18px;">신고내용</th>
				<th style="text-align: center; font-size:18px;">제한선택</th>
				<th style="text-align: center; font-size:18px;">제한</th>
				<th style="text-align: center; font-size:18px;">삭제</th>
				<th style="text-align: center; font-size:18px;">게시글</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="declarationVO" items="${reportBoardVOList}">
				<tr>
					<input type="hidden" id="dclrNo" name="dclrNo"value="${declarationVO.dclrNo}" />
					<td style="text-align: center;">${declarationVO.dclrField}</td>
					<td style="text-align: center;">${declarationVO.mbrId}</td>
					<td style="text-align: center;">${declarationVO.dclrDt}</td>
					<td style="text-align: center;">${declarationVO.dclrTp}</td>
					<td style="text-align: center;">${declarationVO.dclrCn}</td>
					<td style="text-align: center;">
						<select class="form-control category" name="comCode" id="comCode" required>
						    <option value="" selected disabled hidden>제한 선택</option>
						    <c:forEach var="codeVO" items="${codeVOList}">
						        <option value="${codeVO.comCode}">${codeVO.comCodeNm}</option>
						    </c:forEach>
						</select>
					</td>
					<td style="text-align: center;">
						<button class="filter-button limit-btn">제한</button>
					</td>
			        <td style="text-align: center;">
			        	<button class="filter-button report-Del">삭제</button>
			        </td>
			        <td style="text-align: center;">
			            <a href="${declarationVO.dclrUrl}" class="filter-button" style="text-decoration: none;">게시글</a>
			        </td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<div id="entDetailModal" class="modal" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">제출정보 조회</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p><strong>아이디:</strong> <span id="modal-entId"></span></p>
        <p><strong>기업 이름:</strong> <span id="modal-entNm"></span></p>
        <p><strong>대표자 이름:</strong> <span id="modal-entRprsntvNm"></span></p>
        <p><strong>전화번호:</strong> <span id="modal-entTel"></span></p>
        <p><strong>이메일:</strong> <span id="modal-entEmail"></span></p>
        <p><strong>주소:</strong> <span id="modal-entAddr"></span></p>
        <p><strong>우편번호:</strong> <span id="modal-entZip"></span></p>
        <p><strong>사업자등록번호:</strong> <span id="modal-entBrNo"></span></p>
        <p><strong>팩스 번호:</strong> <span id="modal-entFxnum"></span></p>
        <p><strong>직원 수:</strong> <span id="modal-entEmpCnt"></span></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
<!--페이지네이션 -->
<div class="card-body table-responsive p-0" style="display: flex; justify-content: center;">
    <table style="margin-bottom: 30px;" class="pagination-wrapper">
        <tr>
            <td colspan="4" style="text-align: center; border-bottom: none;">
                <div class="dataTables_paginate" id="example2_paginate" style="display: flex; justify-content: center; margin-top: 20px;">
                    <ul class="pagination">
                        <!-- 맨 처음 페이지로 이동 버튼 -->
                        <c:if test="${articlePage.currentPage gt 1}">
                            <li class="paginate_button page-item first">
                                <a href="/adm/reportBoard?currentPage=1"
                                   aria-controls="example2" data-dt-idx="0" tabindex="0" class="page-link">&lt;&lt;</a>
                            </li>
                        </c:if>

                        <!-- 이전 페이지 이동 버튼 -->
                        <c:if test="${articlePage.startPage gt 5}">
                            <li class="paginate_button page-item previous">
                                <a href="/adm/reportBoard?currentPage=${articlePage.currentPage - 5}"
                                   aria-controls="example2" data-dt-idx="0" tabindex="0" class="page-link">&lt;</a>
                            </li>
                        </c:if>

                        <!-- 페이지 번호 -->
                        <c:forEach var="pNo" begin="${articlePage.startPage}" end="${articlePage.endPage}">
                            <li class="paginate_button page-item ${pNo == articlePage.currentPage ? 'active' : ''}">
                                <a href="/adm/reportBoard?currentPage=${pNo}" aria-controls="example2" class="page-link">${pNo}</a>
                            </li>
                        </c:forEach>

                        <!-- 다음 페이지 이동 버튼 -->
                        <c:if test="${articlePage.endPage lt articlePage.totalPages}">
                            <li class="paginate_button page-item next">
                                <a href="/adm/reportBoard?currentPage=${articlePage.currentPage + 5}"
                                   aria-controls="example2" data-dt-idx="7" tabindex="0" class="page-link">&gt;</a>
                            </li>
                        </c:if>

                        <!-- 맨 마지막 페이지로 이동 버튼 -->
                        <c:if test="${articlePage.currentPage lt articlePage.totalPages}">
                            <li class="paginate_button page-item last">
                                <a href="/adm/reportBoard?currentPage=${articlePage.totalPages}"
                                   aria-controls="example2" data-dt-idx="7" tabindex="0" class="page-link">&gt;&gt;</a>
                            </li>
                        </c:if>        
                    </ul>
                </div>
            </td>
        </tr>
    </table>
</div>


<script type="text/javascript">
$(document).ready(function() {
    var Toast = Swal.mixin({
        toast: true,
        position: 'center',
        showConfirmButton: false,
        timer: 1500,
        
        didOpen: (toast) => {
            toast.addEventListener('mouseenter', Swal.stopTimer);
            toast.addEventListener('mouseleave', Swal.resumeTimer);
        }
    });
    $(document).on('click', '.limit-btn', function() {
        var selectedComCode = $(this).closest('tr').find('.category').val(); // 선택된 comCode 값 가져오기
        var mbrId = $(this).closest('tr').find('td:eq(1)').text(); // 두 번째 td (회원 ID) 가져오기
        var dclrNo = $(this).closest('tr').find('input[type="hidden"]').val(); // 해당 행의 dclrNo 값 가져오기

        if (selectedComCode) {
        	console.log("여기는옴");
            //신고 기각일때
            if (selectedComCode === "WAMA04") {
                Swal.fire({
                    title: '신고를 기각 하시겠습니까?',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: 'white',
                    cancelButtonColor: 'white',
                    confirmButtonText: '예',
                    cancelButtonText: '아니오',
                     // 버튼 순서 거꾸로
                }).then((result) => {
                    if (result.isConfirmed) {
                        $.ajax({
                            url: '/adm/reportBoardDel',
                            type: 'POST',
                            data: {
                                dclrNo: dclrNo // 삭제할 dclrNo 값 전달
                            },
                            beforeSend: function(xhr) {
                                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                            },
                            success: function(response) {
                                if (response === "success") {
                                    Toast.fire({
                          				icon:'success',
                          				title:'신고를 기각하셨습니다.'
                          			}).then(() => {
                                        location.reload();
                                    });
                                } else {
                                    Swal.fire(
                                        '삭제 실패',
                                        '삭제에 실패했습니다.',
                                        'error'
                                    );
                                }
                            },
                            error: function() {
                                Swal.fire(
                                    '오류',
                                    '오류가 발생했습니다.',
                                    'error'
                                );
                            }
                        });
                    }
                });
            } else {
                // 신고 기각 아닐때
                Swal.fire({
                    title: '회원 제한을 적용하시겠습니까?',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: 'white',
                    cancelButtonColor: 'white',
                    confirmButtonText: '예',
                    cancelButtonText: '아니오',
                     // 버튼 순서 거꾸로
                }).then((result) => {
                    if (result.isConfirmed) {
                        $.ajax({
                            url: '/adm/boardReport',
                            type: 'POST',
                            data: {
                                comCode: selectedComCode,
                                mbrId: mbrId
                            },
                            beforeSend: function(xhr) {
                                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                            },
                            success: function(response) {
                                if (response === "success") {
                                    Toast.fire({
                          				icon:'success',
                          				title:'회원'+mbrId+'님에게 제한이 적용되었습니다.'
                          			}).then(() => {
                                        // 첫 번째 AJAX 성공 후 자동으로 삭제 AJAX 요청을 실행
                                        $.ajax({
                                            url: '/adm/reportBoardDel',
                                            type: 'POST',
                                            data: {
                                                dclrNo: dclrNo // 삭제할 dclrNo 값 전달
                                            },
                                            beforeSend: function(xhr) {
                                                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                                            },
                                            success: function(response) {
                                                if (response === "success") {
                                                   location.reload(); // 삭제 후 페이지 새로고침
                                                } else {
                                                    Swal.fire(
                                                        '삭제 실패',
                                                        '삭제에 실패했습니다.',
                                                        'error'
                                                    );
                                                }
                                            },
                                            error: function() {
                                                Swal.fire(
                                                    '오류',
                                                    '오류가 발생했습니다.',
                                                    'error'
                                                );
                                            }
                                        });
                                    });
                                } else {
                                    Swal.fire(
                                        '제한 적용 실패',
                                        '회원 제한 적용에 실패했습니다.',
                                        'error'
                                    );
                                }
                            },
                            error: function() {
                                Swal.fire(
                                    '오류',
                                    '오류가 발생했습니다.',
                                    'error'
                                );
                            }
                        });
                    }
                });
            }
        } else {
            Swal.fire(
                '제한 종류를 선택하세요.',
                '',
                'info'
            );
        }
    });

    // 삭제 버튼 클릭 이벤트
    $(document).on('click', '.report-Del', function() {
        var dclrNo = $(this).closest('tr').find('input[type="hidden"]').val();

        Swal.fire({
            title: '정말 삭제하시겠습니까?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: 'white',
            cancelButtonColor: 'white',
            confirmButtonText: '예',
            cancelButtonText: '아니오',
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: '/adm/reportBoardDel',
                    type: 'POST',
                    data: {
                        dclrNo: dclrNo
                    },
                    beforeSend: function(xhr) {
                        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                    },
                    success: function(response) {
                        if (response === "success") {
                            Toast.fire({
                  				icon:'success',
                  				title:'신고가 삭제되었습니다.'
                  			}).then(() => {
                                location.reload();
                            });
                        } else {
                            Swal.fire(
                                '삭제 실패',
                                '삭제에 실패했습니다.',
                                'error'
                            );
                        }
                    },
                    error: function() {
                        Swal.fire(
                            '오류',
                            '오류가 발생했습니다.',
                            'error'
                        );
                    }
                });
            }
        });
    });
});
</script>
