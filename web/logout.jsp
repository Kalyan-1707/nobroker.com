<%-- 
    Document   : logout
    Created on : 12 Dec, 2019, 8:08:38 PM
    Author     : #Lee1707
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        
            session.invalidate(); 

            response.sendRedirect("index.html");
        
        %>
    </body>
</html>
