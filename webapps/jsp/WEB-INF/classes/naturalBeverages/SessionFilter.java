package naturalBeverages;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebInitParam;
/**
 * Only allow people with the session attribute "nick" to go on certain sites.
 *
 * instead of a webxml, an annotation is used to determine when to call this filter
 **/

@WebFilter(filterName = "SessionFilter",
urlPatterns = {"/userSettings.jsp",},
initParams = {})
public class SessionFilter implements Filter
{
	private String path;
	private String logginAttribute = "userID";
	private String errorPage = "notLoggedIn.jsp";

	@Override
	public void init(FilterConfig filterConfig) throws ServletException
	{
		path = filterConfig.getServletContext().getContextPath();
	}

	@Override
	public void doFilter(ServletRequest request
		, ServletResponse response, FilterChain filterChain) throws IOException, ServletException
	{
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;

		//not logged in, filter him out, send him to an error page
		if(httpRequest.getSession().getAttribute(logginAttribute) == null)
		{
			httpResponse.sendRedirect(path+"/"+errorPage);
		} else // the attribute is set, the user is logged in, carry on
		{
			filterChain.doFilter(request,response);
		}
	}

	@Override
	public void destroy()
	{

	}
}