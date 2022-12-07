<!DOCTYPE html>
<html>
<head>
        <title>ExoPet</title>
</head>
<body
        
style = "background-color: lightblue;"
></body>
<%
// TODO: Display user name that is logged in (or nothing if not logged in) 
boolean authenticated = session.getAttribute("authenticatedUser") == null ? false : true;  
String user = (String) session.getAttribute("authenticatedUser"); 
if(authenticated) { 
        out.print("<h2 align=\"left\">Signed in as: " + user + "</h2>");
}
%>
<h1 align="center"><font size = 30 >ExoPet: All of your exotic pet needs</font></h1>


<p style = "text-align: center" ><span style = "font-family:monospace;font-size:35px;color:#4db27c;border-width:2px;border-style:solid; background-color: #dfe3e6; 
        border-color:#0e0d0d; border-radius:15px">
                <a href="listprod.jsp"> Begin Shopping </a> </span></p>

<p style = "text-align: center" ><span style = "font-family:monospace;font-size:30px;color:#4db27c;border-width:2px;border-style:solid; background-color: #dfe3e6; 
        border-color:#0e0d0d; border-radius:15px">
                <a href="listorder.jsp"> List All Orders </a> </span></p>


<p style = "text-align: left" ><span style = "font-family:monospace;font-size:20px;color:#4db27c;border-width:2px;border-style:solid; background-color: #dfe3e6; 
                border-color:#0e0d0d; border-radius:15px">
                <a href="customer.jsp"> Customer Info </a> </span></p>

<p style = "text-align: left" ><span style = "font-family:monospace;font-size:20px;color:#4db27c;border-width:2px;border-style:solid; background-color: #dfe3e6; 
                        border-color:#0e0d0d; border-radius:15px">
                        <a href="admin.jsp"> Administrators </a> </span></p>

 <p style = "text-align: left" ><span style = "font-family:monospace;font-size:20px;color:#4db27c;border-width:2px;border-style:solid; background-color: #dfe3e6; 
                                border-color:#0e0d0d; border-radius:15px">
                                <a href="logout.jsp"> Logout </a> </span></p>
</body>
</head>


