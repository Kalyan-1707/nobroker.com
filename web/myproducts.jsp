<%-- 
    Document   : myproducts
    Created on : 12 Dec, 2019, 5:36:21 PM
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
    <body onload="updateack()">
        
        
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
	<li><a href="farmer_orders.jsp"  ><span class="glyphicon glyphicon-shopping-cart"> </span> Orders</a></li>
        <li><a href="farmer.jsp" ><span class="glyphicon glyphicon-user "> </span> Home</a></li>
	<li><a href="logout.jsp"  ><span class="glyphicon glyphicon-log-out"> </span> Logout</a></li>
        </ul>
	</div>
	</div>
	</nav>
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        <%!
          public  ResultSet getdata(String user_id) throws Exception   {
            
                
          Statement st=database_script.dbconn();
          ResultSet r=st.executeQuery("select * from items where farmer_email='"+user_id+"'");
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
        %>
        <div class="container">
            <form action="updateitems_script" method="post" id="form<%=counter%>">
                <input type="text" value="<%=user_id%>" style="display:none;" name="user_id">
                <input type="text" value="<%=counter%>" style="display:none;" name="form_id">
                
                <input type="text" value="<%=data.getString("item_name")%>" style="display:none;" name="item_name">
            <div class="jumbotron" style="text-align: center;" id="jumb<%=counter%>">
                <table class="table table-borderless">
                    <thead><tr><td class="col-xs-3">Item</td>
                               <td class="col-xs-3">Price($/kg)</td>
                               <td class="col-xs-3">Quantity(kg)</td>
                               <td class="col-xs-3">Sold</td></tr></thead>
                    <tbody><tr><td class="col-xs-3"><%=data.getString("item_name")%></td>
                            <td class="col-xs-3"><input class="form-control " type="number" min="5" max="999" step="5" style="background: none;text-align: center;" name="item_price" id="edit-price-box<%=counter%>" value="<%=data.getString("item_price")%>" disabled></td>
                            <td class="col-xs-3"><input class="form-control "  type="number" min="0.5" max="50"  step="0.5" style="background: none;text-align: center;" name="item_quantity" id="edit-quantity-box<%=counter%>" value="<%=data.getString("item_quantity")%>" disabled></td>
                               <td class="col-xs-3"><%=data.getString("quantity_sold")%></td></tr></tbody>
                </table>
                               <div style="display:none;">
                                   <%=request.getAttribute("update-ack")%>
                                   <input type="number" value="<%=request.getAttribute("update-ack-value")%>" id="update-ack-value"></div>
                
                <button class="btn btn-info" id="update-button<%=counter%>" type="button" onclick="update(<%=counter%>)">Edit</button>
            
                <button class="btn btn-danger" onclick="removeitem(<%=counter%>)" type="button">Remove</button>   
                <br>
                <br>
                <label class="" id="update_ack<%=counter%>" style="margin:0px;color: green;display: none;">
        </label>
            
            </div>
                </form>
        </div>
        
            <%
                counter++;}while(data.next()); }%>
                
                
                
       <script type="text/javascript">
           
           function disable()
           {
            //document.getElementById('edit-price-box0').disabled=true;
            //document.getElementById('edit-quantity-box0').disabled=true;
           }
           
           function updateack()
           {
               var update_ack=document.getElementById('update-ack').value;
               var val=document.getElementById('update-ack-value').value;
               if(update_ack==1)
               {    
                document.getElementById('update_ack'+val.toString()).innerHTML="Value Success Fully Updated";
               document.getElementById('update_ack'+val.toString()).style.display="block"; 
                }
            }
           
           function removeitem(value)
           {
               document.getElementById('form'+value.toString()).action="itemremove_script";
             document.getElementById('form'+value.toString()).submit();
           }
                
        function update(value)
        {
            var btn=document.createElement("BUTTON");
            btn.innerHTML="Update";
            btn.className="btn btn-info";
            document.getElementById('jumb'+value.toString()).appendChild(btn);
            document.getElementById('update-button'+value.toString()).style.display="none";
            document.getElementById('edit-price-box'+value.toString()).disabled=false;
           document.getElementById('edit-quantity-box'+value.toString()).disabled=false;
        
        }
       
       
       </script>       
    
    </body>
</html>
