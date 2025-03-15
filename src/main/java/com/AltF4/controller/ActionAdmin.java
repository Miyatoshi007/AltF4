package com.AltF4.controller;

import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.AltF4.dao.CategoryDAO;
import com.AltF4.dao.CourseDAO;
import com.AltF4.dao.UserDAO;
import com.AltF4.model.Category;
import com.AltF4.model.Course;
import com.AltF4.model.User;
import com.AltF4.utils.AutoGenerateID;

@MultipartConfig()
@WebServlet({ "/admin/manageCourse/insert", "/admin/manageCourse/update", "/admin/manageCourse/delete",
		"/admin/manageUser/insert", "/admin/manageUser/update", "/admin/manageUser/lockUser" })
public class ActionAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ActionAdmin() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String uri = request.getServletPath();

		try {
			if (uri.endsWith("/manageUser/insert")) {
				handleAddUser(request, response);
			} else if (uri.endsWith("/manageUser/update")) {
				handleEditUser(request, response);
			} else if (uri.endsWith("/manageUser/lockUser")) {
				handleLockUser(request, response);
			} else if (uri.endsWith("/manageCourse/insert")) {
				handleAddCourse(request, response);
			} else if (uri.endsWith("/manageCourse/update")) {
				handleEditCourse(request, response);
			} else if (uri.endsWith("/manageCourse/delete")) {
				handleDeleteCourse(request, response);
			} else {
				response.sendError(HttpServletResponse.SC_NOT_FOUND, "Invalid action");
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
					"An error occurred while processing the request.");
		}
	}

	private void handleAddUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String id = AutoGenerateID.generateUserId();
		String fullname = request.getParameter("fullname");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String role = request.getParameter("role");

		String validationMessage = validateAddUser(fullname, email, password, role);

		if (validationMessage != null) {
			sendErrorResponse(response, "/admin/manageUser", validationMessage);
			return;
		}

		User user = new User();
		user.setId(id);
		user.setFullname(fullname);
		user.setEmail(email);
		user.setPassword(password);
		user.setRole(role);

		int result = UserDAO.create(user);

		if (result == 1) {
			String successMessage = URLEncoder.encode("Thêm người dùng thành công.", "UTF-8");
			response.sendRedirect(
					request.getContextPath() + "/admin/manageUser?success=" + successMessage + "&modal=success");
		} else {
			sendErrorResponse(response, "/admin/manageUser", "Failed to add the user. Please try again.");
		}
	}

	private String validateAddUser(String fullname, String email, String password, String role) {
		if (fullname == null || fullname.trim().isEmpty() || email == null || email.trim().isEmpty() || password == null
				|| password.trim().isEmpty() || role == null || role.trim().isEmpty()) {
			return "All fields are required.";
		}

		if (!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")) {
			return "Invalid email format.";
		}

		if (password.length() < 6) {
			return "Password must be at least 6 characters long.";
		}

		if (!role.equalsIgnoreCase("Admin") && !role.equalsIgnoreCase("User")) {
			return "Invalid role. Allowed roles are 'Admin' or 'User'.";
		}

		return null;
	}

	private void handleEditUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String id = request.getParameter("id");
		String role = request.getParameter("role");

		if (id == null || id.trim().isEmpty() || role == null || role.trim().isEmpty()) {
			sendErrorResponse(response, "/admin/manageUser", "ID và vai trò không được để trống.");
			return;
		}

		if (!role.equalsIgnoreCase("Admin") && !role.equalsIgnoreCase("User")) {
			sendErrorResponse(response, "/admin/manageUser",
					"Vai trò không hợp lệ. Chỉ chấp nhận 'Admin' hoặc 'User'.");
			return;
		}

		User user = UserDAO.findById(id);
		if (user == null) {
			sendErrorResponse(response, "/admin/manageUser", "Không tìm thấy người dùng.");
			return;
		}

		user.setRole(role);

		int result = UserDAO.update(user);

		if (result == 1) {
			String successMessage = URLEncoder.encode("Cập nhật vai trò thành công.", "UTF-8");
			response.sendRedirect(
					request.getContextPath() + "/admin/manageUser?success=" + successMessage + "&modal=success");
		} else {
			sendErrorResponse(response, "/admin/manageUser", "Không thể cập nhật vai trò. Vui lòng thử lại.");
		}
	}

	private void handleLockUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String id = request.getParameter("id");

		if (id == null || id.trim().isEmpty()) {
			sendErrorResponse(response, "/admin/manageUser", "User ID is required.");
			return;
		}

		User user = UserDAO.findById(id);
		if (user == null) {
			sendErrorResponse(response, "/admin/manageUser", "User not found.");
			return;
		}

		boolean newLockStatus = !user.isLocked();
		user.setLocked(newLockStatus);

		int result = UserDAO.update(user);

		String action = newLockStatus ? "khóa" : "mở khóa";
		if (result == 1) {
			String successMessage = URLEncoder.encode("Đã " + action + " tài khoản.", "UTF-8");
			response.sendRedirect(
					request.getContextPath() + "/admin/manageUser?success=" + successMessage + "&modal=success");
		} else {
			sendErrorResponse(response, "/admin/manageUser", "Failed to " + action + " the user. Please try again.");
		}
	}

	private void handleAddCourse(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		if (request.getContentType() != null && request.getContentType().startsWith("multipart/form-data")) {
			Part imagePart = request.getPart("image");
			String name = request.getParameter("name");
			String priceStr = request.getParameter("price");
			String saleStr = request.getParameter("sale");
			String categoryStr = request.getParameter("category");

			HttpSession session = request.getSession(false);
			if (session == null || session.getAttribute("currentUser") == null) {
				sendErrorResponse(response, "/admin/manageCourse", "User session is not active. Please log in again.");
				return;
			}

			User instructor = (User) session.getAttribute("currentUser");

			if (instructor == null) {
				sendErrorResponse(response, "/admin/manageCourse", "Invalid user session. Please log in again.");
				return;
			}

			String validationMessage = validateCourse(name, priceStr, saleStr, categoryStr);
			if (validationMessage != null) {
				sendErrorResponse(response, "/admin/manageCourse", validationMessage);
				return;
			}

			double price = Double.parseDouble(priceStr);
			int sale = saleStr != null && !saleStr.trim().isEmpty() ? Integer.parseInt(saleStr) : 0;
			double priceSale = price - (price * sale / 100.0);

			Category courseCategory = CategoryDAO.findById(Integer.parseInt(categoryStr));
			if (courseCategory == null) {
				sendErrorResponse(response, "/admin/manageCourse", "Invalid category.");
				return;
			}

			String imagePath = null;
			if (imagePart != null) {
				String fileName = Path.of(imagePart.getSubmittedFileName()).getFileName().toString();
				String extension = fileName.substring(fileName.lastIndexOf("."));
				fileName = UUID.randomUUID().toString() + extension;

				String projectPath = "D:/FPT Polytechnic/Java4/ASM/src/main/webapp";
				Path assetsDir = Paths.get(projectPath, "assets", "img");

				if (!Files.exists(assetsDir)) {
					Files.createDirectories(assetsDir);
				}

				Path filePath = assetsDir.resolve(fileName);

				try (InputStream inputStream = imagePart.getInputStream()) {
					Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
				}
				imagePath = "/assets/img/" + fileName;
			}

			Course course = new Course();
			course.setName(name);
			course.setInstructor(instructor);
			course.setPrice(price);
			course.setSale(sale);
			course.setPricesale(priceSale);
			course.setImage("/ASM" + imagePath);
			course.setCategory(courseCategory);

			int result = CourseDAO.create(course);

			if (result == 1) {
				response.sendRedirect(request.getContextPath()
						+ "/admin/manageCourse?success=Course added successfully.&modal=success");
			} else {
				sendErrorResponse(response, "/admin/manageCourse", "Failed to add the course. Please try again.");
			}
		} else {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "The request is not multipart.");
		}
	}

	private void handleEditCourse(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String idStr = request.getParameter("id");
		String name = request.getParameter("name");
		String priceStr = request.getParameter("price");
		String saleStr = request.getParameter("sale");
		String categoryStr = request.getParameter("category");
		String description = request.getParameter("description");

		Part imagePart = request.getPart("image");

		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("currentUser") == null) {
			sendErrorResponse(response, "/admin/manageCourse", "User session is not active. Please log in again.");
			return;
		}

		User instructor = (User) session.getAttribute("currentUser");
		if (instructor == null) {
			sendErrorResponse(response, "/admin/manageCourse", "Invalid user session. Please log in again.");
			return;
		}

		String validationMessage = validateCourse(name, priceStr, saleStr, categoryStr);
		if (validationMessage != null) {
			sendErrorResponse(response, "/admin/manageCourse", validationMessage);
			return;
		}

		int id = Integer.parseInt(idStr);
		double price = Double.parseDouble(priceStr);
		int sale = saleStr != null && !saleStr.trim().isEmpty() ? Integer.parseInt(saleStr) : 0;
		double priceSale = price - (price * sale / 100.0);

		Category courseCategory = CategoryDAO.findById(Integer.parseInt(categoryStr));
		if (courseCategory == null) {
			sendErrorResponse(response, "/admin/manageCourse", "Invalid category.");
			return;
		}

		Course course = CourseDAO.findById(id);
		if (course == null) {
			sendErrorResponse(response, "/admin/manageCourse", "Course not found.");
			return;
		}

		String oldImagePath = course.getImage();
		if (imagePart != null && imagePart.getSize() > 0) {
			String fileName = Path.of(imagePart.getSubmittedFileName()).getFileName().toString();
			String extension = fileName.substring(fileName.lastIndexOf("."));
			fileName = UUID.randomUUID().toString() + extension;

			if (!extension.equalsIgnoreCase(".jpg") && !extension.equalsIgnoreCase(".png")) {
				sendErrorResponse(response, "/admin/manageCourse", "Only JPG and PNG images are allowed.");
				return;
			}

			String projectPath = "D:/FPT Polytechnic/Java4/ASM/src/main/webapp";
			Path assetsDir = Paths.get(projectPath, "assets", "img");
			if (!Files.exists(assetsDir)) {
				Files.createDirectories(assetsDir);
			}
			Path filePath = assetsDir.resolve(fileName);

			try (InputStream inputStream = imagePart.getInputStream()) {
				Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
			}

			if (oldImagePath != null && !oldImagePath.isEmpty()) {
				Path oldFilePath = Paths.get(projectPath, oldImagePath.replaceFirst("/ASM", ""));
				Files.deleteIfExists(oldFilePath);
			}

			course.setImage("/ASM/assets/img/" + fileName);
		}

		course.setName(name);
		course.setPrice(price);
		course.setSale(sale);
		course.setPricesale(priceSale);
		course.setInstructor(instructor);
		course.setCategory(courseCategory);
		course.setDescription(description);

		int result = CourseDAO.update(course);

		if (result == 1) {
			response.sendRedirect(request.getContextPath()
					+ "/admin/manageCourse?success=Course updated successfully.&modal=success");
		} else {
			sendErrorResponse(response, "/admin/manageCourse", "Failed to update the course. Please try again.");
		}
	}

	private void handleDeleteCourse(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String idStr = request.getParameter("id");

		if (idStr == null || idStr.trim().isEmpty()) {
			sendErrorResponse(response, "/admin/manageCourse", "Course ID is required.");
			return;
		}

		int id;
		try {
			id = Integer.parseInt(idStr);
		} catch (NumberFormatException e) {
			sendErrorResponse(response, "/admin/manageCourse", "Invalid Course ID.");
			return;
		}

		Course course = CourseDAO.findById(id);
		if (course == null) {
			sendErrorResponse(response, "/admin/manageCourse", "Course not found.");
			return;
		}

		boolean isReferenced = CourseDAO.isCourseReferenced(id);
		if (isReferenced) {
			sendErrorResponse(response, "/admin/manageCourse",
					"Cannot delete the course because it is currently being referenced in enrollments or other data.");
			return;
		}

		int result = CourseDAO.delete(id);

		if (result == 1) {
			response.sendRedirect(request.getContextPath()
					+ "/admin/manageCourse?success=Course deleted successfully.&modal=success");
		} else {
			sendErrorResponse(response, "/admin/manageCourse", "Failed to delete the course. Please try again.");
		}
	}

	private String validateCourse(String name, String priceStr, String saleStr, String categoryStr) {
		if (name == null || name.trim().isEmpty()) {
			return "Course name is required.";
		}
		if (priceStr == null || priceStr.trim().isEmpty()) {
			return "Price is required.";
		}
		try {
			double price = Double.parseDouble(priceStr);
			if (price < 0) {
				return "Price must be a positive number.";
			}
			if (saleStr != null && !saleStr.trim().isEmpty()) {
				int sale = Integer.parseInt(saleStr);
				if (sale < 0 || sale > 100) {
					return "Sale percentage must be between 0 and 100.";
				}
			}
		} catch (NumberFormatException e) {
			return "Invalid number format for price or sale.";
		}

		if (categoryStr == null || categoryStr.trim().isEmpty()) {
			return "Category is required.";
		}

		return null;
	}

	private void sendErrorResponse(HttpServletResponse response, String redirectUrl, String message)
			throws IOException {
		response.sendRedirect(redirectUrl + "?error=" + URLEncoder.encode(message, "UTF-8"));
	}

}
