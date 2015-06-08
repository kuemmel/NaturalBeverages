<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*,java.text.*,java.io.*,naturalBeverages.*"%>
<%
	request.setAttribute("pageTitle","Home");
	request.setAttribute("scripts","utils.js");
%>
<!--head-->
<jsp:include page="modules/siteHead.jsp" />
<BODY class="blue-grey darken-4">
<!-- navbar -->
<jsp:include page="modules/nav.jsp" />
<div class="container  blue-grey lighten-5">
	<div class="row">
		Welcome!
	</div>
</div>
</BODY>
</HTML>