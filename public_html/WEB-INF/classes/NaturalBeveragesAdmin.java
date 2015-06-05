import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

/**
 * Common methods and values for the admin tool.
 **/


public class NaturalBeveragesAdmin extends HttpServlet
{
	protected final String userID = "dz39";
	protected final String passwd = "H!!L";
	protected final String sqlServerLink = "jdbc:mysql://localhost:3306/";
	protected Connection connection;
	protected Statement statement;
	protected PrintWriter out;
	protected final String PUBLIC_HTML_PATH = "/home/"+this.userID+"/public_html/WEB-INF/classes/";

	protected void loadDriver() throws ClassNotFoundException
	{
		Class.forName("com.mysql.jdbc.Driver");
	}

	protected void buildConnectionToDB()
	{
		try
		{
			if(passwd == null || userID == null)
			{
				throw new RuntimeException("Credentials in NBAdmin missing.");
			}
			this.loadDriver();
			this.connection = DriverManager.getConnection(sqlServerLink+userID, userID, passwd);
			this.statement = this.connection.createStatement();
		} catch (Exception e)
		{
			StackTraceElement ste = new Exception().getStackTrace()[0];
			String line = ste.getClassName() + String.valueOf(ste.getLineNumber());

			out.println("Problem occured, cause: "+e+"at line "+line+"<br />");
		}
	}

	protected void closeConnection()
	{
		try
		{
			statement.close();
			connection.close();
			out.close();
		} catch(Exception e)
		{
			out.println("Error trying to close the connection. You have a problem. "+e);
		}
	}

	protected int countTouples(String table) throws SQLException
	{
		try
		{
			//ResultSet resultSet = statement.executeQuery("select count(*) as count from "+table);
			//return resultSet.getInt("count");
			ResultSet resultSet = statement.executeQuery("select * from "+table);
			return resultSet.last() ? resultSet.getRow() : 0; 
		} catch(Exception e) 
		{
			return 0;
		}
	}
	protected void insertValuesFromFile(String name) throws SQLException
	{
		String order = "load data local infile \""+PUBLIC_HTML_PATH+name+".txt\" into table "+name+" fields terminated by ';' lines terminated by '\n' ";
		if (new File(PUBLIC_HTML_PATH+name+".txt").exists())
		{
			out.println(order+" -> ");
			statement.executeUpdate(order);
			out.println("Added rows for "+name+"<br />");
		} else 
		{
			out.println("File for "+name+" does not exist!<br />");
		}
	}
}