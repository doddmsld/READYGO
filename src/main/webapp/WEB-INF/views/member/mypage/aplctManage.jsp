<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>   

<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/member/aplctManage.css" />
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> 
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/sweetalert2.js"></script>
<script>
//sweetAlert 창 띄우기 변수
var Toast = Swal.mixin({
	    toast: true,
	    position: 'center',
	    showConfirmButton: false,
	    timer: 3000
	});	
$(function(){
    $(".aplctCancel").on("click", function() {
        // data-pbancttl 속성에서 pbancTtl 값을 가져옴
        let pbancTtl = $(this).data("pbanc-ttl");
        let pbancNo = $(this).data("pbanc-no")
        let entNm = $(this).data("ent-nm");
        let mbrId = $(this).data("mbr-id")
              
        console.log("mbrId: " + mbrId);
        console.log("pbancNo: " + pbancNo);
        
        // 만약 data 속성에서 값을 가져올 수 없는 경우를 대비해 parent().siblings().eq(0)로 가져오는 부분 수정
        if (!pbancTtl) {
            pbancTtl = $(this).parent().siblings().eq(0).html();
        }
        if (!entNm) {
            entNm = $(this).parent().siblings(".entNm").html();
        }
        
        // 데이터 생성
        let data = {
            "pbancTtl": pbancTtl
        };
        
        // modal에 반영
        $("#modalPbancNo").val(pbancNo);
        $("#modalPbancTtl").val(pbancTtl);
        $("#modalEntNm").val(entNm); 
        $("#modalMbrId").val(mbrId);
        
        // 또는 모달의 텍스트로 표시하고 싶다면 아래 코드 사용
        // $("#modalCancel .modal-body").prepend("<p>공고 제목: " + pbancTtl + "</p>");
    });
   
    $(document).on("click", "#submit", function() {
    	  let mbrId = $("#modalMbrId").val(); 
    	  let pbancNo = $("#modalPbancNo").val();
    	  let aplctCancelCd = $("#codeCom").val(); 
    	  
    	  if (!aplctCancelCd ) {
          	Toast.fire({
  				icon:'warning',
  				title:'취소사유를 선택해주세요'
  			});
              return;
          }
    	  
    	
    	
    	let data = {
    			'mbrId': mbrId,
    			'pbancNo':pbancNo,
    			'aplctCancelCd':aplctCancelCd
    	}
    	Swal.fire({
            title: '추가 하시겠습니까?',
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
        		    	url:'/member/aplctDelete',
        	            contentType: 'application/json;charset=utf-8',
        	            type: 'POST',
        	            dataType: 'json',
        	            data: JSON.stringify(data),
        	            beforeSend:function(xhr){
        					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
        				},
        				success:function(result){
        					console.log("result",result)
        					Toast.fire({
        						icon:'success',
        						title:'취소 성공'
        					});
        					 location.reload();  // 등록 후 페이지 새로고침
        				},
        				error: function(xhr, status, error) {
        	            	Toast.fire({
        						icon:'warning',
        						title:'추가 실패'
        					});
        	            }
        		    	
        		    })
        		  
        	  }
          });
	    
    })

  $(".pbanc-ttl").on("click",function(){
	  var pbancNo = $(this).data("pbancno");
	  window.location.href = '/enter/pbancDetail?pbancNo=' + pbancNo; 
  })
//pdf다운로드
	//data-rsm-no="24"
	//클래스 속성의 값이 pdfDownAlink인 요소들 중에서 클릭한 바로 그 요소(this)의 data
	$(".pdfDownAlink").on("click",function(){
		let rsmNo = $(this).data("rsmNo");
		var popup = window.open('', '이력서 보기', 'width=1,height=1');
		//밖으로 꺼낸 폼의 text박스의 값으로 대입
		$("#frmRsmNo").val(rsmNo);
		//<form id="frm"
		$("#frm").attr("target", '이력서 보기');
		$("#frm").submit();
	});
    
    $('#modalCancel').on('hidden.bs.modal', function () {
        $(this).find('select[name="aplctCancelCd"]').val('');
    });
  
});


</script>
<form id="frm" action="/member/resumeDownload" method="post">
	<input type="hidden" name="rsmNo" id="frmRsmNo" value="" />
	<sec:csrfInput/>
