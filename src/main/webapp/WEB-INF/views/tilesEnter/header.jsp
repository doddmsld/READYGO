<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

   <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard.css">

    <title>기업 헤더</title>

    <!-- Bootstrap core CSS -->
    <link href="resources/css/bootstrap.min.css" rel="stylesheet">
<!-- Additional CSS Files -->
    <link rel="stylesheet" href="../resources/assets/css/fontawesome.css">
    <link rel="stylesheet" href="../resources/assets/css/templatemo-cyborg-gaming.css">
    <link rel="stylesheet" href="../resources/assets/css/owl.css">
    <link rel="stylesheet" href="../resources/assets/css/animate.css">
    <link rel="stylesheet"href="https://unpkg.com/swiper@7/swiper-bundle.min.css"/>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.entVO" var="entVO" />
	<sec:authentication property="principal.memVO" var="memVO1" />
</sec:authorize>
<c:if test="${entVO ne null }">

</c:if>
<script>
$(function() {
	$.ajax({
        url: '/notification/getAlramCnt',  // 서버에서 알림 목록을 가져오는 API
        method: 'GET',
        dataType: 'json',
        success: function(result) {
            var notificationCount = result;
	
            // 알림 갯수 표시
            if (notificationCount > 0) {
            	$('#notificationBadge').show().text(notificationCount);
        		console.log("성공");
            } else {
            	$('#notificationBadge').hide().text(0);
        		console.log("실패");
            }
        },
        error: function() {
            console.error('알림 갯수를 가져오는 데 실패했습니다.');
        }
    });
	
	
	 var auth = $("#authval").val();
     console.log("User Authorities: ", auth);

     if (auth.indexOf("ROLE_MEMBER") !== -1) {
         alert("회원으로 접근할 수 없습니다.");
         location.href="/";
     }else if (auth.indexOf("ROLE_ADMIN") !== -1) {
         alert("관리자로 접근할 수 없습니다.");
         document.getElementById('logoutBtn').submit();
     }
	
	
    var mbrId = "${entVO.entId}";
    var socket = null;

    $(document).ready(function() {
        if (mbrId) {
            connectWs();
        }
    });


    function connectWs() {
        console.log("WebSocket 연결 시작");
        var ws = new SockJS("/alarm");
        ws.onopen = function() {
            console.log('WebSocket 연결 성공');
        };
        ws.onmessage = function(event) {
            console.log("서버로부터 메시지 받음: " + event.data);

            let $socketAlert = $('#socketAlert');

            // 메시지 내용 업데이트
            $socketAlert.html(event.data);

            // 알림 표시 (CSS 클래스를 통한 애니메이션 효과)
            $socketAlert.removeClass('hidden').addClass('visible');
            
            // 3초 후 알림 숨기기
            setTimeout(function() {
                $socketAlert.removeClass('visible').addClass('hidden');
            }, 3000);
            
            // 배지 갱신 로직
            updateNotificationBadgeDisplay();
        };

        ws.onclose = function() {
            console.log('WebSocket 연결 종료');
        };
        socket = ws;  // 웹소켓을 저장
    }

    // 알림 배지 갱신 (실시간으로 서버에서 가져옴)
    function refreshNotificationCount() {
        $.ajax({
            url: '/notification/list',
            method: 'GET',
            dataType: 'json',
            success: function(response) {
                var notificationCount = response.length;

                if (notificationCount > 0) {
                    $('#notificationBadge').show().text(notificationCount);
                } else {
                    $('#notificationBadge').hide().text(0);
                }
            },
            error: function() {
                console.error('알림 갯수를 갱신하는 데 실패했습니다.');
            }
        });
    }

    function updateNotificationBadgeDisplay() {
        var badge = $('#notificationBadge');
        var currentCount = parseInt(badge.text()) || 0;
        currentCount += 1;
        badge.show().text(currentCount);
    }

    document.addEventListener('DOMContentLoaded', function () {
        var currentPath = window.location.pathname;
        console.log(currentPath);

        $('.alink').each(function() {
            var alinkElement = $(this);
            var linkPath = alinkElement.attr('href').split('?')[0];

            if (currentPath === linkPath) {
                alinkElement.addClass('active');
            }

            alinkElement.closest('li').find('.menuDetaild a').each(function() {
                var hrefValue = $(this).attr('href').split('?')[0];

                if (currentPath === hrefValue) {
                    alinkElement.addClass('active');
                }
            });
        });

       
    });

    $(".nav-link").on('click', function() {
        $('.alerts').text("");
        const entIds = $('.loginval').data('value');
        if (entIds != null) {
            $.ajax({
                url: "/enter/alarmList",
                contentType: "application/json;charset=utf-8",
                data: entIds,
                type: "post",
                dataType: "json",
                beforeSend: function(xhr) {
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                },
                success: function(result) {
                    var apd = "";
                    $.each(result, function(idx, item) {
                        apd += "<a class='dropdown-item d-flex align-items-center mess' href='#'>";
                        apd += "<div class='mr-3'><div class='icon-circle bg-warning'><i class='fas fa-exclamation-triangle text-white'></i></div></div><div>";
                        apd += "<div class='small text-gray-500'>" + item.ntcnYmd + "</div>";
                        apd += item.ntcnCn;
                        apd += "</div></a>";
                    });
                    $(".alerts").prepend(apd);
                }
            });
        } else {
            alert("로그인후 이용가능합니다.");
            location.href = "/security/entLogin";
        }
    });
});

