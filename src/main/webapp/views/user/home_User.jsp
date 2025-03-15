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

/* Course Cards */
.course-card {
	background-color: var(--background-light);
	transition: transform 0.3s ease, box-shadow 0.3s ease;
	border-radius: 8px;
	overflow: hidden;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
}

.course-card:hover {
	transform: translateY(-8px);
	box-shadow: 0px 6px 20px var(--hover-shadow);
	cursor: pointer;
}

.course-card img {
	display: block;
	width: 100%;
	height: auto;
}

.course-card .card-title {
	font-weight: 600;
	color: var(--primary-color);
}

.course-card .card-footer {
	font-size: 0.9rem;
	color: var(--text-muted);
	background-color: #f000;
}

.card-description {
	min-height: 32px;
	-webkit-box-orient: vertical;
	-webkit-line-clamp: 2;
	overflow: hidden;
	display: -webkit-box;
}

/* Bookmark icon */
.bookmark-icon {
	color: #0066cc; /* Thay đổi màu sắc của biểu tượng nếu cần */
	cursor: pointer;
	transition: color 0.3s ease;
}

.bookmark-icon:hover {
	color: #ff5722; /* Màu khi hover */
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

	<!-- Hero Section -->
	<section class="hero-section">
		<div class="container">
			<h1>Học lập trình online với ALT F4</h1>
			<p>Tham gia cùng hàng ngàn học viên học lập trình, xây dựng dự án
				và khởi đầu sự nghiệp.</p>
			<form class="d-flex justify-content-center mt-4">
				<input class="form-control w-50 me-2 rounded-pill" type="search"
					placeholder="Tìm kiếm khóa học" aria-label="Search" />
				<button class="btn btn-primary" type="submit">Search</button>
			</form>
		</div>
	</section>

	<section class="container my-5 position-relative">
		<h2 class="text-center mb-5">Khóa học Pro</h2>
		<a href="/ASM/listPremiumCourse"
			class="text-decoration-none text-dark position-absolute"
			style="top: 50px; right: 10px; font-weight: bold; background-color: rgba(255, 255, 255, 0.7); padding: 5px 10px; border-radius: 5px; color: #0066cc;">
			Xem thêm <i class="fa-solid fa-arrow-right pe-2"></i>
		</a>
		<div class="row row-cols-6 row-cols-md-3 g-4">
			<c:forEach items="${ list3Pre }" var="lP">
				<div class="col" style="cursor: pointer;">
					<div class="card course-card"
						onclick="window.location.href='/ASM/user/course/courseDetail?courseId=${ lP.id }'">
						<i
							class="fas fa-bookmark bookmark-icon position-absolute top-0 end-0 p-2"
							style="font-size: 1.5rem"></i> <img
							src="${ lP.image != null ? lP.image : 'https://via.placeholder.com/300x180' }"
							class="card-img-top" alt="${ lP.name }" style="height: 248.39px" />
						<div class="card-body pb-1">
							<h5 class="card-title">${ lP.name }</h5>
							<p class="card-text mb-2"
								style="min-height: 48px; -webkit-box-orient: vertical; -webkit-line-clamp: 2; overflow: hidden; display: -webkit-box;">${ lP.description }</p>
							<div class="d-flex justify-content-start gap-2">
								<p class="card-text text-muted m-0"
									style="text-decoration: line-through">
									<fmt:formatNumber value="${ lP.price }" type="currency"></fmt:formatNumber>
								</p>
								<p class="card-text m-0"
									style="color: #f05123; font-weight: 600">
									<fmt:formatNumber value="${ lP.pricesale }" type="currency"></fmt:formatNumber>
								</p>
							</div>
							<div
								class="card-footer course-card-footer border-0 px-0 d-flex justify-content-between">
								<p class="m-0">
									<i class="fa-solid fa-eye pe-1" style="color: #adadad"></i> ${ lP.purchased }
								</p>
								<p class="m-0">
									<i class="fa-solid fa-circle-play pe-1" style="color: #adadad"></i>
									20
								</p>
								<p class="m-0">
									<i class="fa-solid fa-clock pe-1" style="color: #adadad"></i>15h59
								</p>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</section>

	<!-- Courses Section -->
	<section class="container-fluid my-5">
		<div class="px-5">
			<h2 class="text-start mb-5">Các khóa học miễn phí</h2>
			<div class="row row-cols-5 g-4">
				<c:forEach items="${ listFree }" var="lF">
					<div class="col" style="cursor: pointer;">
						<div class="card course-card mb-3"
							onclick="window.location.href='/ASM/user/course/courseDetail?courseId=${ lF.id }'">
							<i
								class="fas fa-bookmark bookmark-icon position-absolute top-0 end-0 p-2"
								style="font-size: 1.5rem"></i> <img
								src="${ lF.image != null ? lF.image : 'https://via.placeholder.com/300x180' }"
								class="card-img-top" alt="Course" stlye="196.31px" />
							<div class="card-body pb-1">
								<h5 class="card-title">${ lF.name }</h5>
								<p class="card-text mb-2"
									style="min-height: 24px; -webkit-box-orient: vertical; -webkit-line-clamp: 1; overflow: hidden; display: -webkit-box;">${ lF.description }</p>
								<div class="d-flex justify-content-start gap-4 mb-2">
									<p class="card-text m-0"
										style="color: #f05123; font-weight: 600">Miễn phí</p>
								</div>
								<div
									class="card-footer border-0 px-0 d-flex justify-content-between">
									<p class="m-0">
										<i class="fa-solid fa-eye pe-1" style="color: #adadad"></i> 16
									</p>
									<p class="m-0">
										<i class="fa-solid fa-circle-play pe-1" style="color: #adadad"></i>
										20
									</p>
									<p class="m-0">
										<i class="fa-solid fa-clock pe-1" style="color: #adadad"></i>15h59
									</p>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</section>

	<%@ include file="./userComponent/footer.jsp"%>
</body>
</html>
