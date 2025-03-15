<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8" />
<title>Trang Đăng Ký</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet" />
<style>
body {
	background-color: #f4f7fc;
	font-family: "Arial", sans-serif;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
	background: radial-gradient(circle, rgba(0, 102, 204, 0.1) 20%,
		rgba(0, 102, 204, 0) 40%),
		radial-gradient(circle, rgba(0, 102, 204, 0.05) 30%,
		rgba(0, 102, 204, 0) 60%);
	background-size: 300px 300px;
	background-position: 0 0, 150px 150px;
	overflow: hidden;
}

.register-container {
	width: 100%;
	max-width: 400px;
	padding: 30px;
	background-color: #fff;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.register-container .form-control {
	border-radius: 30px;
	padding: 15px;
}

.register-btn {
	background-color: #0066cc;
	color: white;
	border-radius: 30px;
	padding: 12px;
	font-weight: bold;
	border: none;
	width: 100%;
	transition: background-color 0.3s;
}

.register-btn:hover {
	background-color: #005bb5;
}

.register-logo {
	text-align: center;
	margin-bottom: 20px;
}

.register-logo img {
	width: 100px;
	height: 100px;
}

.form-group {
	margin-bottom: 20px;
}

.already-account {
	text-align: center;
	font-size: 14px;
}

.already-account a {
	color: #0066cc;
	text-decoration: none;
}

.already-account a:hover {
	text-decoration: underline;
}

.error-message {
	color: red;
	font-size: 14px;
	margin-bottom: 10px;
	text-align: center;
}
</style>
</head>
<body>
	<div class="register-container">
		<div class="register-logo">
			<img src="/ASM/assets/img/LOGO_AltF4_11.png" alt="Logo" />
			<h4 class="mt-3">Đăng Ký</h4>
		</div>

		<c:if test="${not empty errorMessage}">
			<div class="error-message" id="errNotify">${errorMessage}</div>
		</c:if>

		<form action="/ASM/signup" method="post">
			<div class="form-group">
				<label for="email">Email</label> <input type="text"
					class="form-control" id="email" name="email"
					placeholder="Nhập email của bạn" value="${emailRegister}" />
			</div>

			<div class="form-group">
				<label for="password">Mật khẩu</label> <input type="password"
					class="form-control" id="password" name="password"
					placeholder="Nhập mật khẩu của bạn" value="${passwordRegister}" />
			</div>

			<div class="form-group">
				<label for="confirm-password">Xác nhận mật khẩu</label> <input
					type="password" class="form-control" id="confirm-password"
					name="confirm-password" placeholder="Nhập lại mật khẩu"
					value="${confirmpasswordRegister}" />
			</div>

			<button type="submit" class="btn register-btn" id="signupButton" name="signupButton">Đăng Ký</button>

			<div class="already-account mt-3">
				Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng
					nhập ngay</a>
			</div>
		</form>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
</body>
</html>
