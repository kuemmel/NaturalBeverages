<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*,java.text.*,java.io.*,naturalBeverages.*"%>
<%
	request.setAttribute("pageTitle","LoggedOut");
	request.setAttribute("scripts","utils.js");
%>
<jsp:include page="modules/siteHead.jsp" />
<BODY>
<jsp:include page="modules/nav.jsp" />
<div class="container">
	<a href="index.jsp">Home</a>
	 <%
	 	session.removeAttribute("userID");

	 	if(session.getAttribute("userID") == null)
	 	{
	 		out.println("You are now logged out. See you soon!");
		}
	 %>
</div>
<jsp:include page="/modules/footer.jsp" />
</BODY>
</HTML>
	 