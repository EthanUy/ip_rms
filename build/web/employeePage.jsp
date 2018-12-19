<%-- 
    Document   : employeePage
    Created on : 12 11, 18, 11:56:03 PM
    Author     : Ethan
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page import="hrsystem.Task"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="hrsystem.ClientServlet,hrsystem.DataAccess"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String i = "" + session.getAttribute("id");
    int id = Integer.parseInt(i);
    
    
    
    List<Task> tasks = DataAccess.getEmployeeTask(id);
    
   
    
    request.setAttribute("tasks", tasks);  
%>

<html>
    <head>
        <title>employeePage</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
            <div class='col-md-2 col-md-offset-1'>
                <h3><strong> <% out.print(session.getAttribute("name")); %> </strong> </h3> <br/>
                
                <h4><strong> <% out.print(session.getAttribute("role")+" Employee");%> </strong> </h4>
                <h5> <% out.print(session.getAttribute("email"));%> </h5>
                <h5> <% out.print(session.getAttribute("contact"));%> </h5>
                
            </div>
            <div class='col-md-8'>
                <div class='row'>
                    <h3><strong>Tasks</strong></h3>
                </div>
                <c:forEach items='${tasks}' var='t'>
                    <div class='row' id="${t.getId()}">
                        <div class='panel panel-default'>
                            <div class='panel-heading'>
                                <div class='panel-body'>
                                    <div class='row'>
                                        <h4><strong>${t.getTask()}</strong></h4>
                                    </div>
                                    <div class='row'>
                                        <h5><strong> Status : ${t.getStatus()} </strong></h5>
                                    </div>
                                    <div class='row'>
                                        <button class='btn btn-primary' id='btnUpdate' data-id='${t.getId()}' data-toggle="modal" data-target="#updateModal"> Update Status </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            
        </div>
            <div class="modal fade" id="updateModal" role="dialog">
                <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Update Status</h4>
                  </div>
                  <div class="modal-body">
                          <form action='updateTaskstatus.jsp' method="POST">                         
                              <div class="form-group">
                                    <label for="">Role</label>
                                    <select id="statusselect" class="form-control" name="status" required="required"> 
                                        <option disabled="true" selected default></option>
                                        <option value="Pending">Pending</option>
                                        <option value="OnGoing">On-going</option>
                                        <option value="Completed">Completed</option>
                                    </select>
                                </div>
                              <input type="text" id="updateId" class="hidden" name='id'>
                              
                              <button type='submit' class='btn btn-success'> Submit </button>
                          </form>
                  </div>

                  <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                  </div>
                </div>

              </div>
              </div>
        <!--         End Add Employee modal -->
    </body>
</html>

<script>
    $(document).ready(function(){
        $("#navBar-frame2").load("nav2.html"); 
        
        $("#btnUpdate").on("click", function(){
            $task_id = $(this).data("id");
            $("#updateId").attr("value", $task_id);
        });
    });
</script>