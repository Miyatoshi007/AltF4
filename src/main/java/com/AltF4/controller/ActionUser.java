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

@WebServlet("/user/profile/updateProfile")
public class ActionUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ActionUser() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("currentUser") == null) {
			response.sendRedirect(request.getContextPath() + "/login?error=unauthorized");
			return;
		}

		String fullName = request.getParameter("fullName");
		String email = request.getParameter("email");
		String phoneNumber = request.getParameter("phoneNumber");
		String address = request.getParameter("address");

		User currentUser = (User) session.getAttribute("currentUser");

		String errorMessage = validateUserInput(fullName, email, phoneNumber, address);
		if (errorMessage != null) {
			request.setAttribute("errorMessage", errorMessage);
			response.sendRedirect(request.getContextPath() + "/user/profile?success=nullError");
			return;
		}

		currentUser.setFullname(fullName);
		currentUser.setEmail(email);
		currentUser.setPhoneNumber(phoneNumber);
		currentUser.setAddress(address);

		int result = UserDAO.update(currentUser);

		if (result == 1) {
			session.setAttribute("currentUser", currentUser);
			response.sendRedirect(request.getContextPath() + "/user/profile?success=updated");
		} else {
			request.setAttribute("errorMessage", "Không thể cập nhật thông tin. Vui lòng thử lại sau.");
			response.sendRedirect(request.getContextPath() + "/user/profile?success=nullError");
		}
	}

	private String validateUserInput(String fullName, String email, String phoneNumber, String address) {
		if (fullName == null || fullName.trim().isEmpty()) {
			return "Họ tên không được để trống!";
		}

		if (email == null || !email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
			return "Email không hợp lệ!";
		}

		if (phoneNumber != null && !phoneNumber.matches("^\\d{10,15}$")) {
			return "Số điện thoại không hợp lệ!";
		}

		if (address == null || address.trim().isEmpty()) {
			return "Địa chỉ không được để trống.";
		}
		return null;
	}
}
