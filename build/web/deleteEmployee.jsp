<%-- 
    Document   : deleteEmployee
    Created on : 12 10, 18, 7:13:32 PM
    Author     : Ethan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>-->

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="hrsystem.DataAccess"%>

<%
    int i = DataAccess.disableEmployee(Integer.parseInt(request.getParameter("id")));
    response.sendRedirect("manageEmployees.jsp");
%>
