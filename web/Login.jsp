<%-- 
    Document   : Login
    Created on : 12 6, 18, 9:05:27 AM
    Author     : Ethan
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="hrsystem.Controller"%>
<%@page import="hrsystem.Employee"%>
<%@page import="hrsystem.TempEmployee"%>
<%@page import="hrsystem.DataAccess"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<%
    Employee emp;
    
    //Controller c = new Controller();
    String eml = request.getParameter("eml");
  
    String pwd = request.getParameter("pwd");
    
    String password = DataAccess.getPasswordByEmail(eml);
     
    if(password!=null && password.equals(pwd)){
        emp = DataAccess.getEmployeeDetails(eml, pwd); 
        
        session.setAttribute("name", emp.getName());
        session.setAttribute("email", emp.getEmail());
        // session.setAttribute("password", emp.getPassword());
        session.setAttribute("role", emp.getRole());
        session.setAttribute("status", emp.getStatus());
        session.setAttribute("bday", emp.getBday());
        session.setAttribute("hiredDate", emp.getHiredDate());
        session.setAttribute("isJoined", emp.isJoined());
        session.setAttribute("contact", emp.getContact());
        session.setAttribute("id", emp.getId());
       
        if(session.getAttribute("role").equals("Manager")){
            response.sendRedirect("managerPage.jsp");
        } else {
            response.sendRedirect("employeePage.jsp");
        }
    } else {
        response.sendRedirect("index.html");
    }

%>
