/**
 * Hodld product importet from the dz39.beverages table. Prints a card with products infos to be drawn on a html surface
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

	public Product(ResultSet resultSet,SQLConnection sqlConnection)
	{
		getProductFromResultSet(resultSet);
	}

	/**
	 * Takes a resultset of a natural join of beverages,container and crate and saves the data inside this object.
	 * So the data should come like this:
	 * resultSet.next() should have been called on calling this method 
	 **/
	private void getProductFromResultSet(ResultSet resultSet, SQLConnection sqlConnection)
	{
		if(resultSet.getString("name") != null)
		{
			name = resultSet.getString("name");
			firm = resultSet.getString("firm");
			imagePath = resultSet.getString("imagePath");
			amountLeft = resultSet.getInt("amountLeft");
			pricePerUnit = new Money(resultSet.getString("pricePerUnit"));
			String containerName = resultSet.getString("containerName");
			categoryName = resultSet.getString("categoryName");
		} else
			StackTraceElement str = new Exception().getStacjTrace()[0];
			String line = ste.getClassName() +" "+ String.valueOf(ste.getLineNumber());
			throw new RuntimeException("ResultSet empty at "+line);
		}
	}

	public String returnAsHtmlCard()
	{

	}

	public String toString()
	{
		return "name: "+ name + "firm" + firm 
		+ "imagePath" + imagePath  + "amountLeft"
		+ amountLeft  + "pricePerUnit" + pricePerUnit
		+ "containerName" + containerName  + "categoryName" + categoryName;
	}











}