<%-- 
    Document   : updateTaskstatus
    Created on : 12 19, 18, 1:24:45 AM
    Author     : Ethan
--%>

<%@page import="hrsystem.ClientServlet"%>
<%@page import="hrsystem.TaskStatus"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import='hrsystem.DataAccess' %>
<%@page import='hrsystem.Task' %>
<%@page import='hrsystem.Project' %>


<!DOCTYPE html>
<%
    
    int id = Integer.parseInt(request.getParameter("id"));
//    ClientServlet servlet = new ClientServlet();
//    servlet.startClient("127.0.0.1", 9876);
//    servlet.send(id);
//    servlet.stopClient();
    
    Task t = DataAccess.getTask(id);
    
    String status = request.getParameter("status");
    out.print(status);
    TaskStatus current;

    if(TaskStatus.Pending.toString().equals(status)){
        current = TaskStatus.Pending;
    }else if(TaskStatus.OnGoing.toString().equals(status)){
        current = TaskStatus.OnGoing;
    }else {
        current = TaskStatus.Completed;
    }

    t.setStatus(current);
    
    int i = DataAccess.updateTask(t);

    if(current.equals(TaskStatus.Completed)){
       // servlet.notifyProject(t.getProject_id());
    }
    
    if(i > 0){
        response.sendRedirect("employeePage.jsp");
    }else{
        response.sendRedirect("index.html");
    }
%>