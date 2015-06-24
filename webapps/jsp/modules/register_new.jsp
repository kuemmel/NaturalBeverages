<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*,java.text.*,java.io.*,naturalBeverages.*"%>
<%
	request.setAttribute("pageTitle","Register");
	request.setAttribute("scripts","utils.jsp register.jsp");
%>
<!--
 PRAXI Problems: register.jsp is chached for weeks now on the production server. action="modules/registration.jsp"
 just wont go away, so I added this file, which is basically the same file (in the hope that this won't be cached.)
-->
<!--head-->
<jsp:include page="siteHead.jsp" />
<BODY onload="loadFormInput()" class="blue-grey darken-4">
<!-- navbar -->
<jsp:include page="nav.jsp" />
<div class="container  blue-grey lighten-5">
	 <div class="row">
    <form id="registerForm" class="col s12"  method="post" name="registerForm" action="${pageContext.request.contextPath}/modules/registration.jsp" onsubmit="return(validate());"> <!-- (validate(this))-->
      <div class="row">
        <div class="input-field col s6">
          <input id="name" name="name" type="text" class="validate">
          <label class="active" for="name">First Name</label>
        </div>
        <div class="input-field col s6">
          <input id="surname" name="surname" type="text" class="validate">
          <label class="active" for="surname">Last Name</label>
        </div>
      </div>
      <div class="row">
        <div class="input-field col s6">
          <input id="password" name="password" type="password" class="validate">
          <label class="active" for="password">Password</label>
        </div>
        <div class="input-field col s6">
          <input id="repeatPassword" name="repeatPassword" type="password" class="validate">
          <label class="active" for="repeatPassword">Repeat password</label>
        </div>
      </div>
      <div class="row">
        <div class="input-field col s6">
          <input id="email" name="email" type="email" data-error="That's not an email" class="validate">
          <label class="active" for="email">Email</label>
        </div>
        <div class="input-field col s6">
          <input id="nick" name="nick" type="text" class="validate">
          <label class="active" for="nick">Nick</label>
        </div>
      </div>
      <div class="row">
        <div class="input-field col s6">
          <input id="dateOfBirth" name="dateOfBirth" type="date" class="datepicker">
           <label class="active" for="dateOfBirth">Date Of Birth</label>
        </div>
        <div class="input-field col s6">
          <input id="floor" name="floor" type="text" class="validate">
          <label class="active" for="floor">Floor</label>
        </div>
      </div>
      <div class="row">
        <div class="input-field col s6">
          <input id="address" name="address" type="text" class="validate">
          <label class="active" for="address">Address</label>
        </div>
        <div class="input-field col s6">
          <input id="zipCode" name="zipCode" type="text" class="validate">
          <label class="active" for="zipCode">Zipcode</label>
        </div>
      </div>
      <div class="row">
      	<!--<input class="btn waves-effect waves-light" type="submit" name="login" value=""/>--> 
      	<!--<button class="btn waves-effect waves-light" onclick="submit(this);">Submit</a>-->
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