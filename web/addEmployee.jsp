<%-- 
    Document   : addEmployee
    Created on : 12 6, 18, 4:28:21 PM
    Author     : Ethan
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="hrsystem.DataAccess" %>
<jsp:useBean id="emp" class="hrsystem.TempEmployee"></jsp:useBean>
<jsp:setProperty property="*" name="emp"></jsp:setProperty>

<%
    emp.setBday(new java.sql.Date(new SimpleDateFormat("dd-MM-yyyy").parse(request.getParameter("bdayString")).getTime()));
            
    int i = DataAccess.addEmployee(emp);
    if(i > 0){
        response.sendRedirect("manageEmployees.jsp");
    }else{
        response.sendRedirect("index.html");
    }
%>



