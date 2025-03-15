package com.AltF4.utils;

import java.security.SecureRandom;

public class AutoGenerateOTP {
	private static final String NUMERIC_CHARACTERS = "0123456789";
	private static final int OTP_LENGTH = 6;

	public static String generateOTP() {
		SecureRandom random = new SecureRandom();

		StringBuilder otp = new StringBuilder(OTP_LENGTH);

		for (int i = 0; i < OTP_LENGTH; i++) {
			int index = random.nextInt(NUMERIC_CHARACTERS.length());
			otp.append(NUMERIC_CHARACTERS.charAt(index));
		}

		return otp.toString();
	}

//	public static void main(String[] args) {
//		String otp = generateOTP();
//		System.out.println("Generated OTP: " + otp);
//	}
}
