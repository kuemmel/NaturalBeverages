<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*,java.text.*,java.io.*,naturalBeverages.*"%>

<%
  Cart cart = (Cart) session.getAttribute("cart");
  if(cart != null)
  {
  	out.println(cart.returnAsHtmlTable());
  } else
  {
  	out.println("<b> No products added yet</b>");
  }
%>