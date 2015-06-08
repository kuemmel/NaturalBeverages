<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
  Boolean loggedIn = false;
  if(session.getAttribute("userID") != null)
  {
    loggedIn = true;
  }
  out.println(session.getAttribute("userID"));
%>

<!-- Dropdown Structure -->
<ul id="siteNavigationDropdown" class="dropdown-content s3 m5 l5">
  <li><a href="${pageContext.request.contextPath}/modules/products.jsp">Products</a></li>
  <li><a href="${pageContext.request.contextPath}/index.jsp">Index</a></li>
  <li><a href="${pageContext.request.contextPath}/modules/search.jsp">Search</a></li>
  <li class="divider"></li>
  <li><a href="${pageContext.request.contextPath}/modules/register.jsp">Sign Up</a></li>
  <li><a href="${pageContext.request.contextPath}/modules/cart.jsp">Cart</a></li>
  <li><a href="${pageContext.request.contextPath}/modules/userSettings.jsp">UserSettings</a></li>
</ul>
<!--navbar for every site -->
<nav class="brown darken-3 z-depth-2">
	<div class="nav-wrapper">
    <div class="row">
  		<div class="col">
        <a href="${pageContext.request.contextPath}/index.jsp" class="brand-logo">
          Natural Beverages<i class="mdi-content-send right"> <%=request.getAttribute("pageTitle")%></i>
        </a>
      </div><div clas="divider" />
      <div>
		  <ul class="right hide-on-med-and-down">
        <form class="col <%if(loggedIn)out.println("hide");%>" id="loginForm" method="post" name="loginForm" action="${pageContext.request.contextPath}/modules/login.jsp">
          <li>
            <div class="input-field col">
              <input name="email" placeholder="email" type="email" class="validate">
            </div>
          </li>      
          <li>
            <div class="input-field col">
              <input name="password" placeholder="password" type="password" class="validate\">
            </div>
          </li>
        </form>
        <li><a href="${pageContext.request.contextPath}/modules/logout.jsp"><i class="mdi-action-exit-to-app <%if(!loggedIn)out.println("hide");%>"></i></a></li>
        <li>
          <a class="dropdown-button" href="#!" data-activates="siteNavigationDropdown">
            <i class="mdi-action-list right"></i>
          </a>
        </li>
		  </ul>
    </div>
	</div>
</div>
</nav>
<div class="row">
<%
if (request.getAttribute("pageTitle") == "Home")
{
  out.println("<img class=\"responsive-img\" src=\""+request.getContextPath()+"/pictures/banner.png\">");
} else
{
  out.println("<img class=\"responsive-img\" src=\""+request.getContextPath()+"/pictures/bannerFlat.png\">");
}
%>
</div>