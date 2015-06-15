<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*,java.text.*,java.io.*,naturalBeverages.*"%>
<%
	request.setAttribute("pageTitle","Products");
	request.setAttribute("scripts","utils.js");
%>
<!--head-->
<jsp:include page="siteHead.jsp" />
<BODY class="blue-grey darken-4">
<!-- navbar -->
<jsp:include page="nav.jsp" />
<div class="container">
<!-- tabs -->

<div class="row"
  <div class="col s12">
  	<ul class="tabs">
  	<!--<li class="tab col s3"><a class="active" href="#all">all</a></li>-->
  	<%
  	/**
  	 * Show products by category in tabs.
  	 * First get all the categories, save the tabnames
  	 * Then get the content part
  	 * and lastly print.
  	 *
  	 *
  	 **/


  	String tabDefinition = "";
  	String tabContent = "";
  	SQLConnection sqlCategoryConnection = new SQLConnection(response.getWriter());
  	SQLConnection sqlProductsConnection = new SQLConnection(response.getWriter());
  	ResultSet categories = sqlCategoryConnection.selectAllFrom("categories");
  	while(categories.next())
  	{
  		String category = categories.getString("name");
  		tabDefinition += "    <li class=\"tab col s3\"><a href=\"#"+category+"\">"+category+"</a></li>\n";


		ResultSet productContentResultSet = sqlProductsConnection.getProductsByCategory(category);
		tabContent += "<div id=\""+category+"\" class=\"col s12\"> <!-- TAB --------------------> \n";
		while(productContentResultSet.next())
		{
			Product product = new Product(productContentResultSet);
			String currentProduct = product.returnAsHtmlCard(request.getContextPath());
			tabContent += currentProduct;
		}
		tabContent += "</div>\n";
  		
	}
	out.println(tabDefinition);
	out.println("</ul>\n</div> \n");
	out.println("<!-------content------>"+tabContent.length());
	out.print(tabContent);
	sqlCategoryConnection.closeConnection();
	sqlProductsConnection.closeConnection();

  	%>
</div>

<jsp:include page="footer.html" />
</BODY>
</HTML>