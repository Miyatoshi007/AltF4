<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Quản lý người dùng</title>
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

.table th, .table td {
	vertical-align: middle;
}

.table th {
	width: auto;
}

.table thead th:nth-child(1) {
	width: 2%; /* Cột số thứ tự */
}

.table thead th:nth-child(2), .table thead th:nth-child(3) {
	width: 20%; /* Cột họ tên và email */
}

.table thead th:nth-child(4) {
	width: 20%; /* Cột vai trò */
}

.table thead th:nth-child(5) {
	width: 10%; /* Cột hành động */
	text-align: center;
}

.table td .btn {
	width: 100%; /* Nút chiếm toàn bộ chiều rộng cột */
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

@media ( max-width : 768px) {
	.content {
		margin-left: 0;
	}
}
</style>
</head>
<body>
	<%@ include file="./adminComponent/sidebar.jsp"%>

	<!-- Content -->
	<div class="content">
		<%@ include file="./adminComponent/navbar.jsp"%>

		<h1 class="my-4">Quản lý người dùng</h1>

		<!-- Search Bar -->
		<div class="d-flex justify-content-between align-items-center mb-4">
			<div class="input-group w-50">
				<form action="/ASM/admin/manageUser" method="get"
					style="display: flex; width: 100%;">
					<input type="text" class="form-control search-bar" name="search"
						placeholder="Tìm kiếm người dùng..."
						value="${param.search != null ? param.search : ''}" />
					<button class="btn btn-primary btn-add" type="submit"
						id="searchButton">
						<i class="fas fa-search"></i> Tìm kiếm
					</button>
				</form>
			</div>
			<!-- Nút Thêm User -->
			<button class="btn btn-success btn-add" data-bs-toggle="modal"
				data-bs-target="#addUserModal">
				<i class="fas fa-user-plus"></i> Thêm User
			</button>
		</div>


		<!-- User Table -->
		<div class="table-responsive" style="min-height: 493px">
			<table class="table table-bordered table-hover">
				<thead>
					<tr>
						<th>#</th>
						<th>Họ Tên</th>
						<th>Email</th>
						<th>Vai Trò</th>
						<th>Hành Động</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="user" varStatus="status">
						<tr>
							<td>${status.count}</td>
							<td>${user.fullname}</td>
							<td>${user.email}</td>
							<td>${user.role == 'Admin' ? 'Quản trị viên' : 'Học viên'}</td>
							<td>
								<button class="btn btn-warning btn-sm btn-update-role mb-1"
									data-id="${user.id}" data-role="${user.role}"
									data-bs-toggle="modal" data-bs-target="#updateRoleModal">
									<i class="fas fa-user-edit"></i> Cập nhật vai trò
								</button> <c:choose>
									<c:when test="${user.locked == true}">
										<button class="btn btn-success btn-sm btn-unlock-account mt-1"
											data-id="${user.id}" data-name="${user.fullname}"
											data-bs-toggle="modal" data-bs-target="#unlockAccountModal"
											id="unlockUser">
											<i class="fas fa-unlock"></i> Mở khóa tài khoản
										</button>
									</c:when>
									<c:when test="${user.locked == false}">
										<button class="btn btn-danger btn-sm btn-lock-account mt-1"
											data-id="${user.id}" data-name="${user.fullname}"
											data-bs-toggle="modal" data-bs-target="#lockAccountModal"
											id="lockUser">
											<i class="fas fa-user-lock"></i> Khóa tài khoản
										</button>
									</c:when>
									<c:otherwise>
										<small>Error</small>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

		<!-- Pagination -->
		<nav>
			<ul class="pagination justify-content-center">
				<c:if test="${currentPage > 1}">
					<li class="page-item"><a class="page-link"
						href="?page=${currentPage - 1}&search=${param.search}">Trước</a></li>
				</c:if>
				<c:forEach var="i" begin="1" end="${totalPages}">
					<li class="page-item ${currentPage == i ? 'active' : ''}"><a
						class="page-link" href="?page=${i}&search=${param.search}">${i}</a>
					</li>
				</c:forEach>
				<c:if test="${currentPage < totalPages}">
					<li class="page-item"><a class="page-link"
						href="?page=${currentPage + 1}&search=${param.search}">Tiếp</a></li>
				</c:if>
			</ul>
		</nav>

	</div>

	<div class="modal fade" id="addUserModal" tabindex="-1"
		aria-labelledby="addUserModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<form action="/ASM/admin/manageUser/insert" method="post">
					<div class="modal-header">
						<h5 class="modal-title" id="addUserModalLabel">Thêm Người
							Dùng</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<div class="mb-3">
							<label for="addFullName" class="form-label">Họ Tên</label> <input
								type="text" class="form-control" id="addFullName"
								name="fullname" placeholder="Nhập họ tên" required />
						</div>
						<div class="mb-3">
							<label for="addEmail" class="form-label">Email</label> <input
								type="email" class="form-control" id="addEmail" name="email"
								placeholder="Nhập email" required />
						</div>
						<div class="mb-3">
							<label for="addPassword" class="form-label">Mật khẩu</label> <input
								type="password" class="form-control" id="addPassword"
								name="password" placeholder="Nhập mật khẩu" required />
						</div>
						<div class="mb-3">
							<label for="addRole" class="form-label">Vai Trò</label> <select
								class="form-select" id="addRole" name="role" required>
								<option selected disabled>-- Vui lòng chọn vai trò --</option>
								<option value="Admin">Quản trị viên</option>
								<option value="User">Học viên</option>
							</select>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Hủy</button>
						<button type="submit" class="btn btn-success">Thêm</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<div class="modal fade" id="updateRoleModal" tabindex="-1"
		aria-labelledby="updateRoleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<form action="/ASM/admin/manageUser/update" method="post">
					<div class="modal-header">
						<h5 class="modal-title" id="updateRoleModalLabel">Cập nhật
							vai trò</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<input type="hidden" id="updateRoleUserId" name="id" />
						<div class="mb-3">
							<label for="updateRole" class="form-label">Vai trò</label> <select
								class="form-select" id="updateRole" name="role" required>
								<option value="Admin" id="adminChoose" class="admin-select">Quản trị viên</option>
								<option value="User" id="userChoose" class="user-select">Học viên</option>
							</select>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Hủy</button>
						<button type="submit" class="btn btn-warning" id="updateRoleBtn">Cập nhật</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<div class="modal fade" id="lockAccountModal" tabindex="-1"
		aria-labelledby="lockAccountModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<form action="/ASM/admin/manageUser/lockUser" method="post">
					<div class="modal-header">
						<h5 class="modal-title text-danger" id="lockAccountModalLabel">Khóa
							tài khoản</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<input type="hidden" id="lockAccountUserId" name="id" />
						<p>
							Bạn có chắc chắn muốn khóa tài khoản <strong
								id="lockAccountUserName"></strong> không?
						</p>
						<p class="text-danger">Hành động này sẽ tạm thời vô hiệu hóa
							tài khoản.</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Hủy</button>
						<button type="submit" class="btn btn-danger" id="confirmLock">Khóa</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<div class="modal fade" id="unlockAccountModal" tabindex="-1"
		aria-labelledby="unlockAccountModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<form action="/ASM/admin/manageUser/lockUser" method="post">
					<div class="modal-header">
						<h5 class="modal-title text-success" id="unlockAccountModalLabel">Mở
							khóa tài khoản</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<input type="hidden" id="unlockAccountUserId" name="id" />
						<p>
							Bạn có chắc chắn muốn mở khóa tài khoản <strong
								id="unlockAccountUserName"></strong> không?
						</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Hủy</button>
						<button type="submit" class="btn btn-success" id="confirmUnlock">Mở khóa</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- Modal Thông Báo -->
	<div class="modal fade" id="successModal" tabindex="-1"
		aria-labelledby="successModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="successModalLabel">Thao tác thành
						công</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p>${param.success}</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary"
						data-bs-dismiss="modal" id="closeBtn">Đóng</button>
				</div>
			</div>
		</div>
	</div>


	<script type="text/javascript">
	document.addEventListener("DOMContentLoaded", function () {
	    // Cập nhật vai trò
	    document.querySelectorAll(".btn-update-role").forEach(button => {
	        button.addEventListener("click", function () {
	            const userId = this.getAttribute("data-id");
	            const userRole = this.getAttribute("data-role");

	            document.getElementById("updateRoleUserId").value = userId;
	            document.getElementById("updateRole").value = userRole;
	        });
	    });
	    
		// Khóa tài khoản
	    document.querySelectorAll(".btn-lock-account").forEach(button => {
	        button.addEventListener("click", function () {
	            const userId = this.getAttribute("data-id");
	            const userName = this.getAttribute("data-name");

	            document.getElementById("lockAccountUserId").value = userId;
	            document.getElementById("lockAccountUserName").textContent = userName;
	        });
	    });

	    // Mở khóa tài khoản
	    document.querySelectorAll(".btn-unlock-account").forEach(button => {
	        button.addEventListener("click", function () {
	            const userId = this.getAttribute("data-id");
	            const userName = this.getAttribute("data-name");

	            document.getElementById("unlockAccountUserId").value = userId;
	            document.getElementById("unlockAccountUserName").textContent = userName;
	        });
	    });
	});

	document.addEventListener("DOMContentLoaded", function () {
	    // Kiểm tra trạng thái từ server (giả sử có biến `successMessage` trong JSP)
	    const urlParams = new URLSearchParams(window.location.search);
		if (urlParams.get('modal') === 'success') {
			const successModal = new bootstrap.Modal(document.getElementById('successModal'));
		    successModal.show();
		}
		});
</script>
</body>
</html>
