package com.AltF4.controller;

import java.io.IOException;
import java.time.LocalDateTime;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.AltF4.dao.CourseDAO;
import com.AltF4.dao.EnrollmentDAO;
import com.AltF4.model.Course;
import com.AltF4.model.Enrollment;
import com.AltF4.model.User;

/**
 * Servlet implementation class Enrollment
 */
@WebServlet("/user/enrollCourse")
public class EnrollmentUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public EnrollmentUser() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("currentUser");
		String courseIdParam = request.getParameter("courseId");

		try {
			int courseId = Integer.parseInt(courseIdParam);
			Course course = CourseDAO.findById(courseId);
			course.setPurchased(course.getPurchased() + 1);
			CourseDAO.update(course);

			Enrollment enrollment = new Enrollment();
			enrollment.setUser(user);
			enrollment.setCourse(course);
			enrollment.setEnrollDate(LocalDateTime.now());

			EnrollmentDAO.create(enrollment);

			response.sendRedirect("/ASM/user/listCoursePurchased");
		} catch (NumberFormatException e) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID khóa học không hợp lệ");
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

}
