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
<p style = "text-align: center" ><span style = "font-family:monospace;font-size:65px;color:rgb(82, 79, 79);">
                ExoPet  </span></p>
<p style = "text-align: center" ><span style = "font-family:monospace;font-size:25px;font-style:italic; color:rgb(83, 78, 78);">
        Providing a selection of rare wildlife species on demand!     </span></p>

<hr style="color:grey; height : 2px; background-color:rgb(58, 57, 57)">


<p style = "text-align: center" ><span style = "font-family:monospace;font-size:45px;color:#4db27c;border-width:2px;border-style:solid; background-color: #dfe3e6; 
        border-color:#0e0d0d; border-radius:15px">
                <a href="listprod.jsp"> Begin Shopping </a> </span></p>

<p style = "text-align: center" ><span style = "font-family:monospace;font-size:30px;color:#4db27c;border-width:2px;border-style:solid; background-color: #dfe3e6; 
        border-color:#0e0d0d; border-radius:15px">
                <a href="listorder.jsp"> List All Orders </a> </span></p>


<img src="img/capybara-square-1.jpg.optimal.jpg" width="280" height = "250" align = "left" /><img src="img/download.jpg" width="300" height = "250" align = "center" /><img src="img/SeaQuests-Guide-to-Axolotls-img-900x450.webp" width="305" height = "250" align = "right" />

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


