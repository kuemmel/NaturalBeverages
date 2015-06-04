import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class NaturalBeveragesAdmin extends HttpServlet
{
	protected final String userID = null;
	protected final String passwd = null;
	protected final String sqlServerLink = "jdbc:mysql://localhost:3306/";
	protected Connection connection;
	protected Statement statement;

	protected void loadDriver() throws ClassNotFoundException
	{
		Class.forName("org.gjt.mm.mysql.Driver");
	}

	protected void buildConnectionToDB() throws SQLException
	{
		if(passwd == null || userID == null)
		{
			throw new RuntimeException("Credentials in NBAdmin missing.");
		}
		this.connection = DriverManager.getConnection(sqlServerLink+userID, userID, passwd);
		this.statement = this.connection.createStatement();
	}

	protected int countTouples(String table) throws SQLException
	{
		try
		{
			ResultSet resultSet = statement.executeQuery("select COUNT(*) AS count FROM "+table);
			return resultSet.getInt("count");
		} catch(SQLSyntaxErrorException e) 
		{
			return 0;
		}
	}
	protected void insertValuesFromFile(String table) throws SQLException
	{
		statement.executeUpdate("load data local infile \"/home/"
			+this.userID+"/public_html/WEB-INF/classes/"
			+table+".txt\" into table tel fields terminated by ';' lines terminated by '\n' "); 
	}
}