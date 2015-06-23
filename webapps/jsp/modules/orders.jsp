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
  <ul class="collection">
	 <%
	 /**
	  * Shows all orders by the user.
	  **/
 	String userId = (String) session.getAttribute("userID");
 	SQLConnection sqlConnection = new SQLConnection(response.getWriter());
  SQLConnection orderConnection = new SQLConnection(response.getWriter());
 	try
 	{
 		ResultSet resultSet = sqlConnection.getOrdersFromUser(userId);

 		while(resultSet.next())
 		{
 		  String orderId = resultSet.getString("id");
      java.sql.Date orderDate = resultSet.getDate("dateOfOrder");
      ResultSet orderResult = orderConnection.getBoughtGoodsFromOrderId(orderId);
%>
    <li class="collection-item">
      <h5>Order from <%=orderDate%></h5>
        <table class="hoverable responsive-table">
          <thead>
            <tr>
                <th data-field="name">Item Name</th>
                <th data-field="firm">Firm</th>
                <th data-field="price">Item Price</th>
                <th data-field="amount">Bought amount</th>
            </tr>
          </thead>
          <tbody>
<%
      while(orderResult.next())
      {
      Product product = new Product(orderResult);
      product.setAmount(orderResult.getInt("boughtgoods.amount"));
%>
            <tr>
              <td><%=product.getName()%></td>
              <td><%=product.getFirm()%></td>
              <td><%=product.getPricePerUnit()%></td>
              <td><%=product.getBoughtAmount()%></td>
            </tr>
<%
      }
%>
          </tbody>
        </table>
    </li>
<%
    } 
 	} catch(Exception e)
 	{
 		out.println("Have you really an order on your way? Contact an admin if so! "+e);
 	}
 	
%>
  </ul>
</div>
<jsp:include page="footer.jsp" />
</BODY>
</HTML>
	 