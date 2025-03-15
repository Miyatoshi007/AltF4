package com.AltF4.dao;

import java.util.List;

import com.AltF4.model.Course;
import com.AltF4.utils.XJpa;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

public class CourseDAO {
	static EntityManager entityManager = XJpa.getEntityManager();

	public static List<Course> findAll() {
		String jpql = "SELECT cs FROM Course cs";
		TypedQuery<Course> query = XJpa.getEntityManager().createQuery(jpql, Course.class);
		return query.getResultList();
	}

	public static List<Course> findTop3PremiumCourses() {
		String jpql = "SELECT c FROM Course c WHERE c.category.name = :categoryName ORDER BY c.purchased DESC";
		TypedQuery<Course> query = entityManager.createQuery(jpql, Course.class);
		query.setParameter("categoryName", "Premium");
		query.setMaxResults(3);
		return query.getResultList();
	}

	public static List<Course> findPremiumCourses() {
		String jpql = "SELECT c FROM Course c WHERE c.category.name = :categoryName";
		TypedQuery<Course> query = entityManager.createQuery(jpql, Course.class);
		query.setParameter("categoryName", "Premium");
		return query.getResultList();
	}

	public static List<Course> findFreeCourses() {
		String jpql = "SELECT c FROM Course c WHERE c.category.name = :categoryName";
		TypedQuery<Course> query = entityManager.createQuery(jpql, Course.class);
		query.setParameter("categoryName", "Free");
		return query.getResultList();
	}

	public static Course findById(int id) {
		return entityManager.find(Course.class, id);
	}

	public static List<Course> getCourses(String search, int page, int pageSize) {
		String jpql = "SELECT c FROM Course c WHERE c.name LIKE :search";
		TypedQuery<Course> query = entityManager.createQuery(jpql, Course.class);
		query.setParameter("search", "%" + search + "%");
		query.setFirstResult((page - 1) * pageSize);
		query.setMaxResults(pageSize);

		return query.getResultList();
	}

	// Phương thức lấy tổng số khóa học phù hợp với điều kiện tìm kiếm
	public static int getTotalCourses(String search) {
		String jpql = "SELECT COUNT(c) FROM Course c WHERE c.name LIKE :search";
		TypedQuery<Long> query = entityManager.createQuery(jpql, Long.class);
		query.setParameter("search", "%" + search + "%");

		Long count = query.getSingleResult();
		return count.intValue();
	}

	public static boolean isCourseReferenced(int courseId) {
		String jpql = "SELECT COUNT(e) FROM Enrollment e WHERE e.course.id = :courseId";
		TypedQuery<Long> query = entityManager.createQuery(jpql, Long.class);
		query.setParameter("courseId", courseId);
		Long count = query.getSingleResult();
		return count > 0; // Nếu số lượng lớn hơn 0, khóa học đang được tham chiếu
	}

	public static int create(Course course) {
		entityManager.getTransaction().begin();
		try {
			entityManager.persist(course);
			entityManager.getTransaction().commit();
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			entityManager.getTransaction().rollback();
		}
		return 0;
	}

	public static int update(Course course) {
		entityManager.getTransaction().begin();
		try {
			entityManager.merge(course);
			entityManager.getTransaction().commit();
			return 1;
		} catch (Exception e) {
			entityManager.getTransaction().rollback();
		}
		return 0;
	}

	public static int delete(int id) {
		Course course = entityManager.find(Course.class, id);
		entityManager.getTransaction().begin();
		try {
			entityManager.remove(course);
			entityManager.getTransaction().commit();
			return 1;
		} catch (Exception e) {
			entityManager.getTransaction().rollback();
		}
		return 0;
	}
}
