<%@ page import="java.sql.*,java.util.*" %>
<%@ include file="jdbc.jsp"%>  
<%@ include file="auth.jsp"%> 
<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body
            
style = "background-color: lightblue;"
></body>

<%
String userName = (String) session.getAttribute("authenticatedUser");   
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

