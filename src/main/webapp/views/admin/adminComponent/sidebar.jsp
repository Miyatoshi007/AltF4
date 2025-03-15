<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="sidebar">
	<h3>Admin Dashboard</h3>
	<ul class="list-group">
		<li class="list-group-item ${ isActive == 'Dashboard' ? 'active' : '' }"><a href="/ASM/admin/dashboard"
			class="text-white text-decoration-none"> <i
				class="fas fa-tachometer-alt me-2"></i> Dashboard
		</a></li>
		<li class="list-group-item ${ isActive == 'Manage Users' ? 'active' : '' }"><a href="/ASM/admin/manageUser"
			class="text-white text-decoration-none" id="manageUserBtn"> <i
				class="fas fa-users me-2"></i> Quản lý người dùng
		</a></li>
		<li class="list-group-item ${ isActive == 'Manage Courses' ? 'active' : '' }"><a href="/ASM/admin/manageCourse"
			class="text-white text-decoration-none" id="manageCourseBtn"> <i
				class="fas fa-book me-2"></i> Quản lý khóa học
		</a></li>
		<li class="list-group-item ${ isActive == 'Statitics' ? 'active' : '' }"><a href="/ASM/admin/statitics"
			class="text-white text-decoration-none"> <i
				class="fas fa-chart-bar me-2"></i> Thống kê
		</a></li>
	</ul>
</div>