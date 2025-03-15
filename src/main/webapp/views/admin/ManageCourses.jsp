<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Quản lý khóa học</title>
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

.card-body {
	min-height: 203px
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
	<%@ include file="./adminComponent/sidebar.jsp"%>

	<div class="content">
		<%@ include file="./adminComponent/navbar.jsp"%>

		<h1 class="my-4">Quản lý khóa học</h1>

		<div class="d-flex justify-content-between align-items-center mb-4">
			<form action="/ASM/admin/manageCourse" method="get"
				class="input-group w-50">
				<input type="text" class="form-control search-bar" name="search"
					placeholder="Tìm kiếm khóa học..."
					value="${param.search != null ? param.search : ''}" />
				<button class="btn btn-primary" type="submit" id="searchButton">
					<i class="fas fa-search"></i> Tìm kiếm
				</button>
			</form>

			<button class="btn btn-success btn-add" data-bs-toggle="modal"
				data-bs-target="#addCourseModal">
				<i class="fas fa-plus me-1"></i> Thêm khóa học
			</button>
		</div>

		<div class="row">
			<c:forEach items="${list}" var="course">
				<div class="col-lg-3 col-md-4 col-sm-5 mb-4">
					<div class="card">
						<!-- Sử dụng ảnh của khóa học -->
						<img
							src="${course.image != null ? course.image : 'https://via.placeholder.com/300x180'}"
							alt="${course.name}"
							height="220.8px"/>
						<div
							class="card-body card-body d-flex justify-content-between flex-column">

							<div>
								<!-- Tên khóa học -->
								<h5 class="card-title">${course.name}</h5>

								<!-- Giảng viên -->
								<p class="card-text">Giảng viên:
									${course.instructor.fullname}</p>

								<!-- Hiển thị giá -->
								<c:choose>
									<c:when test="${course.price == 0}">
										<p class="card-text">Giá: Miễn phí</p>
									</c:when>
									<c:otherwise>
										<p class="card-text">Giá: ${course.price} VND</p>
									</c:otherwise>
								</c:choose>

								<!-- Nếu có giảm giá, hiển thị giá sau giảm -->
								<c:if test="${course.sale != null && course.sale > 0}">
									<p class="card-text">Giảm giá: ${course.sale}%</p>
									<p class="card-text">Giá sau giảm: ${course.pricesale} VND</p>
								</c:if>
							</div>
							<div>
								<!-- Nút "Cập nhật bài học" -->
								<a
									href="/ASM/admin/manageCourse/manageLesson?courseId=${course.id}"
									class="btn btn-primary btn-sm"> <i class="fas fa-book"></i>
									Cập nhật bài học
								</a>

								<!-- Nút sửa -->
								<button class="btn btn-warning btn-sm"
									onclick="openEditModal('${course.id}', '${course.name}', '${course.price}', '${course.sale != null ? course.sale : 0}', '${course.image}', '${course.description}')">
									<i class="fas fa-edit"></i> Sửa
								</button>

								<!-- Nút xóa -->
								<button class="btn btn-danger btn-sm"
									onclick="openDeleteModal('${course.id}', '${course.name}')">
									<i class="fas fa-trash-alt"></i> Xóa
								</button>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>

		<!-- Pagination -->
		<nav id="nav">
			<ul class="pagination">
				<c:if test="${currentPage > 1}">
					<li class="page-item"><a class="page-link" id="truoc"
						href="/ASM/admin/manageCourse?page=${currentPage - 1}&search=${search}#nav">Trước</a>
					</li>
				</c:if>

				<c:forEach begin="1" end="${totalPages}" var="i">
					<li class="page-item ${currentPage == i ? 'active' : ''}"><a
						class="page-link"
						href="/admin/manageCourse?page=${i}&search=${search}#nav">${i}</a></li>
				</c:forEach>

				<c:if test="${currentPage < totalPages}">
					<li class="page-item"><a class="page-link" id="sau"
						href="/ASM/admin/manageCourse?page=${currentPage + 1}&search=${search}#nav">Tiếp</a>
					</li>
				</c:if>
			</ul>
		</nav>
	</div>

	<div class="modal fade" id="addCourseModal" tabindex="-1"
		aria-labelledby="addCourseModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h5 class="modal-title" id="addCourseModalLabel">Thêm khóa học
						mới</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<!-- Modal Body -->
				<div class="modal-body">
					<form action="/ASM/admin/manageCourse/insert" method="post"
						enctype="multipart/form-data" onsubmit="setCategoryValue()">
						<div class="row">
							<!-- Course Name -->
							<div class="col-md-6 mb-3">
								<label for="courseName" class="form-label">Tên khóa học</label>
								<input type="text" class="form-control" id="courseName"
									name="name" required />
							</div>

							<!-- Price -->
							<div class="col-md-6 mb-3">
								<label for="price" class="form-label">Giá khóa học (VND)</label>
								<input type="number" class="form-control" id="price"
									name="price" min="0" required />
							</div>
						</div>

						<div class="row">
							<!-- Discount -->
							<div class="col-md-6 mb-3">
								<label for="sale" class="form-label">Giảm giá (%)</label> <input
									type="number" class="form-control" id="sale" name="sale"
									min="0" max="100" />
							</div>

							<!-- Image Upload -->
							<div class="col-md-6 mb-3">
								<label for="courseImage" class="form-label">Hình ảnh</label> <input
									type="file" class="form-control" id="courseImage" name="image"
									accept=".jpg, .jpeg, .png" onchange="previewImage(event)" />
							</div>
						</div>

						<!-- Image Preview -->
						<div class="mt-3 text-center">
							<img id="imagePreview" src="https://via.placeholder.com/300x180"
								alt="Hình ảnh khóa học" class="img-fluid rounded"
								style="max-width: 100%; max-height: 200px;" />
						</div>

						<input type="hidden" id="category" name="category" />

						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Đóng</button>
							<button type="submit" class="btn btn-primary">Thêm khóa
								học</button>
						</div>
					</form>
				</div>
				<!-- Modal Footer -->
			</div>
		</div>
	</div>

	<div class="modal fade" id="editCourseModal" tabindex="-1"
		aria-labelledby="editCourseModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="editCourseModalLabel">Chỉnh sửa
						khóa học</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>

				<!-- Modal Body -->
				<div class="modal-body">
					<form action="/ASM/admin/manageCourse/update" method="post"
						enctype="multipart/form-data" onsubmit="setCategoryForEdit()">
						<input type="hidden" id="editCourseId" name="id" /> <input
							type="hidden" id="editCategory" name="category" />

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="editCourseName" class="form-label">Tên khóa
									học</label> <input type="text" class="form-control" id="editCourseName"
									name="name" required />
							</div>
							<div class="col-md-6 mb-3">
								<label for="editPrice" class="form-label">Giá khóa học
									(VND)</label> <input type="number" class="form-control" id="editPrice"
									name="price" min="0" required />
							</div>
						</div>

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="editSale" class="form-label">Giảm giá (%)</label> <input
									type="number" class="form-control" id="editSale" name="sale"
									min="0" max="100" />
							</div>

							<div class="col-md-6 mb-3">
								<label for="editCourseImage" class="form-label">Hình ảnh</label>
								<input type="file" class="form-control" id="editCourseImage"
									name="image" accept=".jpg, .jpeg, .png"
									onchange="previewEditImage(event)" />
							</div>
							<div class="row">
								<div class="col-12 mb-3">
									<label for="editDescription" class="form-label">Mô tả
										khóa học</label>
									<textarea class="form-control" id="editDescription"
										name="description" rows="4" required></textarea>
								</div>
							</div>

						</div>

						<div class="mt-3 text-center">
							<img id="editImagePreview"
								src="https://via.placeholder.com/300x180"
								alt="Hình ảnh khóa học" class="img-fluid rounded mb-4"
								style="max-width: 100%; max-height: 200px;" />
						</div>

						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Đóng</button>
							<button type="submit" class="btn btn-primary">Lưu thay
								đổi</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="deleteCourseModal" tabindex="-1"
		aria-labelledby="deleteCourseModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="deleteCourseModalLabel">Xác nhận
						xóa khóa học</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					Bạn có chắc chắn muốn xóa khóa học <strong id="deleteCourseName"></strong>
					không?
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Hủy</button>
					<form action="/ASM/admin/manageCourse/delete" method="post">
						<input type="hidden" id="deleteCourseId" name="id" />
						<button type="submit" class="btn btn-danger">Xóa</button>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal Thông Báo Thành Công -->
	<div class="modal fade" id="successModal" tabindex="-1"
		aria-labelledby="successModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="successModalLabel">Thông Báo</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p>Thao tác thành công!</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary"
						data-bs-dismiss="modal">Đóng</button>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		document
				.addEventListener(
						"DOMContentLoaded",
						function() {
							// Preview Image for Add Course Modal
							function previewImage(event) {
								const input = event.target;
								const preview = document
										.getElementById("imagePreview");
								if (input.files && input.files[0]) {
									const reader = new FileReader();
									reader.onload = function(e) {
										preview.src = e.target.result;
									};
									reader.readAsDataURL(input.files[0]);
								} else {
									preview.src = "https://via.placeholder.com/300x180";
								}
							}

							// Preview Image for Edit Course Modal
							function previewEditImage(event) {
								const input = event.target;
								const preview = document
										.getElementById("editImagePreview");
								if (input.files && input.files[0]) {
									const reader = new FileReader();
									reader.onload = function(e) {
										preview.src = e.target.result;
									};
									reader.readAsDataURL(input.files[0]);
								} else {
									preview.src = "https://via.placeholder.com/300x180";
								}
							}

							// Open Edit Modal
							function openEditModal(id, name, price, sale,
									image, description) {
								document.getElementById("editCourseId").value = id;
								document.getElementById("editCourseName").value = name;
								document.getElementById("editPrice").value = price;
								document.getElementById("editSale").value = sale;
								document.getElementById("editImagePreview").src = image
										|| "https://via.placeholder.com/300x180";
								document.getElementById("editDescription").value = description
										|| ''; // Set mô tả
								new bootstrap.Modal(document
										.getElementById("editCourseModal"))
										.show();
							}

							// Open Delete Modal
							function openDeleteModal(id, name) {
								document.getElementById("deleteCourseId").value = id;
								document.getElementById("deleteCourseName").textContent = name;
								new bootstrap.Modal(document
										.getElementById("deleteCourseModal"))
										.show();
							}

							// Set Category Value for Add Course
							function setCategoryValue() {
								const price = document.getElementById("price").value;
								const category = document
										.getElementById("category");
								category.value = price == 0 ? 2 : 1;
							}

							// Set Category Value for Edit Course
							function setCategoryForEdit() {
								const price = document
										.getElementById("editPrice").value;
								const category = document
										.getElementById("editCategory");
								category.value = price == 0 ? 2 : 1;
							}

							// Success Modal
							function showSuccessModal(message) {
								document.getElementById("successModalLabel").textContent = message;
								new bootstrap.Modal(document
										.getElementById("successModal")).show();
							}

							// Attach event listeners
							document.getElementById("courseImage")
									.addEventListener("change", previewImage);
							document.getElementById("editCourseImage")
									.addEventListener("change",
											previewEditImage);
							window.openEditModal = openEditModal;
							window.openDeleteModal = openDeleteModal;
							window.setCategoryValue = setCategoryValue;
							window.setCategoryForEdit = setCategoryForEdit;
							window.showSuccessModal = showSuccessModal;
						});

		document.addEventListener("DOMContentLoaded", function() {
			const urlParams = new URLSearchParams(window.location.search);
			const modalType = urlParams.get('modal');

			if (modalType === 'success') {
				const successModal = new bootstrap.Modal(document
						.getElementById('successModal'));
				successModal.show();
			} else if (modalType === 'error') {
				const errorModal = new bootstrap.Modal(document
						.getElementById('errorModal'));
				errorModal.show();
			}
		});
	</script>
</body>
</html>
