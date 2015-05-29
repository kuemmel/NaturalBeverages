public class NaturalBeveragesAdmin 
{
	protected final String userID = null;
	protected final String passwd = null;
	protected final String sqlServerLink = "jdbc:mysql://localhost:3306/";

	protected void loadDriver() throws ClassNotFoundException
	{
		Class.forName("org.gjt.mm.mysql.Driver");
	}

	protected Connection buildConnectionToDB() throws SQLException
	{
		if(passwd == null || userID == null)
		{
			throw new RuntimeException("Credentials in NBAdmin missing.");
		}
		return DriverManager.getConnection(sqlServerLink+userID, userID, passwd);
	}

	protected int countTouples(String table) throws SQLException
	{
		ResultSet resultSet = statement.executeQuery("select COUNT(*) AS count FROM "+table);
		return resultSet.getInt("count");
	}
	protected void insertValuesFromFile(String table) throws SQLException
	{
		statement.executeUpdate("load data local infile \"/home/"
			+this.userID+"/public_html/WEB-INF/classes/"
			+table+".txt\" into table tel fields terminated by ';' lines terminated by '\n' "); 
	}
}