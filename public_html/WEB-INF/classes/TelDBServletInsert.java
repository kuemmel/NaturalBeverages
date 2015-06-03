//Das JDBC-Servlet "TelDBServletInsert.java"
//Zuerst: ganz viele "imports"
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

//Hier die Klasse mit Vererbung
public class TelDBServletInsert extends HttpServlet
{
   // Hier  IHRE Praxi-UserID fuer "dwNN" und Password fuer "****" einsetzen. 
   // Hier  IHRE Praxi-UserID fuer "dwNN" und Password fuer "****" einsetzen. 
   // Hier  IHRE Praxi-UserID fuer "dwNN" und Password fuer "****" einsetzen. 
   // Hier  IHRE Praxi-UserID fuer "dwNN" und Password fuer "****" einsetzen. 
   // Hier  IHRE Praxi-UserID fuer "dwNN" und Password fuer "****" einsetzen. 
   private String userID="dz39";
   private String passwd="H!!L";

   public void doGet(HttpServletRequest req, HttpServletResponse res)
       throws ServletException, IOException
   {
      res.setContentType("text/html");
      PrintWriter out = res.getWriter();

      String telname = req.getParameter("tname");
      String telnr= req.getParameter("tnr");
      int i = Integer.parseInt(telnr);

      //DB-Treiber einbinden
      try
      {
          Class.forName("org.gjt.mm.mysql.Driver");  //Da sind die Treiber
      }
      catch (ClassNotFoundException e)
      {
          out.println("DB-Treiber nicht da!");
      }

      // Connection zum DB-Server eroeffnen
      try
      {
         Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+userID, userID, passwd);

         //Jetzt einen SQL-Befehl vorbereiten
         Statement st = con.createStatement();  //(Noch) leerer SQL-Befehl

	 //Dynamisch eingegebene Daten
         st.executeUpdate("insert into tel values ('"+telname+"',"+telnr+")");

         //Response Webseite aufbauen
         out.println("<html><head><title>TelDBServletInsert</title></head>");
         out.println("<body bgcolor=\"#CCFFCC\">TelDBServletInsert<hr>");
         out.println("<a href='http://praxi.mt.haw-hamburg.de/~"+userID+"/TelDBServletHome.html'>Home</a><hr>");

         //ResultSet mit Cursor bearbeiten und ausgeben
         ResultSet rs = st.executeQuery("select * from tel where name = '"+telname+"' ");

         //Hier die Cursor-Schleife
         out.println("The following entry has been inserted into table 'teldb': ");
      
         out.println("<table border=\"3\" cellspacing=\"2\" cellpadding=\"2\">");
         while(rs.next())
         {
             String sname = rs.getString("name");
             String snr = rs.getString("nr");
	     String bildlink= "<img src=\"../pictures/"+sname+".jpg" +"\">";
             out.println("<tr><td>"+sname + "</td><td>" + snr + "</td><td>" +bildlink+ "</td></tr>");
         }
         out.println("</table>");

         out.println("<hr><a href='http://praxi.mt.haw-hamburg.de/~"+userID+"/TelDBServletHome.html'>TelDBServletHome</a>");
	 out.println("<hr> </body> </html>");
         st.close();
         con.close();
     }
     catch (Exception e)
     {
         out.println(" MySQL Exception: " + e.getMessage());
     }
   }
 
   public void doPost(HttpServletRequest req, HttpServletResponse res)
       throws ServletException, IOException
   {
      doGet(req, res);
   }

}
