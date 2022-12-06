<!DOCTYPE html>
<html>
<head>
        <title>Exotic Pet Store</title>
</head>
<body>
<h1 align="center">Welcome to Exotic Pet Store</h1>

<h2 align="left"><a href="login.jsp">Login</a></h2>
<h2 align="left"><a href="customer.jsp">Customer Info</a></h2>

<h2 align="center"><a href="listprod.jsp"><font face="Arial, Helvetica, sans-serif" size="30"></font>Begin Shopping</a></h2>

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


