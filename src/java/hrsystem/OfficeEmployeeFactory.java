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
public class OfficeEmployeeFactory implements EmployeeFactory{
    private static OfficeEmployeeFactory instance = null;
    private final String role;
    
    private OfficeEmployeeFactory(){this.role = "Office";}
    
    public static OfficeEmployeeFactory getInstance(){
        if(instance == null)
            instance = new OfficeEmployeeFactory();
        return instance;
    }
    @Override
    public Employee createEmployee() { return new OfficeEmployee(role);}

    @Override
    public String getRole() { return role;}
    
}
