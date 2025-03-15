<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Danh sách Bài học - ${nameCourse}</title>
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
<style type="text/css">
body {
	font-family: "Roboto", sans-serif;
	background: #f8fafc;
	color: #333;
	margin: 0;
	padding: 0;
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
}

.card {
	border-radius: 8px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.card:hover {
	transform: translateY(-5px);
	box-shadow: 0 6px 8px rgba(0, 0, 0, 0.15);
}

.card .card-title {
	font-weight: bold;
}

.card .btn {
	font-size: 14px;
	margin-top: 0.75rem;
}

.card-text {
	margin: 0;
}

@media ( max-width : 768px) {
	.content {
		margin-left: 0;
	}
}

.search-bar {
	max-width: 400px;
}

.pagination {
	justify-content: center;
}

.pagination .page-item .page-link {
	border: 1px solid #ddd;
	border-radius: 4px;
}

.pagination .page-item.active .page-link {
	background-color: #007bff;
	border-color: #007bff;
	color: white;
}

.pagination .page-item:hover .page-link {
	background-color: #f1f1f1;
}

.btn-add {
	border-radius: 5px;
	font-size: 14px;
	padding: 6px 12px;
}
</style>
</head>
<body>
	<!-- Sidebar -->
	<%@ include file="./adminComponent/sidebar.jsp"%>

	<div class="content">
		<!-- Navbar -->
		<%@ include file="./adminComponent/navbar.jsp"%>

		<h1 class="my-4">Danh sách Bài học - ${nameCourse}</h1>

		<div class="d-flex justify-content-between">
			<a href="/ASM/admin/manageCourse" class="btn btn-primary mb-4">Quay lại các
				khóa học</a>
			<button class="btn btn-success mb-4" data-bs-toggle="modal"
				data-bs-target="#addLessonModal">Thêm bài học</button>
		</div>

		<c:if test="${not empty error}">
			<div class="alert alert-danger" role="alert">${error}</div>
		</c:if>

		<c:if test="${not empty lessons}">
			<table class="table">
				<thead>
					<tr>
						<th>#</th>
						<th>Tên bài học</th>
						<th>Nội dung</th>
						<th>URL Video</th>
						<th>Thao tác</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${lessons}" var="lesson" varStatus="status">
						<tr>
							<td>${status.count}</td>
							<td>${lesson.name}</td>
							<td>${lesson.content}</td>
							<td>${lesson.videoUrl}</td>
							<td>
								<button class="btn btn-warning btn-sm"
									onclick="openEditModal('${lesson.id}', '${lesson.name}', '${lesson.content}', '${lesson.videoUrl}')">Sửa</button>
								<button class="btn btn-danger btn-sm"
									onclick="openDeleteModal('${lesson.id}', '${lesson.name}')">Xóa</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>

		<c:if test="${empty lessons}">
			<p>Không có bài học nào trong khóa học này.</p>
		</c:if>
	</div>

	<div class="modal fade" id="addLessonModal" tabindex="-1"
		aria-labelledby="addLessonModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<form action="/ASM/admin/manageCourse/manageLesson" method="post">
					<div class="modal-header">
						<h5 class="modal-title">Thêm bài học mới</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
					</div>
					<div class="modal-body">
						<input type="hidden" name="action" value="add" /> <input
							type="hidden" name="courseId" value="${param.courseId}" />
						<div class="mb-3">
							<label for="lessonName" class="form-label">Tên bài học</label> <input
								type="text" class="form-control" id="lessonName" name="name"
								required />
						</div>
						<div class="mb-3">
							<label for="lessonContent" class="form-label">Nội dung</label>
							<textarea class="form-control" id="lessonContent" name="content"
								rows="4" required></textarea>
						</div>
						<div class="mb-3">
							<label for="lessonVideoUrl" class="form-label">URL Video</label>
							<input type="text" class="form-control" id="lessonVideoUrl"
								name="videoUrl" />
						</div>
						<input type="hidden" name="courseId" value="${course.id}" />
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Hủy</button>
						<button type="submit" class="btn btn-primary">Thêm</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<div class="modal fade" id="editLessonModal" tabindex="-1"
		aria-labelledby="editLessonModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<form action="/ASM/admin/manageCourse/manageLesson" method="post">
					<div class="modal-header">
						<h5 class="modal-title">Sửa bài học</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
					</div>
					<div class="modal-body">
						<input type="hidden" name="action" value="edit" /> <input
							type="hidden" id="editLessonId" name="id" /> <input
							type="hidden" name="courseId" value="${param.courseId}" />
						<div class="mb-3">
							<label for="editLessonName" class="form-label">Tên bài
								học</label> <input type="text" class="form-control" id="editLessonName"
								name="name" required />
						</div>
						<div class="mb-3">
							<label for="editLessonContent" class="form-label">Nội
								dung</label>
							<textarea class="form-control" id="editLessonContent"
								name="content" rows="4" required></textarea>
						</div>
						<div class="mb-3">
							<label for="editLessonVideoUrl" class="form-label">URL
								Video</label> <input type="text" class="form-control"
								id="editLessonVideoUrl" name="videoUrl" />
						</div>
						<input type="hidden" id="editLessonId" name="id" />
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Hủy</button>
						<button type="submit" class="btn btn-primary">Lưu thay
							đổi</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<div class="modal fade" id="deleteLessonModal" tabindex="-1"
		aria-labelledby="deleteLessonModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<form action="/ASM/admin/manageCourse/manageLesson" method="post">
					<div class="modal-header">
						<h5 class="modal-title">Xóa bài học</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
					</div>
					<div class="modal-body">
						<input type="hidden" name="action" value="delete" /> <input
							type="hidden" id="deleteLessonId" name="id" /> <input
							type="hidden" name="courseId" value="${param.courseId}" />
						<p>
							Bạn có chắc chắn muốn xóa bài học <strong id="deleteLessonName"></strong>?
						</p>
						<input type="hidden" id="deleteLessonId" name="id" />
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Hủy</button>
						<button type="submit" class="btn btn-danger">Xóa</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<div class="modal fade" id="successModal" tabindex="-1"
		aria-labelledby="successModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="successModalLabel">Thành công</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p id="successMessage">Thao tác đã được thực hiện thành công!</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary"
						data-bs-dismiss="modal">Đóng</button>
				</div>
			</div>
		</div>
	</div>

	<script>
		function openEditModal(id, name, content, videoUrl) {
			document.getElementById("editLessonId").value = id;
			document.getElementById("editLessonName").value = name;
			document.getElementById("editLessonContent").value = content;
			document.getElementById("editLessonVideoUrl").value = videoUrl;
			new bootstrap.Modal(document.getElementById("editLessonModal"))
					.show();
		}

		function openDeleteModal(id, name) {
			document.getElementById("deleteLessonId").value = id;
			document.getElementById("deleteLessonName").textContent = name;
			new bootstrap.Modal(document.getElementById("deleteLessonModal"))
					.show();
		}
	</script>
	<c:if test="${not empty successMessage}">
		<script>
			document
					.addEventListener(
							'DOMContentLoaded',
							function() {
								document.getElementById('successMessage').textContent = "${successMessage}";
								new bootstrap.Modal(document
										.getElementById('successModal')).show();
							});
		</script>
	</c:if>

</body>
</html>
