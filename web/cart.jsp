<%-- 
    Document   : cart
    Created on : 13 Dec, 2019, 11:41:57 AM
    Author     : #Lee1707
--%>

<%@page import="dbconnection.database_script"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
        <!--jQuery library--> 
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <!--Latest compiled and minified JavaScript--> 
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <nav class="navbar navbar-inverse navbar-static-top" style="margin:0px;">
	<div class="container">
	<div class="navbar-header">
	<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#mynavbar">
	<span class="icon-bar"></span>
	<span class="icon-bar"></span>
	<span class="icon-bar"></span>
	</button>		
	<a href="index.php" class="navbar-brand">No Broker</a>
	</div>
	 <div class="collapse navbar-collapse" id=mynavbar>
	<ul class="nav navbar-nav navbar-right" >
	<li><a href="orders.jsp"  ><span class="glyphicon glyphicon-shopping-cart"> </span> Orders</a></li>
        <li><a href="home.jsp" ><span class="glyphicon glyphicon-user "> </span> Home</a></li>
	<li><a href="logout.jsp"  ><span class="glyphicon glyphicon-log-out"> </span> Logout</a></li>
        </ul>
	</div>
	</div>
	</nav>
        
        
        <center>
            <div class="">
            <center>
            <div class="alert alert-success" id="user_greeting" role="alert" style="margin:0px;background-color: rgb(0,255,0);color: white;display: none;"></div>
            
            </center>
        </div>
        </center>
        
        <%!
            
          public  ResultSet getitems(String it) throws Exception   {
            
                
          Statement st1=database_script.dbconn();
          ResultSet r=st1.executeQuery("SELECT * FROM items where item_name='"+it+"'  ORDER BY item_name,item_price,item_quantity DESC ");
          return r;    
         }  
       
          public  ResultSet getdata(String user_id) throws Exception   {
            
                
          Statement st2=database_script.dbconn();
          ResultSet r=st2.executeQuery("select * from orders where client_email='"+user_id+"' and status='cart' ");
          return r;    
         }  
       %>
        
        
        <%
         
         String user_id=(String)session.getAttribute("user");
         ResultSet data=getdata(user_id);
         ResultSet items;
         int counter=0;
         if(!(data.next()))
         {
             out.println("Nothing found");
            }
         else{
         do
             {
                 
                 float total=data.getFloat("quantity")*data.getFloat("price");
                 items=getitems(data.getString("item_name"));
                 items.next();
        %>
        <div class="container">
            <form action="placeorder" method="post">
                <input type="text" value="<%=user_id%>" style="display:none;" name="user_id">
                <input type="text" value="<%=data.getString("item_name")%>" style="display:none;" name="item_name">
                <input type="text" value="<%=data.getString("vendor")%>" style="display:none;" name="vendor">
                
                <input type="text" value="<%=counter%>" style="display:none;" name="form_id">
                <div class="jumbotron" style="text-align: center;" id="jumb<%=counter%>">
                <table class="table table-borderless">
                    <thead><tr><td class="col-xs-3">Item</td>
                               <td class="col-xs-3">Price($/kg)</td>
                               <td class="col-xs-3">Quantity(kg)</td>
                               <td class="col-xs-3">Vendor</td></tr></thead>
                    <tbody><tr><td class="col-xs-3"><%=data.getString("item_name")%></td>
                            <td class="col-xs-3"><%=data.getString("price")%></td>
                            <td class="col-xs-3" >
                                <button type="button" class="btn form-inline" onclick="total(<%=data.getFloat("price")%>,<%=counter%>,parseFloat(-1),parseFloat(0.5))">-</button>
                                <input class="form-control form-inline" id="qty<%=counter%>" type="number" min="0.5" max="<%=items.getFloat("item_quantity")%>" step="0.5" style="background: none;text-align: center; display: inline; width: 60%;" name="item_quantity"  value="<%=data.getString("quantity")%>" >
                                <button type="button" class="btn form-inline" onclick="total(<%=data.getFloat("price")%>,<%=counter%>,parseFloat(1),parseFloat(<%=items.getFloat("item_quantity")%>))">+</button>
                            </td>
                                    
                               <td class="col-xs-3"><%=data.getString("vendor")%></td></tr></tbody>
                </table>
                
                               Total :$<div id="total<%=counter%>"><%=total%></div>
                <br>
                <% String val="";
                    String cls;
                    if(data.getString("status").equalsIgnoreCase("ordered"))
                    {     val="ordered";cls="btn-success";}
                        else
                    {       val="place order";cls="btn-info";}
                    %>
                <button class="btn <%=cls%>">
                   
                        <%=val%>
                </button>
                
                <br>
                <label class="" id="order_ack<%=counter%>" style="margin:0px;color: green;display: none;">
        </label>
                <div style="display:none;">
                 <%=request.getAttribute("order-ack")%>
                 <input type="number" value="<%=request.getAttribute("order-ack-value")%>" id="order-ack-value">
                </div>
                
            </div>
                </form>
        </div>
        
            <%
                counter++;}while(data.next()); }%>
                
        
                <script type="text/javascript">
         
                function total(price,id,val,range)
                {
                    var qty=parseFloat(document.getElementById("qty"+id.toString()).value);
                    if(!(qty+val==range))
                    {qty=qty+val;
                    document.getElementById("qty"+id.toString()).value=qty;
                    var tot=qty*price;
                    document.getElementById("total"+id.toString()).innerHTML=tot;
                }
            }
    
    
                function orderack()
           {
               var order_ack=document.getElementById('order-ack').value;
               var val=document.getElementById('order-ack-value').value;
               if(order_ack==0)
               {    
                document.getElementById('order_ack'+val.toString()).innerHTML="Out of Stock";
                document.getElementById('update_ack'+val.toString()).style.display="block"; 
                }
                else{
                    document.getElementById("user_greeting").innerHTML="Order Placed";
                    document.getElementById("user_greeting").style.display="block";
                }
                
                
            }
                    
                </script>
                
    </body>
</html>
