package org.example.entity;

import jakarta.persistence.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(nullable = false, unique = true)
    private String username;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false, columnDefinition = "INT DEFAULT 0")
    private int loginCount;

    @Column(nullable = true)
    private LocalDateTime lastLogin;

    /*@Column(nullable = false, updatable = false, columnDefinition = "DATE DEFAULT (CURDATE())")
    private LocalDate created_date;

    @Column(nullable = false, updatable = false, columnDefinition = "TIME DEFAULT (CURTIME())")
    private LocalTime created_time;*/

    @Column(nullable = false, columnDefinition = "BOOLEAN DEFAULT FALSE")
    private boolean isAdmin;

    // Constructor vacío (requerido por JPA)
    public User() {}

    // Constructor con parámetros
    public User(String username, String password) {
        this.username = username;
        this.password = password;
        this.loginCount = 0;
        this.isAdmin = false;
    }

    // Getters y Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getLoginCount() {
        return loginCount;
    }

    public void setLoginCount(int loginCount) {
        this.loginCount = loginCount;
    }

   public LocalDateTime getLastLogin() {
        return lastLogin;
    }

    public void setLastLogin(LocalDateTime lastLogin) {
        this.lastLogin = lastLogin;
    }

   /*public LocalDate getCreatedDate() {
        return created_date;
    }

    public void setCreatedDate(LocalDate createdDate) {
        this.created_date = createdDate;
    }

    public LocalTime getCreatedTime() {
        return created_time;
    }

    public void setCreatedTime(LocalTime createdTime) {
        this.created_time = createdTime;
    }*/

    public boolean isAdmin() {
        return isAdmin;
    }

    public void setAdmin(boolean admin) {
        isAdmin = admin;
    }
}