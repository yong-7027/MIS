/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mis.pojo;

/**
 *
 * @author zheng
 */
public class Customer extends User {
    private String profileImgUrl;
    private int otp;
    private int accAvailable;

    public Customer() {
    }

    public Customer(String profileImgUrl, int otp, int accAvailable) {
        this.profileImgUrl = profileImgUrl;
        this.otp = otp;
        this.accAvailable = accAvailable;
    }

    public Customer(Login login, String email, String verifyToken) {
        super(login, email, verifyToken);
    }

    public Customer(String profileImgUrl, int otp, int accAvailable, Login login, int userId, String userType, String email, Address address, String phone, String verifyToken, int verifyStatus, int life, int lastAttemptTime) {
        super(login, userId, userType, email, address, phone, verifyToken, verifyStatus, life, lastAttemptTime);
        this.profileImgUrl = profileImgUrl;
        this.otp = otp;
        this.accAvailable = accAvailable;
    }

    public String getProfileImgUrl() {
        return profileImgUrl;
    }

    public int getOtp() {
        return otp;
    }

    public int getAccAvailable() {
        return accAvailable;
    }

    public void setProfileImgUrl(String profileImgUrl) {
        this.profileImgUrl = profileImgUrl;
    }

    public void setOtp(int otp) {
        this.otp = otp;
    }

    public void setAccAvailable(int accAvailable) {
        this.accAvailable = accAvailable;
    }
}
