<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file= "jdbc.jsp" %>
<%
	String authenticatedUser = null;
	session = request.getSession(true);

	try
	{
		authenticatedUser = validateLogin(out,request,session);
	}
	catch(IOException e)
	{	System.err.println(e); }

	if(authenticatedUser != null)
		response.sendRedirect("listprod.jsp");		// Successful login
	else
		response.sendRedirect("login.jsp");		// Failed login - redirect back to login page with a message 
%>

<%!
	String validateLogin(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException {

		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String retStr = null;
		int custId = -1; 
		boolean admin = false;

		if(username == null || password == null)
				return null;
		if((username.length() == 0) || (password.length() == 0))
				return null;
		
		try {
			getConnection(); 
			Statement stmt = con.createStatement(); 
			stmt.execute("USE orders"); 

			// TODO: Check if userId and password match some customer account. If so, set retStr to be the username.
			String sql = "SELECT customerId, userid, isadmin FROM customer WHERE userid = ? and password = ?"; 
			PreparedStatement pstmt = con.prepareStatement(sql); 
			pstmt.setString(1, username); 
			pstmt.setString(2, password);  
			// assumes unique userid
			ResultSet rst = pstmt.executeQuery();  
			if(rst.next()) { 
				custId = rst.getInt(1); 
				retStr = rst.getString(2);
				if(rst.getInt(3) == 1) 
					admin = true;
			}
		}  
		catch (SQLException ex) {
			out.println(ex);
		} finally {
			closeConnection();
		}	
		
		if(retStr != null) {	
			session.removeAttribute("loginMessage");
			session.setAttribute("authenticatedUser", retStr); 
			session.setAttribute("authId", custId);
			session.setAttribute("isAdmin", admin);
		} else
			session.setAttribute("loginMessage","Could not connect to the system using that username/password.");
		
		return retStr;
	}
%>

