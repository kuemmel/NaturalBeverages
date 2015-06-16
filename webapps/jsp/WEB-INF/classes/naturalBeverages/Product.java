package naturalBeverages;
import java.sql.*;
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
	// if bought as crates
	private boolean crate;

	public Product(ResultSet resultSet)
	{
		getProductFromResultSet(resultSet);
		this.amount = 0;
		this.crate = false;
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
		} catch(SQLException e)
		{
			StackTraceElement ste = new Exception().getStackTrace()[0];
			String line = ste.getClassName() +" "+ String.valueOf(ste.getLineNumber());
			throw new RuntimeException("ResultSet empty trying to get products: "+e+" "+line);
		}
	}

	public String returnAsHtmlTableRow()
	{
		return "<tr>\n"
			+	  "<td>"+this.name+"</td>\n"
			+	  "<td>"+this.firm+"</td>\n"
			+	  "<td>"+pricePerUnit+"</td>\n"
			+	  "<td>"+refundPerUnit+"</td>\n"
			+	  "<td>"+this.amount+"</td>\n"
			+	  "<td>"+((crate)? "yes" : "no" )+"</td>\n"
			+	  "<td>"+getPricePerAmount()+"</td>\n"
			+	  "<td>"+getRefundPerAmount()+"</td>\n"
			+	"</tr>\n";
	}

	/**
	 * 
	 *
	 * @todo: add \n if necessary
	 **/
	public String returnAsHtmlCard(String contextPath)
	{
		 String card = 
		   "<div class=\"row\">\n"
		  +"  <div class=\"col s8 m8 l8\">\n" 
		  +"    <div class=\"card .mainColor z-depth-3 white-text\">\n"
		  +"      <div class=\"row\">\n"
		  +"        <div class=\"col\">\n"
		  +"          <div class=\"card-image row\" style=\"margin-top:20px;\">\n"
		  +"            <img src=\""+contextPath+this.imagePath+"\" style=\"max-height:250px;max-width:250px;padding-left:10px;\">\n"
		  +"          </div>\n"
		  +"          <span class=\"card-title\" style=\"padding-left:20px;\">"+this.name+"("+this.amountPerUnit+"L)</span>\n"
		  +"            <div style=\"padding-left:20px;\">"+categoryName+"</div>\n"
		  +"        </div>\n"
		  +"        <div class=\"card-content col\" >\n"
		  +"          <table>\n"
		  +"            <tr><td>"+isInStock()+"</td></tr>\n"
		  +"            <tr><td>"+firm+"</td></tr>\n"
		  +"            <tr><td>Price:</td><td>"+pricePerUnit.toString()+"</td></tr>\n"
		  +"            <tr><td>Refund:</td><td>"+refundPerUnit.toString()+"</td></tr>\n"
		  +"            <tr><td>Crate:</td><td>"+getPricePerCrate().toString()+"("+amountPerCrate+")</td></tr>\n"
		  +"            <tr><td>Refund per crate:</td><td>"+getRefundPerCrate().toString()+"</td></tr>\n"
		  +"			<tr><td>current price:</td><td><span name=\"priceSpan\">"+getPricePerUnit().toString()+"</td></tr>\n"
		  +"          </table>\n"
		  +"        </div>\n"
		  +"      </div>\n"
		  +"      <div class=\"row\">\n"
		  +"        <div class=\"card-action\" >\n"
		  +"          <form action=\"\" name=\"form\" method=\"GET\">\n"
		  +"            <div class=\"col\" style=\"width:30%;\">\n"
		  +"                  <button class=\"btn waves-effect waves-light col\" name=\""+"button"+"\" type=\"submit\">Add to cart\n"
		  +"               <i class=\"mdi-content-send right\"></i>\n"
		  +"              </button>\n"
		  +"            </div>\n"
		  +"            <div class=\"col\" style=\"width:70%;\">\n"
		  +"              <p class=\"range-field\">\n"
		  +"                <input type=\"range\" name =\"amount\" value=\"0\" class=\"col\" min=\"1\" max=\""+amountLeft+"\" style=\"width:100%;\" /> <!--style=\"overflow:hidden\";-->\n"
		  +"              </p>\n"
		  +"            </div>\n"
		  +"          </form>\n"
		  +"        </div>\n"
		  +"      </div>\n"
		  +"    </div>\n"
		  +"  </div>\n"
		  +"</div>\n";

		return card;
	}

	public String isInStock()
	{
		if(amountLeft <= amountPerCrate)
		{
			return "only "+amountLeft+" left!";
		} else if(amountLeft == 0)
		{
			return "not available.";
		} else
		{
			return "in Stock!";
		}
	}

	public String toString()
	{
		return ("name " + name + "firm " + firm + "imagePath " + imagePath + "amountLeft "
		+ amountLeft + "pricePerUnit " + pricePerUnit + "amountPerUnit " + amountPerUnit + "refundPerUnit "
		+ refundPerUnit + "refundPerCrate " + refundPerCrate + "amountPerCrate "
		+ amountPerCrate + "categoryName " + categoryName);
	}

	public Money getRefundPerAmount()
	{
		return refundPerUnit.multiply(this.amount).add((crate)? refundPerCrate : new Money(0));
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
}