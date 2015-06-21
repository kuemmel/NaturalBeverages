<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
  Boolean loggedIn = false;
  if(session.getAttribute("userID") != null)
  {
    loggedIn = true;
  }
%>
<!-- Dropdown Structure -->
<ul id="siteNavigationDropdown" class="dropdown-content s5 m5 l5">
  <li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
  <li><a href="${pageContext.request.contextPath}/modules/products.jsp">Products</a></li>
  <li class="divider"></li>
  <li><a href="${pageContext.request.contextPath}/modules/register.jsp" class="<%if(loggedIn)out.println("hide");%>">Sign Up</a></li>
  <li><a class="modal-trigger <%if(!loggedIn)out.println("hide");%>" href="#modal1" onclick="setCartDiv()">Cart</a></li>
  <li><a href="${pageContext.request.contextPath}/modules/userSettings.jsp" class="<%if(!loggedIn)out.println("hide");%>">Settings</a></li>
  <li><a href="${pageContext.request.contextPath}/modules/logout.jsp" class="<%if(!loggedIn)out.println("hide");%>">Log out</a></li>
</ul>
<!--navbar for every site -->
<nav class="nav_over z-depth-3">
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
        <li><a href="${pageContext.request.contextPath}/modules/logout.jsp" class="<%if(!loggedIn)out.println("hide");%>">Log Out<i class="mdi-action-exit-to-app right"></i></a></li>
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
<img class="responsive-img z-depth-2" src="${pageContext.request.contextPath}/images/bannerFlatFlat.png" />