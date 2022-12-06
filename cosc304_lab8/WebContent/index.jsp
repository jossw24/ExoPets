<!DOCTYPE html>
<html>
<head>
        <title>ExoPet</title>
</head>
<body
        
style = "background-color: lightblue;"
></body>

<h1 align="center">ExoPet: All of your exotic pet needs</h1>

<h2 align="left"><a href="login.jsp">Login</a></h2>
<h2 align="left"><a href="customer.jsp"><strong><i>Customer Info</i></strong></a></h2>
<p align = "center" style = "font-family:monospace;font-size:35px; color:#4db27c;">
                <a href="listprod.jsp"> Begin Shopping </a> </p>
<h2 align="center"><a href="listorder.jsp">List All Orders</a></h2>

<h2 align="center"><a href="admin.jsp">Administrators</a></h2>

<%
// TODO: Display user name that is logged in (or nothing if not logged in) 
boolean authenticated = session.getAttribute("authenticatedUser") == null ? false : true;  
String user = (String) session.getAttribute("authenticatedUser"); 
if(authenticated) { 
        out.print("<h2 align=\"left\">Signed in as: " + user + "</h2>");
}
%>
<h2 align="left"><a href="logout.jsp">Log out</a></h2>  
</body>
</head>


