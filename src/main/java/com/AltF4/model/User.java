package com.AltF4.model;

import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "Users")
public class User {
	@Id
	@Column(name = "ID")
	private String id;

	@Column(name = "Email", nullable = false, unique = true)
	private String email;

	@Column(name = "Password", nullable = false)
	private String password;

	@Column(name = "Name")
	private String fullname;

	@Column(name = "Address")
	private String address;

	@Column(name = "PhoneNumber")
	private String phoneNumber;

	@Column(name = "Role", nullable = false)
	private String role;

	@Column(name = "isLocked")
	private boolean locked;

	@OneToMany(mappedBy = "user")
	private List<Bookmark> bookmarks; // Quan hệ OneToMany với Bookmark
}
