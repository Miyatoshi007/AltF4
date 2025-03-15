package com.AltF4.dao;

import java.util.List;

import com.AltF4.model.Category;
import com.AltF4.utils.XJpa;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

public class CategoryDAO {
	static EntityManager entityManager = XJpa.getEntityManager();

	// Phương thức tìm Category theo ID
	public static Category findById(int id) {
		return entityManager.find(Category.class, id); // Trả về đối tượng Category dựa trên ID
	}

	// Phương thức tìm tất cả Categories (nếu cần)
	public static List<Category> findAll() {
		TypedQuery<Category> query = entityManager.createQuery("SELECT c FROM Category c", Category.class);
		return query.getResultList();
	}
}
