<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript" src="../../resources/js/jquery.min.js"></script>
<script>
$(document).ready(function() {
    // 버튼 클릭 시 AJAX 요청
    $('#submitButton').on('click', function() {
        const selectedOption = $('input[name="languageOption"]:checked').attr('id');
        const scoreInput = $('#LanguageInput').val();
        const score = parseInt(scoreInput, 10);

        console.log("선택된 옵션:", selectedOption);
        console.log("입력된 점수:", scoreInput);

        // 선택된 옵션 및 점수 유효성 검사
        if (!selectedOption) {
            alert("언어 옵션이 선택되지 않았습니다.");
            return;
        }

        if (isNaN(score) || score <= 0) {
            alert("유효한 점수를 입력해주세요.");
            return;
        }

        let minScore, maxScore;

        switch (selectedOption) {
            case 'toeic':
                minScore = 320;
                maxScore = 990; // 토익 점수 범위
                break;
            case 'newTeps':
                minScore = 143;
                maxScore = 600; // 텝스 점수 범위
                break;
            case 'toefl':
                minScore = 17;
                maxScore = 120; // 토플 점수 범위
                break;
            default:
                minScore = 0;
                maxScore = 0;
        }

        if (score < minScore || score > maxScore) {
            alert(`입력한 어학점수는 \${minScore}에서 \${maxScore} 사이여야 합니다.`);
            $('#LanguageInput').val(''); // 잘못된 입력을 지우기
            return; // 잘못된 입력 시 함수 종료
        }

        var inputData = {
            score: score,
            selectedOption: selectedOption
        };

        // AJAX 요청
        $.ajax({
            url: '/common/jobTools/language', // 요청할 URL
            type: 'GET', // HTTP 메서드
            data: inputData, // 전송할 데이터
            success: function(response) {
                // 변환된 어학 점수 출력 response => convertScore 리스트
                $('#transform tbody').empty().show();

                $.each(response, function(index, item) {
                    $('#transform tbody').append(
                        '<tr>' +
                        '<td class="table-cell"> 뉴텝스 (New TEPS)</td>' +
                        '<td class="text-right">' + item.newTeps + '점</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td class="table-cell"> 토익 (TOEIC)</td>' +
                        '<td class="text-right">' + item.toeic + '점</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td class="table-cell"> 토플 (TOEFL)</td>' +
                        '<td class="text-right">' + item.toefl + '점</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td class="table-cell"> 오픽 (OPIC)</td>' +
                        '<td class="text-right">' + item.opic + '점</td>' +
                        '</tr>'
                    );
                });
                $('#transform').show();
                $('#hiddenText').hide();
            },
            error: function(xhr, status, error) {
                // 오류 발생 시 처리할 코드 
                console.error(error);
            }
        });
    });
    
 // 초기화 버튼 동작 추가
    $('#reset').on('click', function() {
    	// 입력 필드 초기화
        $('#LanguageInput').val(''); // 점수 입력 필드 비우기
        $('input[name="languageOption"]').prop('checked', false); // 라디오 버튼 초기화
        $('#hiddenText').show(); // 초기 메시지 보이기
        $('#transform').hide(); // 결과 테이블 숨기기

    });
});
</script>


<!-- 1행 영역 -->
<h3>취업TOOL</h3>
<div class="row">
	<!-- /// 리스트 시작 /// -->
	<div class="col-md-8" style="width: 100%;">
		<div class="card2">
			<div class="card2-body">

				<div id="categoryTap">
					<input type="button" id="spelling" value="글자수세기" onclick="location.href='/common/jobTools/spellingCheck'"> 
					<input type="button" id="salary" value="연봉 계산기" onclick="location.href='/common/jobTools/salaryCal'">
					<input type="button" id="netPay" value="실수령액 계산기" onclick="location.href='/common/jobTools/netPayCal'">
					<input type="button" id="credit" value="학점 변환기" onclick="location.href='/common/jobTools/creditTrans'">
					<input type="button" id="language" value="어학점수 변환기" onclick="location.href='/common/jobTools/languageTrans'">
				</div>
				
				<!-- 맞춤법검사, 글자수세기 시작 -->
				<div id="languageTransPage">
					<!-- 텍스트 입력 Div -->
					<div id="inputText">
					<label class="title">어학 시험 종류</label><br>
						<div id="inputDiv">
							<div class="btn-group btn-group-toggle custom-btn-group" data-toggle="buttons">
					                <label class="btn btn-secondary">
					                    <input type="radio" name="languageOption" id="toeic" autocomplete="off" checked=""> 토익 (TOEIC)
					                </label>
					                <label class="btn btn-secondary">
					                    <input type="radio" name="languageOption" id="newTeps" autocomplete="off"> 텝스 (TEPS)
					                </label>
					                <label class="btn btn-secondary">
					                    <input type="radio" name="languageOption" id="toefl" autocomplete="off"> 토플 (TOEFL)
					                </label>
					            </div>
						</div>
						<label class="title">나의 어학 점수</label><br>
						<div id="inputDiv">
							<input id="LanguageInput" class="inputStyle" type="text" placeholder="0"> 
							&nbsp;<span style="font-weight: 400 !important; font-size: 12px;">점</span>
						</div>
					</div>
					<!-- 결과출력 Div -->
					<div id="result">
						<div id="topDiv">
						<p>변환 결과</p>
						</div>
						<div id="resultBox">
							<p id="hiddenText">두 자리 이상 점수를 입력해주세요</p>
								<div id="transform" style="display: none;">
									<table style="width:100%;" class="table table-bordered custom-table">
										<tbody></tbody>
									</table>
								</div>
						</div>
						<div id="btnflex">
	 						<button class="btnStyle" id="submitButton" type="button">변환하기</button> 
							<button class="btnStyle" id="reset" type="button">초기화</button>
						</div>
					</div>
				</div> <!-- 어학점수 변환기 끝  -->
			</div>
		</div>
	</div>
