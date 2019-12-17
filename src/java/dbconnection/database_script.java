/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dbconnection;

import static java.lang.System.out;
import java.sql.*;
/**
 *
 * @author #Lee1707
 */
public class database_script {
    
    static Statement s=null;
    static Connection con=null;
    public static Statement dbconn()
    {
        try{
            Class.forName("com.mysql.jdbc.Driver");
            
             con=DriverManager.getConnection("jdbc:mysql://localhost/nobroker","root","admin");
            
             s=con.createStatement();
        
             return s;
        }
        
        catch(Exception e){
            
            out.println(e);
        
        }
       
        
        
     return s;   
    }
    
}
