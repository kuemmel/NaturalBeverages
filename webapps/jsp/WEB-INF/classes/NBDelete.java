import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
/**
* delete products from the database
* @todo use a list of values to delete from
**/

public class NBDelete extends NaturalBeveragesAdmin
{

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        response.setContentType("text/html");
        out = response.getWriter();
        buildConnectionToDB();
        
        out.println("<html><head><title>NBdelete</title></head>");
        out.println("<body bgcolor=\"#FFFFFF\"> Delete Products <hr>");
        out.println("<hr><a href='http://praxi.mt.haw-hamburg.de/~"+userID+"/admin/NBhome.html'>home</a>");
        out.println("<a href='http://praxi.mt.haw-hamburg.de/~"+userID+"/admin/NBdelete.html'>Noch eines loeschen</a><hr>");
        out.println("Loesche folgenden Eintrag:");
        String rName = request.getParameter("name");

        try
        {
            ResultSet resultSet = statement.executeQuery("select * from beverages where name=\""+rName+"\"");

            String name = "";
            String firm = "";
            out.println("<table border=\"1\"><title>Wert in beverages</title>");
            while(resultSet.next())
            {
                name = resultSet.getString("name");
                firm = resultSet.getString("firm");

                out.println("<tr>");
                out.println("<td>"+name+"</td>");
                out.println("<td>"+firm+"</td>");
                out.println("<td><img height=\"42\" width=\"42\" src=\"../"+resultSet.getString("imagePath")+"\" /></td>");
                out.println("<td>"+resultSet.getInt("amountLeft")+"</td>");
                out.println("<td>"+resultSet.getBigDecimal("pricePerUnit")+"</td>");
                out.println("<td>"+resultSet.getString("containerName")+"</td>");
                out.println("<td>"+resultSet.getString("categoryName")+"</td>");
                out.println("</tr>");
            }
            out.println("</table>");

            try
            {
                statement.executeUpdate("delete from beverages where name = \""+name+"\" and firm = \""+firm+"\";");
            } catch (SQLException e)
            {
                StackTraceElement ste = new Exception().getStackTrace()[0];
                String line = ste.getClassName() + String.valueOf(ste.getLineNumber());
                out.println("Could not delete from table, cause: "+e+"at line "+line+"<br />");
            }

        } catch (SQLException e)
        {
            StackTraceElement ste = new Exception().getStackTrace()[0];
            String line = ste.getClassName() + String.valueOf(ste.getLineNumber());
            out.println("Could not select from table, cause: "+e+"at line "+line+"<br />");
        }
        closeConnection();
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        doGet(request, response);
    }
}