<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script>
document.addEventListener('DOMContentLoaded', function () {
    var navMainLinks = document.querySelectorAll('.nav-item.nav_main .nav-link');
    var navSubLinks = document.querySelectorAll('.nav-item.nav_sub .nav-link');

//     // nav_main 항목에 클릭 이벤트 리스너 추가
//     navMainLinks.forEach(function (link) {
//         link.addEventListener('click', function () {
//             // 모든 nav_main 항목에서 'active' 클래스 제거
//             navMainLinks.forEach(function (item) {
//                 item.parentNode.classList.remove('active');
//             });

//             // 모든 nav_sub 항목에서 'active' 클래스 제거
//             navSubLinks.forEach(function (item) {
//                 item.parentNode.classList.remove('active');
//             });

//             // 클릭된 nav_main 항목에 'active' 클래스 추가
//             this.parentNode.classList.add('active');
//         });
//     });

//     // nav_sub 항목에 클릭 이벤트 리스너 추가
//     navSubLinks.forEach(function (link) {
//         link.addEventListener('click', function () {
//             // 모든 nav_main 항목에서 'active' 클래스 제거
//             navMainLinks.forEach(function (item) {
//                 item.parentNode.classList.remove('active');
//             });

//             // 모든 nav_sub 항목에서 'active' 클래스 제거
//             navSubLinks.forEach(function (item) {
//                 item.parentNode.classList.remove('active');
//             });

//             // 클릭된 nav_sub 항목에 'active' 클래스 추가
//             this.parentNode.classList.add('active');
//         });
//     });
    
    
    var currentPath = window.location.pathname;
    $('.nav-link').each(function() {
        // 각 링크의 href 속성에서 경로만 가져오기
        var linkPath = $(this).attr('href').split('?')[0]; // 쿼리 스트링을 제거하고 경로만 추출
        // 현재 경로와 링크 경로를 비교
        if (currentPath === linkPath) {
        	 $(this).find('p').addClass('active'); // 일치하는 경우 active 클래스 추가
        }
    });
    
});
</script>

<style>
.asideTitle{
	margin-left: 18px;
}
#asideTitle{
	color: #232323;
	font-size: 25px;
	font-weight: 600;
}
.nav-item{
    font-family: pretendard;
}
/* 기본 사이드바 스타일 */
.main-sidebar {
    background-color: #ffffff !important;
}

.nav-sidebar .nav-link {
    color: #000000 !important;
}

.nav-treeview {
    background-color: #ffffff !important;
}

.nav-treeview .nav-link {
    color: #000000 !important;
}

.nav-sidebar .nav-link:hover {
    color: #2CCFC3 !important; /* hover 상태 색상 */
}

/* 클릭된 nav_main 항목의 스타일 */
.nav-sidebar .nav-item.nav_main.active .nav-link {
    color: #2CCFC3 !important; /* 클릭된 nav_main 항목의 글자색 */
    background-color: rgba(44, 207, 195, 0.11) !important; /* 클릭된 nav_main 항목의 배경색 */
}

/* 클릭된 nav_sub 항목의 스타일 */
.nav-sidebar .nav-item.nav_sub.active .nav-link {
    color: #2CCFC3 !important; /* 클릭된 nav_sub 항목의 글자색 */
    background-color: rgba(44, 207, 195, 0.11) !important; /* 클릭된 nav_sub 항목의 배경색 */
}

/* 기본 nav_sub 항목의 스타일 */
.nav-sidebar .nav-item.nav_sub .nav-link {
    color: #000000 !important; /* 기본 글자색 */
    background-color: #ffffff !important; /* 기본 배경색 */
}

/* 기본 nav_main 항목의 스타일 */
.nav-sidebar .nav-item.nav_main .nav-link {
    color: #000000 !important; /* 기본 글자색 */
    background-color: #ffffff !important; /* 기본 배경색 */
}

.nav_sub{
	text-align: left
}
.intrvw{
	margin-left: 32px !important;
}
p.active {
    color: #24D59E; /* 활성화된 링크 색상 */
}
</style>

<aside class="main-sidebar" style="margin-top: 87px;">
<sec:authentication property="principal" var="prc"/>
	<!-- Sidebar -->
	<div class="sidebar">
		<!-- Sidebar user panel (optional) -->
		<div class=" mt-3 pb-3 ">
		</div>
			<div class="asideTitle">
				<p id="asideTitle">지원자 관리</p>
			</div>

		<!-- Sidebar Menu -->
		<nav class="mt-2">
			<ul class="nav nav-pills nav-sidebar flex-column"
				data-widget="treeview" role="menu" data-accordion="false">
				<li class="nav-item nav_main">
					<a href="/enter/listAplct?entId=${prc.username}" class="nav-link"> 
					<img src="/resources/icon/작성글.png" alt="icon" style="width: 31px; height: 29px; position: relative;">
						<p>
							&nbsp;&nbsp;지원자 리스트
						</p>
					</a>
				</li>
				<li class="nav-item nav_main">
					<a href="/enter/intrvw?entId=${prc.username}" class="nav-link"> 
					<img src="/resources/icon/면접아이콘.png" alt="icon" style="width: 31px; height: 29px; position: relative;">
						<p>
							&nbsp;&nbsp;면접 관리
						</p>
					</a>
				</li>
				<li class="nav-item nav_main">
					<a href="/enter/videointrvw?entId=${prc.username}" class="nav-link"> 
					<img src="/resources/icon/videochat.png" alt="icon" style="width: 31px; height: 29px; position: relative;">
						<p>
							&nbsp;&nbsp;화상면접방 관리
						</p>
					</a>
				</li>
			</ul>
		</nav>
		<!-- /.sidebar-menu -->
	</div>
</aside>