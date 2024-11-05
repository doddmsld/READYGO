<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/ckeditor5/ckeditor.js"></script>
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
    margin-left: 15%;
}

table {
    width: 100%;
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
    margin-bottom: 10px;
    margin-top: 50px;
}

input[type="text"] {
    width: 80%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

.search-button, .filter-button {
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    background-color: #FD5D6C;
    color: white;
    width: 120px;
}

.filter-button:hover {
    background-color: white;
    color: #FD5D6C;
    border: 1px solid #FD5D6C;
}

.filter-buttons {
    display: flex;
    justify-content: center;
    gap: 100px;
    margin-bottom: 20px;
}

colgroup col:nth-child(2) {
    width: 50%;
    text-align: left;
}

table thead {
    border-bottom: 2px solid #000;
}

table thead th, table tbody td {
    padding: 10px;
    font-size: 14px;
    border-bottom: 1px solid #ddd;
}

.pagination {
    text-align: center;
    margin-top: 10px;
}

.pagination a {
    border: 1px solid #ddd;
    padding: 5px 10px;
    color: black;
    border-radius: 5px;
    text-decoration: none;
}

.pagination a.active {
    background-color: #FD5D6C;
    color: white;
}

.pagination a:hover:not(.active) {
    background-color: #ddd;
}
.button-container {
    text-align: right;
    margin-top: 20px;
}
.free-title:hover{
	text-decoration: underline;
}
</style>
<body>
    <div class="container">
        <header>
            <h1>자유 게시판</h1>
        </header>
        <div class="search-container">
            <input type="text" placeholder="게시물을 검색하세요">
            <button type="button" class="search-button">검색</button>
        </div>
        <div class="filter-buttons">
            <button type="button" class="filter-button">전체글</button>
            <button type="button" class="filter-button">신입</button>
            <button type="button" class="filter-button">취업</button>
            <button type="button" class="filter-button">자소서</button>
            <button type="button" class="filter-button">면접</button>
            <button type="button" class="filter-button">Q&A</button>
        </div>
        <table>
            <colgroup>
                <col>
                <col>
                <col>
                <col>
                <col>
            </colgroup>
            <thead>
                <tr>
                    <th style="text-align: center;">카테고리</th>
                    <th style="text-align: center;">제목</th>
                    <th style="text-align: center;">작성자</th>
                    <th style="text-align: center;">작성일</th>
                    <th style="text-align: center;">조회수</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td style="text-align: center;">1</td>
                    <td class="free-title" style="text-align: left;">2</td>
                    <td style="text-align: center;">2</td>
                    <td style="text-align: center;">2</td>
                    <td style="text-align: center;">2</td>
                </tr>
            </tbody>
        </table>
        <div class="pagination">
            <a href="#">&laquo;</a>
            <a href="#">1</a>
            <a href="#" class="active">2</a>
            <a href="#">3</a>
            <a href="#">4</a>
            <a href="#">5</a>
            <a href="#">&raquo;</a>
        </div>
        
        <div class="button-container">
            <button type="button" class="btn filter-button">등록</button>
        </div>
    </div>
</body>
