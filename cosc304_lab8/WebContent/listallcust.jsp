<%@ page import="java.sql.*,java.util.*" %>
<%@ include file="jdbc.jsp"%>  
<%@ include file="auth.jsp"%> 
<!DOCTYPE html>
<html>
<head>
<title>List all customers</title>
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

String sql = "SELECT customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid FROM customer";
try { 
	getConnection(); 
	Statement stmt = con.createStatement(); 
	stmt.execute("USE orders");  
	PreparedStatement pstmt = con.prepareStatement(sql); 
	ResultSet rst = pstmt.executeQuery();      
	while(rst.next()) { 
        out.print("<table border=\"1\">"); 
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
        out.print("</table>"); 
        out.print("<hr>"); 
        out.print("<hr>");
	} 
} catch (SQLException e) { 
	out.println(e); 
} 

finally { 
	closeConnection();
}
%> 

</body>
</html>