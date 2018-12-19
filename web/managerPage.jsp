<%-- 
    Document   : managerPage
    Created on : 12 12, 18, 10:52:54 AM
    Author     : Ethan
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="hrsystem.Task"%>
<%@page import="java.util.List"%>
<%@page import="hrsystem.ManagerServlet,hrsystem.Project,hrsystem.DataAccess"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<%
    String i = ""+session.getAttribute("id");
    int id = Integer.parseInt(i);
      
    List<Project> projects = DataAccess.getProjects(id);
//    List<Integer> listId = new ArrayList<Integer>();
//    
//    ManagerServlet servlet = new ManagerServlet();
//    
//    for(Project p : projects){
//        listId.add(p.getId());
//    }
//    
//    servlet.setProjectId(listId);
//    servlet.startClient("127.0.0.1", 9876);
//    servlet.send(servlet);
//    servlet.stopClient();
    
      for(Project p : projects){
          p.setTask(DataAccess.getProjectTask(p.getId()));
      }
      

      request.setAttribute("projects",projects);
%>
<html>
    <head>
        <title>
            Manager Page
        </title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
 
        <link rel='stylesheet' type='text/css' href='stylesheet.css'/>
        <!-- jQuery library -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <!-- Latest compiled JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    </head>
    <style>
        .btn-primary{
            height:40px !important;
        }
    </style>
    
    <body>
        <!--         Start Add Employee modal -->
        <div class="modal fade" id="myModal" role="dialog">
        <div class="modal-dialog">

          <!-- Modal content-->
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal">&times;</button>
              <h4 class="modal-title">Add Project</h4>
            </div>
            <div class="modal-body">
                    <form action='addProject.jsp' method="POST">
                        <div class='form-group'>
                            <label for='name'> Name </label>
                            <input type='text'  class='form-control' name='name'>
                        </div>
                        <input type="text" value="${id}" class="hidden" name='manager_id'>
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
        <div class='row'>
            <div id='navBar-frame2'></div>
        </div>
        <div class='row'>
            <div class='col-md-2 col-md-offset-1'>
                <h3> <strong> <% out.print(session.getAttribute("name")); %> </strong> </h3> <br/>
                
                <h4> <strong> <% out.print(session.getAttribute("role")); %> </strong> </h4> <br/>
                <h5> <% out.print(session.getAttribute("email")); %> </h5> <br/>
                <h5> <% out.print(session.getAttribute("contact")); %> </h5> <br/> 
                
            </div>
            <div class='col-md-8 col-md-offset-1'>
                <div class='row'>
                    <div class='col-md-1'>
                        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
                            <span style="color: #333333" class="glyphicon glyphicon-plus" aria-hidden="true"></span> <b>New Project</b>
                        </button>
                    </div>    
                </div>
                <div class='row'>
                    <h3>Projects</h3>
                </div>
                <c:forEach items="${projects}" var="p">
                    <div class='row' style='width:93%' id='${p.getId()}'>
                        <div class="panel panel-default">   
                            <div class="panel-heading">${p.getName()}</div>
                            <div class="panel-body">
                                
                                <div class='col-md-4 col-md-offset-4'>
                                    <a href='project.jsp?id=${p.getId()}'>
                                        
                                        <button class='btn btn-primary form-control' style='background-color:darkgray;border-color:darkgray'>
                                            <span class='glyphicon glyphicon-eye-open'></span> View Project
                                        </button>
                                    </a>
                                </div>
                               
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            
        </div>
    </body>
</html>

<script>
    $(document).ready(function(){
        $("#navBar-frame2").load("nav2.html"); 
    });
</script>