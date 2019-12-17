<%-- 
    Document   : farmer
    Created on : 11 Dec, 2019, 11:41:55 AM
    Author     : #Lee1707
--%>

<%@page import="java.lang.String"%>
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
        <style>
            input.transparent-input{
       background-color:rgba(0,0,0,0) !important;
       border:none !important;
            }
            th,td,thead{
                text-align: center;
            }
            #slide_bg{
      width: 100%;
      height: 100vh;
      background-position: center center;
      background-size: cover;
      background-repeat: no-repeat;
      backface-visibility: hidden;
      background-image: url('pic1.jpg');
    }
    #table-visibility{display: none;}
        </style>
    </head>
    <body onload="onload_timeout()">
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
        <li><a href="myproducts.jsp" ><span class="glyphicon glyphicon-user "> </span> My Products</a></li>
	<li><a href="logout.jsp"  ><span class="glyphicon glyphicon-log-out"> </span> Logout</a></li>
        </ul>
	</div>
	</div>
	</nav>
        <%
                    String user_id=(String)session.getAttribute("user");
                    String st=(String)session.getAttribute("status");
                    
                    String user=user_id.substring(0, user_id.indexOf("@"));
                    %>
        
    <center>
        <div class="col-sm-offset-5 col-sm-2 status" >
            <center>
            <div class="alert alert-success" id="user_greeting" role="alert" style="margin:0px;background-color: rgb(0,255,0);color: white;z-index: 5;position: fixed;display: none;">Welcome , <%=user%></div>
            <input id="status-value" value="<%=st%>" style="display:none;">
            </center>
        </div>
        </center>
        
        <div id="slide_bg">
            <div class="row" style="padding-top:15px;">
            <div class="col-sm-offset-1 col-sm-2">
            <table class="table table-borderless" style="background-color:rgba(80,208,255,0.25);">
                <thead>
                    <tr>
                     <th>
                         <button class="btn btn-block" style="background: none;" onmouseover="hover('pic1.jpg')">Choose Items</button>
                    </th>
                    </tr>
                </thead>
                <tbody>
                    <tr><td><button class="btn btn-block" style="background: none;"  onclick="item_data('tomato')" onmouseover="hover('vegetables/tomato.jpg')">Tomato</button></td></tr>
                    <tr><td><button class="btn btn-block" style="background:none;"  onclick="item_data('carrot')" onmouseover="hover('vegetables/carrot.jpg')">Carrot</button></td></tr>
                    <tr><td><button class="btn btn-block" style="background: none;"  onclick="item_data('onion')" onmouseover="hover('vegetables/onion.jpg')">Onion</button></td></tr>
                    <tr><td><button class="btn btn-block" style="background: none;" onclick="item_data('potato')" onmouseover="hover('vegetables/potato.jpg')">Potato</button></td></tr>
                </tbody>
            </table>
        </div>
                
                    
        <div class="col-sm-offset-3 col-sm-3 col-sm-offset-3">
            <form action="sell_script" method="post" >
                <input class="form-control" value="<%=user_id%>" readonly="true" style="display:none;" name="user_id">
            <table class="table table-borderless " id="table-visibility" style="background:none;">
                <thead>
                    <tr>
                        <th class="col-xs-6">
                         <label>Item</label>
                    </th>
                    <th class="col-xs-6"><input class="form-control transparent-input" value="tomato" readonly="true" id="item" name="item_name"></th>
                    </tr>
                    
                </thead>
                <tbody>
                    <tr><td class="col-xs-6">Quantity(kg)</td>
                        <td class="col-xs-6"><input type="number" name="item_quantity" class="form-control transparent-input" min='0.5' max="50" step="0.5" value="0.5"></td></tr>
                       
                    <tr><td class="col-xs-6">Price(₹/kg)</td>
                        <td class="col-xs-6"><input type="number" name="item_price" class="form-control transparent-input" min='5' max="999" step="5" value="5"></td></tr>

                    <tr><td colspan="2"><button class="btn btn-block" style="background: none;" id="sell-button">Sell</button> </td></tr>
                </tbody>
            </table>
             </form>
            <br><br>
            <div id="item-ack-farmer" style="display:none;"><%=request.getAttribute("item_ack")%></div>
            <div id="ack" style="display:none;"><%=request.getAttribute("sell_ack")%>
                   </div>
      </div>        
     </div>
        </div>
                   <div id="update-status-value"></div>
                
        
        <script type="text/javascript">
            function hover(urlvalue)
            {
             var val="url("+urlvalue+")";
             document.getElementById('slide_bg').style.backgroundImage=val;
                            
            }
            function ack()
            {
                var ack_val=document.getElementById('ack-val').value;
                document.getElementById("ack").style.display="block";
                document.getElementById("item-ack-farmer").style.display="block";
                console.log(ack_val);
                if(ack_val==1)
                {document.getElementById("ack").innerHTML="Successful Updated<br>Visit <a href='myproducts.jsp'>My Products</a> to Manage";
                  document.getElementById("user_greeting").innerHTML="Success";
                    }
                 else if(ack_val==-1)
                 {
                    document.getElementById("ack").innerHTML="Item added before<br>Visit <a href='myproducts.jsp'>My Products</a> to Manage";
                  document.getElementById("user_greeting").innerHTML="Ohhh!";
                 
                 }
                else
                {
                    document.getElementById("ack").innerHTML="Problem in updating <br>Try after some time.";
                 
                    document.getElementById("user_greeting").innerHTML="Error";
                }
                    document.getElementById("ack").style.display="block";
                    document.getElementById("item-ack-farmer").style.display="block";
                    setTimeout(greeting_user_show,2000);
                }
            function onload_timeout()
            {
                
               var x=document.getElementById('status-value').value;
               if(x==0)
               {
                   document.getElementById("update-status-value").innerHTML="<%session.setAttribute("status", "1");%>";   
              // document.getElementById("user_greeting").style.display="block";
               setTimeout(greeting_user_show,2000);
                }
                else{ack();}
            }
            function greeting_user_show()
            {
                document.getElementById("user_greeting").style.display="block";
                window.setTimeout(greeting_user_hide,2000);
            }
            function greeting_user_hide()
            {
                document.getElementById("user_greeting").style.display="none";
                document.getElementById("ack").style.display="none";
                document.getElementById("item-ack-farmer").style.display="none"; 
            }
            
            function item_data(item_value)
            {
                document.getElementById('table-visibility').style.display="block";
                document.getElementById('item').value=item_value;
               
                    
            }
            
           
        </script>
        
        
        
    </body>
</html>
