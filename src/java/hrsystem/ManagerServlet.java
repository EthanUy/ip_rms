/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hrsystem;


import java.awt.Desktop;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.PrintWriter;
import java.io.Serializable;
import java.net.MalformedURLException;
import java.net.Socket;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javafx.application.Platform;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author LoganLee
 */
public class ManagerServlet extends HttpServlet implements Observer, Serializable{
    private List<Integer> projectId;
    
    Socket socket;
    ObjectOutputStream out;
    ObjectInputStream in;

    public List<Integer> getProjectId() {
        return projectId;
    }

    public void setProjectId(List<Integer> projectId) {
        this.projectId = projectId;
    }
    
    public void startClient(String IP, int port){
        Thread thread = new Thread(){
            public void run(){
                try{
                    socket = new Socket(IP, port);
                    out = new ObjectOutputStream(socket.getOutputStream());
                    in = new ObjectInputStream(socket.getInputStream());
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
                out.close();
                socket.close();
            }
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void send(ManagerServlet s){
        Thread thread = new Thread(){
            public void run(){
                try{
                    out.writeObject(s);
                    out.flush();
                }catch(Exception e){
                    stopClient();
                }
            }
        };
        thread.start();
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
            out.println("<title>Servlet ManagerServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagerServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
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

    @Override
    public void update() {
        try {
            //do refresh
            Desktop.getDesktop().browse(new URL("http://www.google.com").toURI());
        } catch (MalformedURLException ex) {
            Logger.getLogger(ManagerServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (URISyntaxException ex) {
            Logger.getLogger(ManagerServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(ManagerServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
