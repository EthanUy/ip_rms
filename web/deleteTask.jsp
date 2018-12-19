<%-- 
    Document   : deleteTask
    Created on : 12 18, 18, 10:35:41 PM
    Author     : Ethan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="hrsystem.DataAccess"%>

<%
    int i = DataAccess.cancelTask(Integer.parseInt(request.getParameter("task_id")));
    response.sendRedirect("project.jsp?id="+request.getParameter("id"));
%>
