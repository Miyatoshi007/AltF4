<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Thống kê Doanh Thu Khóa Học</title>
<link
	href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&family=Roboto:wght@400;500&display=swap"
	rel="stylesheet" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
body {
	font-family: "Roboto", sans-serif;
	margin: 0;
	background: #f8fafc;
	color: #333;
	display: flex;
	height: 100vh; /* Đảm bảo body chiếm toàn bộ chiều cao màn hình */
	overflow: hidden; /* Giúp tránh thanh cuộn thừa */
}

.sidebar {
	width: 250px;
	position: fixed;
	top: 0;
	left: 0;
	height: 100vh; /* Sidebar chiếm hết chiều cao màn hình */
	background: linear-gradient(135deg, #0056b3, #007bff);
	color: #fff;
	padding: 20px 15px;
	overflow-y: auto;
	box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
}

.sidebar h3 {
	text-align: center;
	font-size: 22px;
	margin-bottom: 30px;
	font-weight: bold;
}

.sidebar .list-group-item {
	font-size: 15px;
	border-radius: 6px;
	background: transparent;
	color: #fff;
	border: none;
	margin-bottom: 10px;
	transition: background 0.3s ease, transform 0.2s ease;
}

.sidebar .list-group-item.active {
	background-color: #ff4500;
	font-weight: bold;
	transform: translateX(10px);
}

.sidebar .list-group-item:hover {
	background-color: rgba(255, 255, 255, 0.2);
}

.navbar {
	background: #fff;
	padding: 15px 20px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.navbar .navbar-brand {
	font-weight: bold;
	color: #0056b3;
}

.navbar .navbar-dark-mode-btn {
	border: none;
	background: none;
	color: #007bff;
	font-size: 18px;
	cursor: pointer;
	transition: color 0.3s ease;
}

.navbar .navbar-dark-mode-btn:hover {
	color: orangered;
}

.content {
	margin-left: 250px;
	padding: 30px;
	width: calc(100% - 250px); /* Phần nội dung chiếm phần còn lại */
	max-width: 100%;
	height: 100vh; /* Đảm bảo content chiếm toàn bộ chiều cao màn hình */
	overflow-y: auto; /* Cho phép cuộn nếu cần thiết */
}

.chart-container {
	position: relative;
	height: calc(100% - 168px);
	/* Đảm bảo biểu đồ chiếm toàn bộ chiều cao còn lại */
	width: 100%;
	margin: 0 auto;
	box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.1);
	background-color: #fff;
	border-radius: 8px;
	padding: 20px;
}

h1 {
	font-size: 2.5rem;
	color: #333;
	margin-bottom: 30px;
	font-weight: bold;
}

@media ( max-width : 768px) {
	.content {
		margin-left: 0;
		width: 100%;
		height: auto; /* Với màn hình nhỏ, chiều cao content không cần fix */
	}
}
</style>
</head>
<body>
	<%@ include file="./adminComponent/sidebar.jsp"%>

	<div class="content">
		<%@ include file="./adminComponent/navbar.jsp"%>

		<h1 class="my-4">Thống kê Doanh Thu Khóa Học</h1>

		<div class="chart-container">
			<canvas id="revenueChart"></canvas>
		</div>

		<script>
			// Dữ liệu doanh thu các khóa học
			const revenueData = {
				labels : [ "HTML cơ bản", "JavaScript nâng cao",
						"React.js cho người mới bắt đầu", ],
				datasets : [ {
					label : "Doanh Thu (VND)",
					data : [ 1200000, 55000000, 1800000 ], // Thay bằng doanh thu thực tế
					backgroundColor : "rgba(54, 162, 235, 0.6)", // Màu nền cho các cột
					borderColor : "rgba(54, 162, 235, 1)", // Màu đường viền
					borderWidth : 1,
				}, ],
			};

			// Tạo biểu đồ
			const ctx = document.getElementById("revenueChart")
					.getContext("2d");
			const revenueChart = new Chart(ctx, {
				type : "bar",
				data : revenueData,
				options : {
					responsive : true,
					plugins : {
						legend : {
							position : "top",
							labels : {
								font : {
									family : "'Montserrat', sans-serif",
									weight : "bold",
								},
							},
						},
					},
					scales : {
						x : {
							beginAtZero : true,
						},
						y : {
							beginAtZero : true,
							ticks : {
								callback : function(value) {
									return value.toLocaleString(); // Hiển thị số với dấu phẩy
								},
							},
						},
					},
				},
			});
		</script>
	</div>

	<script src="./../../assets/js/bootstrap.bundle.min.js"></script>
</body>
</html>
