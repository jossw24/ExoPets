<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
        <title>ExoPet</title>
</head>
<body
        
style = "background-color: lightblue;"
></body>
<div style="margin:0 auto;text-align:center;display:inline">

    <h3>Create Account</h3>
    
    <%
    // Print prior error login message if present
    if (session.getAttribute("loginMessage") != null)
        out.println("<p>"+session.getAttribute("loginMessage").toString()+"</p>");
    %>
    
    <br>
    <form  name="MyForm" method=get >
    <table style="display:inline">
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">First Name:</font></div></td>
        <td><input type="text" name="firstName"  size=15 maxlength=20></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Last Name:</font></div></td>
        <td><input type="lastName" name="lastName"  size=15 maxlength=20></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Email:</font></div></td>
        <td><input type="email" name="email"  size=15 maxlength=20></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Phone:</font></div></td>
        <td><input type="number" name="phonenum"  size=15 maxlength=10></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Address:</font></div></td>
        <td><input type="address" name="address"  size=15 maxlength=30></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">City:</font></div></td>
        <td><input type="text" name="city"  size=15 maxlength=20></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">State:</font></div></td>
        <td><input type="text" name="state"  size=15 maxlength=2></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Postal Code:</font></div></td>
        <td><input type="postalCode" name="postalCode"  size=15 maxlength=7></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Country:</font></div></td>
        <td><input type="text" name="country"  size=15 maxlength=20></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Username:</font></div></td>
        <td><input type="userid" name="userid"  size=15 maxlength=20></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Password:</font></div></td>
        <td><input type="password" name="password" size=15 maxlength=20></td>
    </tr>
    </table>
    <br/>
    <input class="submit" type="submit" name="Submit2" value="Create Account" >
    
    
    
    
    
    
    <p style = "text-align: center" ><span style = "font-family:monospace;font-size:45px;color:#4db27c;border-width:2px;border-style:solid; background-color: #dfe3e6; 
        border-color:#0e0d0d; border-radius:15px">
                <a href="index.jsp"> Start Shopping</a> </span></p>


    </form>
    
    </div>

    <%
    
    try {
        getConnection();
        Statement stmt = con.createStatement();
        stmt.execute("USE orders");
        String firstName = request.getParameter("firstName");
        String lastName= request.getParameter("lastName");
        String email = request.getParameter("email");
        String phonenum = request.getParameter("phonenum");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String postalCode = request.getParameter("postalCode");
        String country = request.getParameter("country");
        String userid = request.getParameter("userid");
        String password = request.getParameter("password");
        
        out.print("<h1>" + "Valid data" + "</h1>");
        PreparedStatement pstmt = con.prepareStatement("INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES (?,?,?,?,?,?,?,?,?,?,?)");
        pstmt.setString(1, firstName);
        pstmt.setString(2, lastName);
        pstmt.setString(3, email);
        pstmt.setString(4, phonenum);
        pstmt.setString(5, address);
        pstmt.setString(6, city);
        pstmt.setString(7, state);
        pstmt.setString(8, postalCode);
        pstmt.setString(9, country);
        pstmt.setString(10, userid);
        pstmt.setString(11, password);
        pstmt.execute();
    } catch (SQLException ex) { 
		out.print(ex);
	} finally { 
		closeConnection();
    }

    %>


</body>
</head>
