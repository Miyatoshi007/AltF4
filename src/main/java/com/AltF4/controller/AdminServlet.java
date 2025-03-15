package com.AltF4.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.AltF4.dao.CourseDAO;
import com.AltF4.dao.StatisticsDAO;
import com.AltF4.dao.UserDAO;
import com.AltF4.model.Course;
import com.AltF4.model.User;

@WebServlet({ "/admin/dashboard", "/admin/manageCourse", "/admin/manageUser", "/admin/statitics" })
public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminServlet() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String uri = request.getServletPath();
		String view = null;

		if (uri.equals("/admin/dashboard")) {
			view = "/views/admin/Dashboard.jsp";
			int countUser = (int) StatisticsDAO.countLearner();
			request.setAttribute("countUser", countUser);
			int countCourse = (int) StatisticsDAO.countCourse();
			request.setAttribute("isActive", "Dashboard");
			request.setAttribute("countCourse", countCourse);
		} else if (uri.equals("/admin/manageCourse")) {
			String search = request.getParameter("search");
			String pageParam = request.getParameter("page");
			int page = (pageParam == null || pageParam.isEmpty()) ? 1 : Integer.parseInt(pageParam);
			int pageSize = 8;

			List<Course> list;
			long totalCourses;
			if (search != null && !search.trim().isEmpty()) {
				list = CourseDAO.getCourses(search, page, pageSize);
				totalCourses = CourseDAO.getTotalCourses(search);
			} else {
				list = CourseDAO.getCourses("", page, pageSize);
				totalCourses = CourseDAO.getTotalCourses("");
			}

			long totalPages = (totalCourses + pageSize - 1) / pageSize;

			request.setAttribute("list", list);
			request.setAttribute("currentPage", page);
			request.setAttribute("totalPages", totalPages);
			request.setAttribute("search", search);
			request.setAttribute("isActive", "Manage Courses");

			view = "/views/admin/ManageCourses.jsp";

		} else if (uri.equals("/admin/manageUser")) {
			String keyword = request.getParameter("search");
			String pageParam = request.getParameter("page");
			int page = (pageParam == null || pageParam.isEmpty()) ? 1 : Integer.parseInt(pageParam);
			int pageSize = 5;

			List<User> list;
			long totalUsers;
			if (keyword != null && !keyword.trim().isEmpty()) {
				list = UserDAO.findByKeywordPaginated(keyword, page, pageSize);
				totalUsers = UserDAO.countUsersByKeyword(keyword);
			} else {
				list = UserDAO.findPaginated(page, pageSize);
				totalUsers = UserDAO.countUsers();
			}

			long totalPages = (totalUsers + pageSize - 1) / pageSize;

			request.setAttribute("list", list);
			request.setAttribute("currentPage", page);
			request.setAttribute("totalPages", totalPages);
			request.setAttribute("search", keyword);
			request.setAttribute("isActive", "Manage Users");

			view = "/views/admin/ManageUser.jsp";

		} else if (uri.equals("/admin/statitics")) {
			view = "/views/admin/Statitics.jsp";
			request.setAttribute("isActive", "Statitics");

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

	}

}