</div>

<style> 


#categoryTap {
	display: flex;
	align-items: center;
	border-top: 1px solid #ccc; 
	justify-content: center;
}

#spelling, #salary, #netPay, #credit, #language{
	width: 100%;
	height: 70px;
	font-size : 14px;
	border: none; 
    background: none; 
    cursor: pointer;
	transition: background-color 0.3s;
	
}
#language{
	text-decoration: underline;
	color : #24D59E;
}

#categoryTap input[type="button"]:hover {
    color: #24D59E;
    text-decoration: underline;
}

.row {
	margin: 0px 24% 0px 24%;
	min-height : 650px;
}

h3 {
margin : 50px 0px 15px 26%;
}

#languageTransPage{
	height : 280px;
	display : flex;
}
#inputText{
	width : 60%;
	height : 280px;
	border : 1px solid #ccc; 
	background-color: rgba(245, 255, 255, 1);
}

#result{
	width : 40%;
	height : 280px;
	border : 1px solid #ccc;
	border-left : none;
	display: flex; 
    flex-direction: column; /* 세로 방향으로 쌓이도록 설정 */
    align-items: center;  
}

.title {
	margin: 40px 11% 10px 15%;
	font-weight: 600 !important;
	font-size: 14px;
}

#textCount p{
	font-size: 12px;
}

#topDiv{
	width : 100%;
	background: linear-gradient(to right, #2CCFC3, #24D59E);
	height: 60px;
	align-items: center;
	padding: 15px;
}

#topDiv p{
	color : white;
	font-size: 17px;
}

.btnStyle {
color: white;
background-color: #24D59E;
border: 1px solid #EBEBEB;
border-radius: 5px;
width: 120px;
padding: 8px 20px 8px 20px;
margin : 0 10px;
transition: all 0.3s ease 0s;
}

.btnStyle:hover {
background-color: #24D59E;
color: white;
}
#resultBox {
	width : 100%;
	display: flex; /* Flexbox 사용 */
    justify-content: center; /* 가로 방향 중앙 정렬 */
    align-items: center;
    height : 140px;
/*      margin : 5px;  */
}
.inputStyle{
	height : 40px;
	width : 110px;
	border: 1px solid #D9D9D9;
}
#inputDiv{
	margin : 2% 0 0 15%;
}
.custom-btn-group .btn {
    background-color: white; 
    color: #6B6B6B; 
    border-radius: 1px;
    border: 1px solid #D9D9D9;
    font-size: 14px;
    font-weight: 400;
    padding: 10px 15px;
}

.custom-btn-group .btn.active {
    background-color: #6B6B6B; /* 활성화된 버튼 색상 */
     color: white;
}

.custom-btn-group .btn:hover {
    background-color: #6B6B6B; /* 호버 시 색상 */
     color: white;
}
#btnflex{
	display : flex;
	margin-top: 20px; /* btnflex 위 여백 추가 */
}
.table-cell {
        padding: 0px 40px 0px 0px; /* 원하는 패딩 크기로 조정 */
    }
.custom-table {
	margin : 5px 0px 5px 0px;
    border-collapse: collapse; /* 테두리 겹침 방지 */
     border-left: none; /* 세로선 제거 */
    border-right: none; /* 세로선 제거 */
}

.custom-table td {
/*   	padding : 8px 20px 8px 20px;   */
    border-left: none; /* 세로선 제거 */
    border-right: none; /* 세로선 제거 */
    font-size: 12px;
}
#transform{
	width : 100%;
}
</style>