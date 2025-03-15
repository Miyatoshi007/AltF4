<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Đổi mật khẩu</title>
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
/* Global Styles */
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

.update-section {
	margin-left: 250px;
	margin-top: 20px;
	margin-bottom: 20px;
	padding: 60px 20px;
	min-height: 50vh;
	padding: 30px 20px 60px 20px;
}

.update-section h2 {
	font-size: 2.4rem;
	font-weight: 700;
	text-align: center;
	margin-bottom: 40px;
}

.form-control {
	border-radius: 10px;
}

.btn-primary {
	background-color: var(--secondary-color);
	border: none;
	padding: 10px 20px;
	font-weight: 600;
	transition: background 0.3s ease;
}

.btn-primary:hover {
	background-color: darkred;
}

.form-section {
	max-width: 600px;
	margin: 0 auto;
	background: white;
	padding: 30px;
	border-radius: 10px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.form-group {
	margin-bottom: 20px;
}

.form-group label {
	font-weight: 600;
	color: #333;
}

.form-group input {
	padding: 10px;
}

.form-group .form-control:focus {
	box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
}

/* Footer */
footer {
	background-color: var(--secondary-color);
	padding: 30px 0;
	z-index: 1040; /* Ensure footer is above sidebar */
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

	<!-- Update User Information Section -->
	<section class="update-section">
		<div class="container">
			<h2>Đổi mật khẩu</h2>
			<div class="form-section">
				<c:if test="${ not empty errorMessage }">
					<div class="alert alert-danger" role="alert" id="errNotify">${ errorMessage }</div>
				</c:if>
				<c:if test="${ not empty successMessage }">
					<div class="alert alert-success" role="alert">${ successMessage }</div>
				</c:if>
				<form action="/ASM/user/changePassword" method="post">
					<div class="form-group">
						<label for="currentPassword">Mật khẩu hiện tại</label> <input
							type="password" class="form-control" id="currentPassword"
							name="currentPassword" value="${ oldPass }" placeholder="Nhập mật khẩu hiện tại" />
					</div>

					<!-- New Password -->
					<div class="form-group">
						<label for="newPassword">Mật khẩu mới</label> <input
							type="password" class="form-control" id="newPassword"
							name="newPassword" value="${ newPass }" placeholder="Nhập mật khẩu mới" />
					</div>

					<!-- Confirm New Password -->
					<div class="form-group">
						<label for="confirmNewPassword">Xác nhận mật khẩu mới</label> <input
							type="password" class="form-control" id="confirmNewPassword"
							name="confirmNewPassword" value="${ confirmNewPass }" placeholder="Xác nhận mật khẩu mới" />
					</div>

					<!-- Update Button -->
					<div class="d-flex justify-content-center">
						<button type="submit" class="btn btn-primary" id="changePasswordButton" name="changePasswordButton">Đổi mật
							khẩu</button>
					</div>
				</form>
			</div>
		</div>
	</section>

	<%@ include file="./userComponent/footer.jsp"%>
</body>
</html>