<%-- 
    Document   : getRoles
    Created on : 12 11, 18, 3:15:08 PM
    Author     : Ethan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="hrsystem.DataAccess" %>
<jsp:useBean id="d" class="hrsystem.DataAccess"></jsp:useBean>

<%
    DataAccess.getRoles();
    

%>