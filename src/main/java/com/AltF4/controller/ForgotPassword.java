package com.AltF4.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.AltF4.dao.UserDAO;
import com.AltF4.model.User;
import com.AltF4.utils.AutoGenerateOTP;
import com.AltF4.utils.SendMail;

@WebServlet({ "/forgotPass/checkMail", "/forgotPass/checkOTP", "/forgotPass/changePass" })
public class ForgotPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ForgotPassword() {
		super();
	}

	private static final String STEP_1 = "step1";
	private static final String STEP_2 = "step2";
	private static final String STEP_3 = "step3";

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String currentStep = (String) session.getAttribute("currentStep");

		if (currentStep == null) {
			session.setAttribute("currentStep", STEP_1);
		}

		request.getRequestDispatcher("/views/forgotPass.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String path = request.getServletPath();

		if ("/forgotPass/checkMail".equals(path)) {
			handleStep1(request, response);
		} else if ("/forgotPass/checkOTP".equals(path)) {
			handleStep2(request, response);
		} else if ("/forgotPass/changePass".equals(path)) {
			handleStep3(request, response);
		}
	}

	private void handleStep1(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String email = request.getParameter("email");
		HttpSession session = request.getSession();

		if (isValidEmail(email)) {
			String otp = AutoGenerateOTP.generateOTP();
			session.setAttribute("otp", otp);
			session.setAttribute("email", email);
			boolean emailSent = SendMail.sendOTP(email, otp);

			if (emailSent) {
				session.setAttribute("currentStep", STEP_2);
				request.getRequestDispatcher("/views/forgotPass.jsp").forward(request, response);
			} else {
				request.setAttribute("errorMessage", "Gửi email không thành công!");
				request.getRequestDispatcher("/views/forgotPass.jsp").forward(request, response);
			}
		} else {
			if (email.isBlank() || email.isEmpty()) {
				request.setAttribute("errorMessage", "Vui lòng nhập email!");
				request.getRequestDispatcher("/views/forgotPass.jsp").forward(request, response);
			} else {
				request.setAttribute("errorMessage", "Email không tồn tại!");
				request.getRequestDispatcher("/views/forgotPass.jsp").forward(request, response);
			}
		}
	}

	private void handleStep2(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String userOTP = request.getParameter("otp");
		String sessionOTP = (String) request.getSession().getAttribute("otp");

		if (userOTP != null && userOTP.equals(sessionOTP)) {
			request.getSession().setAttribute("currentStep", STEP_3);
			request.getRequestDispatcher("/views/forgotPass.jsp").forward(request, response);
		} else {
			request.setAttribute("errorMessage", "Mã OTP không hợp lệ!");
			request.getRequestDispatcher("/views/forgotPass.jsp").forward(request, response);
		}
	}

	private void handleStep3(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
		String newPassword = request.getParameter("new-password");
		String confirmPassword = request.getParameter("confirm-password");
		if (newPassword == null || newPassword.isBlank() || newPassword.isEmpty() || confirmPassword == null
				|| confirmPassword.isBlank() || confirmPassword.isEmpty()) {
			request.setAttribute("errorMessage", "Vui lòng nhập đầy đủ thông tin!");
			request.getRequestDispatcher("/views/forgotPass.jsp").forward(request, response);
		} else if (newPassword != null && confirmPassword != null && newPassword.equals(confirmPassword)) {
			User user = UserDAO.findByEmail(email);
			user.setPassword(confirmPassword);
			UserDAO.update(user);

			response.sendRedirect("/ASM/login");
		} else {
			request.setAttribute("errorMessage", "Mật khẩu không khớp!");
			request.getRequestDispatcher("/views/forgotPass.jsp").forward(request, response);
		}
	}

	private boolean isValidEmail(String email) {
		User user = UserDAO.findByEmail(email);
		return user != null && user.getEmail().equals(email);
	}
}
