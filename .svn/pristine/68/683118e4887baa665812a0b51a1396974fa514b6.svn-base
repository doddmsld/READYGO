<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>   

<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/member/aplctList.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/alert.css" />
<%-- <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/member/recentViewList.css"/> --%>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,200,0,0&icon_names=delete" />
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> 
<script type="text/javascript" src="/resources/js/sweetalert2.js"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/js.cookie.min.js"></script>

<script>
var Toast = Swal.mixin({
    toast: true,
    position: 'center',
    showConfirmButton: false,
    timer: 3000
});	
//onPageLoad 함수 정의
$(function(){

	 console.log("Page has loaded successfully.");
 // 페이지가 로드된 후 실행할 로직을 여기에 추가하세요.

        // 쿠키에서 최근 본 공고 목록 가져오기
        let pbancNoList = Cookies.get('pbancNoList') ? JSON.parse(Cookies.get('pbancNoList')) : [];
        console.log("pbancNoList from cookie:", pbancNoList);
        // 공고 수를 테이블 위에 표시
        if (pbancNoList.length > 0) {
            $('#pbancCount').html(pbancNoList.length);
        } 

        // 만약 최근 본 공고가 없다면 메시지를 표시
        if (pbancNoList.length === 0) {
            $('#pbancList').html('<li>최근 본 공고가 없습니다.</li>');
            return;
        }	
        $.ajax({
        	url:"/member/getPbancRecent",
        	contentType:"application/json;charset=utf-8",
        	data:JSON.stringify(pbancNoList),
        	type:"POST",
        	dataType:"json",
        	beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
        	success:function(result){
        		console.log("result : ", result);
        		 console.log("AJAX 요청 성공, 결과: ", result);  // 성공 시 콘솔에 로그 출력
        		// 서버로부터 받은 공고 정보를 모달에 추가
                let html = ''; 
                if (result.length > 0) {
                    result.forEach(function(pbanc) {
                        
                        let pbancDdlnDt = calculateDDay(pbanc.pbancDdlnDt);

                     // 각 필드가 null 또는 undefined인 경우 기본값으로 표시
                        let title = pbanc.pbancTtl ? pbanc.pbancTtl : "제목 없음";
                        let region = pbanc.pbancRprsrgn ? pbanc.pbancRprsrgn : "지역 정보 없음";
                        let period = pbanc.pbancRcptPd ? pbanc.pbancRcptPd : "접수 기간 정보 없음";

//                      '<span>'+result.length+'</span>'
                        html += '<div class="RBox">' +
		                        '<table class="table rcTable">' +  
				                        '<tr class="t1">' +          
				                            '<td class="rc1">'+
				                        		 '<span class="entNm" style="color:#232323;">'+ pbanc.entNm +'</span><br>'+
				                            '</td>' +             
				                            '<td class="t2">' +             
				                            	 '<span class="pbancRprsDtyNm">' + pbanc.pbancRprsDtyNm + '</span>'+
				                            '</td>' +             
				                            '<td class="td1">'+
						                        '<a target="_blank" href="/enter/pbancDetail?pbancNo=' + pbanc.pbancNo + '">' +
				                            		'<span class="pbancTtl">' + pbanc.pbancTtl + '</span>'+
				                            	'</a>'+
					                            	'<div class="d1">'+
					                            		'<span class="pbancCareerCdNm">' + pbanc.pbancCareerCdNm +'</span>&nbsp;&nbsp;<span class="bar">|</span>&nbsp;&nbsp;'+
					                            		'<span class="pbancAplctEduCdNm">'+pbanc.pbancAplctEduCdNm+'↑'+ '</span>'+
					                            	'</div>' +
			                            	'</td>' +       // 공고 제목
				                            '<td class="pbancDdlnDt">' +
				                            	pbancDdlnDt + 
				                            '<span class="material-symbols-outlined trash" data-pbanc-no="'+ pbanc.pbancNo + '"style="color:#9f9f9f; cursor:pointer;">'+'delete'+'</span>'+
				                            '</td>' +  // 날짜
				                        '</tr>' +
		                    	'</table>'+
            				'</div>';
                    });
                } else {
                    html = '<li>최근 본 공고가 없습니다.</li>';
                }

                $('#pbancList').html(html); // 모달에 HTML을 추가
        	},
        	error: function(error) {
                console.log('Error:', error);
            }
        })
	// 날짜 계산 함수
function calculateDDay(endDateStr) {
    const endDate = new Date(endDateStr);  // 입력된 날짜
    const currentDate = new Date();  // 현재 날짜
    
    const diffTime = endDate - currentDate;  // 두 날짜 차이 계산
    const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));  // 일 단위로 변환
    
    if (diffDays > 0) {
        return 'D-' + diffDays;
    } else if (diffDays === 0) {
        return 'D-Day';
    } else {
        return '종료됨';  // 이미 지난 경우
    }
}
	$(document).on('click', '.trash', function() {
		// Swal.fire 사용하여 수정 확인창 표시
	    Swal.fire({
	        title: '삭제하시겠습니까?',
	        icon: 'error',
	        showCancelButton: true,
	        confirmButtonColor: 'white',
	        cancelButtonColor: 'white',
	        confirmButtonText: '예',
	        cancelButtonText: '아니오'
	    }).then((result) => {
	    	if (result.isConfirmed) {
	    	        let pbancNo = $(this).data('pbanc-no'); // 클릭한 공고 번호 가져오기
	    	        let pbancNoList = Cookies.get('pbancNoList') ? JSON.parse(Cookies.get('pbancNoList')) : [];

	    	        // 공고 번호를 리스트에서 제거
	    	        pbancNoList = pbancNoList.filter(function(no) {
	    	            return no !== pbancNo;
	    	        });

	    	        // 수정된 리스트를 쿠키에 다시 저장
	    	        Cookies.set('pbancNoList', JSON.stringify(pbancNoList));

	                Toast.fire({
	                    icon: 'success',
	                    title: '삭제 완료!'
	                });

	    	        // 화면에서 해당 공고 제거
	    	        $(this).closest('.RBox').remove();

	    	        // 만약 리스트가 비었다면 "최근 본 공고가 없습니다." 메시지 표시
	    	        if (pbancNoList.length === 0) {
	    	            $("#pbancList").html('<li>최근 본 공고가 없습니다.</li>');
	    	        }
	    	}
	    })
	    
	});
	
	
	
