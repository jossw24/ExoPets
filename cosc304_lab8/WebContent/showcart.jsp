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
	<li style="float:right;"><a class="active" href="showcart.jsp">Your Cart</a></li>
	<li style="float:right;"><a href="customer.jsp">Info</a></li>
	<% boolean admin = (boolean) session.getAttribute("isAdmin"); 
		if(admin) 
			out.print("<li style=\"float:right;\"><a href=\"admin.jsp\">Admin</a></li>");
	%>
	<li style="float:right;"><a href="listprod.jsp">Main</a></li>
</ul>

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

	double total = 0;
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
			//getting the price
			pr = Double.parseDouble(price.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid price for product: "+product.get(0)+" price: "+price);
		}
		try
		{
			//getting quantity 
			qty = Integer.parseInt(itemqty.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid quantity for product: "+product.get(0)+" quantity: "+qty);
		}		
		//printing price and total price
		out.print("<td align=\"left\">"+currFormat.format(pr)+"</td>");
		out.print("<td align=\"left\">"+currFormat.format(pr*qty)+"</td></tr>");
		out.println("</tr>");
		total = total+pr*qty;
		totalQty = totalQty +qty;
	}
	out.println("</table>");

	//order total
	out.println("<tr><td colspan=\"4\" align=\"Right\"><b>Order Total: </b></td>"
			+"<td align=\"left\">"+currFormat.format(total)+"</td></tr>");
	out.println("</table>");
	
	//total items in cart
	out.println("<tr><td colspan=\"4\" align=\"Right\"><b> Items in Cart: </b></td>"
		+"<td align=\"left\">"+totalQty +"</td></tr>");


	//checkout button
	out.println("<h2><font size =17><a href=\"checkout.jsp\">Check Out</a></font></h2>");

}
%>
<h2><a href="listprod.jsp">Continue Shopping</a></h2>

</body>
</html> 

