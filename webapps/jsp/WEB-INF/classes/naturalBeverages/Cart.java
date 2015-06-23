package naturalBeverages;
import java.util.ArrayList;
import java.util.Set;
import java.util.Iterator;
import java.sql.*;
import java.io.PrintWriter;
import java.lang.Cloneable;
import org.json.simple.*;
/**
 * compile with  javac  -Xlint:unchecked -cp ..\..\lib\json_simple-1.1.jar Cart.java Product.java Money.java SQLConnection.java
 **/

public class Cart implements Cloneable
{
	private float SERVICE_COST = 0.05f;
	private String userId;
	private int floor;
	public ArrayList<Product> products;

	public Cart(String userId)
	{
		this.userId = userId;
		this.products = new ArrayList<Product>();
		this.floor = getFloorFromUserId(userId);
	}

	public Cart(String userId, JSONObject jsonObject)
	{
		this.userId = userId;
		this.products = new ArrayList<Product>();
		this.floor = getFloorFromUserId(userId);
		SQLConnection sqlConnection = new SQLConnection();
		getProductsFromJSON(jsonObject,sqlConnection);
	}

	public Cart clone()
	{
		Cart cart = new Cart(userId);
		cart.setFloor(this.floor);
		cart.setProducts(this.products);
		return cart;
	}

	/**
	 * Add a single product to the cart from a jsonString which looks like
	 * {"name":"\s+","firm":"\s+","amount":\d+}
	 *
	 *
	 * @todo write new method addSingleProduct(name,firm,amount)
	 * which is called from addProduct and getProductsFromJSON
	 **/
	public void addProduct(JSONObject jsonObject)
	{
		SQLConnection sqlConnection = new SQLConnection();
		try
		{
			String name = (String) jsonObject.get((Object)"name");
			String firm = (String) jsonObject.get((Object)"firm");
			int amount = Integer.parseInt((String) jsonObject.get((Object)"amount"));

			ResultSet resultSet = sqlConnection.getProductByNameAndFirm(name,firm);
			resultSet.next();
			Product product = new Product(resultSet);
			product.setAmount(amount);
			products.add(product);
		} catch (Exception e)
		{
			throw new RuntimeException("error loading single product from db into the cart "+e);
		}
	}

	/**
	 * delete product from cart
	 *
	 **/
	public void removeProduct(String name, String firm)
	{
		for(Product product : products)
		{
			if(product.getName() == name && product.getFirm() == firm)
			{
				products.remove((Object) product);
			}
		}
	}

	//otherwise javac will print a warning! bad practice but it works
	@SuppressWarnings("unchecked")

