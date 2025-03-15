package com.AltF4.utils;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class XJpa {
	static EntityManagerFactory factory;
	static {
		factory = Persistence.createEntityManagerFactory("JAVA4");
	}

	public static EntityManager getEntityManager() {
		if (factory == null) {
			factory = Persistence.createEntityManagerFactory("JAVA4");
		}
		return factory.createEntityManager();
	}
}
