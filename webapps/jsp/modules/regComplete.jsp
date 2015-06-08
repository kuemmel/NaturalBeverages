<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*,java.text.*,java.io.*,naturalBeverages.*"%>
<%
	request.setAttribute("pageTitle","Registration complete");
	request.setAttribute("scripts","utils.js");
%>
<!--head-->
<jsp:include page="siteHead.jsp" />
<BODY class="blue-grey darken-4">
<!-- navbar -->
<jsp:include page="nav.jsp" />
<div class="container  blue-grey lighten-5">
	<div class="row">
		<h5>Registration complete, you can now try to sign in.</h5>
	</div>
</div>
</BODY>
</HTML>