function alerttext() {
    alert("로그인 후 이용하세요.");
    location.href = "/security/entLogin";
}
</script>

<!-- ***** Header Area Start ***** -->
  <header class="header-area header-sticky" >
    <div class="container">
    	<sec:authorize access="isAuthenticated()">
	    	<sec:authentication property="principal.authorities" var="userAuthorities" />
	    	<input id="authval" type="hidden" value="${userAuthorities}">
		                <p style="color: white; overflow: auto;">
					    	<sec:authentication property="principal.entVO" var="entVO"/>
					    </p>
					    <p style="color: white; overflow: auto;">
					    	<sec:authentication property="principal.memVO" var="memVO"/>
					    </p>
		</sec:authorize>
			<div class="row">
	            <div class="col-9" style="height: 70px;">
	                <nav class="main-nav" style="z-index:999;position:relative; padding: 8px 0px;">
	                    <!-- ***** Logo Start ***** -->
	                    <a href="/enter/main" class="logo">
<!-- 	                        <img src="/resources/icon/ReadyGo-로고(초록).png" alt=""> -->
							<img src="/resources/images/찐레디고.gif" style="width: 127px; height: 70px; margin-left: 11px;">
	                    </a>
	                    <div class="search-input">
					         <nav class="top-bar__menu-box-1">
								<ul id="enterMenu" style="font-size:20px;text-align: center;">
									<c:if test="${entVO.entId ne null}">
									<li class="menuDetail"><a class="alink" href="/enter/pbanc?entId=${entVO.entId}">공고관리</a>
										<ul class="nav2-innav">
								          <li class="menuDetaild"><a href="/enter/pbanc?entId=${entVO.entId}">공고관리</a></li>
								          <li class="menuDetaild"><a href="/enter/tempPbanc?entId=${entVO.entId}">공고 임시저장</a></li>
								        </ul>
							        </li>
									</c:if>
									<c:if test="${entVO.entId eq null}">
									<li class="menuDetail"><a class="alink" href="#" onClick="alerttext()">공고관리</a>
										<ul class="nav2-innav">
								          <li class="menuDetaild"><a href="#" onClick="alerttext()">공고관리</a></li>
								          <li class="menuDetaild"><a href="#" onClick="alerttext()">공고 임시저장</a></li>
								        </ul>
							        </li>
									</c:if>
									
							        <c:if test="${entVO.entId ne null}">
									<li class="menuDetail"><a class="alink" href="/enter/listAplct?entId=${entVO.entId}">지원자관리</a>
										<ul class="nav2-innav">
								          <li class="menuDetaild"><a href="/enter/listAplct?entId=${entVO.entId}">지원자 리스트</a></li>
								          <li class="menuDetaild"><a href="/enter/intrvw?entId=${entVO.entId}">면접 관리</a></li>
								          <li class="menuDetaild"><a href="/enter/videointrvw?entId=${entVO.entId}">화상면접방 관리</a></li>
								        </ul>
									</li>
									</c:if>
									<c:if test="${entVO.entId eq null}">
									<li class="menuDetail"><a class="alink"  href="#" onClick="alerttext()">지원자관리</a>
										<ul class="nav2-innav">
								          <li class="menuDetaild"><a href="#" onClick="alerttext()">지원자 리스트</a></li>
								          <li class="menuDetaild"><a href="#" onClick="alerttext()">면접 관리</a></li>
								        </ul>
							        </li>
									</c:if>
							        <c:if test="${entVO.entId ne null}">
										<li class="menuDetail"><a class="alink" href="/enter/scout?entId=${entVO.entId}">스카우트제안</a></li>
									</c:if>
									<c:if test="${entVO.entId eq null}">
										<li class="menuDetail"><a class="alink" href="#" onClick="alerttext()">스카우트제안</a></li>
							        </c:if>
							        <c:if test="${entVO.entId ne null}">
										<li class="menuDetail"><a class="alink" href="/enter/injae?entId=${entVO.entId}">인재</a>
							        </c:if>
							        <c:if test="${entVO.entId eq null}">
										<li class="menuDetail"><a class="alink" href="#" onClick="alerttext()">인재</a>
							        </c:if>
							        </li>
								</ul>
							</nav>
	                    </div>
	
	                    <!-- ***** Menu Start ***** -->
	                    <ul class="navGen">
	                    <sec:authorize access="isAnonymous()">         
					        <li class="nav-items dropdown no-arrow mx-1">
					            <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button"
					                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" onClick="alerttext()">
					 				<img class="fa-bells"src="../resources/images/inform.png" alt="알림 아이콘" />
					                <!-- Counter - Alerts -->
					                <span class="badge badge-danger badge-counter badgent"></span>
					            </a>
					            <!-- Dropdown - Alerts -->
					            <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
					                aria-labelledby="alertsDropdown">
					                <h6 class="dropdown-header">
					                    Alerts Center
					                </h6>
						            <div class="alerts">
						            </div>
					            </div>
					        </li>
			        		<li><a class="headera" href="/security/entLogin">로그인</a></li>
					            <p class="headera">|</p>
					            <li><a class="headera" href="/security/entSignin">회원가입</a></li>
			        </sec:authorize>       
			        <sec:authorize access="isAuthenticated()">
						    <c:if test="${entVO!=null }">
								<!-- 웹소켓알림 -->
								<!-- 웹소켓알림 -->
								<li class="iconSize dropdown">
								    <a href="#" id="notificationIcon" class="nav-link" aria-expanded="false">
								        <img src="../../resources/images/inform.png" alt="알림 아이콘" />
								        <c:if test="${not empty alramList}">
								            <span class="badge badge-warning navbar-badge" id="notificationBadge">띵</span>
								        </c:if>
								    </a>
								    <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right" id="notificationDropdown">
										<c:forEach var="alram" items="${alramList}">
										    <div class="notification-item">
										    	<div class="alarmTitle">알림</div>
										    	<div class="alarmDate"><span class="dat"></span><fmt:formatDate value="${alram.ntcnYmd}" pattern="yyyy.MM.dd hh:mm:ss"/></div>
										        <a href="${alram.ntcnUrl}" class="dropdown-item notify-link">
										            ${alram.ntcnCn}
										        </a>
										        <button class="alramDel">x</button>
										        <input type="hidden" class="ntcnNo" value="${alram.ntcnNo}" />
										    </div>
										</c:forEach>
								    </div>
								</li>
	
								<!-- 웹소켓 알림끝 -->
								<!-- 웹소켓 알림끝 -->
								<!-- 알림받는곳 넣어야함 -->
							    <div id="socketAlert" class="socket-alert hidden"></div>				        
					            <form action="/logout" method="post">
					            	<button  type="submit">로그아웃</button>
						            <sec:csrfInput />
					            </form>
						        <li id="headerUser"><a class="loginval" href="/enter/profile?entId=${entVO.entId}" data-value="${entVO.entId}">${entVO.entNm} 
						        		<c:if test="${entVO.entLogo==null}">
		                        			<img src="/resources/images/member/기본프로필.png" alt="기본프로필.png" id="pImg" />
				                    	</c:if>
				                    	<c:if test="${entVO.entLogo!=null}">
					                        <img src="${entVO.entLogos}" alt="${entVO.fileDetailVOList[0].orgnlFileNm}" id="pImg" />
				                    	</c:if></a></li>
						    </c:if>
						    <c:if test="${memVO!=null }">
					            <li class="iconSize">
					                <button type="button" id="alarmbtn">
					                    <img src="../resources/images/inform.png" alt="알림 아이콘" />
					                </button>
					            </li>
					            <form id="logoutBtn" action="/logout" method="post">
					            	<button type="submit">로그아웃</button>
						            <sec:csrfInput />
					            </form>
						        <li id="headerUser"><a class="loginval" href="/enter/profile?entId=${memVO.mbrId}" data-value="${memVO.mbrId}">${memVO.mbrNm} 
					            	<img src="${entVO.entLogos}" alt="${memVO.fileDetailVOList[0].orgnlFileNm}" id="pImg" />
				                </a>
				                </li>
						    </c:if>
			                </sec:authorize>
	                    </ul>   
	                    <!-- ***** Menu End ***** -->
	                    
	                </nav>
	            </div>  
        	</div>
        
        <hr style="margin-bottom: 0px;"> 
    </div>
    
 </header>
  <!-- ***** Header Area End ***** -->
