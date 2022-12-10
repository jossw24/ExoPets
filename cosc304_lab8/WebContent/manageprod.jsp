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

<p style = "text-align: left" ><span style = "font-family:monospace;font-size:25px;color:#4db27c;border-width:2px;border-style:solid; background-color: #dfe3e6; 
    border-color:#0e0d0d; border-radius:15px">
            <a href="addprod.jsp">Add a new Product</a> </span></p>
<%

String sql = ""SELECT productId, productName, productDesc, productPrice, FROM product";
try { 
	getConnection(); 
	Statement stmt = con.createStatement(); 
	stmt.execute("USE orders");  
	PreparedStatement pstmt = con.prepareStatement(sql); 
	ResultSet rst = pstmt.executeQuery();      
    out.println("<table border=\"1\"><tr><th>Product Name</th><th>Description</th><th>Price</th></tr>");
	while(rst.next()) { 
        int id = rst.getInt(1);
		String pname = rst.getString(2);  
		String pdesc = rst.getString(3); 
		double pprice = rst.getDouble(4);  
        out.print("<tr><td>" + + "</td>"); 
        out.print(""); 
        out.print(""); 
        out.print(""); 
        out.print("</tr>");
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