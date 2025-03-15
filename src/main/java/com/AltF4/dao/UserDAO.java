package com.AltF4.dao;

import java.util.List;

import com.AltF4.model.User;
import com.AltF4.utils.XJpa;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

public class UserDAO {
	static EntityManager entityManager = XJpa.getEntityManager();

	public static List<User> findAll() {
		String jpql = "SELECT u FROM User u";
		TypedQuery<User> query = XJpa.getEntityManager().createQuery(jpql, User.class);
		return query.getResultList();
	}

	public static User findByEmail(String email) {
		String jpql = "SELECT u FROM User u WHERE u.email = :email";
		TypedQuery<User> query = XJpa.getEntityManager().createQuery(jpql, User.class);
		query.setParameter("email", email);

		try {
			return query.getSingleResult();
		} catch (Exception e) {
			return null;
		}
	}

	public static User findById(String id) {
		return XJpa.getEntityManager().find(User.class, id);
	}

	public static List<User> findByKeyword(String keyword) {
		String jpql = "SELECT u FROM User u WHERE u.fullname LIKE :keyword OR u.email LIKE :keyword";
		return entityManager.createQuery(jpql, User.class).setParameter("keyword", "%" + keyword + "%").getResultList();

	}

	public static int create(User user) {
		entityManager.getTransaction().begin();
		try {
			entityManager.persist(user);
			entityManager.getTransaction().commit();
			return 1;
		} catch (Exception e) {
			entityManager.getTransaction().rollback();
		}
		return 0;
	}

	public static int update(User user) {
		entityManager.getTransaction().begin();
		try {
			entityManager.merge(user);
			entityManager.getTransaction().commit();
			return 1;
		} catch (Exception e) {
			entityManager.getTransaction().rollback();
		}
		return 0;
	}

	public static int delete(String id) {
		User user = entityManager.find(User.class, id);
		entityManager.getTransaction().begin();
		try {
			entityManager.remove(user);
			entityManager.getTransaction().commit();
			return 1;
		} catch (Exception e) {
			entityManager.getTransaction().rollback();
		}
		return 0;
	}

	public static List<User> findPaginated(int page, int pageSize) {
		String jpql = "SELECT u FROM User u";
		return entityManager.createQuery(jpql, User.class).setFirstResult((page - 1) * pageSize) // Start index
				.setMaxResults(pageSize) // Number of results
				.getResultList();
	}

	public static long countUsers() {
		String jpql = "SELECT COUNT(u) FROM User u";
		return entityManager.createQuery(jpql, Long.class).getSingleResult();
	}

	public static List<User> findByKeywordPaginated(String keyword, int page, int pageSize) {
		String jpql = "SELECT u FROM User u WHERE u.fullname LIKE :keyword OR u.email LIKE :keyword";
		return entityManager.createQuery(jpql, User.class).setParameter("keyword", "%" + keyword + "%")
				.setFirstResult((page - 1) * pageSize).setMaxResults(pageSize).getResultList();

	}

	public static long countUsersByKeyword(String keyword) {
		String jpql = "SELECT COUNT(u) FROM User u WHERE u.fullname LIKE :keyword OR u.email LIKE :keyword";
		return entityManager.createQuery(jpql, Long.class).setParameter("keyword", "%" + keyword + "%")
				.getSingleResult();

	}

	public static boolean checkExist(String email) {
		return findByEmail(email) != null;
	}
}