// URL에서 pbancNo를 가져오는 함수
function getPbancNoFromURL(url) {
    var regex = /[?&]pbancNo=(\d+)/;  // pbancNo 값 추출을 위한 정규식
    var match = regex.exec(url);
    if (match && match[1]) {
        return match[1];
    }
    console.log("pbancNo 값이 없습니다.");  // pbancNo가 없을 때
    return null;
}
})
</script>

<br>
<div class="container" style="position: relative; bottom: 35px;">	
	<p id="h3">최근 본 공고
		<span id="Rinfo">*&nbsp;&nbsp;최근 본 공고는 최대 7개까지 일주일간 저장됩니다.</span>
	</p>
	<br><br>
			<p id="count">전체&nbsp;&nbsp;<span id="pbancCount"></span>
			</p>
		<br>
	</div>  <!-- 총 공고 수를 표시할 곳 -->
    	<table class="table table-hover text-nowrap">
	    	<thead style="width:100px;">
	           <tr style="text-align: center;">
                  <th class="nm">기업명</th>
                  <th class="entNm" style="font-size: 16px;">업종</th>
                  <th class="aplct">공고</th>
                  <th>마감기한</th>
               </tr>
            </thead>
        </table>
	    <div id="pbancList"></div>     <!-- 최근 본 공고 리스트를 표시할 곳 -->
    
</div>

<style>
table.table.table-hover.text-nowrap {
    position: relative;
    left: 67px;
    bottom: 7px;
    width: 1230px;
}
.table {
    color: #212529;
    background-color: transparent;
    margin-bottom:1px;
}
div#pbancList {
    position: relative;
    left: 70px;
    bottom: 5px;
    border-bottom: 1px solid #232323;
}
.table thead th {
    vertical-align: bottom;
    border-bottom: 1px solid #232323;
    border-top: 1px solid #232323;
}
.table td, .table th {
    vertical-align: middle;
    border-bottom: none;
    border-top:none;
}
.RBox { 
	width: 1230px;
     text-align: center;  
     border-top: none; 
/*      padding-left: 25px;  */
     padding-right: 20px; 
     border-bottom:1px solid #dee2e6;

} 
#h3{
	margin-left:-40px;
	font-weight : 700;
	font-size : 30px;
	color : #212529;
}
th.entNm {
    text-align: left;
	padding-left: 20px;
	font-size: 14px;
    font-weight: 500;
    font-size: 16px;
    font-weight: 650;
}
th.aplct {
    text-align: left;
    position: relative;
    right: 135px;
    font-size: 16px;
    font-weight: 650;
}
td.td1 {
    text-align: left;
    position: relative;
    left: 68px;
}
td.rc1 {
    text-align: left;
    width: 203px;
    position: relative;
    left: 80px;
}
td.t2 {
    text-align: left;
    position: relative;
    left: 75px;
    width: 235px;
}
.pbancTtl {
    text-align: left;
    font-size: 14px;
    font-weight: 650;
    cursor: pointer;
}
.d1 {
    font-size: 12px;
    color: #666363;
    font-weight: normal;
}
.material-symbols-outlined {
  font-variation-settings:
  'FILL' 0,
  'wght' 200,
  'GRAD' 0,
  'opsz' 24;
   color: #595959;
}
.trash{
	color: #595959;
    position: relative;
	top: -1px;
    left: 19px;
}
.pbancDdlnDt{
	font-weight: 500;
    color: #e51515;
    padding-right: 10px;
    position: relative;
    right: 5px;
    font-size: 14px;
    text-align: left;
}
td.pbancDdlnDt {
    position: relative;
    right: 60px;
    width: 90px;
}
.nm{
	text-align: left;
    position: relative;
    left: 80px;
    font-size: 16px;
    font-weight: 700;
}
th{
	width:100px;
	font-size: 16px;
    font-weight: 650;
}	
span#pbancCount {
    background: #24D59E;
    color: white;
    padding: 7px 8px 7px 8px;
    border-radius: 999px;
    font-size: 20px;
}	
#Rinfo{
	font-size: 14px;
    font-weight: 500;
    margin-left: 15px;
    color: #666363;
}
</style>