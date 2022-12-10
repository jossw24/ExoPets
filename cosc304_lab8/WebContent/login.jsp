<!DOCTYPE html>
<html>
<head>
<title>Login Screen</title>
</head>
<body
            
style = "background-color: lightblue;"

></body>

<div style="margin:0 auto;text-align:center;display:inline">

<h3>Please Login to System</h3>

<%
// Print prior error login message if present
if (session.getAttribute("loginMessage") != null)
	out.println("<p>"+session.getAttribute("loginMessage").toString()+"</p>");
%>

<br>
<form name="MyForm" method=post action="validateLogin.jsp">
<table style="display:inline">
	<style>
		td {
			padding: 10px;
			border: 3px solid  rgb(151, 151, 152);
		}
		input[type="text"] {
			width: 100%;
			height: 30px;
			font-size: 16px;
		}
	</style>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Username:</font></div></td>
	<td><input type="text" name="username"  size=10 maxlength=10></td>
</tr>
	<style>
    td {
        padding: 10px;
        border: 3px solid rgb(151, 151, 152);
    }
    input[type="password"] {
        width: 100%;
        height: 30px;
        font-size: 16px;
    }
</style>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Password:</font></div></td>
	<td><input type="password" name="password" size=10 maxlength="10"></td>
</tr>
</table>
<br/>
<input class="submit" type="submit" name="Submit2" value="Log In">
</form>

</div>

</body>
</html>

