package com.AltF4.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "Bookmarks")
public class Bookmark {

	@Id
	@Column(name = "User_id")
	private String userId;

	@Id
	@Column(name = "Course_id")
	private int courseId;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "User_id", referencedColumnName = "ID", insertable = false, updatable = false)
	private User user;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "Course_id", referencedColumnName = "ID", insertable = false, updatable = false)
	private Course course;

}
