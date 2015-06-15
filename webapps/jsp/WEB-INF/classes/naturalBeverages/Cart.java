package naturalBeverages;
import java.util.ArrayList;

public class Cart 
{
	private String userId;
	private ArrayList<Product> products;

	public Cart(String userId)
	{
		this.userId = userId;
	}

	public String returnAsHtmlTable()
	{
		Money price = new Money(0);
		Money refund = new Money(0);
		String head = "";
		String body = "<tbody>";
		String foot = "</tbody></table>";

		head = "<table>\n"
		+"  <thead>\n"
		+"    <tr>\n"
		+"      <th data-field=\"Products\">Products</th>\n"
		+"      <th data-field=\"Firm\">Firm</th>\n"
		+"      <th data-field=\"Price per Bottle\">Price Per Bottle</th>\n"
		+"      <th data-field=\"Refund per Bottle\">Refund Per Bottle</th>\n"
		+"      <th data-field=\"Amount\">Amount</th>\n"
		+"      <th data-field=\"Crate\">Crate</th>\n"
		+"      <th data-field=\"Price\">Price</th>\n"
		+"      <th data-field=\"Refund\">Refund</th>\n"
		+"    </tr>\n"
		+"</thead>\n";

		for(Product product : this.products)
		{
			body += product.returnAsHtmlTableRow();
			refund = refund.add(product.getRefundPerAmount());
			price  = price.add(product.getPricePerAmount());
		}

		foot += "total "+price+" refund "+refund;

		return head+body+foot;

	}
}