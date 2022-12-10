<!DOCTYPE html>
<html>
<head>
        <title>ExoPet</title>
</head>
<body
        
style = "background-color: lightblue;"
></body>
<p style = "text-align: center" ><span style = "font-family:monospace;font-size:65px;color:rgb(82, 79, 79);">
                ExoPet  </span></p>
<p style = "text-align: center" ><span style = "font-family:monospace;font-size:25px;font-style:italic; color:rgb(83, 78, 78);">
        Providing a selection of rare wildlife species on demand!     </span></p>

<hr style="color:grey; height : 2px; background-color:rgb(58, 57, 57)">


<p style = "text-align: center" ><span style = "font-family:monospace;font-size:45px;color:#4db27c;border-width:2px;border-style:solid; background-color: #dfe3e6; 
        border-color:#0e0d0d; border-radius:15px">
                <a href="login.jsp"> Login </a> </span></p>

<p style = "text-align: center" ><span style = "font-family:monospace;font-size:45px;color:#4db27c;border-width:2px;border-style:solid; background-color: #dfe3e6; 
        border-color:#0e0d0d; border-radius:15px">
                <a href="createaccount.jsp"> Create Account</a> </span></p>


                <div style="text-align: center;">
                        <img src="img/9.jpg" width="280" height="250" z-index: 1;" />
                        <img src="img/20.jpg" width="300" height="250" z-index: 1;" />
                        <img src="img/21.jpg" width="305" height="250" z-index: 1;" />
                      </div>

<% 
if(session.getAttribute("accConfirmation") != null)
        out.println("<p style=\"text-align: center;\">"+session.getAttribute("accConfirmation").toString()+"</p>"); 
session.removeAttribute("accConfirmation");
%>

                        
</body>
</head>


