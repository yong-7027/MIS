/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mis.web.servlet;

import com.mis.pojo.Login;
import com.mis.service.LoginService;
import com.mis.service.impl.LoginServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.http.*;

/**
 *
 * @author zheng
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private LoginService loginService = new LoginServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userName = req.getParameter("user-name");
        String password = req.getParameter("psd");
        
        Login loginInfo = new Login(userName, password);
        
        String jsonResp = loginService.processLogin(loginInfo);
        
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
