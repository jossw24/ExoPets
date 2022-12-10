<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp"%>

<html>
<head>
</head>
<body style = "background-color: lightblue;"></body>


<%
// Get product name to search for
// TODO: Retrieve and display info for the product
String tempid = request.getParameter("id"); 
int id = Integer.parseInt(tempid); 
String name = request.getParameter("name");
String price = request.getParameter("price");
out.print("<h2>" + name + "</h2>");

String sql = "SELECT productImageURL, productImage, productDesc FROM product WHERE productId = ?";

// TODO: If there is a productImageURL, display using IMG tag 
	try {
		getConnection();  
        Statement stmt = con.createStatement(); 
		stmt.execute("USE orders"); 
		PreparedStatement pstmt = con.prepareStatement(sql);  
        pstmt.setInt(1, id); 
		ResultSet rst = pstmt.executeQuery();  
		while(rst.next()) {   
            // TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter. 
            // displayimage only catches buffer on safari / ff not chrome! 
            if(rst.getString(1) != null && rst.getBytes(2) != null) { 
                out.print("<img src=\"" + rst.getString(1) + "\" width =\"500\" height=\"250\">"); 
                out.print("<img src =\"displayImage.jsp?id=" + id + "\" width =\"500\" height=\"250\">");
            } else if(rst.getString(1) != null && rst.getBytes(2) == null) { 
                out.print("<img src=\"" + rst.getString(1) + "\" width =\"500\" height=\"250\">"); 
            } else if(rst.getString(1) == null && rst.getBytes(2) != null) { 
                out.print("<img src =\"displayImage.jsp?id=" + id + "\" width =\"500\" height=\"250\">");
            }
            out.print("<h3>"+ rst.getString(3) +"</h3>");
		} 
	} catch (SQLException e) {
		out.println("SQLException: " + e);  
	} finally { // Close connection
		closeConnection(); 
	}
		
// TODO: Add links to Add to Cart and Continue Shopping
out.println("<h3><a href = \"addcart.jsp?id=" + tempid + "&name=" + name + "&price=" + price + "\">Add to Cart</a></h3>"); 
out.println("<h3><a href = \"listprod.jsp\">Continue Shopping</a></h3>"); 


%>

