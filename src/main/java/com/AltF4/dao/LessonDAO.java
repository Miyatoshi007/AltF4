package com.AltF4.dao;

import java.util.List;

import com.AltF4.model.Lesson;
import com.AltF4.utils.XJpa;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

public class LessonDAO {
	static EntityManager entityManager = XJpa.getEntityManager();

	public static List<Lesson> findAllByCourseId(int courseId) {
		String jpql = "SELECT ls FROM Lesson ls WHERE ls.course.id = :courseId";
		TypedQuery<Lesson> query = XJpa.getEntityManager().createQuery(jpql, Lesson.class);
		query.setParameter("courseId", courseId);
		return query.getResultList();
	}

	public static Lesson findById(int id) {
		return entityManager.find(Lesson.class, id);
	}

	public static int create(Lesson lesson) {
		entityManager.getTransaction().begin();
		try {
			entityManager.persist(lesson);
			entityManager.getTransaction().commit();
			return 1;
		} catch (Exception e) {
			entityManager.getTransaction().rollback();
		}
		return 0;
	}

	public static int update(Lesson lesson) {
		entityManager.getTransaction().begin();
		try {
			entityManager.merge(lesson);
			entityManager.getTransaction().commit();
			return 1;
		} catch (Exception e) {
			entityManager.getTransaction().rollback();
		}
		return 0;
	}

	public static int delete(int id) {
		Lesson lesson = entityManager.find(Lesson.class, id);
		entityManager.getTransaction().begin();
		try {
			entityManager.remove(lesson);
			entityManager.getTransaction().commit();
			return 1;
		} catch (Exception e) {
			entityManager.getTransaction().rollback();
		}
		return 0;
	}
}
