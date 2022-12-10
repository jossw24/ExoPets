<%@ page import="java.sql.*" %>
<%@ page import="java.util.Scanner" %>
<%@ page import="java.io.File" %>
<%@ include file="jdbc.jsp" %>

<%

getConnection();
String fileName = "/usr/local/tomcat/webapps/shop/ddl/orderdb_sql.ddl";

try
{
    // Create statement
    Statement stmt = con.createStatement();
    Scanner scanner = new Scanner(new File(fileName));
    // Read commands separated by ;
    scanner.useDelimiter(";");
    while (scanner.hasNext())
    {
        String command = scanner.next();
        if (command.trim().equals("") || command.trim().equals("go"))
            continue;
        // out.print(command+"<br>");        // Uncomment if want to see commands executed
        try
        {
            stmt.execute(command);
        }
        catch (Exception e)
        {	// Keep running on exception.  This is mostly for DROP TABLE if table does not exist.
            out.println(e+"<br>");
        }
    }	 
    scanner.close();
    response.sendRedirect("admin.jsp");
    session.setAttribute("databaseConfirmation","Database has been reset");
    
}
catch (Exception e)
{
    out.print(e);
    session.setAttribute("databaseConfirmation","Issue with loading Database, could not reset");
} finally { 
    closeConnection();
}
%>