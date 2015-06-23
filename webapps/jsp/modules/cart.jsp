<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*,java.text.*,java.io.*,naturalBeverages.*,org.json.simple.*"%>
<%
	request.setAttribute("pageTitle","cart");
	request.setAttribute("scripts","utils.jsp");
%>

<html>
<jsp:include page="siteHead.jsp" />
<body onload="redirect(5000,&quot;../index.jsp&quot;)">
<jsp:include page="nav.jsp" />
<div class="container">
<%
	/**
	 * Receive the products via requestparameters as a json object and iterator over the keys to build the cart and submit it
	 *
	 **/
	//throw new RuntimeException("test");
	String jsonString = request.getParameter("cart");
	JSONObject jsonObject = (JSONObject) JSONValue.parse(jsonString);
	String userId = (String) session.getAttribute("userID");
	Cart cart = new Cart(userId,jsonObject);
	cart.setOrder();
	out.println("<h4>Order sent. The order is on its way to your home! Meanwhile you can check that on your user page!</h4>");

	/*Set<Object> keySet = jsonObject.keySet();
	Iterator<Object> iterator = keySet.iterator();

	while(iterator.hasNext())
	{
		String key = (String) iterator.next();
		out.println(key+"<br />");
	}*/

%>
</div>
<jsp:include page="footer.jsp" />
</BODY>
</HTML>