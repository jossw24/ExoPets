<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>ExoPets Shipping</title>
</head>
<body
            
style = "background-color: lightblue;"
></body>
        

<%  // TODO: Get order id
	String o = request.getParameter("orderid");  
	int order = Integer.parseInt(o);
	// TODO: Check if valid order id
	try { 
		getConnection();  
		// choosing orders db
		Statement stmt = con.createStatement(); 
		stmt.execute("USE orders");
		PreparedStatement pstmt = con.prepareStatement("SELECT orderId from ordersummary WHERE orderId = ?");  
		pstmt.setInt(1, order); 
		ResultSet rs = pstmt.executeQuery();  
		if(!rs.next())  
			order = -1; 
    }  catch(Exception e) {
        out.println("<h1>Invalid Order Id. Go back to prev</h1>");
        return;
    }

	try { 
		getConnection();  
		// choosing orders db
		Statement stmt = con.createStatement(); 
		stmt.execute("USE orders");   

		// TODO: Start a transaction (turn-off auto-commit)
		con.setAutoCommit(false);   

		// TODO: Create a new shipment record.   
		Timestamp time = new Timestamp(System.currentTimeMillis());
		PreparedStatement pstmt = con.prepareStatement("INSERT INTO shipment(warehouseId, shipmentDate) VALUES(?, ?)"); 
		int warehouseID = 1; 
		pstmt.setInt(1, warehouseID);
		pstmt.setTimestamp(2, time);
		pstmt.execute();  

		// TODO: Retrieve all items in order with given id
		PreparedStatement pstmt2 = con.prepareStatement("SELECT productId, quantity FROM orderproduct WHERE orderId = ?"); 
		pstmt2.setInt(1, order);  
		ResultSet rst = pstmt2.executeQuery();  

		// NEED TO FIND A WAY TO CHOOSE A WAREHOUSE, hardcoding for now 
		PreparedStatement pstmt3 = con.prepareStatement("SELECT quantity FROM productinventory WHERE productId = ? and warehouseId = 1"); 

		boolean success = false; 
		int count = 0;

		while(rst.next()) {
			count++;
			int orderProdId = rst.getInt(1); 
			int orderProdQTY = rst.getInt(2);   
			pstmt3.setInt(1, orderProdId); 
			ResultSet rst2 = pstmt3.executeQuery(); 
			if(!rst2.next()) {  
				out.println("<h1>Shipment not done. No inventory for product: " + orderProdId + "</h1>");
				success = false; 
			} else { 
				int invProdQTY = rst2.getInt(1); 
				if(invProdQTY < orderProdQTY) { 
					out.println("<h1>Shipment not done. Not enough inventory for product: " + orderProdId + "</h1>");
					success = false; 
				} else {
					int newQTY = invProdQTY - orderProdQTY; 
					PreparedStatement pstmt4 = con.prepareStatement("UPDATE productinventory SET quantity = ? WHERE productId = ? and warehouseId = 1"); 
					pstmt4.setInt(1, newQTY);
					pstmt4.setInt(2, orderProdId); 
					pstmt4.execute();
					out.println("<h3>Ordered Product: " + orderProdId + " Qty: " + orderProdQTY + " Previous inventory: " + invProdQTY + " New inventory: " + newQTY + "<h3>"); 
					success = true; 
				}
			} 
			if(!success || count == 3) 
				break; 
		} 
		
		if(!success)
			con.rollback(); 
		else {
			con.commit(); 
			out.println("<h3>Shipment Succesful<h3>");
		}

	} catch (SQLException ex) { 
		out.print(ex);
	} finally { 
		con.setAutoCommit(true); 
		closeConnection();
	}
	
	// TODO: Create a new shipment record.
	// TODO: For each item verify sufficient quantity available in warehouse 1.
	// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
	
	// TODO: Auto-commit should be turned back on
%>                       				

<h2><a href="admin.jsp">Back to Admin</a></h2>

</body>
</html>
