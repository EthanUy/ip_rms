/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hrsystem;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author LoganLee
 */
public class FactoryAccess {
    private static FactoryAccess instance = null;
    private List<EmployeeFactory> factories = new ArrayList<>();
    
    private FactoryAccess(){
        //Add new Factory HERE
        factories.add(FieldEmployeeFactory.getInstance());
        factories.add(ManagerFactory.getInstance());
        factories.add(OfficeEmployeeFactory.getInstance());
        factories.add(InternFactory.getInstance());
    }
    
    public static FactoryAccess getInstance(){
        if(instance == null)
            instance = new FactoryAccess();
        return instance;
    }
    
    public List<EmployeeFactory> getFactories(){
        return factories;
    }
}
