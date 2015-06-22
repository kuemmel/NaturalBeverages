<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*,java.text.*,java.io.*,naturalBeverages.*"%>
<%
	request.setAttribute("pageTitle","Home");
	request.setAttribute("scripts","utils.jsp");
%>
<jsp:include page="modules/siteHead.jsp" />
<BODY>
<jsp:include page="modules/nav.jsp" />
<div class="container about">
	<div style="margin-bottom:30px;">
  	<h4 class="center-align" >Welcome</h4>
  	<h5 class="center-align">Buy fresh drinks, organically grown, handcrafted! </h5>
  </div>
  <div class="slider">
    <ul class="slides">
<%
/**
 * print three products (hardcoded on purpose)
 **/
  SQLConnection sqlConnection = new SQLConnection(response.getWriter());
  Product[] products = {null,null,null};
  ResultSet resultSet = sqlConnection.getProductByNameAndFirm("Bavaria","STPAULI Brauerei");resultSet.next();
  //out.println(resultSet.getString("firm"));
  %>
       <li>
        <img src="<%=request.getContextPath()+resultSet.getString("imagePath")%>" >
        <div class="caption center-align">
          <h3><%=resultSet.getString("name")%></h3>
          <h5 class="light grey-text text-lighten-3"><%=" by "+resultSet.getString("firm")%></h5>
        </div>
      </li>
<%
  resultSet.close();
  resultSet = sqlConnection.getProductByNameAndFirm("Islay Haze 18 years","Haze's");resultSet.next();
  %>
       <li>
        <img src="<%=request.getContextPath()+resultSet.getString("imagePath")%>" >
        <div class="caption center-align">
          <h3><%=resultSet.getString("name")%></h3>
          <h5 class="light grey-text text-lighten-3"><%=" by "+resultSet.getString("firm")%></h5>
        </div>
      </li>
<%
  resultSet.close();
  resultSet = sqlConnection.getProductByNameAndFirm("Lancestor Ale","Lancastors");resultSet.next();
  %>
       <li>
        <img src="<%=request.getContextPath()+resultSet.getString("imagePath")%>" >
        <div class="caption center-align">
          <h3><%=resultSet.getString("name")%></h3>
          <h5 class="light grey-text text-lighten-3"><%=" by "+resultSet.getString("firm")%></h5>
        </div>
      </li>
    </ul>
  </div>  
  <div class="row">
    <div class="col s6 m6 l6">
      <h5>What to expect?</h5>
      <blockquote class="blue-grey darken-1">
        <p>Get fresh drinks and fairly and squarly made products. From our tea to our finest scotch, we buy from organically and responsibly producing manufacturers</p>
        <p>We don't use pesticides, we don't exploit our producers</p>
        <p>We try to protect the environment, we intodruce our foreign producers to education</p>
   	  </blockquote>
    </div>
    <div class="col s6 m6 l6">
      <h5>Sign Up!</h5>
      <div class="card blue-grey darken-1">
        <div class="card-content white-text">
          <img src="${pageContext.request.contextPath}/images/beerIcon.png" width="64" height="64">
          <p>Get freshly made juicdes, coffee, mead, beer, whiskey and much more on Natural Beverages!</p>
        </div>
        <div class="card-action">
          <a href="${pageContext.request.contextPath}/modules/register_new.jsp">Sign Up</a>
          <a href="${pageContext.request.contextPath}/modules/products.jsp">Browse Products</a>
        </div>
      </div>
    </div>
  </div>
</div>
</BODY>
<jsp:include page="/modules/footer.jsp" />
</HTML>