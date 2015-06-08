<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% /*allow relative paths from the root %>*/%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<HTML>
<HEAD>
    <c:set var="url">${pageContext.request.requestURL}</c:set>
    <base href="${fn:substring(url, 0, fn:length(url) - fn:length(pageContext.request.requestURI))}${pageContext.request.contextPath}/" />
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
       out.println("  <SCRIPT TYPE=\"text/javascript\" language=\"JavaScript\" src=\"scripts/js/"+script+"\" ></SCRIPT>");
    }
   

  %>
  <SCRIPT type="text/javascript" src="scripts/js/jquery-2.1.1.min.js"></SCRIPT>
  <SCRIPT type="text/javascript" src="scripts/js/materialize.min.js"></SCRIPT>
	<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<META name="viewport" content="width=device-width, initial-scale=1"/>
  <TITLE><%=title%></TITLE>
 	<LINK type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>
 	<LINK type="text/css" rel="stylesheet" href="css/style.css">
</HEAD>