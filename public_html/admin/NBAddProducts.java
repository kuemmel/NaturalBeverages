/**
 * add new products and their containers
 **/

public class NBAddProducts extends NaturalBeveragesAdmin
{
	public void doGet(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException 
	{
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		out.println("<html><head><title>NBAddProducts</title></head>");
        out.println("<body bgcolor=\"#FFFFFF\"> AddProducts <hr>");

		try
		{
			//Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+userID, userID, passwd);
			Connection connection = this.buildConnectionToDB();
			Statement statement = connection.createStatement();



		} catch (Exception e)
		{
			out.println("Problem occured, cause: "+e);
		}	
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException
	{
		doGet(req, res);
	}
}