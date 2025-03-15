package com.AltF4.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.AltF4.dao.CourseDAO;
import com.AltF4.dao.EnrollmentDAO;
import com.AltF4.dao.UserDAO;
import com.AltF4.model.Course;
import com.AltF4.model.Enrollment;
import com.AltF4.model.User;

@WebServlet({ "/user/home/course", "/user/profile", "/user/listCoursePurchased", "/user/listCourseBookmarked",
		"/user/changePassword" })
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UserServlet() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String uri = request.getServletPath();
		String view = null;
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("currentUser");

		if (uri.equals("/user/home/course")) {
			view = "/views/user/home_User.jsp";
			List<Course> list3Pre = CourseDAO.findTop3PremiumCourses();
			List<Course> listFree = CourseDAO.findFreeCourses();
			request.setAttribute("list3Pre", list3Pre);
			request.setAttribute("listFree", listFree);
		} else if (uri.equals("/user/profile")) {
			view = "/views/user/profileUser.jsp";
			request.setAttribute("active", "profile");
		} else if (uri.equals("/user/listCoursePurchased")) {
			view = "/views/user/CoursePurchased.jsp";
			List<Enrollment> enls = EnrollmentDAO.findByUser(user.getId());
			request.setAttribute("listEnl", enls);
			request.setAttribute("active", "listCoursePurchased");
		} else if (uri.equals("/user/listCourseBookmarked")) {
			view = "/views/user/CourseBookmark.jsp";
			request.setAttribute("active", "listCourseBookmarked");
		} else if (uri.equals("/user/changePassword")) {
			view = "/views/user/changePassword.jsp";
			request.setAttribute("active", "changePassword");
		}

		if (view != null) {
			request.getRequestDispatcher(view).forward(request, response);
		} else {
			response.sendError(HttpServletResponse.SC_NOT_FOUND, "Page not found");
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String uri = request.getServletPath();
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("currentUser");
		request.setAttribute("active", "changePassword");
		if (uri.endsWith("/user/changePassword")) {
			String oldPass = request.getParameter("currentPassword");
			String newPass = request.getParameter("newPassword");
			String confirmNewPass = request.getParameter("confirmNewPassword");
			if (oldPass.trim().isEmpty() || newPass.trim().isEmpty() || confirmNewPass.trim().isEmpty()) {
				request.setAttribute("errorMessage", "Vui lòng nhập đầy đủ thông tin!");
				request.setAttribute("oldPass", oldPass);
				request.setAttribute("newPass", newPass);
				request.setAttribute("confirmNewPass", confirmNewPass);
				request.getRequestDispatcher("/views/user/changePassword.jsp").forward(request, response);
				return;
			}
			if (!oldPass.equals(user.getPassword())) {
				request.setAttribute("errorMessage", "Mật khẩu hiện tại không chính xác!");
				request.setAttribute("oldPass", oldPass);
				request.setAttribute("newPass", newPass);
				request.setAttribute("confirmNewPass", confirmNewPass);
				request.getRequestDispatcher("/views/user/changePassword.jsp").forward(request, response);
				return;
			}
			if (!confirmNewPass.equals(newPass)) {
				request.setAttribute("errorMessage", "Xác nhận mật khẩu không khớp!");
				request.setAttribute("oldPass", oldPass);
				request.setAttribute("newPass", newPass);
				request.setAttribute("confirmNewPass", confirmNewPass);
				request.getRequestDispatcher("/views/user/changePassword.jsp").forward(request, response);
				return;
			}

			user.setPassword(confirmNewPass);
			UserDAO.update(user);
			request.setAttribute("successMessage", "Cập nhật mật khẩu thành công!");
			request.getRequestDispatcher("/views/user/changePassword.jsp").forward(request, response);
		}
	}
}
