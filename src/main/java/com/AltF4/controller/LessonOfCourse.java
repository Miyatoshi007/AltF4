package com.AltF4.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.AltF4.dao.CourseDAO;
import com.AltF4.dao.LessonDAO;
import com.AltF4.model.Course;
import com.AltF4.model.Lesson;
import com.AltF4.utils.TrackUrl;

@WebServlet("/admin/manageCourse/manageLesson")
public class LessonOfCourse extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LessonOfCourse() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String courseIdParam = request.getParameter("courseId");
		if (courseIdParam != null) {
			try {
				int courseId = Integer.parseInt(courseIdParam);

				// Lấy danh sách bài học
				List<Lesson> lessons = LessonDAO.findAllByCourseId(courseId);

				request.setAttribute("lessons", lessons);
//				request.setAttribute("courseId", courseId);

				String nameCourse = CourseDAO.findById(courseId).getName();
				request.setAttribute("nameCourse", nameCourse);
				request.setAttribute("isActive", "Manage Courses");
			} catch (NumberFormatException e) {
				request.setAttribute("error", "ID khóa học không hợp lệ.");
			}
		} else {
			request.setAttribute("error", "Không tìm thấy ID khóa học.");
		}

		// Chuyển tiếp đến trang JSP
		request.getRequestDispatcher("/views/admin/ManageLesson.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");

		try {
			if ("add".equals(action)) {
				// Thêm bài học mới
				String name = request.getParameter("name");
				String content = request.getParameter("content");
				String videoUrl = request.getParameter("videoUrl");
				String extrackUrl = TrackUrl.extractSrc(videoUrl);
				int courseId = Integer.parseInt(request.getParameter("courseId"));
				Course course = CourseDAO.findById(courseId);

				Lesson lesson = new Lesson();
				lesson.setName(name);
				lesson.setContent(content);
				lesson.setVideoUrl(extrackUrl);
				lesson.setCourse(course);

				LessonDAO.create(lesson);
				request.setAttribute("successMessage", "Thêm bài học thành công!");

			} else if ("edit".equals(action)) {
				// Sửa bài học
				int id = Integer.parseInt(request.getParameter("id"));
				String name = request.getParameter("name");
				String content = request.getParameter("content");
				String videoUrl = request.getParameter("videoUrl");

				System.out.println("URL: " + videoUrl);

				Lesson lesson = LessonDAO.findById(id);
				lesson.setName(name);
				lesson.setContent(content);

				if (lesson.getVideoUrl() == null) {
					String extrackUrl = TrackUrl.extractSrc(videoUrl);
					lesson.setVideoUrl(extrackUrl);
				} else if (lesson.getVideoUrl().equals(videoUrl)) {
					lesson.setVideoUrl(videoUrl);
				} else {
					String extrackUrl = TrackUrl.extractSrc(videoUrl);
					lesson.setVideoUrl(extrackUrl);
				}

				LessonDAO.update(lesson);
				request.setAttribute("successMessage", "Sửa bài học thành công!");

			} else if ("delete".equals(action)) {
				int id = Integer.parseInt(request.getParameter("id"));

				LessonDAO.delete(id);
				request.setAttribute("successMessage", "Xóa bài học thành công!");
			}

			int courseId = Integer.parseInt(request.getParameter("courseId"));
			List<Lesson> lessons = LessonDAO.findAllByCourseId(courseId);

			request.setAttribute("lessons", lessons);
			request.setAttribute("nameCourse", CourseDAO.findById(courseId).getName());

		} catch (Exception e) {
			request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
		}

		request.getRequestDispatcher("/views/admin/ManageLesson.jsp").forward(request, response);
	}

}
