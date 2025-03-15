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
import com.AltF4.dao.UserDAO;
import com.AltF4.model.Course;
import com.AltF4.model.User;
import com.AltF4.utils.AutoGenerateID;

@WebServlet({ "/index", "/login", "/signup", "/forgotPass", "/logout", "/listPremiumCourse", "/index/course",
		"/error" })
public class StartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public StartServlet() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String uri = request.getServletPath();
		if (uri.endsWith("/login")) {
			request.getRequestDispatcher("/views/login.jsp").forward(request, response);
		}
		if (uri.endsWith("/index")) {
			List<Course> list3Pre = CourseDAO.findTop3PremiumCourses();
			List<Course> listFree = CourseDAO.findFreeCourses();
			request.setAttribute("list3Pre", list3Pre);
			request.setAttribute("listFree", listFree);
			request.getRequestDispatcher("/views/index.jsp").forward(request, response);
		}
		if (uri.endsWith("/signup")) {
			request.getRequestDispatcher("/views/signup.jsp").forward(request, response);
		}
		if (uri.endsWith("/forgotPass")) {
			HttpSession session = request.getSession();
			String currentStep = (String) session.getAttribute("currentStep");

			if (currentStep == null) {
				// Mặc định vào bước 1 nếu chưa có bước nào
				session.setAttribute("currentStep", "step1");
			}
			request.getRequestDispatcher("/views/forgotPass.jsp").forward(request, response);
		}
		if (uri.endsWith("/logout")) {
			handleLogout(request, response);
		}
		if (uri.endsWith("/listPremiumCourse")) {
			List<Course> listPre = CourseDAO.findPremiumCourses();
			request.setAttribute("listPre", listPre);
			HttpSession session = request.getSession();
			User user = (User) session.getAttribute("currentUser");
			if (user == null) {
				request.getRequestDispatcher("/views/listCourse.jsp").forward(request, response);
			} else {
				request.getRequestDispatcher("/views/user/listCourse.jsp").forward(request, response);
			}
		}
		if (uri.endsWith("/index/course")) {

		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String uri = request.getServletPath();
		switch (uri) {
		case "/login":
			handleLogin(request, response);
			break;
		case "/signup":
			handleRegister(request, response);
			break;
		default:
			response.sendError(HttpServletResponse.SC_NOT_FOUND, "Yêu cầu không hợp lệ");
			break;
		}
	}

	private void handleLogin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String email = request.getParameter("email");
		String password = request.getParameter("password");

		String errorMessage = validateLogin(email, password);
		if (errorMessage != null) {
			request.setAttribute("email", email);
			request.setAttribute("password", password);
			request.setAttribute("errorMessage", errorMessage);
			request.getRequestDispatcher("/views/login.jsp").forward(request, response);
		} else {
			User user = UserDAO.findByEmail(email);
			request.getSession().setAttribute("currentUser", user);

			String redirectURL = (String) session.getAttribute("secureUrl");

			session.removeAttribute("secureUrl");

			if (redirectURL != null) {
				response.sendRedirect(redirectURL);
			} else {
				String role = user.getRole();
				if ("admin".equalsIgnoreCase(role)) {
					response.sendRedirect(request.getContextPath() + "/admin/dashboard");
				} else if ("user".equalsIgnoreCase(role)) {
					if (user.getFullname() == null) {
						response.sendRedirect("/ASM/user/profile");
					}
					response.sendRedirect(request.getContextPath() + "/user/home/course");
				} else {
					response.sendError(HttpServletResponse.SC_FORBIDDEN, "Quyền truy cập không hợp lệ.");
				}
			}
		}
	}

	private void handleRegister(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirm-password");

		request.setAttribute("emailRegister", email);
		request.setAttribute("passwordRegister", password);
		request.setAttribute("confirmpasswordRegister", confirmPassword);

		String errorMessage = validateRegister(email, password, confirmPassword);
		if (errorMessage != null) {
			request.setAttribute("errorMessage", errorMessage);
			request.getRequestDispatcher("/views/signup.jsp").forward(request, response);
			return;
		}

		if (UserDAO.checkExist(email)) {
			request.setAttribute("errorMessage", "Email này đã được sử dụng.");
			request.getRequestDispatcher("/views/signup.jsp").forward(request, response);
			return;
		}

		User newUser = new User();
		newUser.setId(AutoGenerateID.generateUserId());
		newUser.setEmail(email);
		newUser.setPassword(password);
		newUser.setRole("User");

		int result = UserDAO.create(newUser);

		if (result == 1) {
			response.sendRedirect(request.getContextPath() + "/login");
		} else {
			request.setAttribute("errorMessage", "Đăng ký không thành công. Vui lòng thử lại sau.");
			request.getRequestDispatcher("/views/signup.jsp").forward(request, response);
		}
	}

	private void handleLogout(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession(false);
		if (session != null) {
			session.invalidate();
		}

		response.sendRedirect(request.getContextPath() + "/index");
	}

	private String validateRegister(String email, String password, String confirmPassword) {
		if (email == null || email.isEmpty() || password == null || password.isEmpty() || confirmPassword == null
				|| confirmPassword.isEmpty()) {
			return "Vui lòng nhập đầy đủ thông tin.";
		}

		String emailPattern = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$";
		if (!email.matches(emailPattern)) {
			return "";
		}

		if (password.length() < 6) {
			return "Mật khẩu phải có ít nhất 6 ký tự.";
		}

		if (!password.equals(confirmPassword)) {
			return "";
		}
		return null;
	}

	private String validateLogin(String email, String password) {
		if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
			return "Vui lòng nhập đầy đủ thông tin đăng nhập.";
		}

		String emailPattern = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$";
		if (!email.matches(emailPattern)) {
			return "Định dạng email không hợp lệ.";
		}

		User user = UserDAO.findByEmail(email);
		if (user == null || !user.getPassword().equals(password)) {
			return "Thông tin tài khoản hoặc mật khẩu không chính xác.";
		}

		return null;
	}

}
