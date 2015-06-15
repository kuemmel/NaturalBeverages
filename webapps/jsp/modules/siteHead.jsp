<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<HTML>
<HEAD>
  <LINK type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/materialize.min.css"  media="screen,projection"/>
  <LINK type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
  <SCRIPT type="text/javascript" src="${pageContext.request.contextPath}/scripts/js/jquery-2.1.1.min.js"></SCRIPT>
  <SCRIPT type="text/javascript" src="${pageContext.request.contextPath}/scripts/js/materialize.min.js"></SCRIPT>
  <%
    /**
     * This site has all the head information used in this project, it is to be included in every .jsp 
     * If a site needs a javascript file, it can set a parameter. 
     * Ussage: 
     *  request.setAttribute("pageTitle","Register");
     *  request.setAttribute("scripts","register.jsp utils.js")
     *
     */
    String title = (String) request.getAttribute("pageTitle");
    String[] scripts = ((String) request.getAttribute("scripts")).split(" ");
    for(String script : scripts)
    {
       out.println("  <SCRIPT TYPE=\"text/javascript\" language=\"JavaScript\" src=\""+request.getContextPath()+"/scripts/js/"+script+"\" ></SCRIPT>");
    }
  %>
	<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<META name="viewport" content="width=device-width, initial-scale=1"/>
  <TITLE><%=title%></TITLE>
</HEAD>