<%@ page import="java.sql.*,java.util.*" %>
<%@ include file="jdbc.jsp"%>  
<%@ include file="auth.jsp"%> 
<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
    <style>
        ul {
        list-style-type: none;
        margin: 0;
        padding: 0;
        overflow: hidden;
        background-color: #333;
        top: 0;
        width: 100%;
        }


        li a {
        display: block;
        color: white;
        text-align: center;
        padding: 14px 16px;
        text-decoration: none;
        }

        li a:hover:not(.active) {
        background-color: #111;
        }

        .active {
        background-color: #0066e4;
        }
    </style>
</head>
<body style = "background-color: lightblue;"></body>

<ul>
	<li style="float:left;"><a>EXOPETS</a></li> 
	<% String user = (String) session.getAttribute("authenticatedUser"); out.print("<li style=\"float:left;\"><a>User: " + user + "</a></li>");%>
	<li style="float:right;"><a href="logout.jsp">Log Out</a></li>
	<li style="float:right;"><a href="listorder.jsp">Your Orders</a></li>
	<li style="float:right;"><a href="showcart.jsp">Your Cart</a></li>
	<li style="float:right;"><a href="customer.jsp">Info</a></li>
	<% boolean admin = (boolean) session.getAttribute("isAdmin"); 
		if(admin) 
			out.print("<li style=\"float:right;\"><a href=\"admin.jsp\" class=\"active\">Admin</a></li>");
	%>
	<li style="float:right;"><a href="listprod.jsp">Main</a></li>
</ul>

<p style = "text-align: left" ><span style = "font-family:monospace;font-size:25px;color:#4db27c;border-width:2px;border-style:solid; background-color: #dfe3e6; 
    border-color:#0e0d0d; border-radius:15px">
            <a href="listallcust.jsp">List all customers</a> </span></p>
<p style = "text-align: left" ><span style = "font-family:monospace;font-size:25px;color:#4db27c;border-width:2px;border-style:solid; background-color: #dfe3e6; 
    border-color:#0e0d0d; border-radius:15px">
            <a href="listallorders.jsp">List all Orders</a> </span></p> 
<form name="resetdata" method="POST" action="adminloaddata.jsp">
    <input type = "submit" value = "Reload Database" />
</form>

<% if(session.getAttribute("databaseConfirmation") != null)
        out.println("<p>"+session.getAttribute("databaseConfirmation").toString()+"</p>"); 
    session.removeAttribute("databaseConfirmation");
%>

</body>
</html>

