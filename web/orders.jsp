<%-- 
    Document   : orders
    Created on : 14 Dec, 2019, 5:59:22 PM
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
	<li><a href="cart.jsp"  ><span class="glyphicon glyphicon-shopping-cart"> </span> Cart</a></li>
        <li><a href="home.jsp" ><span class="glyphicon glyphicon-user "> </span> Home</a></li>
	<li><a href="logout.jsp"  ><span class="glyphicon glyphicon-log-out"> </span> Logout</a></li>
        </ul>
	</div>
	</div>
	</nav>
        
        
        <%!
          public  ResultSet getdata(String user_id) throws Exception   {
            
                
          Statement st=database_script.dbconn();
          ResultSet r=st.executeQuery("select * from orders where client_email='"+user_id+"' and status='ordered' ");
          return r;    
         }  
       %>
        
        
        <%
         
         String user_id=(String)session.getAttribute("user");
         ResultSet data=getdata(user_id);
         int counter=0;
         if(!(data.next()))
         {
             out.println("Nothing found");
            }
         else{
         do
             {
                 float total=data.getFloat("quantity")*data.getFloat("price");
        %>
        
        <div class="container">
            <form action="placeorder" method="post">
                <input type="text" value="<%=user_id%>" style="display:none;" name="user_id">
                <input type="text" value="<%=data.getString("item_name")%>" style="display:none;" name="item_name">
                <input type="text" value="<%=data.getString("vendor")%>" style="display:none;" name="vendor">
                <input type="text" value="<%=data.getString("quantity")%>" style="display:none;" name="item_quantity">
                <input type="text" value="<%=counter%>" style="display:none;" name="form_id">
                <div class="jumbotron" style="text-align: center;" id="jumb<%=counter%>">
                <table class="table table-borderless">
                    <thead><tr><td class="col-xs-3">Item</td>
                               <td class="col-xs-3">Price($/kg)</td>
                               <td class="col-xs-3">Quantity(kg)</td>
                               <td class="col-xs-3">Vendor</td></tr></thead>
                    <tbody><tr><td class="col-xs-3"><%=data.getString("item_name")%></td>
                            <td class="col-xs-3"><%=data.getString("price")%></td>
                            <td class="col-xs-3"><%=data.getString("quantity")%></td>
                               <td class="col-xs-3"><%=data.getString("vendor")%></td></tr></tbody>
                </table>
                
                Total :$<%=total%>
                <br>
                <button class="btn btn-info" disabled="">
                   Order Placed
                </button>
                
                
                
            </div>
                </form>
        </div>
        
            <%
                }while(data.next()); }%>
        
        
        
    </body>
</html>
