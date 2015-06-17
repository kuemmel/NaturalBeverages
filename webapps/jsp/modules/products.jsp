<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*,java.text.*,java.io.*,naturalBeverages.*"%>
<%@ page buffer="none" %>
<%
  request.setAttribute("pageTitle","Products");
  request.setAttribute("scripts","utils.js");
%>
<jsp:include page="siteHead.jsp" />
<BODY class="blue-grey darken-4">
<jsp:include page="nav.jsp" />
<div class="container">
<div class="row">
  <div class="col s12 m12 l12">
    <ul class="tabs z-depth-2 waves-green">
<%
    /**
     * Show products by category in tabs.
     * get products from session to add to 
     *
     **/
    ArrayList<Product> products = new ArrayList<Product>();

    SQLConnection sqlCategoryConnection = new SQLConnection(response.getWriter());
    SQLConnection sqlProductsConnection = new SQLConnection(response.getWriter());
    ResultSet categories = sqlCategoryConnection.selectAllFrom("categories");
    while(categories.next())
    {
      String category = categories.getString("name");
      out.println("    <li class=\"tab col s3\"><a href=\"#"+category+"\">"+category+"</a></li>");
    }
    out.println("    </ul>\n  </div>");
    categories.beforeFirst();

    while(categories.next())
    {
      String category = categories.getString("name");
      ResultSet productContentResultSet = sqlProductsConnection.getProductsByCategory(category);
      out.println("<div id=\""+category+"\" class=\"col s12 waves-green\"> <!-- TAB -------------------->");
      out.println("<ul id=\"list"+category+"\" class=\"containerColor collection \">");
      while(productContentResultSet.next())
      {
        Product product = new Product(productContentResultSet);
        /*
          not easy to read, but easier on the buffer.
          refer to product.java::returnAsHtmlCard() for a more object oriented, but even less elegant solution,
          which is a lot of overhead on the buffer (but way better to read and more refactor friendly(?)).
        */
%>
  <li class="collection-item containerColor">
  <div class="row">
    <!--<div class="col">-->
      <div class="card mainColor z-depth-3 ">
        <div class="row">
          <div class="col">
            <div class="card-image row" style="margin-top:20px;">
              <img src="<%=request.getContextPath()+product.getImagePath()%>" style="max-height:250px;max-width:250px;padding-left:10px;">
            </div>
            <span class="card-title black-text" style="padding-left:20px;"><%=product.getName()%>(<%=product.getAmountPerUnit()%>L)</span>
              <div style="padding-left:20px;"><%=product.getCategoryName()%></div>
          </div>
          <div class="card-content col" >
            <table>
              <tr><td><%=product.isInStock()%></td></tr>
              <tr><td><%=product.getFirm()%></td></tr>
              <tr><td>Price:</td><td><%=product.getPricePerUnit().toString()%></td></tr>
              <tr><td>Refund:</td><td><%=product.getRefundPerUnit().toString()%></td></tr>
              <tr><td>Crate:</td><td><%=product.getPricePerCrate().toString()%>(<%=product.getAmountPerCrate()%>)</td></tr>
              <tr><td>Refund per crate:</td><td><%=product.getRefundPerCrate().toString()%></td></tr>
              <tr><td>current price:</td><td><span placeholder="<%=product.getPricePerUnit().toString()%>" id="priceSpan"><%=product.getPricePerUnit().toString()%></td></tr>
            </table>
          </div>
        </div>
        <div class="row">
          <div class="card-action" >
            <form action="" name="form" method="GET">
              <div class="col" style="width:30%;">
                    <button class="btn waves-effect waves-light col" name=""+"button"+"" type="submit">Add to cart
                 <i class="mdi-content-send right"></i>
                </button>
              </div>
              <div class="col" style="width:70%;">
                <p class="range-field">
                  <input type="range" name ="amount" value="0" class="col" min="1" max="<%=product.getAmountLeft()%>" style="width:100%;" /> <!--style="overflow:hidden";-->
                </p>
              </div>
            </form>
          </div>
        </div>
      </div>
    <!--</div>-->
  </div>
</li>
<%
    }
    out.println("  </ul> \n </div>");
  }
%>

  </div>
</div>
</div>
<jsp:include page="footer.jsp" />
</BODY>
</HTML>
<%
  //sqlCategoryConnection.closeConnection();
  //sqlProductsConnection.closeConnection();
%> 