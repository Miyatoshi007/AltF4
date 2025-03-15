package com.AltF4.utils;

import com.AltF4.dao.UserDAO;

public class AutoGenerateID {
	public static String generateUserId() {
		String userId;
		do {
			// Tạo ID ngẫu nhiên với định dạng "Userxxxxxx" (6 số ngẫu nhiên)
			int randomPart = (int) (Math.random() * 1000000);
			userId = String.format("User" + "%06d", randomPart);
		} while (UserDAO.findById(userId) != null);

		return userId;
	}
}
