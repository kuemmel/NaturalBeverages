<html>
<body>
	Absolute paths in Datasystem of the JSP-Server <br />
  <pre>
    <%= getServletConfig().getServletContext().getRealPath( "/" ) %><br />
    <%= getServletConfig().getServletContext().getRealPath( request.getRequestURI() ) %><br />
  </pre>
</body>
</html>