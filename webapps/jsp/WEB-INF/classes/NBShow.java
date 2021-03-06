import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
/**
 * shows a requested product from the database
 * @todo use a list of values to delete from
 **/
public class NBShow extends NaturalBeveragesAdmin
{

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        response.setContentType("text/html");
        out = response.getWriter();
        buildConnectionToDB();
        
        out.println("<html><head><title>NBshow</title></head>");

    
        out.println("<body bgcolor=\"#FFFFFF\">Show Products <hr>");
        out.println("<hr><a href='http://praxi.mt.haw-hamburg.de/~"+userID+"/admin/NBhome.html'>home</a>");
        out.println("<a href='http://praxi.mt.haw-hamburg.de/~"+userID+"/admin/NBShow.html'>Noch eines anzeigen</a><hr>");

        try
        {
            ResultSet resultSet = statement.executeQuery("select * from beverages where name=\""+request.getParameter("name")+"\"");
            out.println("<table border=\"1\"><title>Wert in beverages</title>");
            while(resultSet.next())
            {
                out.println("<tr>");
                out.println("<td>"+resultSet.getString("name")+"</td>");
                out.println("<td>"+resultSet.getString("firm")+"</td>");
                out.println("<td><img height=\"42\" width=\"42\" src=\"../"+resultSet.getString("imagePath")+"\" /></td>");
                out.println("<td>"+resultSet.getInt("amountLeft")+"</td>");
                out.println("<td>"+resultSet.getBigDecimal("pricePerUnit")+"</td>");
                out.println("<td>"+resultSet.getString("containerName")+"</td>");
                out.println("<td>"+resultSet.getString("categoryName")+"</td>");
                out.println("</tr>");
            }
            out.println("</table>");

        } catch (SQLException e)
        {
                StackTraceElement ste = new Exception().getStackTrace()[0];
                String line = ste.getClassName() + String.valueOf(ste.getLineNumber());
                out.println("Could not insert into table, cause: "+e+"at line "+line+"<br />");
        }
        closeConnection();
    }
    
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        doGet(request, response);
    }
}