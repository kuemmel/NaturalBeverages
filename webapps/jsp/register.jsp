<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<HEAD>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<TITLE>Register</TITLE>
  	<meta name="viewport" content="width=device-width, initial-scale=1"/>

 	<link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>
 	<link type="text/css" rel="stylesheet" href="css/style.css">

	<SCRIPT TYPE="text/javascript" language="JavaScript" src="scripts/js/register.jsp" >
	</SCRIPT>
	<SCRIPT TYPE="text/javascript" language="JavaScript" src="scripts/js/utils.js" >
	</SCRIPT>
</HEAD>
<BODY onload="loadFormInput()" class="blue-grey darken-3">

  <!-- jQuery is required by Materialize to function -->
 <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
  <script type="text/javascript" src="scripts/js/materialize.min.js"></script>
  <script type="text/javascript">
    //custom JS code
  </script>

<nav>
	<div class="nav-wrapper brown darken-3 z-depth-1">
  		<a href="#" class="brand-logo brown darken-2 z-depth-1">Natural Beverages</a>
  		<ul id="nav-mobile" class="right hide-on-med-and-down brown darken-2 z-depth-1">
    		<li><a href="index.jsp">Home</a></li>
    		<li><a href="components.html">Products</a></li>
		</ul>
	</div>
</nav>

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