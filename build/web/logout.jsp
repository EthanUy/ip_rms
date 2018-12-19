<%-- 
    Document   : logout.jsp
    Created on : 12 12, 18, 12:48:41 AM
    Author     : Ethan
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    session.invalidate();
    session = request.getSession();
    response.sendRedirect("index.html");
%>
