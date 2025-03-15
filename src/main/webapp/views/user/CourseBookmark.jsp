<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Danh sách khóa học</title>
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
	margin: 0;
	padding: 0;
}

:root {
	--primary-color: #0066cc;
	--secondary-color: #ff5722;
	--nav-font-color: #f05123;
	--light-color: #ffffff;
	--text-muted: #555;
	--background-light: #ffffff;
	--background-footer: #f8f9fa;
	--hover-shadow: rgba(0, 0, 0, 0.15);
}

.navbar {
	background-color: var(--primary-color) !important;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	z-index: 1050; /* Navbar stays on top */
}

.navbar .nav-link {
	color: var(--light-color) !important;
	font-weight: 500;
	transition: color 0.3s ease;
}

.navbar .nav-link:hover, .navbar .nav-link.active {
	color: var(--nav-font-color) !important;
	font-weight: 600;
}

.navbar-brand img {
	transition: transform 0.3s ease;
}

.navbar-brand img:hover {
	transform: scale(1.1);
}

/* Sidebar styles */
.sidebar {
	background-color: #f4f4f4;
	height: 100%;
	padding-top: 20px;
	position: fixed;
	top: 87px; /* Adjust to prevent overlap with sticky navbar */
	left: 0;
	width: 250px;
	box-shadow: 2px 0px 5px rgba(0, 0, 0, 0.1);
	z-index: 1030; /* Sidebar stays below the navbar */
}

.sidebar .nav-link {
	color: #333;
	padding: 10px;
	text-transform: uppercase;
	font-weight: 600;
}

.sidebar .nav-link:hover {
	background-color: var(--primary-color);
	color: white;
}

.sidebar .nav-link.active {
	background-color: var(--primary-color);
	color: white;
}

/* Main content styles */
.main-content {
	margin-left: 250px;
	/* Offset the main content to the right of the sidebar */
	padding: 40px;
}

.course-card {
	background-color: var(--background-light);
	border-radius: 8px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	margin-bottom: 20px;
	transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.course-card:hover {
	transform: translateY(-8px);
	box-shadow: 0px 6px 20px rgba(0, 0, 0, 0.1);
	cursor: pointer;
}

.course-card img {
	display: block;
	width: 100%;
	height: auto;
	border-radius: 8px 8px 0 0;
}

.course-card .card-body {
	padding: 20px;
}

.course-card .card-footer {
	background-color: #f9f9f9;
	text-align: right;
	padding: 10px 20px;
}

.card-title {
	font-weight: bold;
	color: var(--primary-color);
}

.btn-custom {
	background-color: var(--secondary-color);
	color: white;
	font-weight: bold;
	border: none;
	padding: 8px 16px;
	border-radius: 5px;
	transition: background 0.3s ease;
}

.btn-custom:hover {
	background-color: darkred;
}

/* Footer */
footer {
	background-color: var(--secondary-color);
	padding: 30px 0;
	z-index: 1050; /* Ensure footer is above sidebar */
}

footer h5 {
	font-weight: 700;
	color: var(--primary-color);
	margin-bottom: 20px;
}

footer .footer-link {
	color: var(--primary-color);
	transition: color 0.3s ease;
}

footer .footer-link:hover {
	text-decoration: underline;
	color: var(--cta-color);
}

footer .fa-brands {
	transition: transform 0.3s ease;
}

footer .fa-brands:hover {
	transform: scale(1.2);
}
</style>
</head>
<body>
	<%@ include file="./userComponent/navbar.jsp"%>

	<%@ include file="./userComponent/sidebar.jsp"%>

	<!-- Main Content -->
	<div class="main-content">
		<h2 class="mb-5">Danh sách khóa học đã lưu</h2>
		<div class="row row-cols-1 row-cols-md-3 g-4">
			<!-- Course Card -->
			<div class="col">
				<div class="card course-card">
					<img src="https://via.placeholder.com/300x180" class="card-img-top"
						alt="Course Thumbnail" />
					<div class="card-body">
						<h5 class="card-title">Khóa học Lập trình Java</h5>
						<p class="card-text">Học lập trình Java từ cơ bản đến nâng
							cao.</p>
					</div>
					<div class="card-footer">
						<button class="btn btn-custom" onclick="viewCourse()">
							Xem khóa học</button>
						<button class="btn btn-danger" onclick="deleteCourse()">
							Xóa</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="./userComponent/footer.jsp"%>
</body>
</html>
