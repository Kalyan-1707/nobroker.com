<%-- 
    Document   : home
    Created on : 10 Dec, 2019, 8:29:24 PM
    Author     : #Lee1707
--%>

<%@page import="java.util.ArrayList"%>
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
    <body onload="outofstock()">
        
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
	<li><a href="cart.jsp"  ><span class="glyphicon glyphicon-shopping-cart"> </span> Cart</a></li>
        <li><a href="orders.jsp" ><span class="glyphicon glyphicon-user "> </span> Orders</a></li>
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
          public  ResultSet getdata() throws Exception   {
            
                
          Statement st=database_script.dbconn();
          ResultSet r=st.executeQuery("SELECT * FROM items  ORDER BY item_name,item_price,item_quantity DESC ");
          return r;    
         }  
       %>
       
       
       
        <%
            String user_id=(String)session.getAttribute("user");
         ResultSet data=getdata();
         int i;
         ArrayList<String> items=new ArrayList<String>();
         int counter=0;
         if(!(data.next()))
         {
             out.println("Nothing found");
            } 
         else{
            do
             {
        %>
        <div class="">

	<div class="" >
            
                				
		<div class="col-md-offset-1 col-md-3 col-sm-6 thumbnail"  >
			<img src="vegetables/<%=data.getString("item_name")%>.jpg">
		<div class="caption">
			<center>
                                    <h2><%=data.getString("item_name")%></h2>
                                <p>Price : Rs.<%=data.getString("item_price")%></p>
                                
                         </center>
										
            </div>      
                                <table>
                                    <thead><tr><center><td></td><td></td><td >Qty</td></center></tr></thead>
                               
        <form class="form-inline" action="cartadd_script" method="post">
            <input type="text" style="display: none;" value="<%=data.getString("farmer_email")%>" name="vendor">
                                    <input type="text" style="display: none;" value="<%=data.getString("item_name")%>" name="item_name">
                                    <input type="text" style="display: none;" value="<%=data.getString("item_price")%>" name="item_price">
                                    <input type="text" style="display: none;" value="<%=user_id%>" name="user_email">
                                    <center>
                                    <tbody>
                                    <td><button class="btn btn-info" id="add-to-cart">Add to cart</button></td>
                                    <td colspan="2"><input type="number" class="form-control" value="0.5" min="0.5" max="<%=data.getString("item_quantity")%>" step="0.5" name="item_qty"></td>
                                </tbody>
                                </center>
                                     
                            </form>
                             </table>
                </div>
         </div>
        </div>
        <%
            }while(data.next()); }%>
            
            <div style="display: none;">
                <%=request.getAttribute("cart-ack")%>
            </div>
            <input value="<%=request.getAttribute("cart-item-ack")%>" id="cart-item-ack" style="display:none;">
            
                
            <script type="text/javascript">
                
                
                function outofstock()
                {
                    //var val=document.getElementById("it-qt-val").value;
                    //if(val<=0)
                     //   document.getElementById('add-to-cart').innerHTML="Out Of Stock";
                    cart_ack();
                }
                
                
                
    
                    function cart_ack()
                {
                    var val=document.getElementById("cart-ack").value;
                    var item=document.getElementById("cart-item-ack").value;
                    if(val==1)
                    {
                        
                        document.getElementById('user_greeting').innerHTML=item+" already in cart.Visit <a href='cart.jsp'>cart</a> to manage";
                    }
                    else
                    {
                        document.getElementById('user_greeting').innerHTML=item+" added to cart";
                    }
                    document.getElementById('user_greeting').style.display="block";
                    
                }
            </script> 
            
            
            
    </body>
</html>
