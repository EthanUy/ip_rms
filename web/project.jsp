<%-- 
    Document   : project
    Created on : 12 18, 18, 9:17:04 PM
    Author     : Ethan
--%>

<%@page import="hrsystem.Project"%>
<%@page import="java.util.List"%>
<%@page import="hrsystem.Task"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import='hrsystem.DataAccess'%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    
    Project p = DataAccess.getProject(id);
    
    List<Task> tasks = DataAccess.getProjectTask(id);
    request.setAttribute("tasks",tasks);
    request.setAttribute("p", p);
    request.setAttribute("id", id);
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Project</title>
        
        <link rel='stylesheet' type='text/css' href='stylesheet.css'/>
        <!-- jQuery library -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <!-- Latest compiled JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    </head>
    <body>
        <div class='row'>
            <div id='navBar-frame2'></div>
        </div>
        
        <div class='row'>
            <div class='col-md-3'>
              <div class='row' id='buttonRow'>
                <div class='col-md-1 col-md-offset-1'>
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#editModal">
                        <span style="color: #333333" class="glyphicon glyphicon-pencil" aria-hidden="true"></span> <b>Edit Project Name</b>
                    </button>
                </div>
                <div class='col-md-1 col-md-offset-5'>
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addModal">
                        <span style="color: #333333" class="glyphicon glyphicon-plus" aria-hidden="true"></span> <b>Add task</b>
                    </button>
                </div>
        </div>
            </div>
        </div>
        <div class='row'>
            <div class='col-md-3 col-md-offset-1'>
                <h3>${p.getName()}</h3>
            </div>
        </div>
        <!--         Start edit project modal -->
        <div class="modal fade" id="editModal" role="dialog">
        <div class="modal-dialog">

          <!-- Modal content-->
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal">&times;</button>
              <h4 class="modal-title">Edit Project</h4>
            </div>
            <div class="modal-body">
                    <form action='editProject.jsp?id=${id}' method="POST">
                        <div class='form-group'>
                            <label for='name'> Name </label>
                            <input type='text'  class='form-control' name='name'>
                        </div>
                        <input type="text" value="${p.getManager_id()}" class="hidden" name='manager_id'>
                        
                        <button type='submit' class='btn btn-success'> Submit </button>
                    </form>
            </div>
            
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
          </div>

        </div>
        </div>
        <!--         End edit project modal -->
        
        <!--         Start add project modal -->
        <div class="modal fade" id="addModal" role="dialog">
        <div class="modal-dialog">

          <!-- Modal content-->
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal">&times;</button>
              <h4 class="modal-title">Add Project</h4>
            </div>
            <div class="modal-body">
                    <form action='addTask.jsp?id=${id}' method="POST">
                        <div class='form-group'>
                            <label for='name'> Task name </label>
                            <input type='text'  class='form-control' name='task'>
                        </div>
                        <div class='form-group'>
                            <label for='name'> Employee ID </label>
                            <input type='text'  class='form-control' name='employee_id'>
                        </div>
                        <input type="hidden" value="${p.getManager_id()}">
                        <button type='submit' class='btn btn-success'> Submit </button>
                    </form>
            </div>
            
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
          </div>

        </div>
        </div>
        <!--         End add project modal -->
        
        <div class='row'>
            <div class='col-md-10'>
                <div class='row'>
                    <div class="col-md-offset-2">
                        <h3>Tasks</h3>
                        <c:forEach items="${tasks}" var="t">
                            <div class='row'>
                                <div class="panel panel-default">   
                                    <div class="panel-heading">${t.getTask()} <h4>${t.getStatus()}</h4></div>
                                    <div class="panel-body">
                                         <div class='col-md-4 col-md-offset-4'>
                                             <a href="deleteTask.jsp?id=${id}&task_id=${t.getId()}">
                                                <button class='btn btn-primary form-control' style='background-color:darkgray;border-color:darkgray' type="submit">
                                                    <span class='glyphicon glyphicon-eye-open'></span> Cancel Task
                                                </button>
                                             </a>   
                                        </div>


                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>    
                </div>   
            </div>
        </div>
    </body>
</html>
<script>
    $(document).ready(function(){
        $("#navBar-frame2").load("nav2.html"); 
        

    });
</script>