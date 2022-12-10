<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ include file="jdbc.jsp" %>
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

        response.sendRedirect("index.jsp");
        session.setAttribute("accConfirmation","Your account has been created!");
    } catch (SQLException ex) { 
		out.print(ex);
	} finally { 
		closeConnection();
    }
%>