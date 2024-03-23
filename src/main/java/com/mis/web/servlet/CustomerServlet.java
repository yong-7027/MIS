/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mis.web.servlet;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mis.dao.impl.UserDaoImpl;
import com.mis.pojo.Customer;
import com.mis.pojo.Login;
import com.mis.util.TokenGenerator;
import jakarta.servlet.ServletException;
import java.sql.SQLException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author zheng
 */
@WebServlet("/customer/*")
public class CustomerServlet extends BaseServlet {

    public void selectAll(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("user selectAll..");
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<h1>Hello, Jakarta EE!</h1>");
        out.println("</body></html>");
    }

    public void add(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {
        String userName = req.getParameter("user-name");
        String email = req.getParameter("email");
        String password = req.getParameter("psd");
        String confirmPassword = req.getParameter("confirm-psd");
        String token = TokenGenerator.generateToken(20);
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        
        Map<String, String[]> parameterMap = req.getParameterMap();  
        for (String paramName : parameterMap.keySet()) { 
            String[] paramValues = parameterMap.get(paramName); 
            for (String paramValue : paramValues) { 
                System.out.println(paramName + ": " + paramValue); 
            } 
        }

        UserDaoImpl custDao = new UserDaoImpl();

        String userNameError = checkUserName(userName, custDao);
        String emailError = checkEmail(email, custDao);
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
                custDao.addCustomer(customer);
                
                responses.put("url", "hello.jsp");
                responses.put("token", token);
                responses.put("send_email", email);
            } catch (SQLException e) {
            }
        }
        
        ObjectMapper objectMapper = new ObjectMapper();
        String jsonResp = objectMapper.writeValueAsString(responses);
        
        resp.setContentType("application/json");

        // 将JSON响应发送回Ajax
        PrintWriter out = resp.getWriter();
        out.print(jsonResp);
        out.flush();
    }

    private String checkUserName(String userName, UserDaoImpl custDao) throws SQLException {
        if (userName == null || "".equals(userName.trim())) {
            return "Please enter your user name.";
        } else if (custDao.isExists("username", userName) == true) {
            return "The username is already taken.";
        } else {
            return " ";
        }
    }

    private String checkEmail(String email, UserDaoImpl custDao) throws SQLException {
        if (email == null || "".equals(email.trim())) {
            return "Please enter your email address.";
        }

        String pattern = "^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
        Pattern p = Pattern.compile(pattern);
        Matcher m = p.matcher(email);

        if (!m.matches()) {
            return "The email address pattern is incorrect.";
        }

        if (custDao.isExists("email", email) == true) {
            return "The email address is already taken.";
        }

        return " ";
    }

    private String checkPassword(String password) {
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

    private String checkConfirmPassword(String password, String confirmPassword) {
        if (confirmPassword == null || "".equals(confirmPassword.trim())) {
            return "Please confirm your password.";
        }

        if (!password.equals(confirmPassword)) {
            return "The password do not match.";
        }

        return " ";
    }
}
