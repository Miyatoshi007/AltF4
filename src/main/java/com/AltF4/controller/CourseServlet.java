package com.AltF4.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.AltF4.dao.CourseDAO;
import com.AltF4.dao.EnrollmentDAO;
import com.AltF4.dao.LessonDAO;
import com.AltF4.model.Course;
import com.AltF4.model.Lesson;
import com.AltF4.model.User;

@WebServlet("/user/course/*")
public class CourseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String path = request.getPathInfo();
		if (path == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND, "Invalid endpoint");
			return;
		}

		switch (path) {
		case "/courseDetail":
			handleCourseDetail(request, response);
			break;
		case "/courseLesson":
			handleCourseLesson(request, response);
			break;
		default:
			response.sendError(HttpServletResponse.SC_NOT_FOUND, "Endpoint not found");
		}
	}

	private void handleCourseDetail(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String courseIdParam = request.getParameter("courseId");
		if (courseIdParam == null) {
			response.sendRedirect("/views/error.jsp");
			return;
		}

		try {
			int courseId = Integer.parseInt(courseIdParam);
			Course course = CourseDAO.findById(courseId);
			if (course == null) {
				request.setAttribute("errorMessage", "Khóa học không tồn tại.");
				request.getRequestDispatcher("/views/error.jsp").forward(request, response);
				return;
			}

			User currentUser = (User) request.getSession().getAttribute("currentUser");
			if (currentUser == null) {
				response.sendRedirect("/login.jsp");
				return;
			}

			boolean isEnrolled = EnrollmentDAO.isUserEnrolledInCourse(currentUser.getId(), courseId);
			System.out.println("isEnroll: " + isEnrolled);
			if (isEnrolled) {
				response.sendRedirect("/ASM/user/course/courseLesson?courseId=" + courseId);
			} else {
				request.setAttribute("courseDetail", course);
				request.getRequestDispatcher("/views/user/CourseDetail.jsp").forward(request, response);
			}
		} catch (NumberFormatException e) {
			request.setAttribute("errorMessage", "ID khóa học không hợp lệ.");
			request.getRequestDispatcher("/views/error.jsp").forward(request, response);
		}
	}

	private void handleCourseLesson(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String courseIdParam = request.getParameter("courseId");
		String lessonIdParam = request.getParameter("lessonId");

		if (courseIdParam == null) {
			response.sendRedirect("/views/error.jsp");
			return;
		}

		try {
			int courseId = Integer.parseInt(courseIdParam);

			Course course = CourseDAO.findById(courseId);
			if (course == null) {
				request.setAttribute("errorMessage", "Khóa học không tồn tại.");
				request.getRequestDispatcher("/views/error.jsp").forward(request, response);
				return;
			}

			// Lấy danh sách bài học
			List<Lesson> lessons = LessonDAO.findAllByCourseId(courseId);
			if (lessons == null || lessons.isEmpty()) {
				request.setAttribute("errorMessage", "Khóa học không có bài học nào.");
				request.getRequestDispatcher("/views/error.jsp").forward(request, response);
				return;
			}

			Lesson currentLesson = null;
			if (lessonIdParam != null) {
				int lessonId = Integer.parseInt(lessonIdParam);
				currentLesson = LessonDAO.findById(lessonId);
			}
			if (currentLesson == null) {
				currentLesson = lessons.get(0); // Bài học đầu tiên
			}

			request.setAttribute("course", course);
			request.setAttribute("lessons", lessons);
			request.setAttribute("currentLesson", currentLesson);
			request.getRequestDispatcher("/views/user/Lesson.jsp").forward(request, response);
		} catch (NumberFormatException e) {
			request.setAttribute("errorMessage", "ID khóa học hoặc bài học không hợp lệ.");
			request.getRequestDispatcher("/views/error.jsp").forward(request, response);
		}
	}
}
