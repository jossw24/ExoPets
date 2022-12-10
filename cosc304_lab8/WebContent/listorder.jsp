<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html> 
<head>
<title>Your Orders</title>
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
	<li style="float:right;"><a href="listorder.jsp" class="active">Your Orders</a></li>
	<li style="float:right;"><a href="showcart.jsp">Your Cart</a></li>
	<li style="float:right;"><a href="customer.jsp">Info</a></li>
	<% boolean admin = (boolean) session.getAttribute("isAdmin"); 
		if(admin) 
			out.print("<li style=\"float:right;\"><a href=\"admin.jsp\">Admin</a></li>");
	%>
	<li style="float:right;"><a href="listprod.jsp">Main</a></li>
</ul>

<h1>Your Orders</h1>

<% 
//Note: Forces loading of SQL Server driver 
int customerID = (int) session.getAttribute("authId"); 
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
try (Connection con = DriverManager.getConnection(url, uid, pw);)
{	// Write query to retrieve all order summary records 
	PreparedStatement pstmt = con.prepareStatement("SELECT orderId, firstName, lastName, totalAmount FROM ordersummary, customer WHERE ordersummary.customerId = customer.customerId AND customer.customerId = ?");
	pstmt.setInt(1, customerID);
	ResultSet rst = pstmt.executeQuery(); 
	out.println("<table border=\"1\"><tr><th>OrderId</th><th>Your Name</th><th>totalAmount</th></tr>"); 
		// For each order in the ResultSet
	while (rst.next()) {	 
		out.print("<tr><td>" + rst.getInt(1) + "</td>"); 
		out.print("<td>" + rst.getString(2) + " " + rst.getString(3) + "</td>"); 
		out.print("<td>" + currFormat.format(rst.getDouble(4)) + "</td></tr>");   
		out.println("<tr align=\"right\"><td colspan=\"4\"><table border=\"1\">"); 
		out.println("<tr><th>ProductImage</th><th>ProductName</th><th>Quantity</th><th>Price</th></tr>");
		PreparedStatement pstmt2 = con.prepareStatement("SELECT productImageURL, productName, quantity, price FROM orderproduct, product WHERE orderproduct.productId = product.productId AND orderId = ?"); 
		pstmt2.setInt(1, rst.getInt(1)); 
		ResultSet rst2 = pstmt2.executeQuery();  
			// For each product in the order
		while (rst2.next()) {  
			out.print("<tr><td><img src=\"" + rst2.getString(1) + "\" width =\"200\" height=\"100\"></td>");
			out.print("<td>" + rst2.getString(2) + "</td>");
			out.print("<td>" + rst2.getInt(3) + "</td>");
			out.println("<td>" + currFormat.format(rst2.getDouble(4)) + "</td></tr>");
		} 
		out.println("</table></td></tr>");
	}  
	out.println("</table>");
}
catch (SQLException ex) {
	out.println("SQLException: " + ex);
}
%>

</body>
</html>

