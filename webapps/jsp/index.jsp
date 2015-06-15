<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*,java.text.*,java.io.*,naturalBeverages.*"%>
<%
	request.setAttribute("pageTitle","Home");
	request.setAttribute("scripts","utils.js");
%>
<jsp:include page="modules/siteHead.jsp" />
<BODY>
<jsp:include page="modules/nav.jsp" />
<div class="container">
	<p>Welcome!</p>
</div>
<jsp:include page="/modules/footer.jsp" />
</BODY>
</HTML>