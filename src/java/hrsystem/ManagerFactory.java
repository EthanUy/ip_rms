/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hrsystem;

/**
 *
 * @author username
 */
public class ManagerFactory implements EmployeeFactory{
    private static ManagerFactory instance = null;
    private final String role;
    
    private ManagerFactory(){this.role = "Manager";}
    
    public static ManagerFactory getInstance(){
        if(instance == null)
            instance = new ManagerFactory();
        return instance;
    }
    @Override
    public Employee createEmployee() { return new Manager(role);}

    @Override
    public String getRole() { return role;}
    
}