<script>
function formatDate(timestamp) {
    const date = new Date(timestamp);
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    const hours = String(date.getHours()).padStart(2, '0');
    const minutes = String(date.getMinutes()).padStart(2, '0');
    const seconds = String(date.getSeconds()).padStart(2, '0');

    return year+`.`+month+`.`+day+` `+ hours+`:`+minutes+`:`+seconds;
}
// 클릭할 때 알림 목록을 토글하는 스크립트
$(document).ready(function() {
    // 알림 아이콘 클릭 시 열고 닫기 기능
    $('#notificationIcon').on('click', function(e) {
        e.preventDefault();
        var dropdown = $('#notificationDropdown');

        $.ajax({
            url: '/notification/list',  // 서버에서 알림 목록을 반환하는 API
            method: 'GET',
            dataType: 'json',
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(response) {
                var dropdown = $('#notificationDropdown');
                dropdown.empty();  // 기존 알림 목록 비우기
                if (response.length > 0) {
                    // 알림이 있을 경우 배지를 보여줌
                    dropdown.append('<div class="alarmTitle">알림</div>');
                    dropdown.append('<div class="alarm-actions" style="display: flex; justify-content: space-between;">' + 
                            '<a href="#" class="dropdown-item dropdown-footer" id="alramAllDel">전체삭제</a>' +
                            '<a href="/member/memAlram?mbrId=" class="dropdown-item dropdown-footer" id="alramList" style="text-align:right;">알림목록</a>' +
                            '</div>');
                    var notificationCount = response.length;
                    $('#notificationBadge').show().text(notificationCount);
                    $.each(response, function(index, alram) {
                        dropdown.append(
                            	'<div class="alarmDate"><span class="dat"></span> '+formatDate(alram.ntcnYmd) +'</div>'+
                                '<div class="boxbox"><div><a data-ntcn-no="'+alram.ntcnNo+'" href="'+alram.ntcnUrl+'" class="dropdown-item dropdown-footer notify-link">' + 
                                alram.ntcnCn + 
                                '<input type="hidden" id="ntcnNo" name="ntcnNo" value="' + alram.ntcnNo + '" />' +
                                '</div><div><button data-ntcn-no="'+alram.ntcnNo+'" id="alramDel">x</button></div>' + 
                                '</a></div>'
                        );
                    });
                } else {
                    // 알림이 없을 경우 배지를 숨김
                    $('#notificationBadge').hide().text(0);
                    dropdown.append('<a href="#" class="dropdown-item dropdown-footer">알림이 없습니다.</a>');
                }
                // 알림 목록을 열고 닫기 토글
                dropdown.toggleClass('show');
            },
            error: function() {
                console.error('알림 목록을 불러오는 데 실패했습니다.');
            }
        });
    });

    // 드롭다운 외부 클릭 시 닫기 기능
    $(document).on('click', function(e) {
        var dropdown = $('#notificationDropdown');

        if (!$(e.target).closest('#notificationIcon').length && !$(e.target).closest('#notificationDropdown').length) {
            dropdown.removeClass('show');
        }
    });
    $(document).on('click', '.notify-link', function(e) {
        e.preventDefault(); // 기본 동작 막기 (바로 이동되지 않도록)

        // 알림의 ntcnNo 값 가져오기
        var ntcnNo = $(this).data('ntcnNo');
        var targetUrl = $(this).attr('href');
        // AJAX 요청으로 알림 삭제하기
        $.ajax({
            url: '/notification/alramLinkClick',  // 알림 삭제 처리하는 API 엔드포인트
            method: 'POST',
            data: {
                ntcnNo: ntcnNo  // 삭제할 알림 번호 전달
            },
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");  // CSRF 토큰 설정
            },
            success: function(response) {
                if (response === 'success') {
                    $(e.target).closest('a').remove();
                    // 알림 삭제 후 해당 URL로 이동
                    window.location.href = targetUrl;
                } else {
                    alert('알림 삭제 중 오류가 발생했습니다.');
                }
            },
            error: function() {
                alert('알림 삭제 중 오류가 발생했습니다.');
            }
        });
    });
    $(document).on('click', '#alramDel', function(e) {
    	e.stopPropagation();
        e.preventDefault();
        
        // 클릭된 버튼의 해당 알림 번호 가져오기
//         var ntcnNo = $(this).siblings('input#ntcnNo').val();
		var ntcnNo = $(this).data("ntcnNo");
        $.ajax({
            url: '/notification/alramDel',  // 알림 삭제 처리하는 API 엔드포인트
            method: 'POST',
            data: {
                ntcnNo: ntcnNo  // 삭제할 알림 번호 전달
            },
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");  // CSRF 토큰 설정
            },
            success: function(response) {
                if (response === 'success') {
                    // 성공적으로 삭제한 후 해당 알림 항목 제거
                    $(e.target).closest('a').remove();

                    // 남은 알림 목록을 다시 불러와서 갯수 확인
                    $.ajax({
                        url: '/notification/list',  // 서버에서 알림 목록을 반환하는 API
                        method: 'GET',
                        dataType: 'json',
                        success: function(response) {
                            var dropdown = $('#notificationDropdown');
                            dropdown.empty();  // 기존 알림 목록 비우기
                            
                            if (response.length > 0) {
                            	 // 전체 삭제 버튼 추가
                                dropdown.append('<div class="alarmTitle">알림</div>');
			                    dropdown.append('<div class="alarm-actions" style="display: flex; justify-content: space-between;">' + 
			                            '<a href="#" class="dropdown-item dropdown-footer" id="alramAllDel">전체삭제</a>' +
			                            '<a href="/member/memAlram?mbrId=" class="dropdown-item dropdown-footer" id="alramList" style="text-align:right;">알림목록</a>' +
			                            '</div>');
                                // 알림이 있으면 알림 목록을 추가하고 배지 표시
                                var notificationCount = response.length;
                                $('#notificationBadge').show().text(notificationCount);
                                $.each(response, function(index, alram) {
                                    dropdown.append(
                                        	'<div class="alarmDate"><span class="dat"></span> '+formatDate(alram.ntcnYmd) +'</div>'+
                                        '<div class="boxbox"><div><a data-ntcn-no="'+alram.ntcnNo+'" href="'+alram.ntcnUrl+'" class="dropdown-item dropdown-footer notify-link">' + 
                                        alram.ntcnCn + 
                                        '<input type="hidden" id="ntcnNo" name="ntcnNo" value="' + alram.ntcnNo + '" />' +
                                        '</div><div><button data-ntcn-no="'+alram.ntcnNo+'" id="alramDel">x</button></div>' + 
                                        '</a></div>'
                                    );
                                });
                            } else {
                                // 알림이 없으면 배지를 숨기고 "알림이 없습니다" 메시지 추가
                                $('#notificationBadge').hide().text(0);
                                dropdown.append('<a href="#" class="dropdown-item dropdown-footer">알림이 없습니다.</a>');
                            }
                        },
                        error: function() {
                            console.error('알림 목록 갱신 중 오류가 발생했습니다.');
                        }
                    });
                } else {
                    alert('알림 삭제 중 오류가 발생했습니다.');
                }
            },
            error: function() {
                alert('알림 삭제 중 오류가 발생했습니다.');
            }
        });
    });

    $(document).on('click', '#alramAllDel', function(e) {
        e.preventDefault(); // 기본 동작 막기

        $.ajax({
            url: '/notification/alramAllDel',
            type: 'POST',
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");  // CSRF 토큰 설정
            },
            success: function(response) {
                if (response === "success") {
                    $('#notificationDropdown').empty().append(
                            '<a href="#" class="dropdown-item dropdown-footer">알림이 없습니다.</a>'
                        );
                    $('#notificationBadge').hide().text(0); // 배지 숨기기
                } else if (response === "fail") {
                    alert("알림 삭제에 실패했습니다.");
                } else {
                    alert("오류가 발생했습니다.");
                }
            },
            error: function(xhr, status, error) {
                alert("서버와 통신 중 오류가 발생했습니다. " + error);
            }
        });
    });


});
</script>
<style>
#alramAllDel,#alramList {
    color: #2f2f2f;
    text-decoration: none; 
    padding: 5px;
    display: inline-block;
    background-color: transparent;
}

