import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
/**
 * Create tables
 **/
public class NBCreate extends NaturalBeveragesAdmin
{

	public void doGet(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException 
	{
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		out.println("<html><head><title>NBCreate</title></head>");
        out.println("<body bgcolor=\"#FFFFCC\">Create Database and Tables<hr>");

		try
		{
			//Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+userID, userID, phrase);
			buildConnectionToDB();

			//DB nutzen
			try
			{
				statement.executeUpdate("use dz39;");
			} catch (SQLException e)
			{
				out.println("Problem occured while creating the database, cause: "+e+"<br />");
			}
			// if there are more than two users, check wherever the user really wants to delete
			// the database
			if (this.countTouples("users") > 2
				&& !(request.getParameter("deleteTables").equals("yes")) ) {
				
				out.println("Are you sure about deleting your tables?");
				out.println("<form method='get' action='servlet/NBCreate'>"
					+ "<input type='submit' name='deleteTables' value='yes'></form>"); 
			} else 
			{
				//delete old tables, create new ones
				try 
				{
					statement.executeUpdate("drop table if exists users");
					statement.executeUpdate("create table users (email varchar(64), nick char(10), password TEXT, name char(12), surname char(12), dateOfBirth Date, address char(64), floor int(2), zipcode int(6), dateOfSignUp timestamp default current_timestamp on update current_timestamp, primary key (email)) engine = INNODB;");
					statement.executeUpdate("drop table if exists categories");
					statement.executeUpdate("create table categories (name char(12), primary key (name)) engine = INNODB;");
					statement.executeUpdate("drop table if exists crates");
					statement.executeUpdate("create table crates (id mediumint not null auto_increment, name char(12), amountPerCrate int(3), refund numeric(2,2), primary key (id)) engine = INNODB;");
					statement.executeUpdate("drop table if exists containers");
					statement.executeUpdate("create table containers (id mediumint not null auto_increment, name char(12), amountPerUnit numeric(2,2), refund numeric(2,2), crateName char(12), constraint foreign key (crateName) references Crates(name) on update restrict on delete cascade, primary key(id)) engine = INNODB;");
					statement.executeUpdate("drop table if exists beverages");
					statement.executeUpdate("create table beverages (name char(12), firm char(12), amountLeft int(10), pricePerUnit numeric(10,2), containerName numeric(2,2), categoryName char(12), constraint foreign key (categoryName) references Categories(name) on update restrict on delete cascade, constraint foreign key (containerId) references Containers(id) on update restrict on delete cascade, primary key (name,firm)) engine = INNODB;");
					statement.executeUpdate("drop table if exists orders");
					statement.executeUpdate("create table orders (id mediumint not null unique auto_increment # is needed as a reference to the shoppingcart relation, email varchar(64), dateOfOrder timestamp default current_timestamp on update current_timestamp, service boolean, constraint foreign key (email) references Users(email) on update restrict on delete cascade, primary key (email,dateOfOrder)) engine = INNODB;");
					statement.executeUpdate("drop table if exists boughtGoods");
					statement.executeUpdate("create table boughtGoods (orderID mediumint, BeverageName char(12), crate boolean, amount int(4), constraint foreign key (beverageName) references Beverages(name) on update restrict on delete cascade, constraint foreign key (orderID) references Orders(id) on update restrict on delete cascade, primary key (orderID)) engine = INNODB;");
				} catch (SQLException e)
				{
					out.println("Problem occured while creating tables, cause: "+e+"<br />");
				}


				try
				{
					DatabaseMetaData metaData = connection.getMetaData();
        			ResultSet resultSet = metaData.getTables(null, null, "%", null);
					while (resultSet.next())
					{
						String tableName = resultSet.getString(3);
						try
						{
							insertValuesFromFile(tableName);
						} catch(SQLException e)
						{
							out.println("There's no file for "+tableName+"<br />");
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

			out.println("<a href='http://praxi.mt.haw-hamburg.de/~"+this.userID+"/TelDBServletHome.html'>Home</a><hr>");
			DatabaseMetaData metaData = connection.getMetaData();
        	ResultSet resultSet = metaData.getTables(null, null, "%", null);
			while (resultSet.next())
			{
				String tableName = resultSet.getString(3);
  				out.println("Table \""+tableName+"\" created, it has "
  					+ this.countTouples(tableName)+" Touples.");
			}
        	  
			out.println("<hr><a href='http://praxi.mt.haw-hamburg.de/~"+this.userID+"/TelDBServletHome.html'>TelDBServletHome</a>");
			out.println("<hr> </body> </html>");
			statement.close();
			connection.close();
		} catch (Exception e)
		{
			out.println("Problem occured, cause: "+e+"<br />");
		}	
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException
	{
		doGet(request, response);
	}
}