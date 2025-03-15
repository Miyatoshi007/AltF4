<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Dashboard</title>
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
<style>
body {
	font-family: "Roboto", sans-serif;
	margin: 0;
	background: #f8fafc;
	color: #333;
	transition: background 0.3s ease, color 0.3s ease;
}

.sidebar {
	width: 250px;
	position: fixed;
	top: 0;
	left: 0;
	height: 100vh;
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

.content {
	margin-left: 250px;
	padding: 30px;
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

.card {
	border: none;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	background: #fff;
	transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.card:hover {
	transform: translateY(-5px);
	box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
}

.card .badge {
	font-size: 20px;
	font-weight: bold;
	background: #007bff;
	color: #fff;
	padding: 5px 10px;
	border-radius: 8px;
}

@media ( max-width : 768px) {
	.sidebar {
		width: 100%;
		position: static;
		height: auto;
	}
	.content {
		margin-left: 0;
	}
}
</style>
</head>
<body>
	<%@ include file="./adminComponent/sidebar.jsp"%>

	<!-- Content -->
	<div class="content">
		<!-- Navbar -->
		<%@ include file="./adminComponent/navbar.jsp"%>

		<!-- Overview Cards -->
		<div class="row mt-4">
			<div class="col-md-3">
				<div class="card text-center">
					<h5 class="card-title mt-3">Tổng số học viên</h5>
					<span class="badge">${ countUser }</span>
				</div>
			</div>
			<div class="col-md-3">
				<div class="card text-center">
					<h5 class="card-title mt-3">Số khóa học</h5>
					<span class="badge">${ countCourse }</span>
				</div>
			</div>
			<div class="col-md-3">
				<div class="card text-center">
					<h5 class="card-title mt-3">Doanh thu tháng</h5>
					<span class="badge">15,000,000đ</span>
				</div>
			</div>
			<div class="col-md-3">
				<div class="card text-center">
					<h5 class="card-title mt-3">Khóa học bán chạy</h5>
					<span class="badge">HTML Basics</span>
				</div>
			</div>
		</div>
	</div>


</body>
</html>