#alramAllDel:hover, #alramList:hover {
    color: #24D59E;
    background-color: transparent; 
    text-decoration: none; 
}

#alramAllDel:active, #alramList:active {
    color: #24D59E; 
    background-color: transparent; 
    text-decoration: none; 
}
.boxbox{
	display: flex;
	flex-direction: row;
	justify-content: space-between;
	background-color: #00bc8c0a;
	border-radius: 8px;
	margin-bottom: 15px;

}
.notify-link:hover{
	border-radius: 8px;
}
.notify-link{
	display: flex;
	flex-direction: row;
	justify-content: space-between;
	border-radius: 8px;
}
.dat{
	display: inline-block;
    top: 7px;
    left: 0;
    width: 7px;
    height: 7px;
    border: 2px solid #96a0b5;
    border-radius: 50%;
    box-sizing: border-box;
    content: "";
}
.alarmDate{
	font-size: 12px;
	font-weight: 500;
	color: #96a0b5;
}
/*  알림 내용 */
.alarmCon{
	display: flex;
	flex-direction: column;
	margin-bottom: 15px;
}
#alramAllDel:hover{
	background-color: #fff;
}
/* 알림 제목 텍스트 */
.alarmTitle{
	font-size: 24px;
	font-weight: 600;
	margin-bottom: 20px;
}
/* 알림 창 */
.dropdown-menu-right{
	overflow: hidden;
    position: absolute;
    top: 49px;
    right: -319px;
    padding: 23px 26px 23px 26px;
    max-width: 400px;
    width: 376px;
    height: 720px;
    border: 1px solid #d7dce5;
    border-radius: 16px;
    box-sizing: border-box;
    background-color: #fff;
    box-shadow: 2px 6px 16px 0 rgba(17, 42, 128, 0.08);
    text-align: left;
    overflow: overlay;
}
 .dropdown-menu-right::-webkit-scrollbar {
    width: 10px;
  }
  .dropdown-menu-right::-webkit-scrollbar-thumb {
    background-color: #24D59E;
    border-radius: 10px;
    background-clip: padding-box;
    border: 2px solid transparent;
  }
  .dropdown-menu-right::-webkit-scrollbar-track {
    background-color: #b6ffe9;
    border-radius: 10px;
    box-shadow: inset 0px 0px 5px white;
  }


