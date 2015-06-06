<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<HTML>
<HEAD>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<TITLE>Home</TITLE>
	<SCRIPT TYPE="text/javascript">

/**
 * Delete and re-insert default values into fields
 * also change form type to password in the password field
 **/
function onBlur(form)
{
	if(form.value === '')
	{
		form.value = form.defaultValue;
	}
}
function onFocus(form)
{
	if (form.name == "password")
	{
		form.type = "password";
	}

	if(form.value === form.defaultValue)
	{
		form.value = '';
	}
}

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