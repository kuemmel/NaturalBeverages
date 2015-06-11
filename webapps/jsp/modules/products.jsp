<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*,java.text.*,java.io.*,naturalBeverages.*"%>
<%
	request.setAttribute("pageTitle","Products");
	request.setAttribute("scripts","utils.js");
%>
<jsp:include page="siteHead.jsp" />
<BODY class="blue-grey darken-4">
<jsp:include page="nav.jsp" />
<div class="row">
  <div class="col s12">
  	<ul class="tabs z-depth-2">
  	<!--<li class="tab col s3"><a class="active" href="#all">all</a></li>-->
  	<%
  	/**
  	 * Show products by category in tabs.
  	 *
  	 *
  	 **/
  	SQLConnection sqlCategoryConnection = new SQLConnection(response.getWriter());
  	SQLConnection sqlProductsConnection = new SQLConnection(response.getWriter());
  	ResultSet categories = sqlCategoryConnection.selectAllFrom("categories");
  	while(categories.next())
  	{
  		String category = categories.getString("name");
  		out.println("    <li class=\"tab col s3\"><a href=\"#"+category+"\">"+category+"</a></li>\n");
  	}
  	out.println("</ul>\n</div></div> \n");
  	out.println("<div class=\"container\">\n");
  	categories.beforeFirst();
  	while(categories.next())
  	{
  		String category = categories.getString("name");
		ResultSet productContentResultSet = sqlProductsConnection.getProductsByCategory(category);
		out.println("<div id=\""+category+"\" class=\"col s12\"> <!-- TAB --------------------> \n");
		while(productContentResultSet.next())
		{
			Product product = new Product(productContentResultSet);
			out.println(product.returnAsHtmlCard(request.getContextPath()));
		}
  		out.println("</div>");
	}
	//sqlCategoryConnection.closeConnection();
	//sqlProductsConnection.closeConnection();

  	%>
</div>
</div>
<jsp:include page="footer.html" />
</BODY>
</HTML>