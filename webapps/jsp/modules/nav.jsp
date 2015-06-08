<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Dropdown Structure -->
<ul id="siteNavigationDropdown" class="dropdown-content">
  <li><a href="products.jsp">Products</a></li>
  <li><a href="index.jsp">Index</a></li>
  <li><a href="search.jsp">Search</a></li>
  <li class="divider"></li>
  <li><a href="cart.jsp">Cart</a></li>
  <li><a href="userSettings.jsp">UserSettings</a></li>
</ul>
<!--navbar for every site -->
<nav class="brown darken-3 z-depth-2">
	<div class="nav-wrapper">
    <div class="row">
  		<div class="col">
        <a href="siteHead.jsp" class="brand-logo">
          Natural Beverages<i class="mdi-content-send right"> <%=request.getAttribute("pageTitle")%></i>
        </a>
      </div><div clas="divider" />
      <div>
		  <ul class="right hide-on-med-and-down">
        <li>
          <div class="input-field">
            <input id="search" type="search" required>
            <label for="search"><i class="mdi-action-search"></i></label>
            <i class="mdi-navigation-close"></i>
          </div>
        </li>
        <li>
          <a class="dropdown-button" href="#!" data-activates="siteNavigationDropdown" data-constrainwidth="false" data-hover="true">
            <i class="mdi-action-list right"></i>
          </a>
        </li>
		  </ul>
    </div>
	</div>
</div>
</nav>