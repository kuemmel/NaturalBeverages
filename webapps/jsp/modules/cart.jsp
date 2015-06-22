<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*,java.text.*,java.io.*,naturalBeverages.*,org.json.simple.*"%>
<html>
<head></head>
<body>
<%
	/**
	 * Receive the products via requestparameters as a json object and iterator over the keys to build the cart and submit it
	 *
	 **/
	//throw new RuntimeException("test");
	String jsonString = request.getParameter("cart");
	JSONObject jsonObject = (JSONObject) JSONValue.parse(jsonString);
	String userId = (String) session.getAttribute("userId");
	out.println(userId);
	Cart cart = new Cart("3",jsonObject);
	out.println(userId+" "+jsonObject+"<br><br>");
	for(Product product : cart.products)
	{
	out.println(product.toString()+"<br>");
}

	/*Set<Object> keySet = jsonObject.keySet();
	Iterator<Object> iterator = keySet.iterator();

	while(iterator.hasNext())
	{
		String key = (String) iterator.next();
		out.println(key+"<br />");
	}*/

%>
</body>
</html>