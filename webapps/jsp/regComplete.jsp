<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<HTML>
<HEAD>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<TITLE>Registration Complete</TITLE>
</HEAD>
<BODY>
	 <a href="index.jsp">Home</a>
	 <hr>
	 Registration complete, you can now try to sign in:
	<form method="post" action="login.jsp">
		<input type="text" name="nick" value="name" onblur="onBlur(this)" onfocus="onFocus(this)"/>
		<input type="text" name="password" value="password" onblur="onBlur(this)" onfocus="onFocus(this)" />
		<input type="submit" name="login" value="login" />
	</form>
	<hr>
</BODY>
</HTML>