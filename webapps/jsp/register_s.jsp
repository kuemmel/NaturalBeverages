<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
	request.setAttribute("pageTitle","Register");
	request.setAttribute("scripts","register.jsp utils.js");
%>
<jsp:include page="siteHead.jsp" />
<BODY onload="loadFormInput()" class="blue-grey darken-3">

<div class="container  blue-grey lighten-5">
	<!--<div class="intro brown darken-2 z-depth-1">
	  <h1 class="grey-text text-lighten-5">Natural Beverages</h1>
	</div>-->
 <div class="row">
        <!--<div class="col s12 m6">-->
          <!--<div class="card blue-grey darken-1">-->

            <!--<div class="card-content white-text">-->
              	<!--<span class="card-title">Register</span>-->
				<form class="col s8" method="post" name="form" id="form" action="registration.jsp" onsubmit="return(validate(this));">
					<div class="input-field row s6"> 
						<input type="text" name="email" value="email" onblur="onBlur(this)" onfocus="onFocus(this)" />
					</div>
					<div class="input-field row s6"> 
						<input type="text" name="nick" value="nick" onblur="onBlur(this)" onfocus="onFocus(this)" />
					</div>
					<div class="input-field col s6">
					<input type="text" name="password"  placeholder="password" onblur="onBlur(this)" onfocus="onFocus(this)" /> <!-- value="password"-->
					</div>
					<div class="input-field col s6">
					<input type="text" name="repeatPassword" value="repeat password" onblur="onBlur(this)" onfocus="onFocus(this)" />
					</div>
					<div class="input-field row s6"> 
						<input type="text" name="name" value="name" onblur="onBlur(this)" onfocus="onFocus(this)" />
					</div>
					<div class="input-field row s6"> 
						<input type="text" name="surname" value="surname" onblur="onBlur(this)" onfocus="onFocus(this)" />
					</div>
					<div class="input-field row s6"> 
						<input type="text" name="dateOfBirth" value="dateOfBirth" onblur="onBlur(this)" onfocus="onFocus(this)" />
					</div>
					<div class="input-field row s6"> 
						<input type="text" name="address" value="address" onblur="onBlur(this)" onfocus="onFocus(this)" />
					</div>
					<div class="input-field row s6"> 
						<input type="text" name="floor" value="floor" onblur="onBlur(this)" onfocus="onFocus(this)" />
					</div>
					<div class="input-field row s6"> 
						<input type="text" name="zipCode" value="zipCode" onblur="onBlur(this)" onfocus="onFocus(this)" />
					</div>
				</form>
			</div>
            </div>
            <!--<div class="card-action">
				<button class="btn waves-effect waves-light" type="submit" name="action" onclick="document.getElementById('form').submit();"> Submit
	    			<i class="mdi-content-send right"></i>
	  			</button>
            </div>
          </div>
        </div>-->
      </div>
	</div>
</div>
</BODY>
</HTML>