package naturalBeverages;
import java.sql.*;
import java.security.MessageDigest;
import java.io.PrintWriter;
/**
 * Handles all connections from and to the mySQL Database.
 * SQLConnection(out) builds the connection to the DB
 * @TODO add userID and password on production server!
 **/
public class SQLConnection
{
	//NEEDS TO BE ADJUSTED ON "PRODUCTION" SERVER!
	public final String userID = "root";
	public final String passwd = null;
	//public final String sqlServerLink = "jdbc:mysql://localhost:3306/";
	public final String sqlServerLink = "jdbc:mysql://localhost:3306/dz39";
	public Connection connection;
	public Statement statement;
	public PrintWriter out;
	public final String PUBLIC_HTML_PATH = "/home/"+this.userID+"/public_html/";

	public SQLConnection(PrintWriter out)
	{
		this.out = out;
		this.buildConnectionToDB();
	}

	public void loadDriver() throws ClassNotFoundException
	{
		Class.forName("com.mysql.jdbc.Driver");
	}

	protected void buildConnectionToDB()
	{
		try
		{
			//if(passwd == null || userID == null)
			//{
			//	throw new RuntimeException("Credentials in NBAdmin missing.");
			//}
			this.loadDriver();
			this.connection = DriverManager.getConnection(sqlServerLink, userID, passwd);
			this.statement = this.connection.createStatement();
		} catch (Exception e)
		{
			StackTraceElement ste = new Exception().getStackTrace()[0];
			String line = ste.getClassName() + String.valueOf(ste.getLineNumber());

			out.println("Problem occured, cause: "+e+"at line "+line+"<br />");
		}
	}

	public void closeConnection()
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

	public int countTouples(String table) throws SQLException
	{
		try
		{
			//ResultSet resultSet = statement.executeQuery("select count(*) as count from "+table);
			//return resultSet.getInt("count");
			ResultSet resultSet = selectAllFrom(table);
			return resultSet.last() ? resultSet.getRow() : 0; 
		} catch(Exception e) 
		{
			return 0;
		}
	}

	/**
	 * Some selects to make life easier
 	 * 9.6.15: added more methods
 	 * AND now sanitize the input
	 *
	 **/
	public ResultSet selectAllFrom(String table) throws SQLException
	{
		return statement.executeQuery("select * from "+table);
	}

	public ResultSet selectAllFromWhere(String table, String field, String value) throws SQLException
	{
		return statement.executeQuery("select * from "+table+" where "+field+" = "+value);
	}

	public ResultSet selectAllFromWhereAnd(String table, String field, String value
		, String field2, String value2) throws SQLException
	{
		return statement.executeQuery("select * from "+table+" where "
			+field+" = "+value+" and "+field2+" = "+value2);
	}

	public ResultSet selectXfromWhere(String table, String target, String field, String value) throws SQLException
	{
		return statement.executeQuery("select "+target+" from "+table+" where "+field+" = "+value);
	}

	/**
	 * Encrypt passwords in a weak md5 fashion.
	 * 
	 */
	public String encryptMD5(String password)
	{
		StringBuffer stringBuffer = new StringBuffer();
		try
		{
			MessageDigest messageDigest = MessageDigest.getInstance("MD5");
			messageDigest.reset();
			messageDigest.update(password.getBytes());
			byte[] digest = messageDigest.digest();
			String hex;
			for(byte b : digest)
			{
				hex = Integer.toHexString(0xFF & b);
				if(hex.length() == 1)
				{
					hex = "0"+hex;
				}
				stringBuffer.append(hex);
			}
		} catch (Exception e)
		{
            StackTraceElement ste = new Exception().getStackTrace()[0];
            String line = ste.getClassName() + String.valueOf(ste.getLineNumber());
            out.println("Could not encrypt password, cause: "+e+"at line "+line+"<br />");
		}
		return stringBuffer.toString();
	}

	public ResultSet sqlQuery(String query) throws SQLException
	{
        return statement.executeQuery(query);
	}
	public int sqlUpdate(String query) throws SQLException
	{
		return statement.executeUpdate(query);
	}
}