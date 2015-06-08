<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*,java.io.*,naturalBeverages.*"%>
<%
	request.setAttribute("pageTitle","Settings");
	request.setAttribute("scripts","utils.js userSettings.jsp");

	String email = "";
	String nick = "";
	String name = "";
	String surname = "";
	String birthString = "";
	String address = "";
	int floor = 0;
	int zipCode = 0;
	/**
	 * Get the user information to work on
	 **/
	SQLConnection sqlConnection = new SQLConnection(response.getWriter());
	String userId = (String) session.getAttribute("userID");
	try
	{
		ResultSet resultSet = sqlConnection.selectAllFromWhere("users","id",userId);
		if (resultSet.next())
		{
		    email       = resultSet.getString("email");
		    nick        = resultSet.getString("nick");
		    name        = resultSet.getString("name");
		    surname     = resultSet.getString("surname");
		    address     = resultSet.getString("address");
		    floor       = Integer.parseInt(resultSet.getString("floor"));
		    zipCode     = Integer.parseInt(resultSet.getString("zipCode"));
		}
	} catch (SQLException e)
	{
		out.println("Error occured. "+e);
	}

%>
<!--head-->
<jsp:include page="siteHead.jsp" />
<BODY onload="loadFormInput()" class="blue-grey darken-4">
<!-- navbar -->
<jsp:include page="nav.jsp" />
<div class="container  blue-grey lighten-5">
	 <div class="row">
    <form class="col s12" id="form" method="post" name="form" action="modules/registration.jsp" onsubmit="return(validate());"> <!-- (validate(this))-->
      <div class="row">
        <div class="input-field col s6">
          <input id="name" value="<%=name %>" name="name" type="text" class="validate">
        </div>
        <div class="input-field col s6">
          <input id="surname" value="<%=surname %>" name="surname" type="text" class="validate">
        </div>
      </div>
      <div class="row">
        <div class="input-field col s6">
          <input id="password" placeholder="password" name="password" type="password" class="validate">
        </div>
        <div class="input-field col s6">
          <input id="repeatPassword" placeholder="repeatPassword" name="repeatPassword" type="password" class="validate">
        </div>
      </div>
      <div class="row">
        <div class="input-field col s12">
          <input id="email" value="<%=email %>" name="email" type="email" class="validate">
        </div>
      </div>
      <div class="row">
        <div class="input-field col s12">
          <input id="nick" value="<%=nick %>" name="nick" type="text" class="validate">
        </div>
      </div>
      <div class="row">
        <div class="input-field col s12">
          <input id="floor" value="<%=floor %>" name="floor" type="text" class="validate">
        </div>
      </div>
      <div class="row">
        <div class="input-field col s12">
          <input id="zipCode" value="<%=zipCode %>" name="zipCode" type="text" class="validate">
        </div>
      </div>
      <div class="row">
        <div class="input-field col s12">
          <input id="address" value="<%=address %>" name="address" type="text" class="validate">
        </div>
      </div>
      <div class="row">
      	<!--<input class="btn waves-effect waves-light" type="submit" name="login" value=""/>--> 
      	<button class="btn waves-effect waves-light" type="submit" name="action" onsubmit="return(validate());">Submit
   		  <i class="mdi-content-send right"></i>
        </button>
  	  </div>
      </div>
    </form>
  </div>
</div>
</BODY>
</HTML>