/*알림 버튼 링크 분리*/
.notification-item {
    display: flex;                  /* flexbox로 일렬 정렬 */
    align-items: center;            /* 세로 중앙 정렬 */
    justify-content: space-between; /* 양쪽 끝으로 정렬 */
    padding: 5px 10px;
    border-bottom: 1px solid #eee;  /* 항목 간의 구분선 */
}

.notification-item a {
    flex: 1;                        /* 링크가 가능한 넓이만큼 차지하도록 */
    text-decoration: none;          /* 링크 밑줄 제거 */
    color: #333;                    /* 링크 색상 */
    padding-right: 10px;            /* 링크와 삭제 버튼 사이에 여백 추가 */
}

.notification-item button {
    background: none;               /* 배경 없애기 */
    border: none;                   /* 테두리 없애기 */
    color: red;                     /* 버튼 색상 (원하는 색상으로 변경 가능) */
    cursor: pointer;                /* 클릭 가능한 마우스 포인터 */
    font-size: 16px;                /* 버튼 크기 설정 */
    padding: 0;
}

/* 알림 박스 스타일 */
.socket-alert {
    position: fixed;
    top: 20px;
    right: 20px;
    z-index: 9999;
    background-color: #24D59E; /* 알림 배경색 (초록색) */
    color: #fff; /* 텍스트 색상 */
    padding: 15px 20px;
    border-radius: 8px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
    font-size: 16px;
    font-family: 'Pretendard', sans-serif;
    opacity: 0;
    transition: opacity 0.3s ease, transform 0.3s ease;
    transform: translateY(-20px);
}

