<%@page import="java.util.*,java.sql.*,java.io.*,naturalBeverages.*"%>
<%
	SQLConnection sqlConnection = new SQLConnection(response.getWriter());
	String email = request.getParameter("email");
	String password = sqlConnection.encryptMD5(request.getParameter("password"));
	
	try
	{
		ResultSet resultSet = sqlConnection.sqlQuery("select * from users where email=\""
			+email+"\" and password = \""
			+password+"\";");

		if(resultSet.next())
		{
			session.setAttribute("userID",resultSet.getString("id"));
			response.sendRedirect("userSettings.jsp");
		} else
		{
	 		out.println("Invalid password <a href="+request.getContextPath()+"/index.jsp>try again</a>");
		}

	} catch (SQLException e)
	{
		out.println("Error occured. "+e);
	}

%>
asdasdasd