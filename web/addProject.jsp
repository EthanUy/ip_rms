<%-- 
    Document   : addProjects
    Created on : 12 18, 18, 5:43:44 PM
    Author     : Ethan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="hrsystem.DataAccess" %>
<%@page import="hrsystem.Project"%>
<jsp:useBean id="prj" class="hrsystem.Project"></jsp:useBean>
<jsp:setProperty property="*" name="prj"></jsp:setProperty>

<%
    int i = DataAccess.addProject(prj);
    if(i > 0){
        response.sendRedirect("managerPage.jsp");
    }else{
        response.sendRedirect("index.html");
    }
%>