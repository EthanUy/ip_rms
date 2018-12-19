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
public class FieldEmployeeFactory implements EmployeeFactory{
    private static FieldEmployeeFactory instance = null;
    private final String role;
    
    private FieldEmployeeFactory(){this.role = "Field";}
    
    public static FieldEmployeeFactory getInstance(){
        if(instance == null)
            instance = new FieldEmployeeFactory();
        return instance;
    }
    
    @Override
    public Employee createEmployee() { return new FieldEmployee(role);}
    
    @Override
    public String getRole() { return role;}
}
