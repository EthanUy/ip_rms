package server;

import java.io.ObjectInputStream;
import java.net.Socket;
import hrsystem.Observer;
import java.io.ObjectOutputStream;
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author LoganLee
 */
public class Client {
    
    Socket socket;
    ObjectInputStream in;
    ObjectOutputStream out;
    ObserverData od;
    
    public Client(Socket socket){
        this.socket = socket;
        this.od = ObserverData.getInstance();
        try {
            in = new ObjectInputStream(socket.getInputStream());
            out = new ObjectOutputStream(socket.getOutputStream());
        } catch (Exception e) {
            e.printStackTrace();
        }
        receive();
    }
    
    public void receive(){
        Runnable thread = new Runnable(){
            @Override
            public void run() {
                try {
                    while(true){
                        try{
                        Object o = in.readObject();
//                        if(o.getClass().equals(Observer.class)){
//                            od.addObserver((Observer)o);
//                        }else{
//                            od.notifyObserver((int)o);
//                        }
//                        for(Client c : Server.clients){
//                            send(o);
//                        }
                        System.out.println("[Data received properly] "
                                        + socket.getRemoteSocketAddress()
                                        + ": " + Thread.currentThread().getName());
                        }catch(java.io.EOFException ex){}
                    }
                } catch (Exception e){
                    try{
                        System.out.println(e + " [Message Not Sent]"
                                    + socket.getRemoteSocketAddress()
                                    + ": " + Thread.currentThread().getName());
                        Server.clients.remove(Client.this);
                        in.close();
                        out.close();
                        socket.close();
                    }catch(Exception e2){
                        e.printStackTrace();
                    }
                }
            }
            
        };
        Server.threadPool.submit(thread);
    }
    
    public void send(Object o){
        Runnable thread = new Runnable(){
            @Override
            public void run() {
                try {
                    while(true){
                        out.writeObject(o);
                        out.flush();
                        
                        System.out.println("[Data received properly] "
                                        + socket.getRemoteSocketAddress()
                                        + ": " + Thread.currentThread().getName());

                    }
                } catch (Exception e){
                    try{
                        System.out.println(e + " [Message Not Sent]"
                                    + socket.getRemoteSocketAddress()
                                    + ": " + Thread.currentThread().getName());
                        Server.clients.remove(Client.this);
                        in.close();
                        out.close();
                        socket.close();
                    }catch(Exception e2){
                        e.printStackTrace();
                    }
                }
            }
            
        };
        Server.threadPool.submit(thread);
    }
}
