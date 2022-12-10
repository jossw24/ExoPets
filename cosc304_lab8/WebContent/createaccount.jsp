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
    
    <br>
        <form name="MyForm" method="post" action="createacccode.jsp">
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
            <td><input type="text" name="phonenum"  size=15 maxlength=10></td>
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
    </form>

    </div>

</body>
</head>
