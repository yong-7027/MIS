/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mis.pojo;

import java.util.Date;

/**
 *
 * @author zheng
 */
public class User {
    private Login login;
    private int userId;
    private String userType;
    private String email;
    private Address address;
    private String phone;
    private Date joinDate;
    private String verifyToken;
    private int verifyStatus;
    private int life;
    private int lastAttemptTime;

    public User() {
    }

    public User(Login login, String email, String verifyToken) {
        this.login = login;
        this.email = email;
        this.joinDate = new Date();
        this.verifyToken = verifyToken;
    }

    public User(Login login, int userId, String userType, String email, Address address, String phone, String verifyToken, int verifyStatus, int life, int lastAttemptTime) {
        this.login = login;
        this.userId = userId;
        this.userType = userType;
        this.email = email;
        this.address = address;
        this.phone = phone;
        this.joinDate = new Date();
        this.verifyToken = verifyToken;
        this.verifyStatus = verifyStatus;
        this.life = life;
        this.lastAttemptTime = lastAttemptTime;
    }

    public Login getLogin() {
        return login;
    }

    public int getUserId() {
        return userId;
    }

    public String getUserType() {
        return userType;
    }

    public String getEmail() {
        return email;
    }

    public Address getAddress() {
        return address;
    }

    public String getPhone() {
        return phone;
    }

    public Date getJoinDate() {
        return joinDate;
    }

    public String getVerifyToken() {
        return verifyToken;
    }

    public int getVerifyStatus() {
        return verifyStatus;
    }

    public int getLife() {
        return life;
    }

    public int getLastAttemptTime() {
        return lastAttemptTime;
    }

    public void setLogin(Login login) {
        this.login = login;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setVerifyToken(String verifyToken) {
        this.verifyToken = verifyToken;
    }

    public void setVerifyStatus(int verifyStatus) {
        this.verifyStatus = verifyStatus;
    }

    public void setLife(int life) {
        this.life = life;
    }

    public void setLastAttemptTime(int lastAttemptTime) {
        this.lastAttemptTime = lastAttemptTime;
    }
}
