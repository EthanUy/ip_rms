package hrsystem;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.PrintWriter;
import java.net.Socket;
import javafx.application.Platform;
import javafx.scene.control.TextArea;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author LoganLee
 */
public class ClientServlet extends HttpServlet {

    Socket socket;
    TextArea textArea;
    ObjectOutputStream out;
    ObjectInputStream in;
    
    public void startClient(String IP, int port){
        Thread thread = new Thread(){
            public void run(){
                try{
                    socket = new Socket(IP, port);
                    out = new ObjectOutputStream(socket.getOutputStream());
                    in = new ObjectInputStream(socket.getInputStream());
                    receive();
                }catch(Exception e){
                    if(!socket.isClosed()){
                        System.out.println("[Connection failed to Server]");
                        Platform.exit();
                    }
                }
            }
        };
        
        thread.start();
    }
    
    public void stopClient(){
        try{
            if(socket != null && !socket.isClosed()){
                in.close();
                out.close();
                socket.close();
            }
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void send(int id){
        Thread thread = new Thread(){
            public void run(){
                try{
                    out.writeObject((Object)id);
                    out.flush();
                }catch(Exception e){
                    stopClient();
                }
            }
        };
        thread.start();
    }
    
    public void receive(){
        while(true){
            try{
                Object o = null;
                o = in.readObject();
            }catch(Exception e){
                stopClient();
            }
        }
    }
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ClientServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ClientServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
        
//        if(request.getParameter("status").equals("Completed")){
//            int id = Integer.parseInt(request.getParameter("projectId"));
//            send(id);
//            stopClient();
//        }
    }

    public void notifyProject(int id){
        send(id);
        stopClient();
    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
