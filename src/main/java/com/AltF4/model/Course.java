package com.AltF4.model;

import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "Courses")
public class Course {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID")
	private int id;

	@Column(name = "Name", nullable = false)
	private String name;

	@Column(name = "Image")
	private String image;

	@Column(name = "Description")
	private String description;

	@ManyToOne
	@JoinColumn(name = "Categories_ID", nullable = false)
	@ToString.Exclude
	private Category category;

	@ManyToOne
	@JoinColumn(name = "Instructor_ID", nullable = false)
	@ToString.Exclude
	private User instructor;

	@Column(name = "Purchased", nullable = false)
	private int purchased;

	@Column(name = "Price", nullable = false)
	private double price;

	@Column(name = "SalePercent")
	private Integer sale;

	@Column(name = "PriceSale")
	private double pricesale;

	@Column(name = "Require")
	private String require;

	@OneToMany(mappedBy = "course")
	private List<Bookmark> bookmarks; // Quan hệ OneToMany với Bookmark
}
