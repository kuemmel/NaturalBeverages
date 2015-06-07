<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<HEAD>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<TITLE>Register</TITLE>
	<SCRIPT TYPE="text/javascript" language="JavaScript" src="scripts/js/register.jsp" >
	</SCRIPT>
	<SCRIPT TYPE="text/javascript" language="JavaScript" src="scripts/js/utils.js" >
	</SCRIPT>
</HEAD>
<BODY onload="loadFormInput()">
	Register here. <a href="index.jsp">Home</a>
	<hr>
	<form method="post" name="form" action="registration.jsp" onsubmit="return(validate(this));">
		Email:
		<input type="text" name="email" value="email" onblur="onBlur(this)" onfocus="onFocus(this)" /> <br />
		Nick:
		<input type="text" name="nick" value="nick" onblur="onBlur(this)" onfocus="onFocus(this)" /> <br />
		Password:
		<input type="text" name="password" value="password" onblur="onBlur(this)" onfocus="onFocus(this)" /> 
		<input type="text" name="repeatPassword" value="repeat password" onblur="onBlur(this)" onfocus="onFocus(this)" /> <br />
		<hr>
		Name:
		<input type="text" name="name" value="name" onblur="onBlur(this)" onfocus="onFocus(this)" /> <br />
		Surname:
		<input type="text" name="surname" value="surname" onblur="onBlur(this)" onfocus="onFocus(this)" /> <br />
		Date Of Birth:
		<input type="text" name="dateOfBirth" value="dateOfBirth" onblur="onBlur(this)" onfocus="onFocus(this)" /> <br />
		Address:
		<input type="text" name="address" value="address" onblur="onBlur(this)" onfocus="onFocus(this)" /> <br />
		Floor:
		<input type="text" name="floor" value="floor" onblur="onBlur(this)" onfocus="onFocus(this)" /> <br />
		ZipCode:
		<input type="text" name="zipCode" value="zipCode" onblur="onBlur(this)" onfocus="onFocus(this)" /> <hr>
		<input type="submit" name="submit" value="register"/>
	</form>
</BODY>
</HTML>