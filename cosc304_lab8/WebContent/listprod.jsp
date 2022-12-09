<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %> 
<%@ include file="jdbc.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%> 
<!DOCTYPE html>
<html>
<head>
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

<body style = "background-color: lightblue;">

<ul>
	<li style="float:left;"><a>EXOPETS</a></li> 
	<% String user = (String) session.getAttribute("authenticatedUser"); out.print("<li style=\"float:left;\"><a>User: " + user + "</a></li>");%>
	<li style="float:right;"><a href="logout.jsp">Log Out</a></li>
	<li style="float:right;"><a href="listorder.jsp">Your Orders</a></li>
	<li style="float:right;"><a href="showcart.jsp">Your Cart</a></li>
	<li style="float:right;"><a href="customer.jsp">Info</a></li>
	<% boolean admin = (boolean) session.getAttribute("isAdmin"); 
		if(admin) 
			out.print("<li style=\"float:right;\"><a href=\"admin.jsp\">Admin</a></li>");
	%>
	<li style="float:right;"><a class="active" href="listprod.jsp">Main</a></li>
</ul>

<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp"> 
<select size=1 name ="categoryName"> 
	<option value="All">All</option> 
	<option value="mostBought">Our Top Products</option> 
	<option value="mostBoughtPersonal">Your Most Frequent Buys</option>
	<option value="Fish">Fish</option> 
	<option value="Mammals">Mammals</option> 
	<option value="Birds">Birds</option> 
	<option value="Reptiles">Reptiles</option> 
	<option value="Amphibians">Amphibians</option> 
	<option value="Dragons">Dragons</option> 
	<option value="Fairies">Fairies</option> 
	<option value="Dinosaurs">Dinosaurs</option>
</select>
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form> 

<% // Get product name, customerId, and categoryName to search for
String name = request.getParameter("productName"); 
String catName = request.getParameter("categoryName");   
int customerID = (int) session.getAttribute("authId"); 
// Set header 
String prodHeader;  
if((name == null | name == "") && (catName == null))
	prodHeader = "All Products";
else if((name == null | name == "") && (catName != null))
	prodHeader = "All Products in category: \"" + catName + "\""; 
else if(catName == null | catName.equals("All")) 
	prodHeader = "All Products containing: \"" + name + "\"";
else 
	prodHeader = "All Products containing: \"" + name + "\" in category: \"" + catName + "\"";   

out.print("<h2>" + prodHeader + "</h2>");
		
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

if (catName == null || catName.equals("All")) 
	catName = "%";

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!  

NumberFormat currFormat = NumberFormat.getCurrencyInstance(); 
String query = "SELECT productId, productName, categoryName, productPrice, productImageURL FROM product p, category c WHERE p.categoryId = c.categoryId AND productName LIKE ? AND categoryName LIKE ?"; 

if(catName.equals("mostBought"))
	query = "SELECT TOP 5 p.productId, productName, categoryName, productPrice, productImageURL" 
	+" FROM product p, category c, orderproduct op WHERE p.categoryId = c.categoryId AND p.productId = op.productId" 
	+" AND productName LIKE ?" 
	+" GROUP BY p.productId, productName, categoryName, productPrice, productImageURL" 
	+" ORDER BY SUM(quantity) DESC";


else if(catName.equals("mostBoughtPersonal")) 
	query = "SELECT TOP 5 p.productId, productName, categoryName, productPrice, productImageURL" 
	+" FROM customer cu, ordersummary o, orderproduct op, product p, category c WHERE cu.customerId = o.customerId AND o.orderId = op.orderId AND op.productId = p.productId AND p.categoryId = c.categoryId" 
	+" AND productName LIKE ? AND cu.customerId = ?" 
	+" GROUP BY p.productId, productName, categoryName, productPrice, productImageURL" 
	+" ORDER BY SUM(quantity) DESC"; 


// Make the connection
	try {
		getConnection(); 
		Statement stmt = con.createStatement(); 
		stmt.execute("USE orders"); 
		PreparedStatement pstmt = con.prepareStatement(query);  

		if(catName.equals("mostBoughtPersonal")) 
			pstmt.setInt(2, customerID);
		else if(!catName.equals("mostBought"))
			pstmt.setString(2, catName); 	

		if ((name == null | name == ""))   
			pstmt.setString(1, "%"); 
		else
			pstmt.setString(1, "%" + name + "%");  

		ResultSet rst = pstmt.executeQuery();  
		out.println("<table border=\"1\"><tr><th>Image</th><th>Product Name</th><th>Category</th><th>Price</th></tr>");
		while(rst.next()) {   
			// Print out the ResultSet
			int id = rst.getInt(1);
			String pname = rst.getString(2);  
			String cname = rst.getString(3); 
			double pprice = rst.getDouble(4);  
			String imgURL = rst.getString(5);
			// For each product create a link of the form: addcart.jsp?id=productId&name=productName&price=productPrice
			out.print("<tr><td><img src=\"" + imgURL + "\" width =\"200\" height=\"100\"><a href = \"addcart.jsp?id=" + id + "&name=" + pname + "&price=" + pprice + "\">Add to Cart</a></td>"); 
			out.print("<td><a href = \"product.jsp?id=" + id + "&name=" + pname + "&price=" + pprice + "\">" + pname + "</a></td>");  
			out.print("<td>" + cname + "</td>");  
			out.print("<td>" + currFormat.format(pprice) + "</td></tr>"); 
		} 
		out.print("</table>"); 

	} catch (SQLException e) {
		out.println("SQLException: " + e);  
	} finally { // Close connection
		closeConnection(); 
	}

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00
%>
<p style = "text-align: left" ><span style = "font-family:monospace;font-size:15px;color:#4db27c;border-width:2px;border-style:solid; background-color: #dfe3e6;
	border-color:#0e0d0d; border-radius:15px">
	<a href="adminlogin.jsp"> Administrator</a> </span></p>
</body>
</html>
