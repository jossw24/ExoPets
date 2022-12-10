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

<p style = "text-align: left" ><span style = "font-family:monospace;font-size:25px;color:#4db27c;border-width:2px;border-style:solid; background-color: #dfe3e6; 
    border-color:#0e0d0d; border-radius:15px">
            <a href="admin.jsp">Back to Admin Page</a> </span></p>
<%

    //Statement stmt = con.createStatement();
	// Write query to retrieve all order summary records 
	//ResultSet rst = stmt.executeQuery("SELECT orderId, customer.customerId, firstName, lastName, totalAmount FROM ordersummary, customer WHERE ordersummary.customerId = customer.customerId");

//String userName = (String) session.getAttribute("authenticatedUser");   
// TODO: Write SQL query that prints out total order amount by day
String sql = "SELECT year(orderDate), month(orderDate), day(orderDate), SUM(totalAmount) FROM ordersummary GROUP BY year(orderDate), month(orderDate), day(orderDate)"; 

try { 
    getConnection(); 
	Statement stmt = con.createStatement(); 
	stmt.execute("USE orders");  
	PreparedStatement pstmt = con.prepareStatement(sql); 
	ResultSet rst = pstmt.executeQuery();  
	out.print("<table border=\"1\">"); 
    while(rst.next()) {  
        String date = String.format("%s-%s-%s",rst.getString(1), rst.getString(2), rst.getString(3));  
        String price = String.format("$%s", rst.getString(4));
        out.print("<tr><td><b>Order Date</b></td><td><b>Total Order Amount</b></td</tr>"); 
        out.print("<tr><td>" + date + "</td><td>" + price + "</td></tr>"); 
    } 
    out.print("</table>"); 
} catch (SQLException ex) { 
    out.println(ex);
} finally { 
    closeConnection();
}

%> 

</body>
</html>