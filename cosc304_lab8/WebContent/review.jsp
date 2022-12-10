<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp"%>
<!DOCTYPE html>
<html>
<head>
        <title>ExoPet</title>
        <style>
            textarea {
              width: 35%; /* Set the width of the textarea */
              height: 20%;
              padding: 5x; /* Add some padding to the element */
              border: 5px solid #337ab7; /* Add a border to the element */
              border-radius: 5px; /* Round the corners of the element */
              box-sizing: border-box; /* Make sure the element's content is resized properly */
            }
          </style>
            <style>
                form {
              font-family: cursive; /* Set the font of the form to cursive */
              color: #337ab7; /* Set the color of the text to blue */
            }
            </style>
</head>
<body
        
style = "background-color: lightblue;"
></body>
<h1> Review Confirmation</h1>
<p>Thank you for your review!</p>

</body>

<%
try{
        getConnection();
        session = request.getSession(true);
        int id = Integer.parseInt(request.getParameter("id"));   
        int rating = Integer.valueOf(request.getParameter("rating"));
        String userName = (String) session.getAttribute("authenticatedUser");
        
        String rComment = "N/A";
        if (request.getParameter("comment") == null){
            rComment = "N/A";
        } else {
            rComment = request.getParameter("comment");
        }
        
        String custid = "SELECT customerId FROM customer WHERE userid = ?";
        PreparedStatement pstmt = con.prepareStatement(custid);
        pstmt.setString(1, userName);
        ResultSet rs = pstmt.executeQuery();
        int customerId = 0;
        while(rs.next()){
            customerId = rs.getInt("customerId");
         
        }
        
        String input = "INSERT INTO review (reviewRating, reviewDate, customerId, productId, reviewComment) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement stmt = con.prepareStatement(input);
        stmt.setInt(1, rating);
        stmt.setDate(2, java.sql.Date.valueOf(java.time.LocalDate.now()));
        stmt.setInt(3, customerId);
        stmt.setInt(4, id);
        stmt.setString(5, rComment);
        stmt.execute();
        }
        catch (Exception e){
            out.println(e);
            
        }
    %>
</head>
