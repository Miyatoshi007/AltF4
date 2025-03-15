<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="sidebar">
	<ul class="nav flex-column px-3">
		<li class="nav-item"><a class="nav-link ${ active == 'profile' ? 'active' : '' }"
			href="/ASM/user/profile" id="changeProfile">Thông tin cá nhân</a></li>
		<li class="nav-item"><a class="nav-link ${ active == 'listCoursePurchased' ? 'active' : '' }"
			href="/ASM/user/listCoursePurchased">Khóa học đã mua</a></li>
		<li class="nav-item"><a class="nav-link ${ active == 'listCourseBookmarked' ? 'active' : '' }"
			href="/ASM/user/listCourseBookmarked">Khóa học đã đánh dấu</a></li>
		<li class="nav-item"><a class="nav-link ${ active == 'changePassword' ? 'active' : '' }"
			href="/ASM/user/changePassword" id="changePass">Đổi mật khẩu</a></li>
	</ul>
</div>