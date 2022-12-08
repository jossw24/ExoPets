<!DOCTYPE html>
<html>
<head>
        <title>ExoPet</title>
</head>
<body
        
style = "background-color: lightblue;"
></body>
<h1> Edit Account Information</h1>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
String userName = (String) session.getAttribute("authenticatedUser"); 

String sql = "SELECT customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password FROM customer WHERE userid = ?";
try { 
	getConnection(); 
	Statement stmt = con.createStatement(); 
	stmt.execute("USE orders");  
	PreparedStatement pstmt = con.prepareStatement(sql); 
	pstmt.setString(1, userName);  
	ResultSet rst = pstmt.executeQuery();  
   
 //edit Name (first and last)
 //out.print("<table border=\"1\">"); 
	//if(rst.next()) { 
	//	out.print("<tr><td><b>Customer Id</b></td><td>" + rst.getInt(1) + "</td></tr>"); 
		//out.print("<tr><td><b>First Name</b></td><td>" + rst.getString(2) + "</td></tr>"); 
		//out.print("<tr><td><b>Last Name</b></td><td>" + rst.getString(3) + "</td></tr>"); 
		//out.print("<tr><td><b>Email</b></td><td>" + rst.getString(4) + "</td></tr>"); 
		//out.print("<tr><td><b>Phone</b></td><td>" + rst.getString(5) + "</td></tr>"); 
		//out.print("<tr><td><b>Address</b></td><td>" + rst.getString(6) + "</td></tr>"); 
		//out.print("<tr><td><b>City</b></td><td>" + rst.getString(7) + "</td></tr>");  
		//out.print("<tr><td><b>State</b></td><td>" + rst.getString(8) + "</td></tr>");
		//out.print("<tr><td><b>Postal Code</b></td><td>" + rst.getString(9) + "</td></tr>"); 
		//out.print("<tr><td><b>Country</b></td><td>" + rst.getString(10) + "</td></tr>"); 
		//out.print("<tr><td><b>User Id</b></td><td>" + rst.getString(11) + "</td></tr>");
        //out.print("<tr><td><b>Password</b></td><td><b> HIDDEN</b></td></tr>");
        

   // } 
	//out.print("</table>"); 
   
    %>
  
    <style>
        h2 {
            color : red;
        }
    </style>
    <h2> User Will Be Logged Out If Username Is Changed</h2>
 <form method ="get" action = "editinfo.jsp">
Change First Name <input type = "text" name ="editFname" size = "25">  <br>
Change Last Name <input type = "text" name ="editLname" size = "25"> <br>
Change Email <input type = "text" name ="editEmail" size = "25">  <br>
Change Phone Number <input type = "text" name ="editPhone" size = "25"> <br>
Change Address <input type = "text" name ="editAddress" size = "25">  <br>
Change City <input type = "text" name ="editCity" size = "25">  <br>
Change State <input type = "text" name ="editState" size = "25">  <br>
Change Postal Code <input type = "text" name ="editPostalCode" size = "25">  <br>
Change Country <input type = "text" name ="editCountry" size = "25">  <br>
Change User ID <input type = "text" name ="editUserId" size = "25">  <br>
Change Password <input type = "text" name ="editPassword" size = "25"> <br>
<input type = "submit" value = "Submit"> <br>

    </form>
    <a href="customer.jsp"> Back to Account Info</a>
    <%
     

    String Fname = request.getParameter("editFname");
    if(Fname !=null && !Fname.equals("")){
        String sql2 = "Update customer set firstName = ?  WHERE userid = ?";
    PreparedStatement pstmt2 = con.prepareStatement(sql2); 
	pstmt2.setString(2, userName);
        pstmt2.setString(1, Fname);
        pstmt2.executeUpdate();
        
    }
    String Lname = request.getParameter("editLname");
    if(Lname !=null && !Lname.equals("")){
        String sql2 = "Update customer set lastName = ?  WHERE userid = ?";
    PreparedStatement pstmt2 = con.prepareStatement(sql2); 
	pstmt2.setString(2, userName);
        pstmt2.setString(1, Lname);
        pstmt2.executeUpdate();

    }
    String Email = request.getParameter("editEmail");
    if(Email !=null && !Email.equals("")){
        String sql2 = "Update customer set email = ?  WHERE userid = ?";
    PreparedStatement pstmt2 = con.prepareStatement(sql2); 
	pstmt2.setString(2, userName);
        pstmt2.setString(1, Email);
        pstmt2.executeUpdate();
        

    }
    String Phone = request.getParameter("editPhone");
    if(Phone !=null && !Phone.equals("")){
        String sql2 = "Update customer set phonenum = ?  WHERE userid = ?";
    PreparedStatement pstmt2 = con.prepareStatement(sql2); 
	pstmt2.setString(2, userName);
        pstmt2.setString(1, Phone);
        pstmt2.executeUpdate();

    }
    String Address = request.getParameter("editAddress");
    if(Address !=null && !Address.equals("")){
        String sql2 = "Update customer set address = ?  WHERE userid = ?";
    PreparedStatement pstmt2 = con.prepareStatement(sql2); 
	pstmt2.setString(2, userName);
        pstmt2.setString(1, Address);
        pstmt2.executeUpdate();

    }
    String City = request.getParameter("editCity");
    if(City !=null && !City.equals("")){
        String sql2 = "Update customer set city = ?  WHERE userid = ?";
    PreparedStatement pstmt2 = con.prepareStatement(sql2); 
	pstmt2.setString(2, userName);
        pstmt2.setString(1, City);
        pstmt2.executeUpdate();

    }
    String State = request.getParameter("editState");
    if(State !=null && !State.equals("")){
        String sql2 = "Update customer set state = ?  WHERE userid = ?";
    PreparedStatement pstmt2 = con.prepareStatement(sql2); 
	pstmt2.setString(2, userName);
        pstmt2.setString(1, State);
        pstmt2.executeUpdate();

    }
    String Postal = request.getParameter("editPostalCode");
    if(Postal !=null && !Postal.equals("")){
        String sql2 = "Update customer set postalCode = ?  WHERE userid = ?";
    PreparedStatement pstmt2 = con.prepareStatement(sql2); 
	pstmt2.setString(2, userName);
        pstmt2.setString(1, Postal);
        pstmt2.executeUpdate();

    }
    String Country = request.getParameter("editCountry");
    if(Country !=null && !Country.equals("")){
        String sql2 = "Update customer set country = ?  WHERE userid = ?";
    PreparedStatement pstmt2 = con.prepareStatement(sql2); 
	pstmt2.setString(2, userName);
        pstmt2.setString(1, Country);
        pstmt2.executeUpdate();

    }
    
    String UserID = request.getParameter("editUserId");
    if(UserID !=null && !UserID.equals("")){
        String sql2 = "Update customer set userid = ?  WHERE userid = ?";
    PreparedStatement pstmt2 = con.prepareStatement(sql2); 
	pstmt2.setString(2, userName);
        pstmt2.setString(1, UserID);
        userName = UserID;
        pstmt2.executeUpdate();
        response.sendRedirect("index.jsp");
	

    }
    String Password = request.getParameter("editPassword");
    if(Password !=null && !Password.equals("")){
        String sql2 = "Update customer set password = ?  WHERE userid = ?";
    PreparedStatement pstmt2 = con.prepareStatement(sql2); 
	pstmt2.setString(2, userName);
        pstmt2.setString(1, Password);
        pstmt2.executeUpdate();
        
    }
    
	
    %>
  

  

    <%


	
	
} catch (SQLException e) { 
	out.println(e); 
} 

finally { 
	closeConnection();
}







%>

</body>
</head>