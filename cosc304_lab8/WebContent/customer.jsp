<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
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
	<li style="float:right;"><a class="active" href="customer.jsp">Info</a></li>
	<% boolean admin = (boolean) session.getAttribute("isAdmin"); 
		if(admin) 
			out.print("<li style=\"float:right;\"><a href=\"admin.jsp\">Admin</a></li>");
	%>
	<li style="float:right;"><a href="listprod.jsp">Main</a></li>
</ul>

	<h2>Customer Profile</h2>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
String userName = (String) session.getAttribute("authenticatedUser");  
// TODO: Print Customer information 
// assuming userid has to be unique
String sql = "SELECT customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid FROM customer WHERE userid = ?";
try { 
	getConnection(); 
	Statement stmt = con.createStatement(); 
	stmt.execute("USE orders");  
	PreparedStatement pstmt = con.prepareStatement(sql); 
	pstmt.setString(1, userName);  
	ResultSet rst = pstmt.executeQuery();  
	out.print("<table border=\"1\">"); 
	if(rst.next()) { 
		out.print("<tr><td><b>Customer Id</b></td><td>" + rst.getInt(1) + "</td></tr>"); 
		out.print("<tr><td><b>First Name</b></td><td>" + rst.getString(2) + "</td></tr>"); 
		out.print("<tr><td><b>Last Name</b></td><td>" + rst.getString(3) + "</td></tr>"); 
		out.print("<tr><td><b>Email</b></td><td>" + rst.getString(4) + "</td></tr>"); 
		out.print("<tr><td><b>Phone</b></td><td>" + rst.getString(5) + "</td></tr>"); 
		out.print("<tr><td><b>Address</b></td><td>" + rst.getString(6) + "</td></tr>"); 
		out.print("<tr><td><b>City</b></td><td>" + rst.getString(7) + "</td></tr>");  
		out.print("<tr><td><b>State</b></td><td>" + rst.getString(8) + "</td></tr>");
		out.print("<tr><td><b>Postal Code</b></td><td>" + rst.getString(9) + "</td></tr>"); 
		out.print("<tr><td><b>Country</b></td><td>" + rst.getString(10) + "</td></tr>"); 
		out.print("<tr><td><b>User Id</b></td><td>" + rst.getString(11) + "</td></tr>");
	} 
	out.print("</table>"); 
	
} catch (SQLException e) { 
	out.println(e); 
} 

finally { 
	closeConnection();
}
// Make sure to close connection

%>
<a href = "editinfo.jsp">

	<input type = "button" value = "Edit Info">
</a> <br>
<a href="listprod.jsp"> 
	
	<input type = "button" value = "Main Page">
</a>

</body>
</html>

