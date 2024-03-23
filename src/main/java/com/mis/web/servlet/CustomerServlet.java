/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mis.web.servlet;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonObject;
import com.mis.service.CustomerService;
import com.mis.service.impl.CustomerServiceImpl;
import com.mis.util.RequestUtil;
import jakarta.servlet.ServletException;
import java.sql.SQLException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

/**
 *
 * @author zheng
 */
@WebServlet("/customer/*")
public class CustomerServlet extends BaseServlet {

    private CustomerService custService = new CustomerServiceImpl();

    public void selectAll(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("user selectAll..");
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<h1>Hello, Jakarta EE!</h1>");
        out.println("</body></html>");
    }

    public void add(HttpServletRequest req, HttpServletResponse resp) throws IOException, SQLException {
        // Get the request in Json format (by using Gson package)
        JsonObject jsonBody = RequestUtil.getBody(req);

        String jsonResp = custService.processSignUp(jsonBody);

        resp.setContentType("application/json");

        // 将JSON响应发送回Ajax
        PrintWriter out = resp.getWriter();
        out.print(jsonResp);
        out.flush();
    }

    public void forgetPassword(HttpServletRequest req, HttpServletResponse resp) throws IOException, SQLException, ServletException {
        JsonObject jsonBody = RequestUtil.getBody(req);

        Map<String, String> responses = custService.forgetPassword(jsonBody);

        String error = responses.get("error");
        String email = responses.get("email");
        String otp = responses.get("otp");

        if (error.equals(" ")) {
            req.setAttribute("subject", "Reset Password Notification");
            req.setAttribute("content", "<h3>Hello</h3><p>You are receiving this email because we received a password reset request from your account.</p><br/><br/><p>OTP: <b>" + otp + "</b></p>");
            req.setAttribute("email", email);
            
            req.getServletContext().getRequestDispatcher("/email/send").forward(req, resp);
        }

        ObjectMapper objectMapper = new ObjectMapper();
        String jsonResp = objectMapper.writeValueAsString(responses);

        resp.setContentType("application/json");

        // 将JSON响应发送回Ajax
        PrintWriter out = resp.getWriter();
        out.print(jsonResp);
        out.flush();
    }
}
