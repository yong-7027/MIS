/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mis.service.impl;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonObject;
import com.mis.dao.UserDao;
import com.mis.dao.impl.UserDaoImpl;
import com.mis.pojo.Customer;
import com.mis.pojo.Login;
import com.mis.service.CustomerService;
import com.mis.util.CustomerUtil;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author zheng
 */
public class CustomerServiceImpl implements CustomerService {
    private UserDao userDao = new UserDaoImpl();
    
    @Override
    public String processSignUp(JsonObject jsonBody) throws SQLException, IOException {
        String userName = jsonBody.get("user-name").getAsString();
        String email = jsonBody.get("email").getAsString();
        String password = jsonBody.get("psd").getAsString();
        String confirmPassword = jsonBody.get("confirm-psd").getAsString();
        String token = CustomerUtil.generateToken(20);
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        String userNameError = checkUserName(userName);
        String emailError = checkEmail(email);
        String passwordError = checkPassword(password);
        String confirmPasswordError = checkConfirmPassword(password, confirmPassword);

        Map<String, String> responses = new HashMap<>();

        if (!" ".equals(userNameError)) {
            responses.put("username", userNameError);
        }

        if (!" ".equals(emailError)) {
            responses.put("email", emailError);
        }

        if (!" ".equals(passwordError)) {
            responses.put("password", passwordError);
        }

        if (!" ".equals(confirmPasswordError)) {
            responses.put("confirm_pass", confirmPasswordError);
        }

        // If there is no error message, insert the user information into the users table
        if (" ".equals(userNameError) && " ".equals(emailError) && " ".equals(passwordError) && " ".equals(confirmPasswordError)) {
            Login info = new Login(userName, hashedPassword);
            Customer customer = new Customer(info, email, token);

            try {
                userDao.addCustomer(customer);

                responses.put("url", "hello.jsp");
                responses.put("token", token);
                responses.put("send_email", email);
            } catch (SQLException e) {
                // 处理数据库操作异常
            }
        }

        // 将响应转换为 Json 格式
        ObjectMapper objectMapper = new ObjectMapper();
        String jsonResp = objectMapper.writeValueAsString(responses);
        return jsonResp;
    }
    
    @Override
    public Map<String, String> forgetPassword(JsonObject jsonBody) throws SQLException, IOException {
        String email = jsonBody.get("email").getAsString();
        String otp = CustomerUtil.generateOTP(6);
        Map<String, String> responses = new HashMap<>();
        
        String emailError = checkEmail(email);
        
        switch (emailError) {
            case " ":
                emailError = "No email found. Please enter the valid email.";
                responses.put("error", emailError);
                break;
            case "The email address is already taken.":
                if (userDao.updateOTP(Integer.parseInt(otp), email)) {
                    responses.put("error", " ");
                    responses.put("email", email);
                    responses.put("otp", otp);
                }   
                break;
            default:
                responses.put("error", emailError);
                break;
        }
        
        return responses;
    }
    
    @Override
    public String checkUserName(String userName) throws SQLException {
        if (userName == null || "".equals(userName.trim())) {
            return "Please enter your user name.";
        } else if (userDao.isExists("username", userName) == true) {
            return "The username is already taken.";
        } else {
            return " ";
        }
    }

    @Override
    public String checkEmail(String email) throws SQLException {
        if (email == null || "".equals(email.trim())) {
            return "Please enter your email address.";
        }

        String pattern = "^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
        Pattern p = Pattern.compile(pattern);
        Matcher m = p.matcher(email);

        if (!m.matches()) {
            return "The email address pattern is incorrect.";
        }

        if (userDao.isExists("email", email) == true) {
            return "The email address is already taken.";
        }

        return " ";
    }

    @Override
    public String checkPassword(String password) {
        if (password == null || "".equals(password.trim())) {
            return "Please enter your password.";
        }

        String pattern = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*()\\-_=+{};:,.<>§~\\|\\/\\?]).{8,}$";
        Pattern p = Pattern.compile(pattern);
        Matcher m = p.matcher(password);

        if (!m.matches()) {
            return "Please refer to the below password policy.";
        }

        return " ";
    }

    @Override
    public String checkConfirmPassword(String password, String confirmPassword) {
        if (confirmPassword == null || "".equals(confirmPassword.trim())) {
            return "Please confirm your password.";
        }

        if (!password.equals(confirmPassword)) {
            return "The password do not match.";
        }

        return " ";
    }
}
