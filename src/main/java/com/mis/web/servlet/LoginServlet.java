/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mis.web.servlet;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mis.dao.impl.UserDaoImpl;
import com.mis.pojo.Login;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import jakarta.servlet.http.*;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author zheng
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userName = req.getParameter("user-name");
        String password = req.getParameter("psd");
        
        Login loginInfo = new Login(userName, password);
        long currentTime = System.currentTimeMillis();
        String userNameError;
        String passwordError;
        String url = null;

        UserDaoImpl userDao = new UserDaoImpl();

        if (loginInfo.getUserName() == null || "".equals(loginInfo.getUserName().trim())) {
            userNameError = "Please enter your username.";
        } else {
            userNameError = " ";
        }

        if (loginInfo.getPassword() == null || "".equals(loginInfo.getPassword().trim())) {
            passwordError = "Please enter your password.";
        } else {
            passwordError = " ";
        }

        if (" ".equals(userNameError) && " ".equals(passwordError)) {
            Map<String, Object> result = null;

            try {
                result = userDao.selectByUserName(loginInfo.getUserName());
            } catch (SQLException ex) {
            }

            if (!result.isEmpty()) {
                int userId = (int) result.get("user_id");
                String hashedPassword = (String) result.get("password");
                String userType = (String) result.get("user_type");
                int verifyStatus = (int) result.get("verify_status");
                long lastAttemptTime = (long) result.get("last_attempt_time");
                int life = (int) result.get("life");
                int accountAvailable = (int) result.get("account_aavailable");

                // the number of attempts will be reset every 10 minutes (same as blocking time)
                if (currentTime - lastAttemptTime >= 600) {
                    life = 5;
                }

                if (life > 0) {
                    // verify the password
                    boolean verifyResult = BCrypt.checkpw(loginInfo.getPassword(), hashedPassword);

                    if (verifyResult) {
                        try {
                            userDao.resetLife(loginInfo.getUserName());
                        } catch (SQLException ex) {
                            passwordError = "Something went wrong! Please contact customer service.";
                        }

                        // If user type is user
                        // 1. check the account is banned or not, if NO
                        // 2. check the remember me checkbox is set or not, if YES -> set the cookie
                        // 3. check the account is activated or not, if YES -> bring them to captcha.php, 
                        //                                           if NO  -> ask the user if they want to resend the activate account email
                        if (userType.equals("user")) {
                            if (accountAvailable == 1) {
                                passwordError = " ";
                                
                                if (verifyStatus == 1) {
                                    HttpSession session = req.getSession();
                                    session.setAttribute("loginInfo", loginInfo);
                                    url = "../Captcha.jsp";
                                }
                                else {
//                                    $_SESSION['status'] = "Please Verify your Email Address to Login";
//                                    $_SESSION['resendmail'] = "Do you want to resend the Verification Email?";
//                                    unset($_SESSION['user_id']);
                                    url = "../SignIn.jsp";
                                }
                            }
                            else {
                                passwordError = "Your account has been banned due to a violation of our terms and conditions.";
                            }
                        }
                        // If user type is not the user (admin), bring them to the admin dashboard and delete the cookie
                        else {
//                            setcookie('username', '', time() - 10);
//                            setcookie('password', '', time() - 10);
                            url = "../hello.jsp";
                        }
                    }
                    else {
                        life -= 1;
                        
                        if (life > 0) {
                            passwordError = "The password is incorrect.";
                        }
                        else {
                            passwordError = "Your account has been blocked. Please try after 10 : 00.";
                        }
                        
                        try {
                            // update the number of attempt and last attempt time in real time
                            userDao.updateLifeAndTime(life, lastAttemptTime, loginInfo.getUserName());
                        } catch (SQLException ex) {
                            passwordError = "Something went wrong! Please contact customer service.";
                        }
                    }
                }
                else {
                    // show the remaining blocking time for that account
                    double remainingMin = Math.floor((600 - (currentTime - lastAttemptTime)) / 60);
                    double remainingSec = (600 - (currentTime - lastAttemptTime)) % 60;
                    String timeRemaining = String.format("%d : %02d", remainingMin, remainingSec);
                    passwordError = "Your account has been blocked. Please try after " + timeRemaining + ".";
                }
            }
            else {
                userNameError = "The username does not exists.";
            }
        }
        
        Map<String, String> responses = new HashMap<>();
        
        if (!userNameError.equals(" ")) {
            responses.put("username", userNameError);
        }
        
        if (!passwordError.equals(" ")) {
            responses.put("password", passwordError);
        }
        
        if (userNameError.equals(" ") && passwordError.equals(" ")) {
            responses.put("url", url);
        }
        
        ObjectMapper objectMapper = new ObjectMapper();
        String jsonResp = objectMapper.writeValueAsString(responses);
        
        resp.setContentType("application/json");

        // 将JSON响应发送回Ajax
        PrintWriter out = resp.getWriter();
        out.print(jsonResp);
        out.flush();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
    }

}
