<%@page import="java.util.regex.*"%>
<%
String s = request.getRequestURI().toString();
Pattern p = Pattern.compile("/");
Matcher m = p.matcher(s);
String[] result =  p.split(s);
%>
<iframe src="http://praxi.mt.haw-hamburg.de:8081/<%=result[1]%>/" style="border:0px #FFFFFF none;" name="compile" scrolling="auto" frameborder="0" align=aus marginheight="0px" marginwidth="0px" height="100%" width="100%"></iframe>
