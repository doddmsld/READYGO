<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.content-wrapper {
    background-color: white;
    font-family: pretendard;
}
.page-link {
    color: black; 
    border-radius: 7px; 
    margin:5px;
}
/* 버튼클릭했을 때! */
.page-item.active .page-link {
    z-index: 3;
    color: #24D59E;
    background-color: rgba(44, 207, 195, 0.11); 
    border-radius: 7px;
}
.write_date{
	text-align: center;
}
</style>

<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<section class="content-header">
	<div class="container-fluid">
		<div class="row mb-2" style="margin-left: 150px;">
			<div class="col-sm-6">
				<h1>공지 게시판<br><br></h1>
			</div>
		</div>
	</div>
</section>

<div class="card-body table-responsive p-0" style="display: flex; justify-content: center;">
	<table class="table table-hover text-nowrap col-10">
		<thead>
			<tr>
				<th class="col-1">번호</th>
				<th class="write_date col-5">제목</th>
				<th class="write_date col-2">작성일</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td class="col-1">4</td>
				<td class="col-5">제목입니덩</td>
				<td class="write_date">24-09-11</td>
			</tr>
<!-- 			<tr>
				<td>3</td>
				<td>제목입니덩 제목입니덩</td>
				<td class="write_date">24-09-11</td>
			</tr>
			<tr>
				<td>2</td>
				<td>제목입니덩 제목입니덩!!!</td>
				<td class="write_date">24-09-11</td>
			</tr>
			<tr>
				<td>1</td>
				<td>제목입니덩 제목입니덩@@@</td>
				<td class="write_date">24-09-11</td>
			</tr> -->
		</tbody>
	</table>
</div>

<div class="dataTables_paginate"
	id="example2_paginate" style="display: flex; justify-content: center;">
	<ul class="pagination">
	<li></li>
		<li class="paginate_button page-item previous disabled"
			id="example2_previous"><a href="#" aria-controls="example2"
			data-dt-idx="0" tabindex="0" class="page-link">&lt;&lt;</a></li>
		<li class="paginate_button page-item previous disabled"
			id="example2_previous"><a href="#" aria-controls="example2"
			data-dt-idx="0" tabindex="0" class="page-link">&lt;</a></li>
		<li class="paginate_button page-item active"><a href="#"
			aria-controls="example2" data-dt-idx="1" tabindex="0"
			class="page-link">1</a></li>
		<li class="paginate_button page-item "><a href="#"
			aria-controls="example2" data-dt-idx="2" tabindex="0"
			class="page-link">2</a></li>
		<li class="paginate_button page-item "><a href="#"
			aria-controls="example2" data-dt-idx="3" tabindex="0"
			class="page-link">3</a></li>
		<li class="paginate_button page-item "><a href="#"
			aria-controls="example2" data-dt-idx="4" tabindex="0"
			class="page-link">4</a></li>
		<li class="paginate_button page-item "><a href="#"
			aria-controls="example2" data-dt-idx="5" tabindex="0"
			class="page-link">5</a></li>
		<li class="paginate_button page-item next" id="example2_next"><a
			href="#" aria-controls="example2" data-dt-idx="7" tabindex="0"
			class="page-link">&gt;</a></li>
		<li class="paginate_button page-item next" id="example2_next"><a
			href="#" aria-controls="example2" data-dt-idx="7" tabindex="0"
			class="page-link">&gt;&gt;</a></li>
		<li></li>
	</ul>
</div>
