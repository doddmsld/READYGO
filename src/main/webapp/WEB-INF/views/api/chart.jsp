<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>연도별 입사자수</title>
    <!-- chart.js 설치 -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<style>
 		.btn{
			border : 1px solid #24D59E;
 			border-radius : 5px;
 			height : 34px;
 			background: white;
 			color:#24D59E; 
 		}
 		.btn:hover{
 			background: #24D59E;
 			color: white;
 		}
 		#btnParent{
 			margin: 10px;
 			justify-content: flex-end;
 			display: flex;
 		}
</style>
<body>
	<div id="btnParent">
    <button class="btn" onclick="fChgType()">타입 변경</button>
	</div>
    <!-- 차트 크기는 부모 크기를 조절하면 거기에 맞게 자동으로 맹글어짐-->
    <div style="width:auto;height:auto;border:2px solid none; background: white; border-radius: 9px;">
        <!-- 차트 그릴 위치 지정 canvas webGL(그래픽엔진) 사용 -->
        <canvas id="myChart"></canvas>
    </div>
    <script>
        // 버튼 눌렀을 때 실행
        function fChg() {
            //값 재 할당!
            mChart.data.datasets[0].data = fRanArrData();
            mChart.data.datasets[1].data = fRanArrData();
            //chart.js에서 가장 중요한 메소드, 다시 그려랑(re rendering)
            mChart.update();
        }

        let isToggle = false;
        function fChgType() {
            // 오직 bar와 line만 믹스 가능(생각해 보면 그냥 이해됨)
            if (isToggle) {
                mChart.data.datasets[0].type = "bar";
                mChart.data.datasets[1].type = "line";
            } else {
                mChart.data.datasets[0].type = "line";
                mChart.data.datasets[1].type = "bar";
            }
            mChart.update();
            isToggle = !isToggle;
        }


        const ctx = document.querySelector('#myChart');

        const mChart = new Chart(ctx, {
            type: 'bar',  // bar, line, pie, doughnut, radar 등등...
            data: {
                labels: ['2023.8', '2023.9', '2023.10', '2023.11', '2023.12', '2024.1', '2024.2', '2024.3', '2024.4', '2024.5', '2024.6', '2024.7', '2024.8'],
                datasets: [
                    {
                        label: '전체인원',
                        data: [100, 120, 110, 100, 110, 115, 120, 100, 110, 115, 120, 115, 120],
                        borderWidth: 1,
                    },
                    {
                        label: '입사자',
                        data: [10, 19, 13, 15, 12, 13, 9, 10, 19, 13, 15, 12, 13],
                        borderWidth: 1,
                    },
                    {
                        label: '퇴사자',
                        data: [1, 2, 3, 4, 4, 5, 1, 1, 1, 3, 1, 2, 5],
                        borderWidth: 1
                    }
                ]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
        // mChart에 담긴 값 확인, 누느로 꼬옥 화긴하장!
        console.log("labels:", mChart.data.labels);
        console.log("labels:", mChart.data.datasets[0]);
        console.log("labels:", mChart.data.datasets[1].label);
        console.log("labels:", mChart.data.datasets[1].data);


    </script>
</body>

</html>