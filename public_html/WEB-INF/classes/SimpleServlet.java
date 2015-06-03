/**
 * erstes einfaches Servlet
 **/

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class SimpleServlet extends HttpServlet
{
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		response.setContentType("text/html");
		try (PrintWriter out = response.getWriter())
		{
			
			String name = "Me First Servlet, ye";
			out.println("<HTML>");
			out.println("<HEAD>");
			out.println("<TITLE>");
			out.println(name);
			out.println("</TITLE>");
			out.println("</HEAD>");
			out.println("<BODY bgcolor =\"FFFF00\">");
			out.println("Sup, gurl, me first servlet, <i>yo</i>");
			out.println("</BODY>");
			out.println("</HTML>");
		}
	}

	/**
	 * Does nothing but call doGet(f w/e r)
	 **/
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException
	{
		doGet(request,response);
	}

}