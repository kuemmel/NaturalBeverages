<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<HTML>
<HEAD>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<TITLE>Registration Complete</TITLE>
	<SCRIPT TYPE="text/javascript" language="JavaScript" src="scripts/js/utils.js" >
	</SCRIPT>
</HEAD>
<BODY>
	 <a href="index.jsp">Home</a>
	 <hr>
	 <%
	 	session.removeAttribute("userID");

	 	if(session.getAttribute("userID") == null)
	 	{
	 		out.println("You are now logged out. See you soon.");
		}
	 %>
	</form>
	<hr>
</BODY>
</HTML>