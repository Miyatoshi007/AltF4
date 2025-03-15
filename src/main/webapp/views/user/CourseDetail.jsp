<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Trang chủ</title>
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
:root {
	--primary-color: #0066cc; /* Màu xanh chủ đạo */
	--secondary-color: #e3f2fd; /* Xanh nhạt */
	--cta-color: #0056b3; /* Màu nhấn cho nút */
	--nav-font-color: #f05123;
	--light-color: #ffffff;
	--text-color: #333; /* Màu chữ */
	--text-muted: #666; /* Màu chữ phụ */
	--background-footer: #f8f9fa;
	--white: #fff;
	--hover-shadow: rgba(0, 0, 0, 0.15);
}

/* Navbar */
.navbar {
	background-color: var(--primary-color) !important;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
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

/* Hero Section */
.hero-section {
	background: linear-gradient(to right, #007bff, #0056b3);
	color: white;
	text-align: center;
	padding: 60px 20px;
}

.hero-section h1 {
	font-size: 2.8rem;
	font-weight: 700;
	margin-bottom: 15px;
}

.hero-section p {
	font-size: 1.2rem;
	margin-bottom: 25px;
}

.hero-section .form-control {
	border: none;
	box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
}

.hero-section .btn-primary {
	padding: 10px 20px;
	background-color: var(--secondary-color);
	border: none;
	transition: background 0.3s ease;
}

.hero-section .btn-primary:hover {
	background-color: darkred;
}

/* Course Card */
.course-card {
	background-color: var(--white);
	border: none;
	border-radius: 8px;
	overflow: hidden;
	box-shadow: 0 4px 8px var(--hover-shadow);
	transition: transform 0.3s ease, box-shadow 0.3s ease;
	cursor: pointer;
}

.course-card:hover {
	transform: translateY(-10px);
	box-shadow: 0 8px 16px var(--hover-shadow);
}

.course-card img {
	border-bottom: 1px solid var(--secondary-color);
}

/* Course Details */
.course-details {
	padding: 20px;
	border-radius: 8px;
	background-color: var(--secondary-color);
	box-shadow: 0 4px 8px var(--hover-shadow);
}

.course-details h4 {
	font-weight: 700;
	color: var(--primary-color);
	margin-bottom: 20px;
}

.course-details ul {
	color: var(--text-color);
	list-style: none;
	padding-left: 0;
}

.course-details ul li {
	margin-bottom: 10px;
}

.course-details strong {
	color: var(--primary-color);
}

/* Footer */
footer {
	background-color: var(--secondary-color);
	padding: 30px 0;
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
	<fmt:setLocale value="vi_VN" />
	<%@ include file="./userComponent/navbar.jsp"%>

	<section class="hero-section">
		<div class="container">
			<h1>Đăng ký khóa học: ${ courseDetail.name }</h1>
			<p>Tham gia cùng hàng ngàn học viên học lập trình, xây dựng dự án
				và khởi đầu sự nghiệp.</p>
		</div>
	</section>

	<main class="container my-5">
		<div class="row">
			<!-- Course Details -->
			<div class="col-md-6 mb-4">
				<div class="card course-card">
					<img
						src="${ courseDetail.image != null ? courseDetail.image : 'https://via.placeholder.com/300x180' }"
						class="card-img-top" alt="Course Image" />
					<div class="card-body">
						<h5 class="course-title">${ courseDetail.name }</h5>
						<p class="card-text">${ courseDetail.description }</p>
					</div>
				</div>
			</div>

			<!-- Course Information -->
			<div class="col-md-6">
				<div class="course-details">
					<h4 class="mb-4 text-center">Thông tin chi tiết của khóa học</h4>
					<ul class="list-unstyled">
						<li><strong>Người tạo:</strong> ${ courseDetail.instructor.fullname }</li>
						<li><strong>Số lượng bài học:</strong> 14</li>
						<li><strong>Mô tả:</strong> ${ courseDetail.description }</li>
						<li><strong>Giá:</strong> <c:if
								test="${ courseDetail.pricesale != 0 }">
								<span style="text-decoration: line-through; color: gray"><fmt:formatNumber
										value="${ courseDetail.price }" type="currency" /> </span>
								<strong style="color: #f05123"><fmt:formatNumber
										value="${ courseDetail.pricesale }" type="currency" /></strong>
							</c:if> <c:if test="${ courseDetail.pricesale == 0 }">
								<strong style="color: #f05123">Miễn phí</strong>
							</c:if></li>
						<li><strong>Yêu cầu:</strong> ${ courseDetail.require }</li>
					</ul>
					<div class="d-flex justify-content-center mt-4">
						<!-- <button type="button" class="btn btn-primary rounded-pill px-5">
                Đăng ký ngay
              </button> -->
						<a class="btn btn-primary rounded-pill px-5"
							href="/ASM/user/enrollCourse?courseId=${courseDetail.id}">Đăng
							ký ngay</a>

					</div>
				</div>
			</div>
		</div>
	</main>

	<%@ include file="./userComponent/footer.jsp"%>

</body>
</html>
