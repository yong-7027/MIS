/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.mis.dao;

import com.mis.pojo.Customer;
import java.sql.SQLException;
import java.util.Map;

/**
 *
 * @author zheng
 */
public interface UserDao {
    public Map<String, Object> selectByUserName(String userName) throws SQLException;
    public Map<String, Object> selectByToken(String token) throws SQLException;
    public Map<String, Integer> selectOtpByEmail(String email) throws SQLException;
    public boolean isExists(String columnName, String value) throws SQLException;
    public void addCustomer(Customer cust) throws SQLException;
    public boolean updateVerifyStatus(String verifyToken) throws SQLException;
    public boolean resetLife(String userName) throws SQLException;
    public boolean updateLifeAndTime(int life, long lastAttemptTime, String userName) throws SQLException;
    public boolean updateOTP(int otp, String email) throws SQLException;
    public boolean updatePassword(String password, String email) throws SQLException;
}
