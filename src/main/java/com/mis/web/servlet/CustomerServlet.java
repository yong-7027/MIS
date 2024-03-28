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
import java.util.HashMap;
import java.util.Map;
import org.json.JSONObject;

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
//        JsonObject jsonBody = RequestUtil.getBody(req);
        System.out.println("Username: " + req.getParameter("user-name"));
        JSONObject jObj = new JSONObject(RequestUtil.getBody(req));

        String jsonResp = custService.processSignUp(jObj);

        resp.setContentType("application/json");

        // 将JSON响应发送回Ajax
        PrintWriter out = resp.getWriter();
        out.print(jsonResp);
        out.flush();
    }

    public void forgetPassword(HttpServletRequest req, HttpServletResponse resp) throws IOException, SQLException, ServletException {
//        JsonObject jsonBody = RequestUtil.getBody(req);
        JSONObject jObj = new JSONObject(RequestUtil.getBody(req));

        Map<String, String> responses = custService.forgetPassword(jObj);

        String error = responses.get("error");
        String email = responses.get("email");
        String otp = responses.get("otp");
        String url = responses.get("url");

        if (error.equals(" ")) {
            req.setAttribute("subject", "Reset Password Notification");
            req.setAttribute("content", "<h3>Hello</h3><p>You are receiving this email because we received a password reset request from your account.</p><br/><br/><p>OTP: <b>" + otp + "</b></p>");
            req.setAttribute("email", email);
            req.setAttribute("url", url);

            HttpSession session = req.getSession();
            session.setAttribute("email", email);
            session.setAttribute("OtpTime", System.currentTimeMillis());

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

    public void verifyOtp(HttpServletRequest req, HttpServletResponse resp) throws IOException, SQLException, ServletException {
        String otp = req.getParameter("otp");

        HttpSession session = req.getSession();
        String email = (String) session.getAttribute("email");
        Long otpTime = (Long) session.getAttribute("OtpTime");

        int status = custService.verifyOtp(otp, email, otpTime);

        switch (status) {
            case 0:
                //            echo "<script>alert('OTP verification success')</script>";
                resp.sendRedirect(req.getContextPath() + "/PasswordReset.jsp");
                break;
            case 1:
                //            echo "<script>alert('OTP verification failed')</script>";
                resp.sendRedirect(req.getContextPath() + "/ForgotPassword.jsp");
                break;
            default:
                Map<String, String> responses = new HashMap<>();
                responses.put("error", "OTP is expired. Please resend it.");

                ObjectMapper objectMapper = new ObjectMapper();
                String jsonResp = objectMapper.writeValueAsString(responses);

                resp.setContentType("application/json");

                // 将JSON响应发送回Ajax
                PrintWriter out = resp.getWriter();
                out.print(jsonResp);
                out.flush();
                break;
        }
    }

    public void passwordReset(HttpServletRequest req, HttpServletResponse resp) throws IOException, SQLException, ServletException {
        JSONObject jObj = new JSONObject(RequestUtil.getBody(req));
        HttpSession session = req.getSession();
        String email = (String) session.getAttribute("email");
        String jsonResp;

        Map<String, String> responses = custService.passwordReset(jObj, email);

        if (!" ".equals(responses.get("url"))) {
            resp.sendRedirect(req.getContextPath() + responses.get("url"));
        } else {
            ObjectMapper objectMapper = new ObjectMapper();
            jsonResp = objectMapper.writeValueAsString(responses);

            resp.setContentType("application/json");

            // 将JSON响应发送回Ajax
            PrintWriter out = resp.getWriter();
            out.print(jsonResp);
            out.flush();
        }
    }
}