/* 알림 박스 표시할 때 */
.socket-alert.visible {
    opacity: 1;
    transform: translateY(0);
}

/* 알림 박스 숨길 때 */
.socket-alert.hidden {
    opacity: 0;
    transform: translateY(-20px);
    transition: opacity 0.3s ease, transform 0.3s ease;
}
/*알림여기까지*/
.row{
	display: flex;
	justify-content: center;
}
#nav2 li{
	margin : 10px;
	margin-left: 50px;
	display: inline-block; 
	
}

#nav2{
	text-align: center;
	padding-top : 5px;
	padding-bottom : 5px;
	border-top: 1px solid #D6D6D6;
	border-bottom: 1px solid #D6D6D6;
}

.logo img{
	height : 70px;
}

nav.main-nav, ul {
    align-items: center; /* 수직 중앙 정렬 */
}

#nav2 li:last-child{
	border-left: 2px solid #D6D6D6;
	padding-left : 55px;
    color: #24D59E;
}

.iconSize img{
	width:30px;
	height:30px;
}
.navGen li{
	display: flex;
	justify-content:flex-end;
}
#enterMenu{/*기업 헤더 메뉴*/
	display: flex;
	justify-content: space-around;
	width: 600px;
	
}
.menuDetail{
	width : 110px;
	height: :65px;
}
.top-bar__menu-box-1 > ul ul {
  display: none;
}

