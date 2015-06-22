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
 * loads a single Product from values and returns as json
 * servlet-lib-path: H:\Programme\XAMPP\tomcat\lib\servlet-api.jar
 * javac -cp ..\..\lib\json_simple-1.1.jar;servlet-lib-path .\CartServlet.java Cart.java Product.java Money.java SQLConnection.java
 * javac -cp ..\..\lib\json_simple-1.1.jar;H:\Programme\XAMPP\tomcat\lib\servlet-api.jar .\CartServlet.java Cart.java Product.java Money.java SQLConnection.java
 **/
@WebServlet("/ProductServlet")
public class ProductServlet extends HttpServlet
{
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		PrintWriter out = response.getWriter();

		String newProductJson = request.getParameter("new");
		if(newProductJson != null) { //add a new product
			JSONObject jsonObject = (JSONObject) JSONValue.parse(newProductJson);
			if(jsonObject == null) throw new RuntimeException("requestparameter was empty.");
			Product product = new Product(jsonObject);
			out.println(product.getJSON());
		}
		
	}

	public void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException
	{
        doPost(request,response);
    }
}