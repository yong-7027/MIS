/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mis.web.servlet;

// GlassFish Server has comes with Jakarta Mail, so don't import Javax Mail, it will clash
import com.mis.dao.impl.UserDaoImpl;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.ServletException;
import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.util.Map;
import java.util.Properties;


/**
 *
 * @author zheng
 */
@WebServlet("/email/send")
public class EmailServlet extends BaseServlet {

    public void send(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException, MessagingException {
        // Connection parameters for configuring the mail server
        Properties properties = new Properties();

        // Enabling Authentication for SMTP Servers
        properties.put("mail.smtp.auth", "true");
        // Enable encryption
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.ssl.trust", "*");

        String companyEmail = "mistore040321@gmail.com";
        String password = "xiauluvkcwsywdhf";
        String recipient = req.getParameter("email");
        String token = req.getParameter("token");

        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(companyEmail, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("mistore040321@gmail.com"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
            message.setSubject("Email Verification from MIStore");
            message.setContent("<h2>You have Registered with MIStore</h2>\n"
                    + "            <h5>Verify your email address to Login with the below given link</h5>\n"
                    + "            <br/><br/>\n"
                    + "            <a href='http://localhost/MIS/email/verify?token=" + token + "'>Activate</a>", "text/html");

            Transport.send(message);

            System.out.println("Email sent successfully!");
            
            resp.sendRedirect("../hello.jsp");

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }

    public void verify(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String token = req.getParameter("token");
        UserDaoImpl custDao = new UserDaoImpl();

        try {
            Map<String, Object> result = custDao.selectByToken(token);
            if (!result.isEmpty()) {
                if (result.get("verify_status").equals("0")) {
                    if (custDao.updateVerifyStatus(token)) {
                        resp.sendRedirect("hello.jsp");
                    }
                    else {
                        resp.sendRedirect("hello.jsp");
                    }
                }
                else {
                    resp.sendRedirect("hello.jsp");
                }
            }
        } catch (SQLException ex) {
        }
    }
}
