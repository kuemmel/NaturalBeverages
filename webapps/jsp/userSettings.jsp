<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*,java.io.*,naturalBeverages.*"%>
<%
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
<!DOCTYPE html>
<html>
<HEAD>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<TITLE>User Settings</TITLE>
	<SCRIPT TYPE="text/javascript" language="JavaScript" src="scripts/js/userSettings.jsp" >
	</SCRIPT>
	<SCRIPT TYPE="text/javascript" language="JavaScript" src="scripts/js/utils.js" >
	</SCRIPT>

</HEAD>
<BODY onload="loadFormInput()">
	User Settings <a href="index.jsp">Home</a>
	<hr>
	<form method="post" name="form" action="userSettingsAltered.jsp" onsubmit="return(validate(this));">
		Email:
		<input type="text" name="email" value="<%=email%>" onblur="onBlur(this)" onfocus="onFocus(this)" />
		<input type="text" name="repeatEmail" value="repeat email" onblur="onBlur(this)" onfocus="onFocus(this)" /> <br />
		Nick:
		<input type="text" name="nick" value="<%=nick%>" onblur="onBlur(this)" onfocus="onFocus(this)" /> <br />
		Old password:
		<input type="text" name="oldPassword" value="old password" onblur="onBlur(this)" onfocus="onFocus(this)" /> 
		Password:
		<input type="text" name="password" value="new password" onblur="onBlur(this)" onfocus="onFocus(this)" /> 
		<input type="text" name="repeatPassword" value="repeat password" onblur="onBlur(this)" onfocus="onFocus(this)" /> <br />
		<hr>
		Name:
		<input type="text" name="name" value="<%=name%>" onblur="onBlur(this)" onfocus="onFocus(this)" /> <br />
		Surname:
		<input type="text" name="surname" value="<%=surname%>" onblur="onBlur(this)" onfocus="onFocus(this)" /> <br />
		Address:
		<input type="text" name="address" value="<%=address%>" onblur="onBlur(this)" onfocus="onFocus(this)" /> <br />
		Floor:
		<input type="text" name="floor" value="<%=floor%>" onblur="onBlur(this)" onfocus="onFocus(this)" /> <br />
		ZipCode:
		<input type="text" name="zipCode" value="<%=zipCode%>" onblur="onBlur(this)" onfocus="onFocus(this)" /> <hr>
		<input type="submit" name="submit" value="submit"/>
	</form>
		<form method="post" name="aboort" action="index.jsp">
		<input type="submit" name="abbort" value="abbort" />
	</form>
	<hr>
	<form method="post" name="logOut" action="loggedOut.jsp">
		<input type="submit" name="submit" value="logout" />
	</form>

</BODY>
</HTML>