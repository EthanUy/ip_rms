<%-- 
    Document   : editEmployee
    Created on : 12 9, 18, 5:55:03 PM
    Author     : Ethan
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="hrsystem.DataAccess,hrsystem.TempEmployee,hrsystem.EmployeeStatus"%>

<%
    TempEmployee emp = new TempEmployee();
    
    emp.setId(Integer.parseInt(request.getParameter("id")));
    emp.setContact(request.getParameter("contact"));
    emp.setBday(new java.sql.Date(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("bday")).getTime()));
    emp.setHiredDate(new java.sql.Date(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("hiredDate")).getTime()));
    emp.setEmail(request.getParameter("email"));
    emp.setIsJoined(request.getParameter("isJoined").equals("true"));
    emp.setPassword(request.getParameter("password"));
    emp.setName(request.getParameter("name"));
    emp.setRole(request.getParameter("role"));
    
    String status = request.getParameter("status");

    if(status.equals(EmployeeStatus.Hired.toString())){
        emp.setStatus(EmployeeStatus.Hired);
    }else{
        emp.setStatus(EmployeeStatus.Vacation);
    }

    int i = DataAccess.updateEmployee(emp);
    response.sendRedirect("manageEmployees.jsp");
%>


