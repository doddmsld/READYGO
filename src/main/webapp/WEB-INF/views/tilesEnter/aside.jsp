<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,200,0,0" />
<script>
document.addEventListener('DOMContentLoaded', function () {
    var navMainLinks = document.querySelectorAll('.nav-item.nav_main .nav-link');
    var navSubLinks = document.querySelectorAll('.nav-item.nav_sub .nav-link');
	
    // nav_main 항목에 클릭 이벤트 리스너 추가
    navMainLinks.forEach(function (link) {
        link.addEventListener('click', function () {
            // 모든 nav_main 항목에서 'active' 클래스 제거
            navMainLinks.forEach(function (item) {
                item.parentNode.classList.remove('active');
            });

            // 모든 nav_sub 항목에서 'active' 클래스 제거
            navSubLinks.forEach(function (item) {
                item.parentNode.classList.remove('active');
            });

            // 클릭된 nav_main 항목에 'active' 클래스 추가
            this.parentNode.classList.add('active');
        });
    });

    // nav_sub 항목에 클릭 이벤트 리스너 추가
    navSubLinks.forEach(function (link) {
        link.addEventListener('click', function () {
            // 모든 nav_main 항목에서 'active' 클래스 제거
            navMainLinks.forEach(function (item) {
                item.parentNode.classList.remove('active');
            });

            // 모든 nav_sub 항목에서 'active' 클래스 제거
            navSubLinks.forEach(function (item) {
                item.parentNode.classList.remove('active');
            });

            // 클릭된 nav_sub 항목에 'active' 클래스 추가
            this.parentNode.classList.add('active');
        });
    });
    
});

</script>

<style>
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
	text-align: center;
}
</style>

<aside class="main-sidebar sidebar-dark-primary elevation-4">
<sec:authentication property="principal" var="prc"/>
	<!-- Sidebar -->
	<div class="sidebar">
		<!-- Sidebar user panel (optional) -->
		<div class=" mt-3 pb-3 ">
		</div>
			<sec:authorize access="isAuthenticated()">
			<c:if test="${prc.authorities eq '[ROLE_ENTER]'}">
			<div class="image">
				<a href="/enter/main"><img src="/resources/icon/ReadyGo-로고(초록).png" 
					alt="Logo"></a>
			</div>
			</c:if >
			<c:if test="${prc.authorities eq '[ROLE_MEMBER]'}">
				<a href="/"><img src="/resources/icon/ReadyGo-로고(초록).png" 
					alt="Logo"></a>
			</c:if>
		
		<c:if test="${prc.authorities eq '[ROLE_ENTER]'}">
		<!-- Sidebar Menu -->
		<nav class="mt-2">
			<ul class="nav nav-pills nav-sidebar flex-column"
				data-widget="treeview" role="menu" data-accordion="false">
				<li class="nav-item nav_main">
					<a href="/enter/profile?entId=${prc.username}" class="nav-link"> 
					<img src="/resources/icon/내프로필.png" alt="icon">
						<p>
							&nbsp;&nbsp;내 프로필 
						</p>
					</a>
				</li>
				<li class="nav-item nav_main">
					<a href="/enter/edit?entId=${prc.username}" class="nav-link"> 
					<img src="/resources/icon/개인정보수정.png" alt="icon">
						<p>
							&nbsp;&nbsp;기업정보 수정
						</p>
					</a>
				</li>
				<li class="nav-item nav_main">
					<a href="/enter/passEdit?entId=${prc.username}" class="nav-link"> 
					<img src="/resources/icon/passEdit.png" alt="icon" style="width:22px;height: 20px;">
						<p>
							&nbsp;&nbsp;비밀번호 변경
						</p>
					</a>
				</li>
				<li class="nav-item nav_main">
					<a href="/enter/entaddmem?entId=${prc.username}" class="nav-link"> 
					<span class="material-symbols-outlined" style="vertical-align: middle;font-size: 24px;">person_add</span>
						<p>
							&nbsp;&nbsp;기업회원 추가
						</p>
					</a>
				</li>
				<li class="nav-item nav_main"><a href="#" class="nav-link"> 
					<img src="/resources/icon/알림.png" alt="icon">
						<p>
							&nbsp;&nbsp;알림 목록
						</p>
					</a>
				</li>	
			</ul>
		</nav>
		</c:if>
		</sec:authorize>
		<!-- /.sidebar-menu -->
	</div>
</aside>