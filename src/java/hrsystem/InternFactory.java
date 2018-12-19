/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hrsystem;

/**
 *
 * @author Ethan
 */
public class InternFactory implements EmployeeFactory{
    private static InternFactory instance = null;
    private final String role;
    
    
    private InternFactory(){this.role = "Intern";}
    
    public static InternFactory getInstance(){
        if(instance == null)
            instance = new InternFactory();
        return instance;
    }
    
    @Override
    public Employee createEmployee() { return new Intern(role);}
    
    @Override
    public String getRole() { return role;}
}
