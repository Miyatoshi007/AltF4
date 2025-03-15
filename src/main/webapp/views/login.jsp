<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8" />
<title>Trang Đăng Nhập</title>

<!-- Bootstrap 5.0.2 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>

<!-- Font Awesome for icons -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet" />

<!-- Custom CSS -->
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
	background-size: 300px 300px; /* Tăng khoảng cách của các chấm */
	background-position: 0 0, 150px 150px;
	/* Điều chỉnh vị trí của các chấm để giảm sự chồng chéo */
	overflow: hidden;
}

.login-container {
	width: 100%;
	max-width: 400px;
	padding: 30px;
	background-color: #fff;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.login-container .form-control {
	border-radius: 30px;
	padding: 15px;
}

.login-btn {
	background-color: #0066cc;
	color: white;
	border-radius: 30px;
	padding: 12px;
	font-weight: bold;
	border: none;
	width: 100%;
	transition: background-color 0.3s;
}

.login-btn:hover {
	background-color: #005bb5;
}

.login-logo {
	text-align: center;
	margin-bottom: 20px;
}

.login-logo img {
	width: 100px;
	height: 100px;
}

.form-group {
	margin-bottom: 20px;
}

.forgot-password {
	text-align: center;
	font-size: 14px;
}

.forgot-password a {
	color: #0066cc;
	text-decoration: none;
}

.forgot-password a:hover {
	text-decoration: underline;
}

.register-link {
	text-align: center;
	margin-top: 15px;
	font-size: 14px;
}

.register-link a {
	color: #0066cc;
	text-decoration: none;
}

.register-link a:hover {
	text-decoration: underline;
}

.toast {
	border-radius: 8px;
	overflow: hidden;
	animation: fadeInUp 0.5s ease;
	background: linear-gradient(135deg, #ff6a6a, #ff4747);
	/* Gradient đỏ đẹp */
	color: #fff;
}

.toast-body {
	font-size: 14px;
	font-weight: 500;
	letter-spacing: 0.5px;
}

.toast-container {
	animation: slideInUp 0.4s ease;
	z-index: 1055;
}

/* Animation xuất hiện */
@
keyframes fadeInUp {from { opacity:0;
	transform: translateY(50px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}

/* Animation vào màn hình */
@
keyframes slideInUp {from { transform:translateY(100%);
	
}

to {
	transform: translateY(0);
}
}
</style>
</head>
<body>
	<div class="login-container">
		<div class="login-logo">
			<img src="./assets/img/LOGO_AltF4_11.png" alt="Logo" />
			<h4 class="mt-3">Đăng Nhập</h4>
		</div>

		<c:if test="${not empty errorMessage}">
			<div class="alert alert-danger text-center" role="alert" id="errNotify">
				${errorMessage}</div>
		</c:if>


		<form action="/ASM/login" method="post">
			<div class="form-group">
				<label for="email">Email</label> <input type="text"
					class="form-control" id="email" name="email"
					placeholder="Nhập email của bạn"
					value="${ email != null ? email : '' }" />
			</div>

			<div class="form-group">
				<label for="password">Mật khẩu</label> <input type="password"
					class="form-control" id="password" name="password"
					placeholder="Nhập mật khẩu của bạn"
					value="${ password != null ? password : '' }" />
			</div>

			<button type="submit" class="btn login-btn" name="loginbutton" id="loginbutton">Đăng Nhập</button>

			<div class="forgot-password mt-3">
				<a href="/ASM/forgotPass">Quên mật khẩu?</a>
			</div>

			<div class="register-link mt-3">
				Chưa có tài khoản? <a href="/ASM/signup">Đăng ký ngay</a>
			</div>
		</form>
	</div>

	<div class="toast-container position-fixed top-0 end-0 p-3"
		style="z-index: 1055;">
		<div id="unauthorizedToast"
			class="toast align-items-center text-white border-0 shadow-lg"
			role="alert" aria-live="assertive" aria-atomic="true">
			<div class="d-flex">
				<div class="toast-body d-flex align-items-center">
					<i class="fas fa-exclamation-circle me-2 fs-5"></i> <span>Bạn
						phải đăng nhập để tiếp tục.</span>
				</div>
				<button type="button" class="btn-close btn-close-white me-2 m-auto"
					data-bs-dismiss="toast" aria-label="Close"></button>
			</div>
		</div>
	</div>

	<div class="toast-container position-fixed top-0 end-0 p-3"
		style="z-index: 1055;">
		<div id="lockAccountToast"
			class="toast align-items-center text-white border-0 shadow-lg"
			role="alert" aria-live="assertive" aria-atomic="true">
			<div class="d-flex">
				<div class="toast-body d-flex align-items-center">
					<i class="fas fa-exclamation-circle me-2 fs-5"></i> <span>Tài
						khoản này hiện đang bị vô hiệu hóa.</span>
				</div>
				<button type="button" class="btn-close btn-close-white me-2 m-auto"
					data-bs-dismiss="toast" aria-label="Close"></button>
			</div>
		</div>
	</div>

	<script>
    document.addEventListener("DOMContentLoaded", () => {
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get("error") === "unauthorized") {
            const toastEl = document.getElementById("unauthorizedToast");
            const toast = new bootstrap.Toast(toastEl);
            toast.show();
        }
        if (urlParams.get("error") === "account_locked") {
            const toastEl = document.getElementById("lockAccountToast");
            const toast = new bootstrap.Toast(toastEl);
            toast.show();
        }
    });
</script>
</body>
</html>
