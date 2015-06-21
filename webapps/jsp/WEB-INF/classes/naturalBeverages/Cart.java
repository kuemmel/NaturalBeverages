package naturalBeverages;
import java.util.ArrayList;
import java.util.Set;
import java.util.Iterator;
import java.sql.*;
import java.io.PrintWriter;
import org.json.simple.*;
/**
 * compile with  javac  -Xlint:unchecked -cp ..\..\lib\json_simple-1.1.jar cart.java Product.java Money.java
 **/

public class Cart 
{
	private String userId;
	public ArrayList<Product> products;
	public ArrayList<String> test;

	public Cart(String userId, JSONObject jsonObject)
	{
		this.userId = userId;
		this.products = new ArrayList<Product>();
		this.test = new ArrayList<String>();
		SQLConnection sqlConnection = new SQLConnection();
		getProductsFromJSON(jsonObject,sqlConnection);
		setOrder(sqlConnection);
	}

	/**
	 * Gets a jsonobject
	 * {"form:firm:name":{"firm":"the firm", "amount","price","name","refund",}}
	 * only name, firm, amount are needed to load the rest of the data from the tables.
	 **/
	private void getProductsFromJSON(JSONObject jsonObject,SQLConnection sqlConnection)
	{
		//otherwise javac will print a warning! bad practice but it works
		Set<?> keySet = jsonObject.keySet();
		Iterator<?> iterator = keySet.iterator();
		

		while(iterator.hasNext())
		{
			String key = (String) iterator.next();
			JSONObject currentProduct = (JSONObject) jsonObject.get((Object)key);
			String firm = (String)currentProduct.get((Object)"firm");
			String name = (String)currentProduct.get((Object)"name");
			int amount = Integer.parseInt((String)currentProduct.get((Object)"amount"));
			try
			{
				ResultSet resultSet = sqlConnection.getProductByNameAndFirm(name,firm);
				resultSet.next();
				Product product = new Product(resultSet);
				product.setAmount(amount);
				products.add(product);

			} catch(Exception e)
			{
				throw new RuntimeException("error loading products from db "+e);
			}
			//test.add((String)currentProduct.get((Object)"firm"));
			
		}

	}
	private void setOrder(SQLConnection sqlConnection)
	{
		int floor = 0;
		String getUserQuery = "select * from users where id = \""+userId+"\";";
		try 
    	{
    		ResultSet userResultSet = sqlConnection.sqlQuery(getUserQuery);

			userResultSet.next();
			floor = Integer.parseInt(userResultSet.getString("floor"));
			String orderInsertQuery = "insert into orders (userId,service) values (\""+userId+"\",\"1\");";
        	int orderId = sqlConnection.sqlUpdateReturnGenerated(orderInsertQuery);

        	for(Product product : this.products)
        	{
        		product.insertIntoBoughtGoods(sqlConnection,orderId);
        	}
    	} catch(SQLException e)
    	{
    		throw new RuntimeException("Problem setting up the order: "+e+" "+floor);
    	}
	}
}