<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*,java.text.*,java.io.*,naturalBeverages.*"%>

<%
  Cart cart = session.getParameter("cart");
  assert cart;
  out.println(cart.returnAsHtmlTable());
%>