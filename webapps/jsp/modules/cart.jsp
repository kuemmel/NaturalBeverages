<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*,java.text.*,java.io.*,naturalBeverages.*,javax.json.*"%>
<html>
<head></head>
<body>
<%
	/**
	 * Receive the products via requestparameters and map over them and submit them to the database
	 *
	 **/
	//throw new RuntimeException("test");
	String cart = request.getParameter("cart");
	
	JsonReader jsonReader = Json.createReader(cart);
	JsonObject object = jsonReader.readObject();
	out.println("hello");
	//out.println(object.getString("form:STPAULI Brauerei:Bavaria"));
	



%>
</body>
</html>