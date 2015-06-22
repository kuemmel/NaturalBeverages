import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
/**
 * Create tables
 * and load initial tables and static values from txt files inside the web-inf/classes folder
 **/
public class NBCreate extends NaturalBeveragesAdmin
{
	public void doGet(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException 
	{
		response.setContentType("text/html");
		out = response.getWriter();

		buildConnectionToDB();
		out.println("<hr><a href='http://praxi.mt.haw-hamburg.de/~"+userID+"/admin/NBhome.html'>home</a><hr>");
		out.println("<html><head><title>NBCreate</title></head>");
        out.println("<body bgcolor=\"#FFFFCC\">Create Database and Tables<hr>");

		//buildConnectionToDB();

		//DB nutzen
		try
		{
			statement.executeUpdate("use dz39;");
		} catch (SQLException e)
		{
			StackTraceElement ste = new Exception().getStackTrace()[0];
			String line = ste.getClassName() + String.valueOf(ste.getLineNumber());

			out.println("Problem occured while creating the database, cause: "+e+"at line "+line+"<br />");
		}
			int toupleCount = 0;
		try
		{
			toupleCount = this.countTouples("users");
		} catch (SQLException e)
		{
			StackTraceElement ste = new Exception().getStackTrace()[0];
			String line = ste.getClassName() + String.valueOf(ste.getLineNumber());

			out.println("Something went wrong on counting the tuples in users at line"+line+"! ");
			e.printStackTrace();
			out.println("Users does not exist. Trying to go on!");
		}

		// if there are more than two users, check wherever the user really wants to delete
		// the database
		if ( toupleCount > 2 && !(request.getParameter("deleteTables").equals("yes")) )
		{	
			out.println("Are you sure about deleting your tables?");
			out.println("<form method='get' action='servlet/NBCreate'>"
				+ "<input type='submit' name='deleteTables' value='yes'></form>"); 
		} else 
		{
		//delete old tables, create new ones
			try 
			{
				//test
				statement.executeUpdate("drop table if exists boughtgoods; ");
				statement.executeUpdate("drop table if exists orders; ");
				statement.executeUpdate("drop table if exists beverages; ");
				statement.executeUpdate("drop table if exists containers; ");
				statement.executeUpdate("drop table if exists crates; ");
				statement.executeUpdate("drop table if exists categories; ");
				statement.executeUpdate("drop table if exists users;");
				statement.executeUpdate("create table users (id mediumint not null unique auto_increment, email varchar(64) unique, nick varchar(30), password text, name varchar(30), surname varchar(30), dateOfBirth date, address varchar(64), floor int(2), zipcode int(6), dateOfSignUp timestamp default current_timestamp on update current_timestamp, primary key (id)) engine = INNODB;");
				statement.executeUpdate("create table categories (name varchar(30), primary key (name)) engine = INNODB;");
				statement.executeUpdate("create table crates (name varchar(30), amountPerCrate int(3), refund numeric(2,2), primary key (name)) engine = INNODB;");
				statement.executeUpdate("create table containers (name varchar(30), amountPerUnit numeric(2,2), refund numeric(2,2), crateName varchar(30), primary key(name), constraint foreign key (crateName) references dz39.crates(name) on update restrict on delete cascade) engine = INNODB;");
				statement.executeUpdate("create table beverages (name varchar(30), firm varchar(30), imagePath text, amountLeft int(10), pricePerUnit numeric(10,2), containerName varchar(30), categoryName varchar(30), primary key (name,firm), constraint foreign key (categoryName) references dz39.categories(name) on update restrict on delete cascade, constraint foreign key (containerName) references dz39.containers(name) on update restrict on delete cascade) engine = INNODB;");
				statement.executeUpdate("create table orders (id mediumint not null unique auto_increment, userId mediumint, dateOfOrder timestamp default current_timestamp on update current_timestamp, service boolean, primary key (id), constraint foreign key (userId) references dz39.users(id) on update restrict on delete cascade) engine = INNODB;");
				statement.executeUpdate("create table boughtgoods (orderId mediumint, beverageName varchar(30), crate boolean, amount int(4), primary key (orderid,beverageName)	, constraint foreign key (beverageName) references dz39.beverages(name) on update restrict on delete cascade, constraint foreign key (orderId) references dz39.orders(id) on update restrict on delete cascade) engine = INNODB;");
			} catch (SQLException e)
			{ 
				StackTraceElement ste = new Exception().getStackTrace()[0];
				String line = ste.getClassName() + String.valueOf(ste.getLineNumber());

				out.println("Problem occured while creating tables, cause: "+e+"at line "+line+"<br />");

			}
			out.println("Tables created. <br />");

			try
			{
				DatabaseMetaData metaData = connection.getMetaData();
				ResultSet resultSet = metaData.getTables(null, null, "%", null);
				resultSet.last();
				while (resultSet.previous())
				{
					String tableName = resultSet.getString(3);
					try
					{
						insertValuesFromFile(tableName);
					} catch(SQLException e)
					{
						out.print(" <br /> \t <b> are the data files in unix line endings(\\n)?</b>");
						out.println("Problem occured: "+e+"<br />");
						//can happen, if there is no mass data needed, for example Users.
					} catch(NullPointerException e)
					{
						out.println(e);
					}
				}
			}
			catch(Exception e)
			{
				out.println(e.getMessage()+"<br> Problem mit: LOAD DATA article !<br>"+"<br />");
			}
		}
		out.println("<hr>");
		out.println("static values filled in -- <br />");

		out.println("<a href='http://praxi.mt.haw-hamburg.de/~"+this.userID+"/TelDBServletHome.html'>Home</a><hr>");

		try
		{
			DatabaseMetaData metaData = connection.getMetaData();
        	ResultSet resultSet = metaData.getTables(null, null, "%", null);
			while (resultSet.next())
			{
				String tableName = resultSet.getString(3);
  				out.println("	\tTable \""+tableName+"\" created, it has "
  					+ this.countTouples(tableName)+" Touples. <br />");
			}
        	  
			out.println("<hr><a href='http://praxi.mt.haw-hamburg.de/~"+this.userID+"/TelDBServletHome.html'>TelDBServletHome</a>");
			out.println("<hr> </body> </html>");
		} catch (Exception e)
		{
			StackTraceElement ste = new Exception().getStackTrace()[0];
			String line = ste.getClassName() + String.valueOf(ste.getLineNumber());

			out.println("Problem occured, while printing stuff "+e+" at line "+line+"<br />");
		}
		closeConnection();
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException
	{
		doGet(request, response);
	}
}