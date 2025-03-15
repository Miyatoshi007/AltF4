<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Khóa học của bạn</title>
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&display=swap"
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
	;
}

.bg-dark-gray {
	background-color: #AAAAAA;
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

.course-video {
	background-color: #00000010;
	color: #000000;
	padding: 20px;
	border-radius: 8px;
}

.video-player {
	width: 100%;
	height: 500px;
	border-radius: 8px;
	background: #000;
}

.video-title {
	font-size: 1.5rem;
	font-weight: 600;
	margin-top: 20px;
}

.video-description {
	font-size: 1rem;
	color: #666;
	margin-top: 10px;
}

.video-list {
	margin-top: 30px;
}

.video-item {
	display: flex;
	align-items: center;
	padding: 10px 0;
	border-bottom: 1px solid #ddd;
	cursor: pointer;
}

.video-item:hover {
	background-color: #f1f1f1;
}

.video-thumbnail {
	width: 100px;
	height: 60px;
	border-radius: 4px;
	background: #ccc;
	margin-right: 15px;
}

.video-info {
	flex-grow: 1;
}

.video-info h5 {
	font-size: 1rem;
	margin: 0;
	color: #0056b3;
	font-weight: 500;
}

.video-info p {
	margin: 0;
	color: #777;
	font-size: 0.875rem;
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
	<%@ include file="./userComponent/navbar.jsp"%>

	<!-- Main Content -->
	<div class="container my-5">
		<div class="row">
			<!-- Video Section -->
			<div class="col-lg-8">
				<div class="course-video">
					<div class="video-player">
						<!-- Kiểm tra xem currentLesson có null không trước khi hiển thị video -->
						<c:if test="${not empty currentLesson}">
							<iframe width="100%" height="500" src="${currentLesson.videoUrl}"
								title="YouTube video player" frameborder="0"
								allow="accelerometer; autoplay; clipboard-write;
								encrypted-media; gyroscope; picture-in-picture; web-share"
								referrerpolicy="strict-origin-when-cross-origin" allowfullscreen>
							</iframe>
						</c:if>
					</div>
					<!-- Hiển thị tên và mô tả bài học -->
					<h3 class="video-title">${currentLesson.name}</h3>
					<p class="video-description">${currentLesson.content}</p>
				</div>
			</div>

			<!-- Danh sách bài học -->
			<div class="col-lg-4">
				<h4>Danh sách bài học</h4>
				<div class="video-list border p-2 py-0">
					<c:forEach var="lesson" items="${lessons}">
						<div
							class="video-item ${lesson.id == currentLesson.id ? 'bg-light' : ''}"
							onclick="window.location.href='/ASM/user/course/courseLesson?courseId=${course.id}&lessonId=${lesson.id}'">
							<div class="video-thumbnail">
								<img
									src="${lesson.course.image != null ? lesson.course.image : 'https://via.placeholder.com/150x100'}"
									alt="${lesson.name}" class="img-fluid">
							</div>
							<div class="video-info">
								<h5>${lesson.name}</h5>
								<p>60 phút</p>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="./userComponent/footer.jsp"%>
</body>
</html>
