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
<div class="container  blue-grey lighten-5">
<!-- tabs -->

<%

  SQLConnection sqlConnection = new SQLConnection(response.getWriter());
  ResultSet resultSet = sqlConnection.getProducts();


  while(resultSet.next())
  {
    Product product = new Product(resultSet);
    out.println(product.returnAsHtmlCard());
  }
%>

</BODY>
</HTML>