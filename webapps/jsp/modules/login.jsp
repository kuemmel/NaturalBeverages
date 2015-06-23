<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*,java.text.*,java.io.*,naturalBeverages.*,org.json.simple.*"%>
<%
	request.setAttribute("pageTitle","Login");
	request.setAttribute("scripts","utils.jsp");
%>

<html>
<jsp:include page="siteHead.jsp" />
<body onload="redirect(5000,&quot;../index.jsp&quot;)">
<jsp:include page="nav.jsp" />
<div class="container">
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
			session.setAttribute("floor",resultSet.getString("floor"));
			response.sendRedirect("userSettings.jsp");
		} else
		{
	 		out.println("Invalid password <a href="+request.getContextPath()+"/index.jsp><h5>try again</h5></a>");
		}

	} catch (SQLException e)
	{
		out.println("Error occured. "+e);
	}

%>
</div>
<jsp:include page="footer.jsp" />
</BODY>
</HTML>