/* 모든 메뉴를 마우스 인식 시 배경색을 변경 */
.top-bar__menu-box-1 ul > li > ul > li:hover > a {
 	color:#24D59E; !important;
}

/* 2차 메뉴가 보이도록 만들어 보자 */
.top-bar__menu-box-1 > ul > li:hover > ul {
  display: block;
  background: white;
  
}
/* 1차 메뉴를 제한 구역으로 설정 */
.top-bar__menu-box-1 > ul > li {
  position: relative;
}

/* 2차 메뉴에 absolute 값을 주기 */
/* .top-bar__menu-box-1 > ul > li > ul { */
/*   position: absolute; */
/*   top: 100%;		/* 2차 메뉴를 1차 메뉴의 아래에 위치시킨다 */ */
/*   left: 0;		/* 2차 메뉴를 1차 메뉴의 왼쪽 벽에 붙인다 */ */
/*   width: 120%;		/* 부모의 너비를 그대로 받아온다 */ */
/* } */
.nav-item.dropdown.no-arrow.d-sm-none:hover {
    background-color: none; /* 배경색 변경을 방지 */
    cursor: default; /* 마우스 포인터 변경 방지 */
    /* 추가로 hover 시 발생하는 효과를 여기서 제거할 수 있습니다 */
}
/*
.header-area .main-nav .navGen li:last-child:hover a{ 
	background-color: inherit ; /* 부모 요소의 배경색 상속 */
    color: inherit ; /* 부모 요소의 텍스트 색상 상속 */
    text-decoration: none ; /* 밑줄 제거 */
    box-shadow: none ; /* 그림자 제거 */
    border: none ; /* 테두리 제거 */
 } 
 */
