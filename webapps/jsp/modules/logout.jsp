<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*,java.text.*,java.io.*,naturalBeverages.*"%>
<%
	request.setAttribute("pageTitle","LoggedOut");
	request.setAttribute("scripts","utils.jsp");
%>
<jsp:include page="siteHead.jsp" />
<BODY>
<jsp:include page="nav.jsp" />
<div class="container">
	<a href="${pageContext.request.contextPath}/index.jsp">Home</a>
	 <%
	 	session.removeAttribute("userID");
	 	session.removeAttribute("floor");
	 	//session.removeAttribute("cart");

	 	if(session.getAttribute("userID") == null)
	 	{
	 		out.println("<p>You are now logged out. See you soon!</p>");
		}
	 %>
</div>
<jsp:include page="footer.jsp" />
</BODY>
</HTML>
	 