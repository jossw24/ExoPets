<%@ page import="java.sql.*, java.util.Locale" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ include file = "jdbc.jsp"%>  
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order Processing</title>
</head>
<body
            
style = "background-color: lightblue;"
></body>
<%
// Get customer id
String custId = request.getParameter("customerId");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
// Determine if valid customer id was entered
// Determine if there are products in the shopping cart
// If either are not true, display an error message

if(custId == null || custId.equals(""))
    out.print("<h1>Invalid Customer id. Go back to prev</h1>");
else if(productList == null)
    out.print("<h1> Your shopping cart is empty!</h1>");
else{
    //Check if customer id is a number
    int num =-1;
    try
    {
        num = Integer.parseInt(custId);
    }
    catch(Exception e) {
        out.println("<h1>Invalid Customer id. Go back to prev</h1>");
        return;
    }

    String sql = "SELECT customerId, firstName + ' ' + lastName FROM Customer WHERE customerId = ? ";
    NumberFormat curFormat = NumberFormat.getCurrencyInstance(Locale.US);

    try
    {
        getConnection(); 
        Statement stmt = con.createStatement(); 
		stmt.execute("USE orders"); 

        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setInt(1, num);
        ResultSet rst = pstmt.executeQuery();
        
        int orderId = 0;
        String custName = "";
        if(!rst.next())
            out.println("<h1>Invalid customer id. go back to previous page</h1>");
        else
        {
            custName = rst.getString(2);
            // Enter order information into database
            sql = "INSERT INTO OrderSummary (customerId, orderDate) VALUES (?,?)";
            pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setInt(1, num);

            Timestamp timestamp = new Timestamp(System.currentTimeMillis());
            pstmt.setTimestamp(2, timestamp);

            pstmt.executeUpdate();

            ResultSet keys = pstmt.getGeneratedKeys();
            keys.next();

            orderId = keys.getInt(1);
 
            out.print("<h1>Your Order Summary</h1>");
            out.print("<table border=\"2\"><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th>");
            double total = 0;

            Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();

            while (iterator.hasNext())
                {
                Map.Entry<String, ArrayList<Object>> entry = iterator.next();
                ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
                String productId = (String) product.get(0);
                out.print("<tr><td>"+ productId+ "</td>");
                out.print("<td>"+ product.get(1)+ "</td>");
                out.print("<td align=\"center\">"+ product.get(3)+ "</td>");
                String price = (String) product.get(2);
                double pr = Double.parseDouble(price);
                int qty = ( (Integer)product.get(3)).intValue();
                out.print("<td align=\"right\">"+ curFormat.format(pr)+ "</td>");
                out.print("<td align=\"right\">"+ curFormat.format(pr*qty)+ "</td>");
                out.print("</tr>");

                total = total + pr*qty;

                sql = "INSERT INTO OrderProduct (orderId, productId, quantity, price) VALUES (?,?,?,?)";
                pstmt = con.prepareStatement(sql);
                pstmt.setInt(1, orderId);
                pstmt.setInt(2, Integer.parseInt(productId));
                pstmt.setInt(3, qty);
                pstmt.setString(4, price);
                pstmt.executeUpdate();
 
                }

                out.println("<tr><td colspan=\"4\" align =\"left\"><b>OrderTotal</b></td><td align=\"right\">"+curFormat.format(total)+"</td>");
                out.println("</table>");

                sql = "UPDATE OrderSummary SET totalAmount = ? WHERE orderId = ? ";
                pstmt = con.prepareStatement(sql);
                pstmt.setDouble(1, total);
                pstmt.setInt(2, orderId);
                pstmt.executeUpdate();

                String custtId = request.getParameter("customerId");
            
                String sql2 = "SELECT address, city, state, postalCode, country FROM customer WHERE customerId = ?";
                PreparedStatement pstmt2 = con.prepareStatement(sql2);
                pstmt2.setString(1, custtId);

                ResultSet rst2 = pstmt2.executeQuery();
                out.println("<h1>Order completed. Will be shipped soon to: </h1>");
                
                out.println("<table border=\"2\"><tr><th>Address</th><th>City</th><th>State</th><th>Postal Code</th> <th>Country</th></tr>");
                while(rst2.next()) {
                    out.print("<tr><td>" + rst2.getString(1) + "</td>");
                    out.print("<td>" + rst2.getString(2) + "</td>");
                    out.print("<td>" + rst2.getString(3) + "</td>");
                    out.print("<td>" + rst2.getString(4) + "</td>");
                    out.print("<td>" + rst2.getString(5) + "</td></tr>");

                }
                out.print("</table>");
            
                out.println("<h1>Your order reference number is: "+orderId+"</h1>");
                out.println("<h1>Shipping to customer: "+custId+" Name: " + custName+"</h1>");
                out.print("<h2><a href=\"listprod.jsp\"> Return to shopping</a></h2>");
                session.setAttribute("productList", null);

        }

    }
    catch(SQLException ex) {
        out.println(ex);
    }

    finally {
        closeConnection();
    }
}
%>
</BODY>
</HTML>

 
