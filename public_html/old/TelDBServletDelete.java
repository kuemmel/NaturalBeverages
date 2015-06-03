//Das JDBC-Servlet "TelDBServletDelete.java"
//Zuerst: ganz viele "imports"
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

//Hier die Klasse mit Vererbung
public class TelDBServletDelete extends HttpServlet
{
   // Hier  IHRE Praxi-UserID fuer "dwNN" und Password fuer "****" einsetzen. 
   // Hier  IHRE Praxi-UserID fuer "dwNN" und Password fuer "****" einsetzen. 
   // Hier  IHRE Praxi-UserID fuer "dwNN" und Password fuer "****" einsetzen. 
   // Hier  IHRE Praxi-UserID fuer "dwNN" und Password fuer "****" einsetzen. 
   // Hier  IHRE Praxi-UserID fuer "dwNN" und Password fuer "****" einsetzen. 
   private String userID="****";
   private String passwd="****";

   public void doGet(HttpServletRequest req, HttpServletResponse res)
       throws ServletException, IOException
   {
      res.setContentType("text/html");
      PrintWriter out = res.getWriter();
      String telname = req.getParameter("tname");

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
         //st.executeUpdate("insert into tel values ('"+telname+"',"+telnr+")");

         //Response Webseite aufbauen
         out.println("<html><head><title>TelDBServletDelete</title></head>");
         out.println("<body bgcolor=\"#FFCCCC\">TelDBServletDelete<hr>");
         out.println("<a href='http://praxi.mt.haw-hamburg.de/~"+userID+"/TelDBServletHome.html'>Home</a><hr>");
         
         //ResultSet mit Cursor bearbeiten und ausgeben
         ResultSet rs = st.executeQuery("select * from tel where name = '"+telname+"' ");

         //Hier die Cursor-Schleife
         out.println("The following entry will be deleted from table 'teldb': ");
      
         out.println("<table border=\"3\" cellspacing=\"2\" cellpadding=\"2\">");
         int ideletecount=0;
         while(rs.next())
         {
             String sname = rs.getString("name");
             String snr = rs.getString("nr");
	     String bildlink= "<img src=\"../pictures/"+sname+".jpg" +"\">";
             out.println("<tr><td>"+sname + "</td><td>" + snr + "</td><td>" +bildlink+ "</td></tr>");
             ideletecount++;
         
         }
         out.println("</table>");
         if(ideletecount==0)
         {
             out.println("<br>Could not find any tuple to be deleted with name = "+telname);
         }
         else 
         {
             st.executeUpdate("delete from tel where name = '"+telname+"' ");
         }
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
