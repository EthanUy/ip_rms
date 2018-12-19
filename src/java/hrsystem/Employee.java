/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hrsystem;

import java.sql.Date;

/**
 *
 * @author username
 */
public abstract class Employee {
    
    private int id;
    private String name;
    private Date bday;
    private Date hiredDate;
    private String contact;
    private String email;
    private EmployeeStatus status;
    private boolean isJoined;
    private Task task;
    private String password;
    private String role;

    public Employee() {
    }

    public Employee(String role){
        this.role = role;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getBday() {
        return this.bday;
    }

    public void setBday(Date bday) {
//        DateFormat df = new SimpleDateFormat("dd-MM-yyyy");
//      
//        df.parse(bday);
        
        this.bday = bday;
    }

    public Date getHiredDate() {
        return hiredDate;
    }

    public void setHiredDate(Date hiredDate) {
        this.hiredDate = hiredDate;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public EmployeeStatus getStatus() {
        return status;
    }

    public void setStatus(EmployeeStatus status) {
        this.status = status;
    }

    public boolean isJoined() {
        return isJoined;
    }

    public void setIsJoined(boolean isJoined) {
        this.isJoined = isJoined;
    }

    public Task getTask() {
        return task;
    }

    public void setTask(Task task) {
        this.task = task;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole(){
        return role;
    }
    
    public void setRole(String role){
        this.role = role;
    }
}
