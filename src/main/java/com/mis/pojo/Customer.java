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

    private String verifyToken;
    private int verifyStatus;
    private String profileImgUrl;
    private int otp;
    private int accAvailable;

    public Customer() {
    }

    public Customer(String verifyToken, int verifyStatus, String profileImgUrl, int otp, int accAvailable) {
        this.verifyToken = verifyToken;
        this.verifyStatus = verifyStatus;
        this.profileImgUrl = profileImgUrl;
        this.otp = otp;
        this.accAvailable = accAvailable;
    }

    public Customer(Login login, String email, String verifyToken) {
        super(login, email);
        this.verifyToken = verifyToken;
    }

    public Customer(String verifyToken, int verifyStatus, String profileImgUrl, int otp, int accAvailable, Login login, int userId, String userType, String email, Address address, String phone, int life, int lastAttemptTime) {
        super(login, userId, userType, email, address, phone, life, lastAttemptTime);
        this.verifyToken = verifyToken;
        this.verifyStatus = verifyStatus;
        this.profileImgUrl = profileImgUrl;
        this.otp = otp;
        this.accAvailable = accAvailable;
    }

    public String getVerifyToken() {
        return verifyToken;
    }

    public int getVerifyStatus() {
        return verifyStatus;
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

    public void setVerifyToken(String verifyToken) {
        this.verifyToken = verifyToken;
    }

    public void setVerifyStatus(int verifyStatus) {
        this.verifyStatus = verifyStatus;
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
