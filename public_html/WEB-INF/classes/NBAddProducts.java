    import java.io.*;
    import java.sql.*;
    import javax.servlet.*;
    import javax.servlet.http.*;
    /**
     * add new products to the product line.
     *  -> insert images into /public_html/images/
     *  @todo copy images from client to /public_html/images
     **/

    public class NBAddProducts extends NaturalBeveragesAdmin
    {

        public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
        {
        response.setContentType("text/html");
        out = response.getWriter();
        buildConnectionToDB();
                
        out.println("<html><head><title>NBAddProducts</title></head>");
        out.println("<body bgcolor=\"#FFFFFF\"> AddProducts <hr>");
        out.println("<hr><a href='http://praxi.mt.haw-hamburg.de/~"+userID+"/admin/NBhome.html'>home</a>");
        out.println("<a href='http://praxi.mt.haw-hamburg.de/~"+userID+"/admin/NBAddProducts.html'>Noch eines hinzufuegen</a><hr>");

        // get all parameters
        // Validation is done inside the .html file, so this is not safe from attacks!
        String name = request.getParameter("beverageName");
        String firm = request.getParameter("beverageFirm");
        String path = request.getParameter("beverageImagePath");
        int amount = Integer.parseInt(request.getParameter("beverageAmountLeft"));
        Money price = new Money(request.getParameter("beveragePricePerUnit"));
        String containerName = request.getParameter("beverageContainerName");
        String category = request.getParameter("beverageCategoryName");

        //out.println("given values: <br />");
        //out.println(name+";"+firm+";"+path+";"+amount+";"+price+";"+containerName+";"+category+";<br />");
        out.println("Inserting. <hr>");
        try
        {
            statement.executeUpdate("insert into beverages values (\""
                +name+"\",\""
                +firm+"\",\""
                +path+"\",\""
                +amount+"\",\""
                +price.getValue()+"\",\""
                +containerName+"\",\""
                +category+"\");");
        } catch (SQLException e)
        {
            StackTraceElement ste = new Exception().getStackTrace()[0];
            String line = ste.getClassName() + String.valueOf(ste.getLineNumber());
            out.println("Could not insert into table, cause: "+e+"at line "+line+"<br />");
        }

        try
        {
            ResultSet resultSet = statement.executeQuery("select * from beverages");
            out.println("<table border=\"1\"><title>Alle Werte in beverages</title>");
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