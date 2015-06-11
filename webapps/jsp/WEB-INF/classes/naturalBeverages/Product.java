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
		  +"          <span class=\"card-title\" style=\"padding-left:10px;\">"+this.name+"("+this.amountPerUnit+"L)</span>"
		  +"            <div style=\"padding-left:20px;\">"+categoryName+"</div>"
		  +"        </div>"
		  +"        <div class=\"card-content col\" >"
		  +"          <table>"
		  +"            <tr><td>"+isInStock()+"</td></tr>"
		  +"            <tr><td>"+firm+"</td></tr>"
		  +"            <tr><td>Price:</td><td>"+pricePerUnit.toStrig()+"</td></tr>"
		  +"            <tr><td>Refund:</td><td>"+refundPerUnit.toString()+"</td></tr>"
		  +"            <tr><td>Crate:</td><td>"+getPricePerCrate().toString()+"("+amountPerCrate+")</td></tr>"
		  +"            <tr><td>Refund per crate:</td><td>"+getRefundPerCrate().toString()+"refund per crate</td></tr>"
		  +"          </table>"
		  +"        </div>"
		  +"      </div>"
		  +"      <div class=\"row\">"
		  +"        <div class=\"card-action\" > <!--style=\"background-color:green;\"-->"
		  +"          <form action=\"\" name=\""+name+firm+"Form\" method=\"GET\">"
		  +"            <div class=\"col\" style=\"width:30%;\">"
		  +"                <p>"
		  +"                  <button class=\"btn waves-effect waves-light col\" name=\""+name+firm+"\" type=\"submit\">Add to cart"
		  +"                </p>"
		  +"               <i class=\"mdi-content-send right\"></i>"
		  +"              </button>"
		  +"            </div>"
		  +"            <div class=\"col\" style=\"width:70%;\">"
		  +"              <p class=\"range-field\">"
		  +"                <input type=\"range\" name =\""+name+firm+"Amount\" class=\"col\" id=\"test5\" min=\"1\" max=\""+amountLeft+"\" style=\"width:100%;\" /> <!--style=\"overflow:hidden\";-->"
		  +"              </p>"
		  +"            </div>"
		  +"          </form>"
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