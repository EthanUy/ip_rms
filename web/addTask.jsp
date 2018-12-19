<%-- 
    Document   : addTask
    Created on : 12 19, 18, 12:03:27 AM
    Author     : Ethan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="hrsystem.DataAccess" %>
<%@page import="hrsystem.Task"%>
<jsp:useBean id="tsk" class="hrsystem.Task"></jsp:useBean>
<jsp:setProperty property="*" name="tsk"></jsp:setProperty>
<%@page import="hrsystem.DataAccess,hrsystem.Task,hrsystem.TaskStatus"%>

<%
    Task task = new Task();
    
    String id =  request.getParameter("id");
    
    task.setProject_id(Integer.parseInt(id));
    task.setEmployee_id(Integer.parseInt(request.getParameter("employee_id")));
    task.setTask(request.getParameter("task"));
    
        String status = request.getParameter("status");

        TaskStatus current;

        if(TaskStatus.Pending.toString().equals(status)){
            current = TaskStatus.Pending;
        }else if(TaskStatus.OnGoing.toString().equals(status)){
            current = TaskStatus.OnGoing;
        }else if(TaskStatus.Completed.toString().equals(status)){
            current = TaskStatus.Completed;
        }else{
            current = TaskStatus.Cancelled;
        }

        task.setStatus(current);
   
    int i = DataAccess.addTask(task);
    response.sendRedirect("project.jsp?id="+id);
%>
