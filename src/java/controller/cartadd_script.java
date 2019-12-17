/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import DAO.model;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author #Lee1707
 */
public class cartadd_script extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        try{
        
            String mail=request.getParameter("user_email");
             String it_name=request.getParameter("item_name");
              String it_qty=request.getParameter("item_qty");
               String it_price=request.getParameter("item_price");
                String vendor=request.getParameter("vendor"); 
                
                model m=new model();
                
                int x=m.cartadd(mail,it_name,it_qty,it_price,vendor);
                if(x==0)
                {
                 //out.println("Items in cart");
                request.setAttribute("cart-item-ack", it_name); 
                request.setAttribute("cart-ack", "<input value=1 id='cart-ack' style=\"display:none;\">");
                request.getRequestDispatcher("home.jsp").forward(request, response);
                
                }
                else if(x==1)
                {
                    //out.println("Item to be added");
                    request.setAttribute("cart-item-ack", it_name);
                    request.setAttribute("cart-ack", "<input value=0 id='cart-ack' style=\"display:none;\">");
                    request.getRequestDispatcher("home.jsp").forward(request, response);
                   
                 }
                else{}
             
        }
        catch(Exception e)
        {
            out.println(e);
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

    

}
