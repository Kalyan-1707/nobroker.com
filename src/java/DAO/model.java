/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import dbconnection.database_script;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author #Lee1707
 */
public class model {
    
    
    public int reg(String email, String password, String contact,String category) throws SQLException{
        
        Statement st=database_script.dbconn();
        int x=st.executeUpdate("insert into login values('"+email+"','"+password+"','"+contact+"','"+category+"')");
        return 1;        

    }

    public int log_val(String email, String password) throws SQLException  {
        
        int x=0;
        String temp;
        Statement st=database_script.dbconn();
        ResultSet r=st.executeQuery("select category from login where email='"+email+"' and password='"+password+"'");
        if(r.next())
        {
            temp=r.getString("category");
            if(temp.equalsIgnoreCase("farmer"))
                x=1;
            else if(temp.equalsIgnoreCase("client"))
                x=0;
        }
        else{
            x=-1;
        }
       return x;
    }

    public int sell_insert(String user_email,String it_name, String it_quantity, String it_price)throws SQLException 
    {
        //Quantity sold initial value 0;
       // String temp;
        int x;
        Statement st=database_script.dbconn();
        ResultSet r=st.executeQuery("select * from items where farmer_email='"+user_email+"' and item_name='"+it_name+"'");
        if(r.next())
        {
                x=0;
        }
        else{
         x=st.executeUpdate("insert into items values('"+user_email+"','"+it_name+"','"+it_quantity+"','"+it_price+"',0)");
         }
        
        return x;
    }

    public int items_update(String it_name, String it_quantity, String it_price, String user_email)throws SQLException 
    {
        
        Statement st=database_script.dbconn();
        int x=st.executeUpdate("update items set item_price='"+it_price+"',item_quantity='"+it_quantity+"' where farmer_email='"+user_email+"' and item_name='"+it_name+"' ");
        return x;
    
    
    }

    public int item_remove(String user_email, String it_name, String it_price, String it_quantity)throws SQLException 
        {  
        Statement st=database_script.dbconn();
        int x=st.executeUpdate("delete from items where farmer_email='"+user_email+"' and item_name='"+it_name+"' ");
        return 1;
    }

    public int cartadd(String mail, String it_name, String it_qty, String it_price, String vendor)throws SQLException 
      {    
          
        int x;
        String status="cart";
        Statement st=database_script.dbconn();
        ResultSet r=st.executeQuery("select * from orders where client_email='"+mail+"' and item_name='"+it_name+"' and status='"+status+"'");
        if(r.next())
        {
                x=0;
        }
        else{
         x=st.executeUpdate("insert into orders values('"+mail+"','"+it_name+"','"+vendor+"','"+it_qty+"','"+it_price+"','"+status+"')");
        }
        return x;
    }

    public int place_order(String mail, String it_name, String vendor,String it_qty)throws SQLException
        {
            Statement st=database_script.dbconn();
        ResultSet rs=st.executeQuery("select item_quantity from items where farmer_email='"+vendor+"' and item_name='"+it_name+"'");
        int x;
        rs.next();
        
        float it_qt=rs.getFloat("item_quantity");
        it_qt=it_qt-Float.parseFloat(it_qty);
        if(it_qt==0)
             x=st.executeUpdate("delete from items where farmer_email='"+vendor+"' and item_name='"+it_name+"'");
        
        if(it_qt<0)
            return -1;
        
          x=st.executeUpdate("update items set item_quantity='"+it_qt+"' where farmer_email='"+vendor+"' and item_name='"+it_name+"'");
        
         x=st.executeUpdate("update orders set status='ordered',quantity='"+it_qty+"' where client_email='"+mail+"' and item_name='"+it_name+"' and vendor='"+vendor+"' ");
        
        return x;
    }
    
    
    
    
    
    
    
}
