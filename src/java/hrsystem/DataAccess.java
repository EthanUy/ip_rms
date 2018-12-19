/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hrsystem;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author LoganLee
 */
public class DataAccess {
    private static FactoryAccess factoryAccess;
    private static Connection conn;
    private static PreparedStatement ps;
    private static Statement s;
    private static ResultSet rs;
    
    
    static{
        conn = null;
        ps = null;
        s = null;
        rs = null;
        
        factoryAccess = FactoryAccess.getInstance();
    }
    
    public static Connection getConnection(){
        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ip_rms", "root", "");
        }catch (ClassNotFoundException | SQLException e){
            System.out.println(e);
        }
        return conn;
    }
    
    public static void closeConnection(){
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) { /* ignored */}
        }
        if (ps != null) {
            try {
                ps.close();
            } catch (SQLException e) { /* ignored */}
        }
        if (s != null){
            try{
                s.close();
            } catch (SQLException e) { /* ignored */}
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) { /* ignored */}
        }
    }
    
    public static String getPasswordByEmail(String email){
        String ret = null;
        
        try{
            conn = getConnection();
            ps = conn.prepareStatement("SELECT password FROM employee WHERE email=?");
            ps.setString(1, email);
            rs = ps.executeQuery();
            while(rs.next()){
                ret = rs.getString("password");
            }
        }catch(SQLException e){
            System.out.println(e);
        }finally {
            closeConnection();
        }
        return ret;
    }
    
    public static List<String> getRoles(){
        List<String> list = new ArrayList<>();
        String query = "SELECT role FROM role";
        try{
            conn = getConnection();
            s = conn.createStatement();
            rs = s.executeQuery(query);
            while(rs.next()){
                list.add(rs.getString("role"));
            }
        }catch(SQLException e){
            System.out.println(e);
        }finally{
            closeConnection();
        }
        
        return list;
    }
    
    public static int addRole(String role){
        int status = 0;
        try{
            conn = getConnection();
            ps = conn.prepareStatement("INSERT INTO role VALUES (?)");
            ps.setString(1, role);
            
            status = ps.executeUpdate();
        }catch(SQLException e){
            System.out.println(e);
        }finally{
            closeConnection();
        }
        
        return status;
    }
    
    public static int addEmployee(Employee emp){
        int status = 0;
        try{
            conn = getConnection();
            ps = conn.prepareStatement("INSERT INTO employee (name,bday,hiredDate,contact,email,isJoined,status,password,role) VALUES (?,?,NOW(),?,?,0,'Hired',?,?)");
            ps.setString(1, emp.getName());
            ps.setDate(2, new java.sql.Date(System.currentTimeMillis()));
            ps.setString(3, emp.getContact());
            ps.setString(4, emp.getEmail());
            ps.setString(5, emp.getPassword());
            ps.setString(6, emp.getRole());
            
            status = ps.executeUpdate();
        }catch(SQLException e){
            System.out.println(e);
        }finally{
            closeConnection();
        }
        
        return status;
    } 
    
    public static int updateEmployee(Employee emp){
        int status = 0;
        try{
            conn = getConnection();
            ps = conn.prepareStatement("UPDATE employee SET name=?, bday=?, hiredDate=?, contact=?, email=?, status=?, isJoined=?, password=?, role=? WHERE id=?");

            ps.setString(1, emp.getName());
            ps.setDate(2, emp.getBday());
            ps.setDate(3, emp.getHiredDate());
            ps.setString(4, emp.getContact());
            ps.setString(5, emp.getEmail());
            ps.setString(6, emp.getStatus().toString());
            ps.setBoolean(7, emp.isJoined());
            ps.setString(8, emp.getPassword());
            ps.setString(9, emp.getRole());
            
            status = ps.executeUpdate();
        }catch(SQLException e){
            System.out.println(e);
        }finally{
            closeConnection();
        }
        
        return status;
    }
    
    public static int disableEmployee(int id){
        int status = 0;
        try{
            conn = getConnection();
            ps = conn.prepareStatement("UPDATE employee SET status='Fired' WHERE id=?");
            ps.setInt(1, id);
            status = ps.executeUpdate();
        }catch(SQLException e){
            System.out.println(e);
        }finally{
            closeConnection();
        }
        
        return status;
    }
    
    public static List<Employee> getEmployeeRecords(){
        List<Employee> empList = new ArrayList<>();
        List<EmployeeFactory> facList = factoryAccess.getFactories();
        String query = "SELECT * FROM employee WHERE status NOT IN ('Fired')";
        try{
            conn = getConnection();
            s = conn.createStatement();
            rs = s.executeQuery(query);
            
            while(rs.next()){
                Employee emp = null;
                
                for(EmployeeFactory fac : facList){
                    if(fac.getRole().equals(rs.getString("role")))
                        emp = fac.createEmployee();
                }
                
                if(emp != null){
                    emp.setId(rs.getInt("id"));
                    emp.setName(rs.getString("name"));
                    emp.setBday(rs.getDate("bday"));
                    emp.setHiredDate(rs.getDate("hiredDate"));
                    emp.setContact(rs.getString("contact"));
                    emp.setEmail(rs.getString("email"));

                    String status = rs.getString("status");

                    if(status.equals(EmployeeStatus.Fired.toString())){
                        emp.setStatus(EmployeeStatus.Fired);
                    }else if(status.equals(EmployeeStatus.Hired.toString())){
                        emp.setStatus(EmployeeStatus.Hired);
                    }else{
                        emp.setStatus(EmployeeStatus.Vacation);
                    }

                    emp.setIsJoined(rs.getBoolean("isJoined"));
                    emp.setPassword(rs.getString("password"));

                    empList.add(emp);
                }
            }
        }catch(SQLException e){
            System.out.println(e);
        }finally{
            closeConnection();
        }
        
        return empList;
    }
    
    //////////////////////NEw
    public static List<Employee> getManagerRecords(){
        List<Employee> empList = new ArrayList<>();
        List<EmployeeFactory> facList = factoryAccess.getFactories();
        String query = "SELECT * FROM employee WHERE status NOT IN ('Fired') AND role='Manager'";
        try{
            conn = getConnection();
            s = conn.createStatement();
            rs = s.executeQuery(query);
            
            while(rs.next()){
                Employee emp = null;
                
                for(EmployeeFactory fac : facList){
                    if(fac.getRole().equals(rs.getString("role")))
                        emp = fac.createEmployee();
                }
                
                if(emp != null){
                    emp.setId(rs.getInt("id"));
                    emp.setName(rs.getString("name"));
                    emp.setBday(rs.getDate("bday"));
                    emp.setHiredDate(rs.getDate("hiredDate"));
                    emp.setContact(rs.getString("contact"));
                    emp.setEmail(rs.getString("email"));

                    String status = rs.getString("status");

                    if(status.equals(EmployeeStatus.Fired.toString())){
                        emp.setStatus(EmployeeStatus.Fired);
                    }else if(status.equals(EmployeeStatus.Hired.toString())){
                        emp.setStatus(EmployeeStatus.Hired);
                    }else{
                        emp.setStatus(EmployeeStatus.Vacation);
                    }

                    emp.setIsJoined(rs.getBoolean("isJoined"));
                    emp.setPassword(rs.getString("password"));

                    empList.add(emp);
                }
            }
        }catch(SQLException e){
            System.out.println(e);
        }finally{
            closeConnection();
        }
        
        return empList;
    }
    
    public static Employee getEmployeeDetails (String email,String password){
        List<EmployeeFactory> facList = factoryAccess.getFactories();
        Employee emp = null;
            try {
                conn = getConnection(); 
                ps = conn.prepareStatement("SELECT * FROM `employee` WHERE email=? AND password=?");
                ps.setString(1, email);
                ps.setString(2, password);
                rs = ps.executeQuery();

                while(rs.next()){
                    for(EmployeeFactory fac : facList){
                        if(fac.getRole().equals(rs.getString("role")))
                            emp = fac.createEmployee();
                    }
                    
                    if(emp != null){
                        emp.setId(rs.getInt("id"));
                        emp.setName(rs.getString("name"));
                        emp.setBday(rs.getDate("bday"));
                        emp.setHiredDate(rs.getDate("hiredDate"));
                        emp.setContact(rs.getString("contact"));
                        emp.setEmail(rs.getString("email"));

                        String status = rs.getString("status");

                        if(status.equals(EmployeeStatus.Fired.toString())){
                            emp.setStatus(EmployeeStatus.Fired);
                        }else if(status.equals(EmployeeStatus.Hired.toString())){
                            emp.setStatus(EmployeeStatus.Hired);
                        }else{
                            emp.setStatus(EmployeeStatus.Vacation);
                        }

                        emp.setIsJoined(rs.getBoolean("isJoined"));
                        emp.setPassword(rs.getString("password"));

                }
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(DataAccess.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return emp;
    }

    
    public static List<Employee> getNonMangerRecords(){
        List<Employee> empList = new ArrayList<>();
        List<EmployeeFactory> facList = factoryAccess.getFactories();
        String query = "SELECT * FROM employee WHERE status NOT IN ('Fired') AND role NOT LIKE 'Manager'";
        try{
            conn = getConnection();
            s = conn.createStatement();
            rs = s.executeQuery(query);
            
            while(rs.next()){
                Employee emp = null;
                
                for(EmployeeFactory fac : facList){
                    if(fac.getRole().equals(rs.getString("role")))
                        emp = fac.createEmployee();
                }
                
                if(emp != null){
                    emp.setId(rs.getInt("id"));
                    emp.setName(rs.getString("name"));
                    emp.setBday(rs.getDate("bday"));
                    emp.setHiredDate(rs.getDate("hiredDate"));
                    emp.setContact(rs.getString("contact"));
                    emp.setEmail(rs.getString("email"));

                    String status = rs.getString("status");

                    if(status.equals(EmployeeStatus.Fired.toString())){
                        emp.setStatus(EmployeeStatus.Fired);
                    }else if(status.equals(EmployeeStatus.Hired.toString())){
                        emp.setStatus(EmployeeStatus.Hired);
                    }else{
                        emp.setStatus(EmployeeStatus.Vacation);
                    }

                    emp.setIsJoined(rs.getBoolean("isJoined"));
                    emp.setPassword(rs.getString("password"));

                    empList.add(emp);
                }
            }
        }catch(SQLException e){
            System.out.println(e);
        }finally{
            closeConnection();
        }
        
        return empList;
    }
    
    public static Employee getEmployee(int id){
        Employee emp = null;
        List<EmployeeFactory> facList = factoryAccess.getFactories();
        String query = "SELECT * FROM employee WHERE id=?";
        try{
            conn = getConnection();
            ps = conn.prepareStatement(query);
            
            ps.setInt(1, id);
            
            rs = ps.executeQuery();
            
            while(rs.next()){
                
                for(EmployeeFactory fac : facList){
                    if(fac.getRole().equals(rs.getString("role")))
                        emp = fac.createEmployee();
                }
                
                if(emp != null){
                    emp.setId(rs.getInt("id"));
                    emp.setName(rs.getString("name"));
                    emp.setBday(rs.getDate("bday"));
                    emp.setHiredDate(rs.getDate("hiredDate"));
                    emp.setContact(rs.getString("contact"));
                    emp.setEmail(rs.getString("email"));

                    String status = rs.getString("status");

                    if(status.equals(EmployeeStatus.Fired.toString())){
                        emp.setStatus(EmployeeStatus.Fired);
                    }else if(status.equals(EmployeeStatus.Hired.toString())){
                        emp.setStatus(EmployeeStatus.Hired);
                    }else{
                        emp.setStatus(EmployeeStatus.Vacation);
                    }

                    emp.setIsJoined(rs.getBoolean("isJoined"));
                    emp.setPassword(rs.getString("password"));
                }
            }
        }catch(SQLException e){
            System.out.println(e);
        }finally{
            closeConnection();
        }
        
        return emp;
    }
    
    public static List<Task> getEmployeeTask(int id){
        List<Task> list = new ArrayList<>();
        try{
            conn = getConnection();
            ps = conn.prepareStatement("SELECT * FROM task WHERE employee_id=? AND status NOT IN ('Cancelled', 'Completed')");
            
            ps.setInt(1, id);
            
            rs = ps.executeQuery();
            
            while(rs.next()){
                Task t = new Task();
                String status = rs.getString("status");
                TaskStatus current;
                
                t.setId(rs.getInt("id"));
                t.setTask(rs.getString("task"));
                
                if(TaskStatus.Pending.toString().equals(status)){
                    current = TaskStatus.Pending;
                }else if(TaskStatus.OnGoing.toString().equals(status)){
                    current = TaskStatus.OnGoing;
                }else if(TaskStatus.Completed.toString().equals(status)){
                    current = TaskStatus.Completed;
                }else{
                    current = TaskStatus.Cancelled;
                }
                
                t.setStatus(current);
                list.add(t);
            }
        }catch(SQLException e){
            System.out.println(e);
        }finally{
            closeConnection();
        }
        
        return list;
    }
    
    public static int joinEmployee(int id){
        int status = 0;
        try{
            conn = getConnection();
            ps = conn.prepareStatement("UPDATE employee SET isJoined=1 WHERE id=?");

            ps.setInt(1, id);
            
            status = ps.executeUpdate();
        }catch(SQLException e){
            System.out.println(e);
        }finally{
            closeConnection();
        }
        
        return status;
    }
    
    public static List<Project> getProjects(int id){
        List<Project> list = new ArrayList<>();
        String query = "SELECT * FROM project WHERE manager_id='"+id+"'";
        try{
            conn = getConnection();
            s = conn.createStatement();
            rs = s.executeQuery(query);
            
            while(rs.next()){
                Project p = new Project(rs.getInt("id"));
                p.setManager_id(rs.getInt("manager_id"));
                p.setName(rs.getString("name"));
                String status = rs.getString("status");
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
                
                p.setStatus(current);
                
                list.add(p);
            }
        }catch(SQLException e){
            System.out.println(e);
        }finally{
            closeConnection();
        }
        
        return list;
    }
    
    public static List<Task> getProjectTask(int id){
        List<Task> list = new ArrayList<>();
        try{
            conn = getConnection();
            ps = conn.prepareStatement("SELECT * FROM task WHERE project_id=? AND status NOT IN ('Cancelled')");
            
            ps.setInt(1, id);
            
            rs = ps.executeQuery();
            
            while(rs.next()){
                Task t = new Task();
                String status = rs.getString("status");
                TaskStatus current;
                
                t.setId(rs.getInt("id"));
                t.setTask(rs.getString("task"));
                
                if(TaskStatus.Pending.toString().equals(status)){
                    current = TaskStatus.Pending;
                }else if(TaskStatus.OnGoing.toString().equals(status)){
                    current = TaskStatus.OnGoing;
                }else if(TaskStatus.Completed.toString().equals(status)){
                    current = TaskStatus.Completed;
                }else{
                    current = TaskStatus.Cancelled;
                }
                
                t.setStatus(current);
                list.add(t);
            }
        }catch(SQLException e){
            System.out.println(e);
        }finally{
            closeConnection();
        }
        
        return list;
    }
    
    public static int addProject(Project project){
        int status = 0;
        try{
            conn = getConnection();
            ps = conn.prepareStatement("INSERT INTO project VALUES (null, 'Pending', ?, ?)");
            ps.setInt(1, project.getManager_id());
            ps.setString(2, project.getName());
            
            status = ps.executeUpdate();
        }catch(SQLException e){
            System.out.println(e);
        }finally{
            closeConnection();
        }
        
        return status;
    }
    
    public static int updateProject(Project project){
        int status = 0;
        try{
            conn = getConnection();
            ps = conn.prepareStatement("UPDATE project SET name=?, status=?, manager_id=? WHERE id=?");

            ps.setString(1, project.getName());
            ps.setString(2, project.getStatus().toString());
            ps.setInt(3, project.getManager_id());
            ps.setInt(4, project.getId());
            
            status = ps.executeUpdate();
        }catch(SQLException e){
            System.out.println(e);
        }finally{
            closeConnection();
        }
        
        return status;
    }
    
    public static int cancelProject(int id){
        int status = 0;
        try{
            conn = getConnection();
            ps = conn.prepareStatement("UPDATE project SET status='Cancelled' WHERE id=?");
            ps.setInt(1, id);
            status = ps.executeUpdate();
        }catch(SQLException e){
            System.out.println(e);
        }finally{
            closeConnection();
        }
        
        cancelAllTask(id);
        disjoinAllEmployee(id);
        
        return status;
    }
    
    public static int addTask(Task task){
        int status = 0;
        try{
            conn = getConnection();
            ps = conn.prepareStatement("INSERT INTO task VALUES (null, 'Pending', ?, ?, ?)");
            ps.setString(1, task.getTask());
            ps.setInt(2, task.getProject_id());
            ps.setInt(3, task.getEmployee_id());
            
            status = ps.executeUpdate();
        }catch(SQLException e){
            System.out.println(e);
        }finally{
            closeConnection();
        }
        
        joinEmployee(task.getEmployee_id());
        
        return status;
    }
    
    public static int updateTask(Task task){
        int status = 0;
        try{
            conn = getConnection();
            ps = conn.prepareStatement("UPDATE task SET status=?, project_id=?, employee_id=? WHERE id=?");

            ps.setString(1, task.getStatus().toString());
            ps.setInt(2, task.getProject_id());
            ps.setInt(3, task.getEmployee_id());
            ps.setInt(4, task.getId());
            
            status = ps.executeUpdate();
        }catch(SQLException e){
            System.out.println(e);
        }finally{
            closeConnection();
        }
        
        return status;
    }
    
    public static int cancelTask(int id){
        int status = 0;
        try{
            conn = getConnection();
            ps = conn.prepareStatement("UPDATE task SET status='Cancelled' WHERE id=?");
            ps.setInt(1, id);
            status = ps.executeUpdate();
        }catch(SQLException e){
            System.out.println(e);
        }finally{
            closeConnection();
        }
        
        return status;
    }
    
    public static Task getTask(int id){
        Task t = new Task();
  
        String query = "SELECT * FROM task WHERE id=?";
        try{
            conn = getConnection();
            ps = conn.prepareStatement(query);
            
            ps.setInt(1, id);
            
            rs = ps.executeQuery();
            
            while(rs.next()){
                
                t.setId(rs.getInt("id"));
                t.setEmployee_id(rs.getInt("employee_id"));
                t.setProject_id(rs.getInt("project_id"));
                String status = rs.getString("status");
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
                
                t.setStatus(current);
                
            }
        }catch(SQLException e){
            System.out.println(e);
        }finally{
            closeConnection();
        }
      
        
        return t;
    }
    
    public static Project getProject(int id){
        Project p = new Project();
  
        String query = "SELECT * FROM project WHERE id=?";
        try{
            conn = getConnection();
            ps = conn.prepareStatement(query);
            
            ps.setInt(1, id);
            
            rs = ps.executeQuery();
            
            while(rs.next()){
                
                p.setId(rs.getInt("id"));
                p.setManager_id(rs.getInt("manager_id"));
                p.setName(rs.getString("name"));
                    
                String status = rs.getString("status");
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
                
                p.setStatus(current);
                
            }
        }catch(SQLException e){
            System.out.println(e);
        }finally{
            closeConnection();
        }
      
        
        return p;
    }
    
    public static int cancelAllTask(int id){
        int status = 0;
        try{
            conn = getConnection();
            ps = conn.prepareStatement("UPDATE task SET status='Cancelled' WHERE project_id=?");
            ps.setInt(1, id);
            status = ps.executeUpdate();
        }catch(SQLException e){
            System.out.println(e);
        }finally{
            closeConnection();
        }
        
        return status;
    }
    
    public static int disjoinAllEmployee(int id){
        int status = 0;
        try{
            conn = getConnection();
            ps = conn.prepareStatement("UPDATE task JOIN employee ON task.employee_id = employee.id SET isJoined=0 WHERE task.project_id=?");
            ps.setInt(1, id);
            status = ps.executeUpdate();
        }catch(SQLException e){
            System.out.println(e);
        }finally{
            closeConnection();
        }
        
        return status;
    }

}
