<%-- 
    Document   : editProject
    Created on : 12 18, 18, 11:17:21 PM
    Author     : Ethan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="hrsystem.DataAccess,hrsystem.Project,hrsystem.ProjectStatus"%>

<!DOCTYPE html>
<%
    //TempEmployee emp = new TempEmployee();
    Project prj = new Project();
    
    String id =  request.getParameter("id");
    
    prj.setId(Integer.parseInt(id));
  
    prj.setManager_id(Integer.parseInt(request.getParameter("manager_id")));
    prj.setName(request.getParameter("name"));
    
        String status = request.getParameter("status");

        ProjectStatus current;

        if(ProjectStatus.Pending.toString().equals(status)){
            current = ProjectStatus.Pending;
        }else if(ProjectStatus.OnGoing.toString().equals(status)){
            current = ProjectStatus.OnGoing;
        }else if(ProjectStatus.Completed.toString().equals(status)){
            current = ProjectStatus.Completed;
        }else{
            current = ProjectStatus.Cancelled;
        }

        prj.setStatus(current);
   
    int i = DataAccess.updateProject(prj);
    response.sendRedirect("project.jsp?id="+prj.getId());
%>