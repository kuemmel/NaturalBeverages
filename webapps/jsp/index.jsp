<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<HTML>
<HEAD>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<TITLE>Home</TITLE>
	<SCRIPT TYPE="text/javascript" language="JavaScript" src="scripts/js/utils.js" >
	</SCRIPT>
</HEAD>
<BODY>
	<form method="post" action="login.jsp">
		Sign in: 
		<input type="text" name="email" value="email" onblur="onBlur(this)" onfocus="onFocus(this)"/>
		<input type="text" name="password" value="password" onblur="onBlur(this)" onfocus="onFocus(this)" />
		<input type="submit" name="login" value="login" />
	</form> <a href="register.jsp">Sign Up</a>
	<hr>
</BODY>
</HTML>