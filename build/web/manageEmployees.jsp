<%-- 
    Document   : manageEmployees
    Created on : 12 8, 18, 9:41:15 AM
    Author     : Ethan
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  
<%@page import="hrsystem.DataAccess, hrsystem.Employee, hrsystem.Project, java.util.*, java.sql.Date" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>
            Manage Employees 
        </title>
        <link rel='stylesheet' type='text/css' href='stylesheet.css'/>
        <link rel='stylesheet' type='text/css' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css'/>
        <link rel='stylesheet' type='text/css' href='https://cdn.datatables.net/1.10.19/css/dataTables.bootstrap.min.css'/>
        
        <!-- jQuery library -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <!-- Latest compiled JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
     
    </head>
    <style> 
        #buttonRow{
            margin-bottom:5px;
        }
    </style>
    <body>
        <%
            List<Employee> list = DataAccess.getEmployeeRecords();
            List<String> role = DataAccess.getRoles();
            request.setAttribute("list", list);  
            request.setAttribute("role", role);
        %>
        <div class='container-fluid'>
        <div class='row'>
            <div id='navbar-frame'></div>
        </div>
        <div class='row' id='buttonRow'>
            <div class='col-md-1 col-md-offset-1'>
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addEmployee">
                    <span style="color: #333333" class="glyphicon glyphicon-plus" aria-hidden="true"></span> <b>New Employee</b>
                </button>
            </div>
          
        </div>
        <div class='row'>
            <div class='col-md-10 col-md-offset-1'>
                <table class="table table-striped table-bordered" id="viewEmployee">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name </th>
                            <th>Birthday</th>
                            <th>Date Hired</th>
                            <th>Status</th>
                            <th>Contact</th>
                            <th>Email</th>
                            <th>Password</th>
                            <th>isJoined</th>
                            <th>Role</th>
                            <th></th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${list}" var="e">
                            <tr id="${e.getId()}">

                                <td>${e.getId()}</td>
                                <td>${e.getName()}</td>
                                <td>${e.getBday()}</td>
                                <td>${e.getHiredDate()}</td>
                                <td>${e.getStatus()}</td>
                                <td>${e.getContact()}</td>
                                <td>${e.getEmail()}</td>
                                <td>${e.getPassword()}</td>
                                <td>${e.isJoined()}</td>
                                <td>${e.getRole()}</td>
                                <td>
                                    <button class="btn btn-warning edit" type='button' id="${e.getId()}">
                                        <span style="color: #333333" class="glyphicon glyphicon-pencil" aria-hidden="true" ></span> <b>Edit</b>
                                    </button>

                                    <button class="btn btn-primary hidden save" type='submit'>
                                        <span style="color: #333333" class="glyphicon glyphicon-save" aria-hidden="true"></span> <b>Save</b>
                                    </button>    
                                </td>
                                <td>
                                    <button id='${e.getId()}' class="btn btn-danger delete" data-toggle="modal" data-target="#deleteEmployee" type='button'>
                                        <span style="color: #333333" class="glyphicon glyphicon-trash" aria-hidden="true"></span> <b>Delete</b>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        
        <!--         Start Add Employee modal -->
        <div class="modal fade" id="addEmployee" role="dialog">
            
              <div class="modal-content">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                  <h4 class="modal-title">Add Employee</h4>
                </div>
                
                <div class='row'>
                    <div class='col-md-4 col-md-offset-4' id="formContainer">
                        <form action='addEmployee.jsp' method="POST">
                            <div class="modal-body">
                                <h3 style="text-align:center;margin-bottom:45px;"> Add Employee </h3>
                                <div class="form-group">
                                    <label for="name"> Name </label>
                                    <input class='form-control' type='text' placeholder="name" name="name" required='required'>
                                </div>
                                <div class="form-group">
                                    <label for="bday"> Birth Date </label>
                                    <input class='form-control' type="date" placeholder="bday" name="bdayString" required='required'>
                                </div>
                                <div class="form-group">
                                    <label for="contact"> Contact </label>
                                    <input class='form-control' type='text' placeholder="contact" name="contact" required='required'>
                                </div>
                                <div class="form-group">
                                    <label for="email"> Email </label>
                                    <input class='form-control' type='text' placeholder="email" name="email" required='required'>
                                </div>                          
                                <div class="form-group">
                                    <label for="">Role</label>
                                    <select id="roleselect" class="form-control" name="role" required="required"> 
                                        <option disabled="true" selected default></option>
                                        <c:forEach items="${role}" var="mr">                                      
                                            <option value='${mr}'>${mr}</option>
                                        </c:forEach>  
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="password"> Password </label>
                                    <input class='form-control' type='password' name="password" required='required'>
                                </div>
                                <button id='register' class='form-control btn btn-primary' type='submit'> Register </button>

                            </div> 
                        </form>    
                    </div>
                </div>
            </div>
                   
        </div> 
        
        <!--         End Add Employee modal -->
       
        <!-- Start Delete Employee modal -->
        <div class="modal fade" id="deleteEmployee" role="dialog">
          <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">End Project</h4>
              </div>
                <form action="deleteEmployee.jsp" method="POST">
                    <input type="hidden" name="id" id="deleteID"/>
                    <div class="modal-body">
                        <label>Are you sure you want to delete?</label>
                    </div>
                    <div class="modal-footer">
                      <div style="text-align: right;">
                          <button class="btn btn-success"  type="submit">
                              <span style="color: #333333" class="glyphicon glyphicon-ok" aria-hidden="true"></span> <b>Yes</b>
                          </button>
                          <button class="btn btn-danger" type="button" data-dismiss="modal">
                              <span style="color: #333333" class="glyphicon glyphicon-remove" aria-hidden="true"></span> <b>No</b>
                          </button>
                      </div>
                    </div>
                </form>
            </div>

          </div>
        </div>
        </div>
    <!-- End Delete Employee modal -->
    </body>
