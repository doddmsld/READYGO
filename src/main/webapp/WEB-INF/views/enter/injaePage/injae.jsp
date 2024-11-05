<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>인재 검색</title>
<link rel="stylesheet"
   href="<%=request.getContextPath()%>/resources/css/enter/injae.css" />
   <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/alert.css" />
</head>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript">
var Toast = Swal.mixin({
   toast: true,
   position: 'center',
   showConfirmButton: false,
   timer: 3000
   });

//모달 제어
document.addEventListener("DOMContentLoaded", function() {
    var modal = document.getElementById("scoutModal");
    var scoutButtons = document.querySelectorAll(".scout-button");
    var closeBtn = document.querySelector(".close");
    var cancelButton = document.getElementById("cancel-btn");

    // 모든 "스카우트 제안하기" 버튼에 클릭 이벤트 추가
    scoutButtons.forEach(function(button) {
        button.addEventListener("click", function() {
            modal.style.display = "block";
        });
    });

    // 닫기 버튼 클릭 시 모달 닫기
    closeBtn.onclick = function() {
        modal.style.display = "none";
    }

    // 취소 버튼 클릭 시 모달 닫기
    cancelButton.onclick = function() {
        modal.style.display = "none";
    }

    // 모달 외부 클릭 시 모달 닫기
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
});
document.addEventListener("DOMContentLoaded", function() {
    var modal = document.getElementById("scoutModal");
    var scoutButtons = document.querySelectorAll(".scout-button");
    var closeBtn = document.querySelector(".close");
    var cancelButton = document.getElementById("cancel-btn");
    var keywordInput = document.getElementById('keywordInput'); // 검색창 요소 가져오기
    var xBtn = document.querySelector(".x-btn"); // X 버튼 요소 가져오기

    // 모든 "스카우트 제안하기" 버튼에 클릭 이벤트 추가
    scoutButtons.forEach(function(button) {
        button.addEventListener("click", function() {
            modal.style.display = "block";
        });
    });

    // 닫기 버튼 클릭 시 모달 닫기
    closeBtn.onclick = function() {
        modal.style.display = "none";
    }

    // 취소 버튼 클릭 시 모달 닫기
    cancelButton.onclick = function() {
        modal.style.display = "none";
    }

    // X 버튼 클릭 시 검색란 비우기
    xBtn.onclick = function() {
        keywordInput.value = ""; // 검색창의 내용을 초기화
        updateCheckboxes(); // 체크박스 상태도 업데이트하여 초기화
    }

    // 모달 외부 클릭 시 모달 닫기
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }

    // 검색란의 값을 바탕으로 체크박스 상태 업데이트
    function updateCheckboxes() {
        let keywords = keywordInput.value.split(', ').filter(Boolean);
        let checkboxes = document.querySelectorAll('#downdrop input[type="checkbox"]');
        checkboxes.forEach((checkbox) => {
            let label = checkbox.closest('label');
            if (keywords.includes(checkbox.value)) {
                checkbox.checked = true;
                label.style.fontWeight = '700';
            } else {
                checkbox.checked = false;
                label.style.fontWeight = 'normal';
            }
        });
    }
});
</script>
<body>
   <sec:authentication property="principal" var="prc" />
   <c:if test="${prc ne 'anonymousUser'}">
      <input type="hidden" id="hasRoleEnter" value="${prc.authorities}" />
   </c:if>
   <div class="contain-box" style="display: flex;">
      <!-- 왼쪽 콘텐츠: 인재 검색 결과 -->
      <div class="left-content" style="flex: 3; margin-right: 20px;">
         <div class="box">
            <!-- 
            {entId=,keywordInput=}
             -->
            <form action="/enter/injaePost" method="post" id="searchForm">
               <div class="search">
                  <input type="hidden" id="entId" name="entId"
                  value="${prc.username}"/>
                  <div style="display: flex;position: relative;width: 910px;">
                     <input type="text" id="keywordInput"
                        placeholder="하나 이상의 자격조건 키워드를 포함" style="width: 100%;"> 
                     <button type="button" class="x-btn" 
                     style="border: 0; background-color: transparent;position: absolute;top: 5px; bottom: 5px;right: 2px;box-shadow:none;">
                        <img src="../resources/icon/x-img.png" alt="x" class="x-img" style="width: 23px; height: 23px;"/>
                     </button>   
                  </div>
                  
                     <button type="submit" id="sub-btn" class="sub-btn">검색</button>

                  <div id="downdrop" class="downdrop">
                     <!-- 알파벳 버튼 -->
                     <div class="alphabet-buttons"
                        style="display: flex; flex-direction: column; padding-right: 10px;">
                        <select class="AZSelect" size="10">
                           <option class="alphabet-button" data-letter="A">A</option>
                           <option class="alphabet-button" data-letter="B">B</option>
                           <option class="alphabet-button" data-letter="C">C</option>
                           <option class="alphabet-button" data-letter="D">D</option>
                           <option class="alphabet-button" data-letter="E">E</option>
                           <option class="alphabet-button" data-letter="F">F</option>
                           <option class="alphabet-button" data-letter="G">G</option>
                           <option class="alphabet-button" data-letter="H">H</option>
                           <option class="alphabet-button" data-letter="I">I</option>
                           <option class="alphabet-button" data-letter="J">J</option>
                           <option class="alphabet-button" data-letter="K">K</option>
                           <option class="alphabet-button" data-letter="L">L</option>
                           <option class="alphabet-button" data-letter="M">M</option>
                           <option class="alphabet-button" data-letter="N">N</option>
                           <option class="alphabet-button" data-letter="O">O</option>
                           <option class="alphabet-button" data-letter="P">P</option>
                           <option class="alphabet-button" data-letter="Q">Q</option>
                           <option class="alphabet-button" data-letter="R">R</option>
                           <option class="alphabet-button" data-letter="S">S</option>
                           <option class="alphabet-button" data-letter="T">T</option>
                           <option class="alphabet-button" data-letter="U">U</option>
                           <option class="alphabet-button" data-letter="V">V</option>
                           <option class="alphabet-button" data-letter="W">W</option>
                           <option class="alphabet-button" data-letter="X">X</option>
                           <option class="alphabet-button" data-letter="Y">Y</option>
                           <option class="alphabet-button" data-letter="Z">Z</option>
                        </select>
                     </div>
                     <!-- 체크박스가 포함된 드롭다운 오른쪽 -->
                     <div id="skillListContainer" class="checkbox-grid"
                        style="flex: 3; margin-left: 20px;">
                        <c:forEach var="skill" items="${skillList}">
                           <label data-letter="${skill.comCodeNm.charAt(0)}"> 
                              <input type="checkbox" name="keywordInput" value="${skill.comCodeNm}" />${skill.comCodeNm}
                           </label>
                        </c:forEach>
                     </div>
                  </div>
               </div>
               <sec:csrfInput />
            </form>
            
            <p class="total">전체  <b>${total}</b></p>
            <div style="display: flex; justify-content: center;">
               <div class="result">
                  <!-- 검색 결과 카드 -->
                  <c:forEach var="MemberVO" items="${articlePage.content}"
                     varStatus="status">
                     <div class="resultCard">
                        <div class="profile">
                           <c:if test="${MemberVO.fileGroupSn eq null}">
                              <img src="../resources/icon/인재.png" alt="img">
                           </c:if>
                           <c:if test="${MemberVO.fileGroupSn ne null }">
                              <img src="${MemberVO.fileGroupSn}" alt="img">
                           </c:if>
                           <div class="profile-info">
                              <div style="display: flex;">
                              <input type="hidden" class="mbrEml" value="${MemberVO.mbrEml}">
                              <input type="hidden" class="mbrId" value="${MemberVO.mbrId}">
                                 <div class="name">${MemberVO.mbrNm}</div>
                                 &nbsp;&nbsp;
                                 <p class="details">${MemberVO.mbrBrdt}세 ·
                                    ${MemberVO.career}</p>
                              </div>
                              <div class="details">${MemberVO.tpbizSeCd}</div>
                              <div class="skills">
                                 <span class="skill-badge">${MemberVO.skCd}</span>
                              </div>
                           </div>
                        </div>
                        <div class="actions">
                           <a href="/member/profile?mbrId=${MemberVO.mbrId}"
                              target="_blank"><button class="profileGo">프로필</button></a>
                           <button class="scout-button">스카우트 제안</button>
                        </div>
                     </div>
                  </c:forEach>
                    <!-- 검색 조건이 없을 때, 카드 위에 메시지 표시 -->
                    <c:if test="${empty articlePage.content}">
                        <div class="resultCard" style="text-align: center;">
                            <p>검색 조건이 없습니다.</p>
                        </div>
                    </c:if>                  
               </div>
            </div>
            <!-- 페이지네이션 -->
            <div class="card-body table-responsive p-0"
               style="display: flex; justify-content: center;">
               <table style="margin-bottom: 30px;">
                  <tr>
                     <td colspan="4" style="text-align: center;">
                        <div class="dataTables_paginate" id="example2_paginate"
                           style="display: flex; justify-content: center; margin-top: 20px;">
                           <ul class="pagination">

                              <!-- 맨 처음 페이지로 이동 버튼 -->
                              <c:if test="${articlePage.currentPage gt 1}">
                                 <li class="paginate_button page-item first">
                                 <c:if test="${empty param.keywordInput}">
                                    <a href="/enter/injae?entId=${prc.username}&currentPage=1"
                                       aria-controls="example2" data-dt-idx="0" tabindex="0"
                                       class="page-link">&lt;&lt;</a>
                                 </c:if>
                                 <c:if test="${not empty param.keywordInput}">
                                    <a href="/enter/injae?entId=${prc.username}&currentPage=1&keywordInput=${keyword}"
                                       aria-controls="example2" data-dt-idx="0" tabindex="0"
                                       class="page-link">&lt;&lt;</a>
                                 </c:if>
                                 </li>
                              </c:if>

                              <!-- 이전 페이지 버튼 -->
                              <c:if test="${articlePage.startPage gt 1}">
                                 <li class="paginate_button page-item previous" id="example2_previous">
                                    <c:if test="${empty param.keywordInput}">
                                       <a href="/enter/injae?entId=${prc.username}&currentPage=${(articlePage.startPage - 1) lt 1 ? 1 : (articlePage.startPage - 1)}"
                                       aria-controls="example2" data-dt-idx="0" tabindex="0"
                                       class="page-link">&lt;</a>
                                    </c:if>
                                    <c:if test="${not empty param.keywordInput}">
                                       <a href="/enter/injae?entId=${prc.username}&currentPage=${(articlePage.startPage - 1) lt 1 ? 1 : (articlePage.startPage - 1)}
                                       &keywordInput=${keyword}"
                                       aria-controls="example2" data-dt-idx="0" tabindex="0"
                                       class="page-link">&lt;</a>
                                    </c:if>
                                 </li>
                              </c:if>

                              <!-- 페이지 번호 -->
                              <c:forEach var="pNo" begin="${articlePage.startPage}" end="${articlePage.endPage}">
                                 <li class="paginate_button page-item ${pNo == articlePage.currentPage ? 'active' : ''}">
                                    <c:if test="${empty param.keywordInput}">
                                       <a href="/enter/injae?entId=${prc.username}&currentPage=${pNo}"
                                       aria-controls="example2" class="page-link">${pNo}</a>
                                    </c:if>
                                    <c:if test="${not empty param.keywordInput}">
                                       <a href="/enter/injae?entId=${prc.username}&currentPage=${pNo}&keywordInput=${keyword}"
                                       aria-controls="example2" class="page-link">${pNo}</a>
                                    </c:if>
                                 </li>
                              </c:forEach>

                              <!-- 다음 페이지 버튼 -->
                              <c:if test="${articlePage.endPage lt articlePage.totalPages}">
                                 <li class="paginate_button page-item next" id="example2_next">
                                    <c:if test="${empty param.keywordInput}">
                                       <a href="/enter/injae?entId=${prc.username}&currentPage=${articlePage.startPage+5}"
                                       aria-controls="example2" data-dt-idx="7" tabindex="0"
                                       class="page-link">&gt;</a>
                                    </c:if>
                                    <c:if test="${not empty param.keywordInput}">
                                       <a href="/enter/injae?entId=${prc.username}&currentPage=${articlePage.startPage+5}
                                       &keywordInput=${keyword}"
                                       aria-controls="example2" data-dt-idx="7" tabindex="0"
                                       class="page-link">&gt;</a>
                                    </c:if>
                                 </li>
                              </c:if>

                              <!-- 맨 마지막 페이지로 이동 버튼 -->
                              <c:if
                                 test="${articlePage.currentPage lt articlePage.totalPages}">
                                 <li class="paginate_button page-item last">
                                    <c:if test="${empty param.keywordInput}">
                                       <a href="/enter/injae?entId=${prc.username}&currentPage=${articlePage.totalPages}"
                                       aria-controls="example2" data-dt-idx="7" tabindex="0"
                                       class="page-link">&gt;&gt;</a>
                                    </c:if>
                                    <c:if test="${not empty param.keywordInput}">
                                       <a href="/enter/injae?entId=${prc.username}&currentPage=${articlePage.totalPages}
                                       &keywordInput=${keyword}"
                                       aria-controls="example2" data-dt-idx="7" tabindex="0"
                                       class="page-link">&gt;&gt;</a>
                                    </c:if>
                                 </li>
                              </c:if>

                           </ul>
                        </div>
                     </td>
                  </tr>
               </table>
            </div>

            <!-- 모달 창 구조 -->
            <div id="scoutModal" class="modal"
               style="display: none; z-index: 999;">
               <div class="modal-content">
                  <div style="display: flex;justify-content: space-between;
                           background: linear-gradient(to right, #2CCFC3, #24D59E);height: 100px;border-top-left-radius: 8px; border-top-right-radius: 8px; ">
                     <h2>스카우트 제안</h2>
                     <span class="close">&times;</span>
                  </div>

                  <form id="scoutForm" enctype="multipart/form-data">
                     <div class="scout-div">
                        <label for="title" class="scout-title"><span
                           style="color: red;">*</span> 스카우트 제안 제목 </label> 
                           <input type="text" id="title"
                           name="title" placeholder="제안 시 해당 인재에게 보여지므로, 신중히 작성해주세요.">
                           <input type="hidden" id="mbrIdForm" name="mbrId">
                           <input type="hidden" id="mbrEmlForm"name="mbrEml">
                           <input type="hidden" id="entId" name="entId" value="${prc.username}">
                     </div>
                        
                     <div class="scout-div">
                        <label for="jobPost" class="scout-title">&nbsp;&nbsp;&nbsp;스카우트 제안 공고 </label> 
                        <select
                           id="jobPost" name="jobPost">
                           <option value="" disabled selected>공고를 선택해주세요.</option>
                           <!-- 공고 리스트를 JSP에서 동적으로 추가 -->
                           <c:forEach var="pbanc" items="${pbancList}">
                              <option value="${pbanc.pbancTtl}">${pbanc.pbancTtl}</option>
                           </c:forEach>
                        </select>
                     </div>

                     <div class="scout-div">
                        <label for="content" class="scout-title"> <span
                           style="color: red;">*</span> 스카우트 제안 내용</label>
                        <textarea id="content" name="content"
                           placeholder="해당 인재에게 전달하고자 하는 주요 제안 정보를 작성해주세요.&#13;&#10;예시) 회사 정보, 직급 및 직책, 연봉 등"></textarea>
                     </div>

                     <div class="scout-div">
                        <label for="file" class="scout-title">&nbsp;&nbsp;&nbsp;스카우트 제안 첨부파일</label> <input
                           type="file" id="file" name="file">
                     </div>

                     <div
                        style="display: flex; justify-content: space-evenly; margin-top: 30px;">
                        <button type="button" id="cancel-btn">취소</button>
                        <button type="submit" id="submit-btn">제안</button>
                     </div>
                  </form>
               </div>
            </div>
         </div>
      </div>

      <!-- 오른쪽 콘텐츠: 추천 인재 -->
      <div class="right-sidebar">
         <div style="display: flex; justify-content: space-between;">
            <h6>추천 인재</h6>
            <a href="/enter/injae?entId=${prc.username}">
            <img alt=""   src="../resources/icon/refresh.png" class="refresh"></a>
         </div>
         <c:forEach var="recommend" items="${recommendList}"
            varStatus="status">
            <a href="/member/profile?mbrId=${recommend.mbrId}" target="_blank">
               <button class="re-btn">
                  <div class="recommend-list">
                     <div>
                        <c:if test="${recommend.fileGroupSn eq null}">                        
                           <img class="re-img" src="../resources/icon/인재.png" alt="img">
                        </c:if>
                        <c:if test="${recommend.fileGroupSn ne null}">                        
                           <img class="re-img" src="${recommend.fileGroupSn}" alt="img">
                        </c:if>
                     </div>
                     <div class="recommend-info">
                        <div>
                           <p style="font-weight: 600; font-size: 15px;">
                              ${recommend.mbrNm} · ${recommend.career}</p>
                        </div>
                        <div>
                           <p style="font-size: 12px;">${recommend.tpbizSeNm}</p>
                           <p style="font-size: 12px;">${recommend.skCd}</p>
                        </div>
                     </div>
                  </div>
               </button>
            </a>
         </c:forEach>
      </div>

   </div>

</body>
<script>
//검색란에 글씨가 적혀있을때만 버튼 활성화
document.addEventListener("DOMContentLoaded", function() {
    var keywordInput = document.getElementById('keywordInput');
    var searchButton = document.querySelector('button.sub-btn');

    // 키워드 입력란에 내용이 있을 때만 버튼 활성화
    keywordInput.addEventListener('input', function() {
        if (keywordInput.value.trim() === "") {
            searchButton.disabled = true;
        } else {
            searchButton.disabled = false;
        }
    });

    // 페이지 로드 시 검색 버튼을 초기 비활성화 상태로 설정
//     searchButton.disabled = true;
});
document.addEventListener("DOMContentLoaded", function() {
    // 검색창을 클릭하면 드롭다운이 나타나거나 사라지게 함
    var keywordInput = document.getElementById('keywordInput');
    var downdrop = document.getElementById('downdrop');
    var selectBox = document.querySelector('select');
    var checkboxes = document.querySelectorAll('#downdrop input[type="checkbox"]');

    keywordInput.addEventListener('click', function() {
        downdrop.classList.toggle('show');  // 드롭다운 토글
    });
    // 셀렉트박스에서 선택할 때마다 체크박스를 필터링
    selectBox.addEventListener('change', function() {
        var selectedLetter = this.value;  // 선택된 값(A, B, C 등)
        const labels = document.querySelectorAll('#skillListContainer label');

        labels.forEach(label => {
            const labelLetter = label.getAttribute('data-letter');
            label.style.display = (labelLetter === selectedLetter) ? 'block' : 'none';
        });
    });

    // 체크박스 클릭 시 검색란에 추가 및 글씨체 굵게 변경
    checkboxes.forEach((checkbox) => {
        checkbox.addEventListener('change', function() {
            updateKeywordInput();
        });
    });

    // 검색란에 입력된 값이 변경될 때 체크박스를 업데이트
    keywordInput.addEventListener('input', function() {
        updateCheckboxes();
    });

    // 드롭다운 외부 클릭 시 드롭다운 숨기기
    window.onclick = function(event) {
        if (!event.target.matches('#keywordInput') && !event.target.closest('.downdrop')) {
            if (downdrop.classList.contains('show')) {
                downdrop.classList.remove('show');
            }
        }
    };

    // 검색 버튼 클릭 시 드롭다운 닫기
    document.querySelector('button[type="button"]').addEventListener('click', function() {
        if (downdrop.classList.contains('show')) {
            downdrop.classList.remove('show');
        }
//         search();
    });
    
   //스카우트 모달 띄우기 전 데이터 보내기
   $('.scout-button').on('click',function(){
      
        let mbrId = $(this).closest('.resultCard').find('.mbrId').val();
        let mbrEml = $(this).closest('.resultCard').find('.mbrEml').val();
        
        console.log('Member ID: ' + mbrId);
        console.log('Member Email: ' + mbrEml);
        
        $("#mbrIdForm").val(mbrId);
        $("#mbrEmlForm").val(mbrEml);
   })
   
//     // 스카우트 폼 제출 처리
//     document.getElementById('submit-btn').addEventListener('click', function(e) {
//         e.preventDefault();
//         var formData = new FormData(document.getElementById('scoutForm'));
//         let mbrEml = $('#mbrEmlForm').val();
//         formData.append('recipientEmail', mbrEml);  // 수신자 이메일 추가
//         $.ajax({
//             url: '/enter/sendScoutEmail',
//             type: 'POST',
//             data: formData,
//             processData: false,
//             contentType: false,
//             beforeSend: function(xhr) {
//                 xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
//             },
//             success: function(response) {
//                 alert('이메일이 성공적으로 전송되었습니다.');
//                 document.getElementById('scoutModal').style.display = 'none';
//             },
//             error: function() {
//                 alert('이메일 전송에 실패했습니다. 다시 시도해주세요.');
//             }
//         });
//     });
   

   
   $(document).on("click", "#submit-btn", function(event) {
       event.preventDefault(); // 기본 폼 전송 방지
       var formData = new FormData(document.getElementById('scoutForm'));
       let mbrEml = $('#mbrEmlForm').val();
       formData.append('recipientEmail', mbrEml);  // 수신자 이메일 추가
       
       $("#scoutForm").attr("action", "/enter/sendScoutEmail");

       // Swal.fire 사용하여 수정 확인창 표시
       Swal.fire({
           title: '스카우트 제안하시겠습니까?',
           icon: 'question',
           showCancelButton: true,
           confirmButtonColor: 'white',
           cancelButtonColor: 'white',
           confirmButtonText: '예',
           cancelButtonText: '아니오'
       }).then((result) => {
           if (result.isConfirmed) {
               $.ajax({
                   url: '/enter/sendScoutEmail',
                   type: 'POST',
                   data: formData,
                   processData: false,
                   contentType: false,
                   beforeSend: function(xhr) {
                       xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                   },
                    success: function(response) {
                        Toast.fire({
                            icon: 'success',
                            title: '스카우트 제안 성공'
                        });
                        document.getElementById('scoutModal').style.display = 'none';
                    },
                    error: function() {
                        Toast.fire({
                            icon: 'error',
                            title: '스카우트 제안 실패'
                        });
                   }
               });
           }
       });
   });

   
    // 체크박스를 업데이트하여 검색란에 값을 반영
    function updateKeywordInput() {
        let selectedKeywords = [];
        checkboxes.forEach((box) => {
            let label = box.closest('label');
            if (box.checked) {
                selectedKeywords.push(box.value);
                label.style.fontWeight = '700'; // 체크된 경우 글씨 굵게
            } else {
                label.style.fontWeight = 'normal'; // 체크 해제되면 원래대로
            }
        });
        keywordInput.value = selectedKeywords.join(', ');
    }

    // 검색란의 값을 바탕으로 체크박스 상태 업데이트
    function updateCheckboxes() {
        let keywords = keywordInput.value.split(', ').filter(Boolean);
        checkboxes.forEach((checkbox) => {
            let label = checkbox.closest('label');
            if (keywords.includes(checkbox.value)) {
                checkbox.checked = true;
                label.style.fontWeight = '700';
            } else {
                checkbox.checked = false;
                label.style.fontWeight = 'normal';
            }
        });
    }

    // 검색 기능: 선택된 체크박스를 출력
//     function search() {
//         const selectedKeywords = keywordInput.value;
//         alert("선택된 키워드: " + selectedKeywords);
//     }
});
$(function(){
   // 스카우트 폼 제출 처리
    document.getElementById('sub-btn').addEventListener('click', function(e) {
        e.preventDefault();
        let val = $('#keywordInput').val();
        console.log("val.length : " + val.length);
      if(val.length>0){
         document.getElementById("searchForm").submit();
      }else{
         location.href="/enter/injae?entId=${prc.username}";
      }
    });
});
</script>
</html>
