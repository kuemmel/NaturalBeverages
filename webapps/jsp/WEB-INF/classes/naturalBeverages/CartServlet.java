package naturalBeverages;
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.ArrayList;
import java.util.Set;
import java.util.Iterator;
import java.sql.*;
import org.json.simple.*;
import java.util.Enumeration;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.WebInitParam;

/**
 * Takes a json object as a request POST parameter in the form of
 * {name:"name",firm:"name",amount:"amont"}
 * loads another json Object as a string from session (whole objects just would not save)
 * combines those strings with the Cart object and returns the result(as json)
 * servlet-lib-path: H:\Programme\XAMPP\tomcat\lib\servlet-api.jar
 * javac -cp ..\..\lib\json_simple-1.1.jar;servlet-lib-path .\CartServlet.java Cart.java Product.java Money.java SQLConnection.java
 * javac -cp ..\..\lib\json_simple-1.1.jar;H:\Programme\XAMPP\tomcat\lib\servlet-api.jar .\CartServlet.java Cart.java Product.java Money.java SQLConnection.java
 **/
@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet
{
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();	
		String cartString = (String) session.getAttribute("cart");
		String userId = (String) session.getAttribute("userID");
		JSONObject cart = null;
		Cart cartObject = null;

		//if(true) throw new RuntimeException(cartString);
	
		if(userId == null) throw new RuntimeException("Not logged in.");
		if(cartString == null) // there is no cart as of yet
		{
			cartObject = new Cart(userId);
		} else //load cartjson Object from string
		{
			cart = (JSONObject) JSONValue.parse(cartString);
			cartObject = new Cart(userId,cart);
		}

		String newProductJson = request.getParameter("new");
		if(newProductJson != null) { //add a new product
			JSONObject jsonObject = (JSONObject) JSONValue.parse(newProductJson);
			if(jsonObject == null) throw new RuntimeException("requestparameter was empty.");
			
			cartObject.addProduct(jsonObject);

			cartString = cartObject.getJSON();
		} else //delete product from cart
		{
			String name = request.getParameter("name");
			String firm = request.getParameter("firm");
			
			
		}
		if(true)throw new RuntimeException(cartObject.countProducts()+"");
		session.setAttribute("cart",cartString);
		out.println(cartString);
	}

	public void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException
	{
        doPost(request,response);
    }
}