	/**
	 * Gets a jsonobject
	 * {"form:firm:name":{"firm":"the firm", "amount","price","name","refund",}}
	 * only name, firm, amount are needed to load the rest of the data from the tables.
	 **/
	private void getProductsFromJSON(JSONObject jsonObject,SQLConnection sqlConnection)
	{
		
		Set<?> keySet = jsonObject.keySet();
		//if(true)throw new RuntimeException("test"+JSONObject);
		Iterator<?> iterator = keySet.iterator();
		

		while(iterator.hasNext())
		{
			String key = (String) iterator.next();
			JSONObject currentProduct = (JSONObject) jsonObject.get((Object)key);
			String firm = (String)currentProduct.get((Object)"firm");
			String name = (String)currentProduct.get((Object)"name");
			int amount = (int) ((java.lang.Long)currentProduct.get((Object)"amount")).intValue();
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

	
	/*
	 * Gets a jsonobject
	 * {"form:firm:name":{"firm":"the firm", "amount","price","name","refund",}}
	 * only name, firm, amount are needed to load the rest of the data from the tables.
	 *
	private void getProductsFromJSON(JSONObject jsonObject,SQLConnection sqlConnection)
	{
		Iterator<?> iterator = null;
		JSONObject cart = null;
		try 
		{
			cart = (JSONObject) jsonObject.get((Object)"cart");
			Set<?> keySet = cart.keySet();
			iterator = keySet.iterator();
		}catch(Exception e)
		{
			throw new RuntimeException("something went wrong "+cart+" "+e);
		}
		

		while(iterator.hasNext())
		{
			String key = (String) iterator.next();
			JSONObject currentProduct = (JSONObject) cart.get((Object)key);
			String firm = (String)currentProduct.get((Object)"firm");
			String name = (String)currentProduct.get((Object)"name");
			int amount = (int) ((java.lang.Long)currentProduct.get((Object)"amount")).intValue();
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

	}*/

	public int countProducts()
	{
		return this.products.size();
	}

	public String test()
	{
		String test = this.products.get(0).toString();
		test += this.products.get(1).toString();
		return test;
	}

	@SuppressWarnings("unchecked") //json-simple does not support generics as of yet (it seems)
	public String getJSON()
	{
		JSONObject productJSON = new JSONObject();
		int id = 0;
		for(Product product : products)
		{
			productJSON.put(Integer.toString(id),product.getJSON());
		}

		
		JSONObject total = new JSONObject();

		total.put("price",this.getTotal().toString());
		total.put("refund",this.getTotalRefund().toString());
		total.put("service",this.getTotalServiceCost().toString());

		JSONObject object = new JSONObject();
		object.put("cart",productJSON);
		object.put("total",total);

		return object.toString();
	}

	public Money getTotal()
	{
		//return this.calcTotalPrice().add(calcTotalRefund().add(calcTotalServiceCost()));
		Money result = new Money("0");
		for(Product product : products)
		{
			result = result.add(product.getTotal());
		}
		return result;
	}

	public Money getTotalPrice()
	{
		Money result = new Money("0");
		for(Product product : products)
		{
			result = result.add(product.getPricePerAmount());
		}
		return result;
	}

	public Money getTotalRefund()
	{
		Money result = new Money("0");
		for(Product product : products)
		{
			result = result.add(product.getRefundPerAmount());
		}

		return result;
	}

	/**
	 * Total service cost, the extra charge for carrying everything to the owner
	 * floor * amount in L * SERVICE_COST
	 **/
	public Money getTotalServiceCost()
	{
		float amountInL = 0;
		for(Product product : products)
		{
			amountInL += product.getAmountPerUnit();
		}

		return new Money(this.floor*amountInL*SERVICE_COST);
	}


	public void setOrder()
	{
		SQLConnection sqlConnection = new SQLConnection();
		try 
    	{
			String orderInsertQuery = "insert into orders (userId,service) values (\""+userId+"\",\"1\");";
        	int orderId = sqlConnection.sqlUpdateReturnGenerated(orderInsertQuery);

        	for(Product product : this.products)
        	{
        		product.insertIntoBoughtGoods(sqlConnection,orderId);
        	}
        	//subtract bought goods from the database
    		subtractBoughtGoods(sqlConnection);
    	} catch(SQLException e)
    	{
    		throw new RuntimeException("Problem setting up the order: "+e+" "+this.floor);
    	}
	}

	/**
	 * When the order is complete, subtract the amount of bought goods from the database
	 **/
	private void subtractBoughtGoods(SQLConnection sqlConnection) throws SQLException
	{
		for(Product product : products)
		{
			product.subtractAmountFromDB(sqlConnection);
		}
	}

	private int getFloorFromUserId(String userId)
	{
		SQLConnection sqlConnection = new SQLConnection();
		int floor = 0;
		String getUserQuery = "select * from users where id = \""+userId+"\";";
		try 
    	{
    		ResultSet userResultSet = sqlConnection.sqlQuery(getUserQuery);

			userResultSet.next();
			floor = Integer.parseInt(userResultSet.getString("floor"));
		} catch(SQLException e)
    	{
    		throw new RuntimeException("Problem setting up the order: "+e+" "+floor);
    	}
		return floor;
	}

	public void setProducts(ArrayList<Product> products)
	{
		this.products = products;
	}

	public void setFloor(int floor)
	{
		this.floor = floor;
	}


}