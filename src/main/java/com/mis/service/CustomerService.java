/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mis.service;

import com.google.gson.JsonObject;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;

/**
 *
 * @author zheng
 */
public interface CustomerService {
    public String processSignUp(JsonObject jsonBody) throws SQLException, IOException;
    public Map<String, String> forgetPassword(JsonObject jsonBody) throws SQLException, IOException;
    public String checkUserName(String userName) throws SQLException;
    public String checkEmail(String email) throws SQLException;
    public String checkPassword(String password);
    public String checkConfirmPassword(String password, String confirmPassword);
}
