/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mis.web.servlet;

import jakarta.servlet.ServletException;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.http.*;

/**
 *
 * @author zheng
 */

/* BaseServlet: 根据请求路径分发 */
/* HttpServlet: 根据请求方式分发(post and get) */
public class BaseServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Get the request path
        String uri = req.getRequestURI();  // /MIS/user/selectAll
        
        // Get the request's method name
        int index = uri.lastIndexOf('/');  
        String methodName = uri.substring(index + 1);  // /selectAll  -> selectAll
        
        // Execute the method
        // Get the class that method belongs to
        Class<? extends BaseServlet> cls = this.getClass();
        
        try {
            // The getMethod() method accepts a method name and a parameter type as arguments
            Method method = cls.getMethod(methodName, HttpServletRequest.class, HttpServletResponse.class);
            
            // Invoke the method
            method.invoke(this, req, resp);
        } catch (NoSuchMethodException | IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException ex) {
            Logger.getLogger(BaseServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