</html>
<script src="https://code.jquery.com/jquery-3.3.1.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/1.10.19/js/dataTables.bootstrap.min.js" type="text/javascript"></script>
<script type='text/javascript'>
    $(document).ready(function(){
        $("#navbar-frame").load("nav2.html");
        
        $("#viewEmployee").DataTable({
            "columnDefs": [
                { "width": "10%", "targets": 0 }
              ]
        });
 
        $("#viewEmployee").on("click", ".edit", function(){
            
            var role = $(this).parent().prev();
            var isJoined = role.prev();
            var password = isJoined.prev();
            var email = password.prev();
            var contact = email.prev();
            var Status = contact.prev();
            var hiredDate = Status.prev();
            var birthDate = hiredDate.prev();
            var name = birthDate.prev();
            var id = name.prev();
            
            var r = role.text();
            var iJ = isJoined.text();
            var pwd = password.text();
            var eml = email.text();
            var con = contact.text();
            var hD = hiredDate.text();
            var s = Status.text();
            var bD = birthDate.text();
            var nm = name.text();
            var i = id.text();
            
            var statusString = "<select name='status' required='required' class='form-control col-xs-2' id='status'>";
            
            if(s==="Hired"){
                statusString+= "<option value='Hired' selected> Hired</option>";
                statusString+= "<option value='Vacation'> Vacation </option>";
            } else {
                statusString+= "<option value='Vacation' selected> Vacation </option>";
                statusString+= "<option value='Hired'> Hired</option>";
            }
            statusString+= "</select>";
            
            var roleString = "<select name='role' required='required' class='form-control col-xs-2' id='role'>";
            
            <c:forEach items="${role}" var="r">
                if("${r}"===r){
                    roleString+= "<option value='${r}' selected> ${r} </option>";
                }else{
                    roleString+= "<option value='${r}'> ${r} </option>";
                }
            </c:forEach>
            
            roleString += "</select>";
            
            var joinedString = "<select name='isJoined' id='isJoined' class='form-control'>";
            
            if(iJ==="false"){
                joinedString += "<option value='false' selected>false</option>";
                joinedString += "<option value='true'> true </option>";
            } else {
                joinedString += "<option value='true' selected> true </option>";
                joinedString += "<option value='false'> false </option>";
            }
            
            joinedString += "</select>";
            
            role.html(roleString);
            Status.html(statusString);
            isJoined.html(joinedString);
            password.html("<input type='text' name='password' value="+pwd+" class='form-control col-xs-2'>");
            id.html("<input type='text' name='id' value='"+$(this).attr("id")+"' class='form-control col-xs-2' readonly>");
            email.html("<input type='text' name='email' value="+eml+" class='form-control col-xs-2'>");
            contact.html("<input type='text' name='contact' value="+con+" class='form-control col-xs-2'>");
            hiredDate.html("<input type='date' name='hiredDate' value="+hD+" class='form-control col-xs-2'>");
            birthDate.html("<input type='date' name='bday' value="+bD+" class='form-control col-xs-2'>");
            name.html("<input type='text' name='name' value="+nm+" class='form-control col-xs-2'>");
            
            $(this).addClass("hidden");
            var save =  $(this).next();
        
            save.removeClass("hidden");
            
            var trID = $(this).parent().parent().attr("id");
            
            var temp = "<form action='editEmployee.jsp' method='POST' class='editForm'>"+$(this).parent().parent().html()+ "</form>";
            
            document.getElementById(trID).innerHTML = temp;
        });
        
        $("#viewEmployee").on("click", ".save", function(){
            $(this).prev().removeClass('hidden');
            
            $(this).addClass('hidden');
            
            var role = $(this).parent().prev();
            var isJoined = role.prev();
            var password = isJoined.prev();
            var email = password.prev();
            var contact = email.prev();
            var Status = contact.prev();
            var hiredDate = Status.prev();
            var birthDate = hiredDate.prev();
            var name = birthDate.prev();
            var id = name.prev();
            
            var r = role.children(':first').val();
            var iJ = isJoined.children(':first').val();
            var pwd = password.children(':first').val();
            var eml = email.children(':first').val();
            var con = contact.children(':first').val();
            var hD = hiredDate.children(':first').val();
            var bD = birthDate.children(':first').val();
            var nm = name.children(':first').val();
            var i = id.children(':first').val();
            var s = Status.children(':first').val();
            
            alert("1.role: "+r+"\n"+"2.isJoined: "+iJ+"\n"+"3.Password: "+pwd+"\n"+"4.Email: "+eml+"\n"+"5.Contact: "+con+"\n"+"6.Hired Date: "+hD+"\n"+"7.bday: "+bD+"\n"+"8.Name: "+nm+"\n"+"9.id: "+i+"\n"+"10.status: "+s);
            
            $.ajax({
                url:'editEmployee.jsp',
                type:'POST',
                data:{
                    'id':i,
                    'name':nm,
                    'bday':bD,
                    'hiredDate':hD,
                    'contact':con,
                    'email':eml,
                    'role':r,
                    'isJoined':iJ,
                    'password':pwd,
                    'status':s
                },
                success:function(){
                    location.reload(true);
                }
            });
        });
        
        $("#viewEmployee").on("click", ".delete", function(){
            $('#deleteID').val($(this).attr('id'));
        });
    });
</script>
