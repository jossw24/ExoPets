<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
</head>
<body
            
style = "background-color: lightblue;"
></body>
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