</form>
<br>
<div class="container" style="position: relative; bottom: 35px;">
   <p id="h3">입사 지원 관리</p>
   <br><br>
   <p id="count">전체&nbsp;&nbsp;<span id="total">${articlePage.total}</span></p><br>
   <div id="filter">
		<form id="filterForm" action="/member/aplctManage" method="GET">

		<div style="position: relative; right: 310px; top: 40px;">
			<input type="date" id="dateInput1" name="dateInput1">&nbsp;~&nbsp;

			<input type="date" id="dateInput2" name="dateInput2">
		</div>	
			<div style="position: relative; top: 1px;">
				<input type="text" id="keywordInput" name="keywordInput"
					placeholder="검색" value="${param.keywordInput}">
				<button class="search" type="submit">검색</button>
				<span class="material-symbols-outlined" id="sricon">search</span>
			</div>
		</form>
	</div>
   <div class="card-body table-responsive p-0">
            <table class="table table-hover text-nowrap">
            <thead>
               <tr>
                  <th>지원일자</th>
                  <th class="entNm" style="font-size: 16px;">기업명</th>
                  <th class="aplct">지원내역</th>
                  <th>관리</th>
               </tr>
            </thead>
            <tbody>
            <c:choose>
			<c:when test="${not empty articlePage.content}">
            <c:forEach var="aplctVO" items="${articlePage.content}" varStatus="stat">
               <tr style="border-bottom: 1px solid #dee2e6;">
                  <td class="appymd"><fmt:formatDate value="${aplctVO.aplctAppymd}" pattern="yyyy.MM.dd"/></td>
                  <td class="entNm">${aplctVO.entNm}</td>
                  
                 	<td class="aplct">
						<span class="pbanc-ttl" data-pbancno="${aplctVO.pbancNo}">
						<a target="_blank" href="/enter/pbancDetail?pbancNo=${aplctVO.pbancNo}">${aplctVO.pbancTtl}</a></span><br>
							<span class="material-symbols-outlined">clinical_notes</span>
							<span>
							<a id="aplcont1" class="pdfDownAlink" data-rsm-no="${aplctVO.rsmNo}">${aplctVO.rsmTtl}</a></span>
										   &nbsp;&nbsp;&nbsp;
					        <span class="material-symbols-outlined">clinical_notes</span>
					        <span>
					        	<c:choose>
		                            <c:when test="${not empty aplctVO.fileDetailVOList}">
		                                <c:forEach var="file" items="${aplctVO.fileDetailVOList}">
		                                    <a href="/download?fileName=${file.filePathNm}">
							                    <span id="aplcont2">${file.orgnlFileNm}</span>
							                </a>
		                                </c:forEach>
		                            </c:when>
		                            <c:otherwise>
		                                <span id="aplcont2">-</span>
		                            </c:otherwise>
	                       	    </c:choose>
					        </span>
								&nbsp;&nbsp;&nbsp;
							<span id="aplcont3">지원분야 : ${aplctVO.rcritNm}</span>			   
						</td>
                  
                  <td>
                     <c:choose>
                        <c:when test="${not empty aplctVO.aplctCancelCd}">
                           <span class="btn btn-default" id="cancelSuc">취소완료</span>
                        </c:when>
                        <c:otherwise>
                           <button type="button" class="btn btn-default aplctCancel" data-toggle="modal" 
                              data-target="#modalCancel" id="btnCancel" 
                              data-pbanc-no="${aplctVO.pbancNo}"
                              data-pbanc-ttl="${aplctVO.pbancTtl}" 
                              data-ent-nm="${aplctVO.entNm}" 
                              data-mbr-id="${aplctVO.mbrId}">지원취소</button>
                        </c:otherwise>
                     </c:choose>
                  </td>
                                    
               </tr>
               </c:forEach>
            </c:when>
				<c:otherwise>
					<tr>
						<td id="noSrc"colspan="4">검색 결과가 없습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
            </tbody>
            <c:if test="${not empty articlePage.content}">
            <!-- ///////////////////// 페이징 ///////////////////// -->
            <tfoot>
               <tr>
                  <td colspan="4" style="text-align: center; border-top: 1px solid #232323;">
                     <div class="dataTables_paginate" id="example2_paginate"
                        style="display: flex; justify-content: center; margin-top:10px;">
                        <ul class="pagination">
                                       <br>
                        <!-- 맨 처음 페이지로 이동 버튼 -->
                        <c:if test="${articlePage.currentPage gt 1}">
                            <li class="paginate_button page-item first">
                                <a href="/member/aplctManage?mbrId=${param.mbrId}&currentPage=1&keywordInput=${param.keywordInput}&dateInput1=${param.dateInput1}&dateInput2=${param.dateInput2}"
                                   aria-controls="example2" data-dt-idx="0" tabindex="0" class="page-link">&lt;&lt;</a>
                            </li>
                        </c:if>

                           <!-- 이전 페이지 버튼 -->
                           <c:if test="${articlePage.startPage gt 1}">
                               <li class="paginate_button page-item previous" id="example2_previous">
                                    <a href="/member/aplctManage?mbrId=${param.mbrId}&currentPage=${(articlePage.startPage - 1) lt 1 ? 1 : (articlePage.startPage - 1)}&keywordInput=${param.keywordInput}&dateInput1=${param.dateInput1}&dateInput2=${param.dateInput2}"
                                      aria-controls="example2" data-dt-idx="0" tabindex="0" class="page-link">&lt;</a>
                               </li>
                           </c:if>
                           
                           <!-- 페이지 번호 -->
                           <c:forEach var="pNo" begin="${articlePage.startPage}" end="${articlePage.endPage}">
                               <li class="paginate_button page-item ${pNo == articlePage.currentPage ? 'active' : ''}">
                                   <a href="/member/aplctManage?mbrId=${param.mbrId}&currentPage=${pNo}&keywordInput=${param.keywordInput}&dateInput1=${param.dateInput1}&dateInput2=${param.dateInput2}" 
                                   aria-controls="example2" class="page-link">${pNo}</a>
                               </li>
                           </c:forEach>
                           
                           <!-- 다음 페이지 버튼 -->
                           <c:if test="${articlePage.endPage lt articlePage.totalPages}">
                               <li class="paginate_button page-item next" id="example2_next">
                                   <a href="/member/aplctManage?mbrId=${param.mbrId}&currentPage=${articlePage.startPage+5}&keywordInput=${param.keywordInput}&dateInput1=${param.dateInput1}&dateInput2=${param.dateInput2}"
                                      aria-controls="example2" data-dt-idx="7" tabindex="0" class="page-link">&gt;</a>
                               </li>
                           </c:if>
                           
                           <!-- 맨 마지막 페이지로 이동 버튼 -->
                        <c:if test="${articlePage.currentPage lt articlePage.totalPages}">
                            <li class="paginate_button page-item last">
                                <a href="/member/aplctManage?mbrId=${param.mbrId}&currentPage=${articlePage.totalPages}&keywordInput=${param.keywordInput}&dateInput1=${param.dateInput1}&dateInput2=${param.dateInput2}"
                                   aria-controls="example2" data-dt-idx="7" tabindex="0" class="page-link">&gt;&gt;</a>
                            </li>
                        </c:if>

                        </ul>
                     </div>
                  </td>
               </tr>
            </tfoot>
            </c:if>
      </table>
      </div>
