<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*,java.text.*,java.io.*,naturalBeverages.*"%>
<%
	request.setAttribute("pageTitle","Orders");
	request.setAttribute("scripts","utils.jsp");
%>
<jsp:include page="siteHead.jsp" />
<BODY>
<jsp:include page="nav.jsp" />
<div class="container">
	<a href="${pageContext.request.contextPath}/index.jsp">Home</a>
	 <%

	 /**
	  * Shows all orders by the user.
	  **/
 	String userId = session.getAttribute("userID");
 	SQLConnection sqlConnection = new SQLConnection(out);
 	ArrayList<String> orders = new ArrayList<>();
 	try
 	{
 		ResultSet resultSet = sqlConnection.getOrdersFromUser(userId);

 		while(resultSet.next())
 		{
 			orders.add(resultSet.getString("id"));
 			
 		}

 	} catch(Exception e)
 	{
 		out.println("Have you really an order on your way? Contact an admin if so! "+e);
 	}


	for(String orderId : orders)
	{
		sqlConnection.getBoughtGoodsFromOrderId(orderId);

%>

      <table>
        <thead>
          <tr>
              <th data-field="date">Date</th>
              <th data-field="name">Item Name</th>
              <th data-field="price">Item Price</th>
          </tr>
        </thead>

        <tbody>
          <tr>
            <td>Alvin</td>
            <td>Eclair</td>
            <td>$0.87</td>
          </tr>
          <tr>
            <td>Alan</td>
            <td>Jellybean</td>
            <td>$3.76</td>
          </tr>
          <tr>
            <td>Jonathan</td>
            <td>Lollipop</td>
            <td>$7.00</td>
          </tr>
        </tbody>
      </table>
            





<%
 

 	
	 %>
</div>
<jsp:include page="footer.jsp" />
</BODY>
</HTML>
	 