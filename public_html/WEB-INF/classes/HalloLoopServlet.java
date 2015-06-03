/**
 * erstes einfaches Servlet
 **/

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class HalloLoopServlet extends HttpServlet
{
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		response.setContentType("text/html");
		int quantity = Integer.valueOf(request.getParameter("tnr"));

		try (PrintWriter out = response.getWriter())
		{
			String name = "Me First Servlet, ye";
			out.println("<HTML>");
			out.println("<HEAD>");
			out.println("<TITLE>");
			out.println("</TITLE>");
			out.println("</HEAD>");
			out.println("<BODY bgcolor =\"FFFF00\">");
			for (int i=0; i<quantity;i++) {
				out.println("Hodor");
			}
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