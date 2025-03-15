<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<nav
	class="navbar navbar-expand-lg navbar-light shadow-sm sticky-top px-5">
	<div class="container-fluid">
		<a class="navbar-brand" href="/ASM/user/home/course"> <img
			src="/ASM/assets/img/LOGO_AltF4_11.png" width="64" height="64"
			alt="ALT F4 Logo" />
		</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarNav" aria-controls="navbarNav"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav ms-auto">
				<li class="nav-item"><a class="nav-link active"
					href="/ASM/user/home/course">Trang chủ</a></li>
				<li class="nav-item"><a class="nav-link" href="#">Các bài
						viết đánh giá</a></li>
				<li class="nav-item"><a class="nav-link" href="#">Về chúng
						tôi</a></li>
				<li class="nav-item dropdown ms-3"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-bs-toggle="dropdown" aria-expanded="false">
						<i class="fa-solid fa-user pe-2"></i><span id="userGreeting">Chào,
							${ currentUser.fullname }</span>
				</a>
					<ul class="dropdown-menu dropdown-menu-end"
						aria-labelledby="navbarDropdown">
						<li><a class="dropdown-item" href="/ASM/user/profile" id="personalProfile">Thông
								tin cá nhân</a></li>
						<li><a class="dropdown-item"
							href="/ASM/user/listCoursePurchased">Danh sách khóa học</a></li>
						<li><a class="dropdown-item" href="#">Cài đặt</a></li>
						<li><hr class="dropdown-divider" /></li>
						<li><a class="dropdown-item" href="/ASM/logout"
							id="logoutButton">Đăng xuất</a></li>
					</ul></li>
			</ul>
		</div>
	</div>
</nav>