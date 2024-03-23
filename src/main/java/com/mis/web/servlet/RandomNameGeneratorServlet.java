/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mis.web.servlet;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mis.dao.impl.UserDaoImpl;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author zheng
 */
@WebServlet("/RandomNameGeneratorServlet")
public class RandomNameGeneratorServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String characters = "0123456789qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM!@#$%^&*_+=-";
        String username = "";
        int length = Integer.parseInt(req.getParameter("length"));
        UserDaoImpl custDao = new UserDaoImpl();

        try {
            do {
                for (int i = 0; i < length; i++) {
                    username += characters.charAt((int) (Math.random() * characters.length()));
                }
            } while (custDao.isExists("username", username));

            ObjectMapper objectMapper = new ObjectMapper();
            String jsonResp = objectMapper.writeValueAsString(username);

            resp.setContentType("application/json");

            // 将JSON响应发送回Ajax
            PrintWriter out = resp.getWriter();
            out.print(jsonResp);
            out.flush();
            
        } catch (SQLException ex) {
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
    }

}
