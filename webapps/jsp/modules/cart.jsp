<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*,java.text.*,java.io.*,naturalBeverages.*,java.util.Map"%>
<html>
<head></head>
<body>
<%
	/**
	 * Receive the products via requestparameters and map over them and submit them to the database
	 *
	 **/

	Map <String, String[]> parameters = request.getParameterMap();
	for(String parameter : parameters.keySet())
	{
		if(parameter.toLowerCase().startsWith("key"))
		{
			String[] values = parameters.get(parameter);
			for(String value : values) out.print(value);
			println("<br />");
		}

	}
}



%>
</body>
</html>