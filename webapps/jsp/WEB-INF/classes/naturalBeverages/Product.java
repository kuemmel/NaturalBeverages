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

	public Product(ResultSet resultSet)
	{
		getProductFromResultSet(resultSet);
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
		if(resultSet.getString("name") != null)
		{
			name 			= resultSet.getString("name");
			firm 			= resultSet.getString("firm");
			imagePath 		= resultSet.getString("imagePath");
			amountLeft 		= resultSet.getInt("amountLeft");
			pricePerUnit 	= new Money(resultSet.getString("pricePerUnit"));
			amountPerUnit 	= resultSet.getInt("amountPerUnit");
			refundPerUnit 	= new Money(resultSet.getString("containers.refund"));
			amountPerCrate 	= resultSet.getInt("amountPerCrate");
			refundPerCrate 	= new Money(resultSet.getString("crates.refund"));
			categoryName 	= resultSet.getString("categoryName");
		} else
			StackTraceElement str = new Exception().getStacjTrace()[0];
			String line = ste.getClassName() +" "+ String.valueOf(ste.getLineNumber());
			throw new RuntimeException("ResultSet empty at "+line);
		}
	}
	/**
	 * 
	 *
	 * @todo: add \n if necessary
	 **/
	public String returnAsHtmlCard()
	{
		 String card = 
		   "<div class=\"row\">"
		  +"  <div class=\"col s4 m4 l4\">"
		  +"    <div class=\"card brown darken-3 white-text\">"
		  +"      <div class=\"row\">"
		  +"        <div class=\"col\">"
		  +"          <div class=\"card-image row\" style=\"margin-top:20px;\">"
		  +"            <img src=\""+this.imagePath+"\" style=\"max-height:250px;max-width:250px;\">"
		  +"          </div>"
		  +"          <span class=\"card-title\" style=\"padding-left:10px;\">"+this.name+": "+this.amountPerUnit+"L</span>"
		  +"        </div>"
		  +"        <div class=\"card-content col\" >"
		  +"          <table>"
		  +"            <tr><td>In "+isInStock()+"</td></tr>"
		  +"            <tr><td>"+firm+"</td></tr>"
		  +"            <tr><td>"+pricePerUnit.toStrig()+"</td><td>1.20€</td></tr>"
		  +"            <tr><td>"+refundPerUnit.toString()+"</td><td>1.20€</td></tr>"
		  +"            <tr><td>"+getPricePerCrate().toString()+"(anzahl)</td><td>1.20€</td></tr>"
		  +"            <tr><td>"+getRefundPerCrate().toString()+"refund per crate</td><td>1.20€</td></tr>"
		  +"            <tr><td></td><td>"+categoryName+"</td></tr>"
		  +"          </table>"
		  +"        </div>"
		  +"      </div>"
		  +"      <div class=\"row\">"
		  +"        <div class=\"card-action\" >"
          +"		  <form action=\"\" method=\"GET\">"
          +"		    <input type=\"hidden\" value=\""+ +"\" name=\""++"\" />"
          +"		    <button class=\"btn waves-effect waves-light\" type=\"submit\">Add to cart"
          +"		     <i class=\"mdi-content-send right\"></i>"
          +"		    </button>"
          +"		  </form>"
		  +"        </div>"
		  +"      </div>"
		  +"    </div>"
		  +"  </div>"
		  +"</div>";

		return card;
	}

	private String isInStock()
	{
		if(amountLeft <= amountPerCrate)
		{
			return "only "+amountLeft+" left!";
		} else if(amountLeft == 0)
		{
			return "not available."
		} else
		{
			return "in Stock!";
		}
	}

	public String toString()
	{
		return "name: "+ name + "firm" + firm 
		+ "imagePath" + imagePath  + "amountLeft"
		+ amountLeft  + "pricePerUnit" + pricePerUnit
		+ "containerName" + containerName  + "categoryName" + categoryName;
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
	public int    getAmountLeft()
	{
		return amountLeft;
	}
	public Money  getPricePerUnit()
	{
		return pricePerUnit;
	}
	public float  getAmountPerUnit()
	{
		return amountPerUnit;
	}
	public Money  getRefundPerUnit()
	{
		return refundPerUnit;
	}
	public Money  getRefundPerCrate()
	{
		return refundPerCrate;
	}
	public int    getAmountPerCrate()
	{
		return amountPerCrate;
	}
	public String getCategoryName()
	{
		return categoryName;
	}
}