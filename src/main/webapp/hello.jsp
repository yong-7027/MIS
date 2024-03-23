<%-- 
    Document   : hello
    Created on : 20 Mar 2024, 11:54:49 am
    Author     : zheng
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
            System.out.println("hello world ~~~");
        %>

        <c:if test="true">
            <h1>true</h1>
        </c:if>

        <c:if test="false">
            <h1>false</h1>
        </c:if>
    </body>
</html>
