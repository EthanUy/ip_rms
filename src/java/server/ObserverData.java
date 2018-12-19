/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package server;

import java.util.Vector;
import hrsystem.Observer;
import hrsystem.Subject;
import hrsystem.ManagerServlet;
/**
 *
 * @author LoganLee
 */
public class ObserverData implements Subject{
    
    public Vector<Observer> observers = new Vector<Observer>();
    private static ObserverData instance = null;
    
    private ObserverData(){}
    
    public static ObserverData getInstance(){
        if(instance==null)
            instance = new ObserverData();
        return instance;
    }

    @Override
    public void addObserver(Observer observer) {
        observers.add(observer);
    }

    @Override
    public void removeObserver(Observer observer) {
        observers.remove(observer);
    }

    @Override
    public void notifyObserver(int id) {
        
        for(Observer o : observers){
            for(int p_id : ((ManagerServlet)o).getProjectId()){
                if(p_id == id)
                    o.update();
            }
        }
    }
}
