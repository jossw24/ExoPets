<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ include file="jdbc.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Your Shopping Cart</title>
</head>
<body
            
style = "background-color: lightblue;"
></body>

<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
int totalQty = 0;
if (productList == null)
{	out.println("<H1>Your shopping cart is empty!</H1>");
	productList = new HashMap<String, ArrayList<Object>>();
}
else
{
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();

	out.println("<h1>Cart Summary </h1>");
	

	out.print("<table border=\"3\"><tr><th>Product Name</th><th>Quantity</th>");
	out.println("<th>Price</th><th>Subtotal</th></tr>");

	double total =0;
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext()) 
	{	Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		if (product.size() < 4)
		{
			out.println("Expected product with four entries. Got: "+product);
			continue;
		}
		
		out.print("<td>"+product.get(1)+"</td>");

		out.print("<td border=\"1\" align=\"center\">"+product.get(3)+"</td>");
		Object price = product.get(2);
		Object itemqty = product.get(3);
		double pr = 0;
		int qty = 0;
		
		try
		{
			pr = Double.parseDouble(price.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid price for product: "+product.get(0)+" price: "+price);
		}
		try
		{
			qty = Integer.parseInt(itemqty.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid quantity for product: "+product.get(0)+" quantity: "+qty);
		}		

		out.print("<td align=\"left\">"+currFormat.format(pr)+"</td>");
		out.print("<td align=\"left\">"+currFormat.format(pr*qty)+"</td></tr>");
		out.println("</tr>");
		total = total+pr*qty;
		totalQty = totalQty +qty;
	}
	out.println("</table>");

	out.println("<tr><td colspan=\"4\" align=\"Right\"><b>Order Total: </b></td>"
			+"<td align=\"left\">"+currFormat.format(total)+"</td></tr>");
	out.println("</table>");
	out.println("<tr><td colspan=\"4\" align=\"Right\"><b> Items in Cart: </b></td>"
		+"<td align=\"left\">"+totalQty +"</td></tr>");


	out.println("<h2><font size =17><a href=\"checkout.jsp\">Check Out</a></font></h2>");

	//trying to do product recommendation off of first item in cart
	/* try {
		getConnection(); 
		Statement stmt = con.createStatement(); 
		stmt.execute("USE orders"); 
		PreparedStatement pstmt = con.prepareStatement(query);  

		out.println("<table border=\"1\"><tr><th>Image</th><th>Product Name</th><th>Category</th><th>Price</th></tr>");
			int id = product.get(0).getInt(1);
			String pname = product.get(0).getString(2);  
			String cname = product.get(0).getString(3); 
			double pprice = product.get(0).getDouble(4);  
			String imgURL = product.get(0).getString(5);
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
	*/


}
%>
<h2><a href="listprod.jsp">Continue Shopping</a></h2>

</body>
</html> 

