package com.AltF4.dao;

import java.util.List;

import com.AltF4.model.Enrollment;
import com.AltF4.utils.XJpa;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

public class EnrollmentDAO {
	public static EntityManager entityManager = XJpa.getEntityManager();

	public static List<Enrollment> findByUser(String id) {
		String jpql = "SELECT enl FROM Enrollment enl WHERE enl.user.id = :userId";
		TypedQuery<Enrollment> query = entityManager.createQuery(jpql, Enrollment.class);
		query.setParameter("userId", id);
		return query.getResultList();
	}

	public static boolean isUserEnrolledInCourse(String userId, int courseId) {
		String jpql = "SELECT COUNT(e) FROM Enrollment e WHERE e.user.id = :userId AND e.course.id = :courseId";
		Long count = entityManager.createQuery(jpql, Long.class).setParameter("userId", userId)
				.setParameter("courseId", courseId).getSingleResult();
		return count > 0;
	}

	public static int create(Enrollment enrollment) {
		entityManager.getTransaction().begin();
		try {
			entityManager.persist(enrollment);
			entityManager.getTransaction().commit();
			return 1;
		} catch (Exception e) {
			entityManager.getTransaction().rollback();
		}
		return 0;
	}

	public static int update(Enrollment enrollment) {
		entityManager.getTransaction().begin();
		try {
			entityManager.merge(enrollment);
			entityManager.getTransaction().commit();
			return 1;
		} catch (Exception e) {
			entityManager.getTransaction().rollback();
		}
		return 0;
	}

	public static int delete(int id) {
		Enrollment enrollment = entityManager.find(Enrollment.class, id);
		entityManager.getTransaction().begin();
		try {
			entityManager.remove(enrollment);
			entityManager.getTransaction().commit();
			return 1;
		} catch (Exception e) {
			entityManager.getTransaction().rollback();
		}
		return 0;
	}
}