<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Cập nhật thông tin</title>
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

/* Page Section */
.update-section {
	padding: 60px 20px;
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
			<h2>Cập nhật thông tin cá nhân</h2>
			<div class="form-section">
				<form action="/ASM/user/profile/updateProfile" method="post">
					<!-- Full Name -->
					<div class="form-group">
						<label for="fullName">Họ và tên</label> <input type="text"
							class="form-control" id="fullName" name="fullName"
							placeholder="Nhập họ và tên" value="${ currentUser.fullname }" />
					</div>

					<!-- Email -->
					<div class="form-group">
						<label for="email">Email</label> <input type="email"
							class="form-control" id="email" name="email"
							placeholder="Nhập email" value="${ currentUser.email }" />
					</div>

					<!-- Phone -->
					<div class="form-group">
						<label for="phone">Số điện thoại</label> <input type="text"
							class="form-control" id="phone" name="phoneNumber"
							placeholder="Nhập số điện thoại"
							value="${ currentUser.phoneNumber }" />
					</div>

					<!-- Address -->
					<div class="form-group">
						<label for="address">Địa chỉ</label> <input type="text"
							class="form-control" id="address" name="address"
							placeholder="Nhập địa chỉ" value="${ currentUser.address }" />
					</div>

					<!-- Update Button -->
					<div class="d-flex justify-content-center">
						<button type="submit" class="btn btn-primary" id="changeProfileButton" name="changeProfileButton">Cập nhật</button>
					</div>
				</form>
			</div>
		</div>
	</section>

	<div class="toast-container position-fixed bottom-0 end-0 p-3"
		style="z-index: 1055;">
		<div id="toastSuccess"
			class="toast align-items-center bg-success text-white border-0 shadow-lg"
			role="alert" aria-live="assertive" aria-atomic="true">
			<div class="d-flex">
				<div class="toast-body d-flex align-items-center">
					<i class="fas fa-exclamation-circle me-2 fs-5"></i> <span>Cập
						nhật thông tin thành công.</span>
				</div>
				<button type="button" class="btn-close btn-close-white me-2 m-auto"
					data-bs-dismiss="toast" aria-label="Close"></button>
			</div>
		</div>
		<div id="toastError"
			class="toast align-items-center bg-danger text-white border-0 shadow-lg"
			role="alert" aria-live="assertive" aria-atomic="true">
			<div class="d-flex">
				<div class="toast-body d-flex align-items-center">
					<i class="fas fa-exclamation-circle me-2 fs-5"></i> <span>Cập
						nhật thông tin thất bại.</span>
				</div>
				<button type="button" class="btn-close btn-close-white me-2 m-auto"
					data-bs-dismiss="toast" aria-label="Close"></button>
			</div>
		</div>
	</div>

	<%@ include file="./userComponent/footer.jsp"%>

	<!-- Script for showing toast -->
	<script>
		const urlParams = new URLSearchParams(window.location.search);
		const successParam = urlParams.get('success');

		if (successParam === 'updated') {
			const toast = new bootstrap.Toast(document
					.getElementById('toastSuccess'));
			toast.show();
		} else if (successParam === 'nullError') {
			const toast = new bootstrap.Toast(document
					.getElementById('toastError'));
			toast.show();
		}
	</script>
</body>
</html>
