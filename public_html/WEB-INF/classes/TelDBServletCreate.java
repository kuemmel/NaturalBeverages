//Das JDBC-Servlet "TelDBServletCreate.java"
//Zuerst: ganz viele "imports"
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

//Hier die Klasse mit Vererbung
public class TelDBServletCreate extends HttpServlet
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

	 try
         {
             st.executeUpdate("drop table if exists tel;");
         }
         catch (Exception e)
         {
             out.println("Problem mit: DROP TABLE tel !!");
         }
         // Jetzt normales SQL-Skript, aber innerhalb des Servlets
         st.executeUpdate("create table tel(name char(11) primary key, nr int)");
         st.executeUpdate("insert into tel values ('Hugo',4444)");
         st.executeUpdate("insert into tel values ('Hajo',5555)");
         st.executeUpdate("insert into tel values ('Maxi',7777)");
         st.executeUpdate("insert into tel values ('Mini',4444)");

         // Hier LOAD DATA LOCAL INFILE, um Massendaten zu laden.
         try
    	 {
    	    st.executeUpdate("load data local infile \"/home/"+userID+"/public_html/WEB-INF/classes/teldb.txt\" into table tel fields terminated by ';' lines terminated by '\n' "); 
    	 }
    	 catch(Exception e)
    	 {
    	    out.println(e.getMessage()+"<br> Problem mit: LOAD DATA article !<br>");
    	 }

         //Response Webseite aufbauen
         out.println("<html><head><title>TelDBServletCreate</title></head>");
         out.println("<body bgcolor=\"#FFFFCC\">TelDBServletCreate<hr>");
         out.println("<a href='http://praxi.mt.haw-hamburg.de/~"+userID+"/TelDBServletHome.html'>Home</a><hr>");

         //ResultSet mit Cursor bearbeiten und ausgeben
         ResultSet rs = st.executeQuery("select * from tel");

         //Hier die Cursor-Schleife, aber nur durchzaehjlen, keine Tupel-Ausgabe
         int ituplecount=0;
         while(rs.next())
         {
             ituplecount++;
         }
         out.println("Table teldb created with "+ituplecount+" tuples of test data");
          
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
