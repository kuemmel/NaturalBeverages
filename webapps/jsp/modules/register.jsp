<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*,java.text.*,java.io.*,naturalBeverages.*"%>
<%
	request.setAttribute("pageTitle","Register");
	request.setAttribute("scripts","utils.js register.jsp");
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
          <input id="name" name="name" type="text" class="validate">
          <label for="name">First Name</label>
        </div>
        <div class="input-field col s6">
          <input id="surname" name="surname" type="text" class="validate">
          <label for="surname">Last Name</label>
        </div>
      </div>
      <div class="row">
        <div class="input-field col s6">
          <input id="password" name="password" type="password" class="validate">
          <label for="password">Password</label>
        </div>
        <div class="input-field col s6">
          <input id="repeatPassword" name="repeatPassword" type="password" class="validate">
          <label for="repeatPassword">Repeat password</label>
        </div>
      </div>
      <div class="row">
        <div class="input-field col s12">
          <input id="email" name="email" type="email" class="validate">
          <label for="email">Email</label>
        </div>
      </div>
      <div class="row">
        <div class="input-field col s12">
          <input id="nick" name="nick" type="text" class="validate">
          <label for="nick">Nick</label>
        </div>
      </div>
      <div class="row">
        <div class="input-field col s12">
          <input id="dateOfBirth" name="dateOfBirth" type="date" class="datepicker">
        </div>
      </div>
      <div class="row">
        <div class="input-field col s12">
          <input id="floor" name="floor" type="text" class="validate">
          <label for="floor">Floor</label>
        </div>
      </div>
      <div class="row">
        <div class="input-field col s12">
          <input id="zipCode" name="zipCode" type="text" class="validate">
          <label for="zipCode">Zipcode</label>
        </div>
      </div>
      <div class="row">
        <div class="input-field col s12">
          <input id="address" name="address" type="text" class="validate">
          <label for="address">Address</label>
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