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
import javax.servlet.http.HttpSession;

/**
 *
 * @author #Lee1707
 */
public class sell_script extends HttpServlet {

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
            String it_name=request.getParameter("item_name");
            String it_quantity=request.getParameter("item_quantity");
            String it_price=request.getParameter("item_price");
            String user_email=request.getParameter("user_id");
            model m=new model();
            
            out.println(it_quantity);
            int x=m.sell_insert(user_email,it_name,it_quantity,it_price);
            if(x==0)
            {
                //out.println("Hello");
                request.setAttribute("sell_ack","<input id='ack-val' value=-1 style=\"display:none;\">");
                request.setAttribute("item_ack",it_name);
                
                request.getRequestDispatcher("farmer.jsp").forward(request, response);
            }
            else if(x==1)
            {
                //out.println("Hell");
                request.setAttribute("sell_ack","<input id='ack-val' value=1 style=\"display:none;\">");
                request.setAttribute("item_ack",it_name);
                
                request.getRequestDispatcher("farmer.jsp").forward(request, response);
            
            }
            else{
                    
                request.setAttribute("sell_ack","<input id='ack-val' value=0 style=\"display:none;\">");
                response.sendRedirect("farmer.jsp");
            }
            
            
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
