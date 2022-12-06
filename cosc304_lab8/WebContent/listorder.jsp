<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html> 
<head>
<title>YOUR NAME Grocery Order List</title>
</head>
<body>

<h1>Order List</h1>

<%
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00

// Make connection 
	String url = "jdbc:sqlserver://cosc304_sqlserver;databaseName=orders;TrustServerCertificate=True";		
	String uid = "sa";
	String pw = "304#sa#pw";

// Making currency format 
NumberFormat currFormat = NumberFormat.getCurrencyInstance();		
try (Connection con = DriverManager.getConnection(url, uid, pw); 
	Statement stmt = con.createStatement();) 
{	// Write query to retrieve all order summary records 
	ResultSet rst = stmt.executeQuery("SELECT orderId, customer.customerId, firstName, lastName, totalAmount FROM ordersummary, customer WHERE ordersummary.customerId = customer.customerId");
	out.println("<table border=\"1\"><tr><th>OrderId</th><th>CustomerId</th><th>CustomerName</th><th>totalAmount</th></tr>"); 
		// For each order in the ResultSet
	while (rst.next()) {	 
		out.print("<tr><td>" + rst.getInt(1) + "</td>"); 
		out.print("<td>" + rst.getInt(2) + "</td>"); 
		out.print("<td>" + rst.getString(3) + " " + rst.getString(4) + "</td>"); 
		out.print("<td>" + currFormat.format(rst.getDouble(5)) + "</td></tr>");   
		out.println("<tr align=\"right\"><td colspan=\"4\"><table border=\"1\">"); 
		out.println("<tr><th>ProductId</th><th>Quantity</th><th>Price</th></tr>");
		PreparedStatement pstmt2 = con.prepareStatement("SELECT productId, quantity, price FROM orderproduct WHERE orderId = ?"); 
		pstmt2.setInt(1, rst.getInt(1)); 
		ResultSet rst2 = pstmt2.executeQuery();  
			// For each product in the order
		while (rst2.next()) {  
			out.print("<tr><td>" + rst2.getInt(1) + "</td>");
			out.print("<td>" + rst2.getInt(2) + "</td>");
			out.println("<td>" + currFormat.format(rst2.getDouble(3)) + "</td></tr>");
		} 
		out.println("</table></td></tr>");
	}  
	out.println("</table>");
}
catch (SQLException ex)
{
	out.println("SQLException: " + ex);
}
%>

</body>
</html>
