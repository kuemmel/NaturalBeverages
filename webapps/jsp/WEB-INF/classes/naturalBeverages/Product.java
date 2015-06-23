package naturalBeverages;
import java.sql.*;
import org.json.simple.*;
/**
 * Hold a product imported from the dz39.beverages table joined with crates, containers and categories.
 * Prints a card with product infos to be drawn on a html surface
 *
 **/

public class Product
{
	private String name;
	private String firm;
	private String imagePath;
	private int    amountLeft;
	private Money  pricePerUnit;
	private float  amountPerUnit;
	private Money  refundPerUnit;
	private Money  refundPerCrate;
	private int    amountPerCrate;
	private String categoryName;

	// the amount of products to be bought
	private int amount;

	public Product(ResultSet resultSet)
	{
		getProductFromResultSet(resultSet);
		this.amount = 0;
	}

	public Product(JSONObject jsonObject)
	{
		getProductFromJSON(jsonObject);
	}

	/**
	 * Takes a resultset of a left join of beverages,container,crates and categories and saves the data inside this object.
	 * -> for a deeper explanation check SQLConnection::getProducts()
	 * The data should come like this:
	 *  beverages.name, firm, imagePath, amountLeft, pricePerUnit, amountPerUnit, containers.refund,
	 *  amountPerCrate, crates.refund, categories.name
	 *  -> resultSet.next() should have been called on calling this method 
	 **/
	private void getProductFromResultSet(ResultSet resultSet)
	{
		try
		{
			name 			= resultSet.getString("name");
			firm 			= resultSet.getString("firm");
			imagePath 		= resultSet.getString("imagePath");
			amountLeft 		= resultSet.getInt("amountLeft");
			pricePerUnit 	= new Money(resultSet.getString("pricePerUnit"));
			amountPerUnit 	= resultSet.getFloat("amountPerUnit");
			refundPerUnit 	= new Money(resultSet.getString("containers.refund"));
			amountPerCrate 	= resultSet.getInt("amountPerCrate");
			refundPerCrate 	= new Money(resultSet.getString("crates.refund"));
			categoryName 	= resultSet.getString("category");
		} catch(Exception e)
		{
			String stackTrace = e.getStackTrace().toString();
			StackTraceElement ste = new Exception().getStackTrace()[0];
			String line = ste.getClassName() +" "+ String.valueOf(ste.getLineNumber());
			throw new RuntimeException("ResultSet empty trying to get products: "+e+" "+" "+stackTrace+" "+line);
		}
	}
	
	/**
	 * Add a single product to the cart from a jsonString which looks like
	 * {"name":"\s+","firm":"\s+","amount":\d+}
	 *
	 *
	 * @todo write new method addSingleProduct(name,firm,amount)
	 * which is called from addProduct and getProductsFromJSON
	 **/
	public void getProductFromJSON(JSONObject jsonObject)
	{
		SQLConnection sqlConnection = new SQLConnection();
		try
		{
			String name = (String) jsonObject.get((Object)"name");
			String firm = (String) jsonObject.get((Object)"firm");
			int amount = Integer.parseInt((String) jsonObject.get((Object)"amount"));

			ResultSet resultSet = sqlConnection.getProductByNameAndFirm(name,firm);
			resultSet.next();
			getProductFromResultSet(resultSet);
			this.setAmount(amount);
		} catch (Exception e)
		{
			throw new RuntimeException("error loading single product from db "+e);
		}
	}


	public void insertIntoBoughtGoods(SQLConnection sqlConnection, int orderId) throws SQLException
	{
		String query = "insert into boughtgoods (orderId,beverageName,crate,amount) values (\""+orderId+"\",\""+this.name+"\",\"1\",\""+this.amount+"\");";
		sqlConnection.sqlUpdate(query);
	}

	public void subtractAmountFromDB(SQLConnection sqlConnection) throws SQLException
	{
		if(amountLeft-amount < 0) throw new RuntimeException("amountleft < 0");
	    String query = "update beverages set amountLeft ="+(amountLeft-amount)+" where beverages.name =\""+this.name
	    	+"\" and beverages.firm = \""+this.firm+"\";";

        sqlConnection.sqlUpdate(query);
	}

	@SuppressWarnings("unchecked") //json-simple does not support generics as of yet (it seems)
	public JSONObject getJSON()
	{
		JSONObject object = new JSONObject();

		object.put("name",this.name);
		object.put("firm",this.firm);
		object.put("amount",this.amount);
		object.put("pricePerUnit",this.pricePerUnit.toString());
		object.put("amountPerUnit",this.amountPerUnit);
		object.put("refundPerUnit",this.refundPerUnit.toString());
		object.put("refundPerCrate",this.refundPerCrate.toString());
		object.put("amountPerCrate",this.amountPerCrate);
		object.put("price",this.getPricePerAmount().toString());
		object.put("refund",this.getRefundPerAmount().toString());

		return object;
	}

	public String isInStock()
	{
		if(amountLeft == 0)
		{
			return "not available.";
			
		} else if(amountLeft <= amountPerCrate)
		{
			return "only "+amountLeft+" left!";
		} else
		{
			return "in Stock!";
		}
	}

	public void setAmount(int amount)
	{
		this.amount = amount;
	}

	public String toString()
	{
		return ("name " + name + "firm " + firm + "imagePath " + imagePath + "amountLeft "
		+ amountLeft + "pricePerUnit " + pricePerUnit + "amountPerUnit " + amountPerUnit + "refundPerUnit "
		+ refundPerUnit + "refundPerCrate " + refundPerCrate + "amountPerCrate "
		+ amountPerCrate + "categoryName " + categoryName);
	}

	public Money getTotal()
	{
		return getPricePerAmount().add(getRefundPerAmount());
	}

	/**
	 * Returns the refund. If there are enough bottle to be put into a crate, the refund for the crate is added.
	 * 
	 **/
	public Money getRefundPerAmount()
	{
		Money refundPerAmount = refundPerUnit.multiply(this.amount);
		if(this.amount > this.amountPerCrate)
		{
			Money crateRefund = refundPerCrate.multiply((int)Math.floor(this.amount/this.amountPerCrate));	
			return refundPerAmount.add(crateRefund);	
		}
		
		return refundPerAmount;
	}

	public Money getPricePerAmount()
	{
		return pricePerUnit.multiply(this.amount);
	}

	public Money getRefundPerCrate()
	{
		return refundPerUnit.multiply(amountPerCrate).add(refundPerCrate);
	}

	public Money getPricePerCrate()
	{
		return pricePerUnit.multiply(amountPerCrate);
	}

	public String getName()
	{
		return name;
	}
	public String getFirm()
	{
		return firm;
	}
	public String getImagePath()
	{
		return imagePath;
	}
	public int getAmountLeft()
	{
		return amountLeft;
	}
	public Money getPricePerUnit()
	{
		return pricePerUnit;
	}
	public float getAmountPerUnit()
	{
		return amountPerUnit;
	}
	public Money getRefundPerUnit()
	{
		return refundPerUnit;
	}
	public Money getCrateRefund()
	{
		return refundPerCrate;
	}
	public int getAmountPerCrate()
	{
		return amountPerCrate;
	}
	public String getCategoryName()
	{
		return categoryName;
	}

	public int getBoughtAmount()
	{
		if(amount == 0)
		{
			throw new RuntimeException("Product has not been bought // amount = 0!");
		}
		return this.amount;
	}
}