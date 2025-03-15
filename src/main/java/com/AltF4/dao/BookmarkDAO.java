package com.AltF4.dao;

import java.util.List;

import com.AltF4.model.Bookmark;
import com.AltF4.model.Course;
import com.AltF4.model.User;
import com.AltF4.utils.XJpa;

import jakarta.persistence.EntityManager;

public class BookmarkDAO {
	public static EntityManager entityManager = XJpa.getEntityManager();

	// Tạo một bookmark mới
	public static int create(Bookmark bookmark) {
		entityManager.getTransaction().begin();
		try {
			entityManager.persist(bookmark);
			entityManager.getTransaction().commit();
			return 1;
		} catch (Exception e) {
			entityManager.getTransaction().rollback();
			e.printStackTrace();
		}
		return 0;
	}

	// Cập nhật một bookmark
	public static int update(Bookmark bookmark) {
		entityManager.getTransaction().begin();
		try {
			entityManager.merge(bookmark);
			entityManager.getTransaction().commit();
			return 1;
		} catch (Exception e) {
			entityManager.getTransaction().rollback();
			e.printStackTrace();
		}
		return 0;
	}

	// Xóa bookmark bằng cách sử dụng kết hợp userId và courseId
	public static int delete(String userId, int courseId) {
		try {
			entityManager.getTransaction().begin();
			String jpql = "DELETE FROM Bookmark b WHERE b.userId = :userId AND b.courseId = :courseId";
			int result = entityManager.createQuery(jpql).setParameter("userId", userId)
					.setParameter("courseId", courseId).executeUpdate();
			entityManager.getTransaction().commit();
			return result > 0 ? 1 : 0;
		} catch (Exception e) {
			entityManager.getTransaction().rollback();
			e.printStackTrace();
		}
		return 0;
	}

	// Lấy danh sách khóa học mà người dùng đã bookmark
	public static List<Course> getBookmarkedCoursesByUserId(String userId) {
		try {
			String jpql = "SELECT b.course FROM Bookmark b WHERE b.userId = :userId";
			return entityManager.createQuery(jpql, Course.class).setParameter("userId", userId).getResultList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	// Kiểm tra nếu người dùng đã bookmark khóa học
	public static boolean isBookmarked(String userId, int courseId) {
		try {
			String jpql = "SELECT COUNT(b) FROM Bookmark b WHERE b.userId = :userId AND b.courseId = :courseId";
			long count = entityManager.createQuery(jpql, Long.class).setParameter("userId", userId)
					.setParameter("courseId", courseId).getSingleResult();
			return count > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// Lấy bookmark theo ID (nếu cần thiết)
	public static Bookmark findById(String userId, int courseId) {
		try {
			String jpql = "SELECT b FROM Bookmark b WHERE b.userId = :userId AND b.courseId = :courseId";
			return entityManager.createQuery(jpql, Bookmark.class).setParameter("userId", userId)
					.setParameter("courseId", courseId).getSingleResult();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public static List<Course> getBookmarkedCoursesByUserId(int userId) {
		try {
			String jpql = "SELECT c FROM Course c WHERE c.id IN (SELECT b.course.id FROM Bookmark b WHERE b.user.id = :userId)";
			List<Course> bookmarkedCourses = entityManager.createQuery(jpql, Course.class)
					.setParameter("userId", userId).getResultList();
			return bookmarkedCourses;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public static boolean isCourseBookmarked(String userId, int courseId) {
		try {
			// Kiểm tra xem khóa học đã có trong danh sách bookmark của người dùng chưa
			String jpql = "SELECT b FROM Bookmark b WHERE b.user.id = :userId AND b.course.id = :courseId";
			Bookmark existingBookmark = entityManager.createQuery(jpql, Bookmark.class).setParameter("userId", userId)
					.setParameter("courseId", courseId).getResultList().stream().findFirst().orElse(null);
			return existingBookmark != null; // Nếu tồn tại, đã được bookmark
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false; // Nếu có lỗi hoặc không tồn tại, trả về false
	}

	public static boolean addBookmark(String userId, int courseId) {
		try {
			// Tạo mới đối tượng Bookmark
			Bookmark newBookmark = new Bookmark();
			User user = entityManager.find(User.class, userId);
			Course course = entityManager.find(Course.class, courseId);
			newBookmark.setUser(user);
			newBookmark.setCourse(course);

			// Lưu vào cơ sở dữ liệu
			entityManager.getTransaction().begin();
			entityManager.persist(newBookmark);
			entityManager.getTransaction().commit();
			return true;
		} catch (Exception e) {
			if (entityManager.getTransaction().isActive()) {
				entityManager.getTransaction().rollback();
			}
			e.printStackTrace();
		}
		return false;
	}

	public static boolean removeBookmark(String userId, int courseId) {
		try {
			// Xóa bookmark
			String jpql = "DELETE FROM Bookmark b WHERE b.user.id = :userId AND b.course.id = :courseId";
			int deletedCount = entityManager.createQuery(jpql).setParameter("userId", userId)
					.setParameter("courseId", courseId).executeUpdate();

			return deletedCount > 0; // Nếu có bản ghi bị xóa, trả về true
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}
