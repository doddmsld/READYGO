<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

/* 네비게이션 링크 스타일 설정 */
.nav-link {
    display: flex; /* 수평으로 아이템을 배치하기 위해 flexbox 사용 */
    align-items: center; /* 링크 내부의 요소들을 수직으로 중앙 정렬 */
    padding: 10px; /* 링크 내부에 10px 패딩 추가 */
    text-decoration: none; /* 링크의 기본 밑줄 제거 */
    color: black; /* 텍스트 색상을 검정색으로 설정 */
    border-radius: 10px; /* 테두리의 모서리를 둥글게 만듦 */
    transition: background-color 0.3s ease; /* 배경색이 바뀔 때 0.3초 동안 부드럽게 전환 */
}

/* 네비게이션 링크 내부에 표시될 숫자 스타일 */
.nav-link .number {
    display: inline-block; /* 숫자가 인라인 블록으로 배치되어 공간을 차지하게 함 */
    width: 30px; /* 숫자의 가로 크기 설정 */
    height: 30px; /* 숫자의 세로 크기 설정 */
    line-height: 30px; /* 숫자를 세로 가운데에 위치시키기 위한 줄 높이 설정 */
    text-align: center; /* 숫자를 가로 가운데 정렬 */
    background-color: white; /* 숫자의 배경을 흰색으로 설정 */
    color: #24D59E; /* 숫자의 글자 색상을 녹색(#00c896)으로 설정 */
    font-weight: bold; /* 숫자의 글자를 굵게 만듦 */
    margin-right: 10px; /* 숫자와 텍스트 사이에 10px 간격 추가 */
    border-radius: 5px; /* 숫자의 배경을 둥글게 설정 */
    border: 2px solid #24D59E; /* 링크에 녹색(#00c896) 테두리 추가 */
}

</style>

<aside class="main-sidebar sidebar-dark-primary elevation-4" 
			style="position: relative;  z-index: 2;
			width: 600px; height: 900px;
			border-top:1px solid #e5e5e5;">

	<!-- Sidebar -->
	<div class="sidebar">
		<!-- Sidebar user panel (optional) -->
		<div class=" mt-3 pb-3 ">
		</div>
<!-- 			<div class="image"> -->
<!-- 				<img src="/resources/icon/ReadyGo-로고(초록).png" -->
<!-- 					alt="Logo"> -->
<!-- 			</div> -->

		<!-- Sidebar Menu -->
		<nav class="mt-2">
			<ul class="nav nav-pills nav-sidebar flex-column"
				data-widget="treeview" role="menu" data-accordion="false">
				<li class="nav-item nav_main">
					<a href="/oustou/regist1" class="nav-link" > 
					<div class="number">1</div>
						<p>
							&nbsp;&nbsp;기본정보 
						</p>
					</a>
				</li>
				<li class="nav-item nav_main">
					<a href="/oustou/regist2" class="nav-link"> 
					<div class="number">2</div>
						<p>
							&nbsp;&nbsp;가격설정
						</p>
					</a>
				</li>
				<li class="nav-item nav_main">
					<a href="/oustou/regist3" class="nav-link"> 
					<div class="number">3</div>
						<p>
							&nbsp;&nbsp;서비스 설명
						</p>
					</a>
				</li>
				<li class="nav-item nav_main">
					<a href="/oustou/regist4" class="nav-link"> 
					<div class="number">4</div>
						<p>
							&nbsp;&nbsp;이미지 
						</p>
					</a>
				</li>
				<li class="nav-item nav_main">
					<a href="/oustou/regist5" class="nav-link"> 
					<div class="number">5</div>
						<p>
							&nbsp;&nbsp;요청사항 
						</p>
					</a>
				</li>
			</ul>
		</nav>
		<!-- /.sidebar-menu -->
	</div>
</aside>