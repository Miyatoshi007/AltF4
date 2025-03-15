package com.AltF4.utils;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.Message;

public class SendMail {
	private static final String SMTP_HOST = "smtp.gmail.com";
	private static final String SMTP_PORT = "587";
	private static final String FROM_EMAIL = "ninhnapc09333@gmail.com"; // Email gửi
	private static final String EMAIL_PASSWORD = "erfiejsezuvkkxoc"; // Mật khẩu email gửi

	public static boolean sendOTP(String toEmail, String otp) {
		Properties properties = new Properties();
		properties.put("mail.smtp.host", SMTP_HOST);
		properties.put("mail.smtp.port", SMTP_PORT);
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.starttls.enable", "true");

		Session session = Session.getInstance(properties, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(FROM_EMAIL, EMAIL_PASSWORD);
			}
		});

		try {
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(FROM_EMAIL));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
			message.setSubject("Mã OTP để thay đổi mật khẩu");
			message.setText("Mã OTP của bạn là: " + otp);

			Transport.send(message);
			return true; // Gửi email thành công
		} catch (MessagingException e) {
			e.printStackTrace();
			return false; // Gửi email thất bại
		}
	}
}