/* .headera:hover{ */
/* 	background: #24D59E !important; */
/* } */
.dropdown-item d-flex align-items-center mess{
	background-color: inherit ; /* 부모 요소의 배경색 상속 */
    color: inherit ; /* 부모 요소의 텍스트 색상 상속 */
    text-decoration: none ; /* 밑줄 제거 */
    box-shadow: none ; /* 그림자 제거 */
    border: none ; /* 테두리 제거 */
}
.navGen li a{
	display: block;
    font-weight: 400;
    font-size: 12px;
    text-transform: capitalize;
    color: #666;
    -moz-transition: all 0.3s ease 0s;
    -o-transition: all 0.3s ease 0s;
    transition: all 0.3s ease 0s;
    border: transparent;
    padding: 13px 10px;
    border-radius: 18px;
    letter-spacing: .3px;
}
.navGen li a:hover{
  color: #2f2f2f;
  background-color: none;
}

.menuDetail a.active {
    color: #24D59E; /* 활성화된 링크 색상 */
    font-weight: bold; /* 글꼴 두께 조정 */
}
.nav2-innav {
	width : 140px;
	padding-top: 10px;
	padding-bottom: 10px;
    display: none; /* 기본적으로 숨김 */
    position: absolute; /* 서브 메뉴 위치 설정 */
    top: 100%; /* 부모 메뉴 아래에 위치 */
    left: 0; /* 부모 메뉴와 같은 위치에 시작 */
    list-style: none; /* 기본 목록 스타일 제거 */
    background-color: white; /* 배경색 설정 */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 그림자 추가 */
    z-index: 10;
}

#nav2 li:hover .nav2-innav {
    display: block; /* 마우스 오버 시 보이도록 설정 */
}

.nav2-innav li {
    display: block; /* 세로 정렬 */
    font-size: 0.9em;
    margin: 10px 10px;
}
</style>