<!-- 지원 취소 모달 시작 ///////////////////////////////// -->
<div class="modal fade" id="modalCancel">
  <div class="modal-dialog">
    <div class="modal-content">
     <form id="cancelForm" action="/member/aplctDelete?${_csrf.parameterName}=${_csrf.token}" method="post"> <!-- form 시작 -->
      <div class="modal-header" style="margin-bottom: 10px; height:62px;">
         <span id="title" style="color:#232323; margin-left:300px; padding: 0px 0 5px 0; font-size: 22px; font-weight: 600;">지원 취소</span>
      </div>
      <div class="modal-body">
        <p>
           <label style="margin-right:45px;">기업명</label>
           <input type="text" id="modalEntNm" readonly/><br>
           
           <label>공고 제목</label>
           <input type="text" id="modalPbancTtl" readonly/><br>
           
           <input type="hidden" name="mbrId" id="modalMbrId"/>
           <input type="hidden" name="pbancNo" id="modalPbancNo"/>
           
           <label style="position: relative; left: 10px;">취소 사유<span class="required">*</span></label>
           <select name="aplctCancelCd" id="codeCom" required>
              <option value="" selected disabled>취소 사유를 선택해주세요</option>
              <c:forEach var="codeVO" items="${cancelList}">
                 <option value="${codeVO.comCode}">${codeVO.comCodeNm}</option>
              </c:forEach>
           </select>
        </p>
      </div>
      <div id="control">
        <button type="button" id="close" class="btn btn-default" data-dismiss="modal">취소</button>
        <button type="button" id="submit"  class="btn btn-primary">확인</button>
      </div>
      <sec:csrfInput />
      </form>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
</div>
<!-- /.modal -->            
</div>

