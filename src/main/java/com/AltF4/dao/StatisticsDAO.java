package com.AltF4.dao;

import com.AltF4.utils.XJpa;

import jakarta.persistence.EntityManager;

public class StatisticsDAO {
	static EntityManager entityManager = XJpa.getEntityManager();

	public static long countLearner() {
		String jpql = "SELECT COUNT(u) FROM User u WHERE u.role = 'User'";
		return entityManager.createQuery(jpql, Long.class).getSingleResult();
	}

	public static long countCourse() {
		String jpql = "SELECT COUNT(c) FROM Course c";
		return entityManager.createQuery(jpql, Long.class).getSingleResult();
	}

}
