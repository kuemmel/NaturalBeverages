<%@page contentType="text/javascript" %>
/**
 * Initialize modals(e.g the cart)
 **/
$(document).ready(function()
{
	// the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
	$('.modal-trigger').leanModal();
  /**
   * Initialize dropdown
   **/
  $('.dropdown-button').dropdown(
  {
        inDuration: 300,
        outDuration: 225,
        constrain_width: false, // Does not change width of dropdown to that of the activator
        hover: true, // Activate on hover
        gutter: 0, // Spacing from edge
        belowOrigin: true // Displays dropdown below the button
  });
  /**
   * Initialize materialboxes (open up images)
   **/
  $('.materialboxed').materialbox();  
  /**
   * Initialize tabs
   **/
  $('ul.tabs').tabs();
  $('.slider').slider(
  {
    Indicators: true,
    Height: 1000,
    Transition: 50,
    Interval: 6000
  });
});

/**
 * submit the loginForm on pressing enter. --> copy pasted
 **/
$(function()
{
    $('form').each(function()
    {
        $(this).find('input').keypress(function(e)
        {
            // Enter pressed?
            if(e.which == 10 || e.which == 13)
            {
                this.form.submit();
            }
        });

        $(this).find('input[type=submit]').hide();
    });
});

/**
 * Cart functions
 * UPDATE: Most browsers in university are too old to have html5 (and therefore no localStorage).
 * There are two ways to do this now: Cookies and ajax. This is an ajax approach.
 *
 **/

function submitProductForm(formName)
{

  var dialog = 'Added to Cart! <a class=\"btn white-text\" onclick=\"revertAdd(&quot;'+formName+'&quot;)\">revert</a>';
  Materialize.toast(dialog, 2000,"",function() {addToCart(formName)});
}

/**
 * Does not work right now, gets called too soon
 **/
function revertAdd(formName)
{
  var form = document.getElementById(formName);
  form["amount"].value = 0;
}


function setObject(key, value)
{
    document.cookie = key+"="+JSON.stringify(value);
}

function getObject(key)
{
  var name = key + "=";
  var all_cookies = document.cookie.split(';'); //get all cookies
  for(var i=0; i<all_cookies.length;i++)
  {
    var cookie = all_cookies[i];
    while(cookie.charAt(0)== ' ') cookie = cookie.substring(1);
    if(cookie.indexOf(name) == 0) return cookie.substring(name.length,cookie.length);
  }
  return "";
}

/**
 * Add the current product to the cart
 *
function addToCart(formName)
{
  var form = document.getElementById(formName);
  
  if(form["amount"].value > 0)
  {
    var cart = getObject("cart");
    if(cart === "") var cart = {};
    else cart = JSON.parse(cart);
    productHash = {};
    productHash["firm"] = form["firm"].value;
    productHash["price"] = form["price"].value;
    productHash["refund"] = form["refund"].value;
    productHash["amount"] = form["amount"].value;
    productHash["name"] = form["name"].value;

    cart[formName] = productHash;
    setObject("cart",cart);
    //setCart();
  } else
  {
    return;
  }
}*/

/**
 * Returns the data for a product
 **/
function addToCart(formName)
{

  var form = document.getElementById(formName);
  
  if(form["amount"].value > 0)
  {

    productHash = {};
    productHash["firm"] = form["firm"].value;
    productHash["amount"] = form["amount"].value;
    productHash["name"] = form["name"].value;
    var contextPath = "/jsp"
    var data = {"new":JSON.stringify(productHash)};
    $.post(contextPath+"/ProductServlet",data,function(data,status){setProductDetails(data)});
  }
}

function setProductDetails(data)
{
  console.log("data: "+data);
  var cart = getObject("cart");
  if(cart === "") var cart = {};
  else cart = JSON.parse(cart);
  var json = JSON.parse(data);
  productHash = {};
  productHash["firm"] = json["firm"];
  productHash["name"] = json["name"];
  productHash["amount"] =json["amount"];
  productHash["pricePerUnit"] = json["pricePerUnit"];
  productHash["refundPerUnit"] = json["refundPerUnit"];
  productHash["refundPerCrate"] = json["refundPerCrate"];
  productHash["amountPerUnit"] = json["amountPerUnit"];
  productHash["amountPerCrate"] = json["amountPerCrate"];
  productHash["price"] = json["price"];
  productHash["refund"] = json["refund"];
  console.log("productHash: "+productHash);
  cart["firm:"+json["firm"]+":"+json["name"]] = productHash;
  setObject("cart",cart);
}

/**
 * submit cart as a requestparameter for the jsp program and clear the cart
 */
function submitCart()
{
  //load cart
  var cart = getObject("cart");
  var data = {"cart":cart};
  console.log(data);
  if (cart === null || cart === "")
  {
    var cartDiv = document.getElementById("cartDiv");
    cartDiv.innerHTML = "<p><h5>It's no use to submit an empty cart!</h5></p>\n";
    return false;
  }

  document.forms["cartForm"]["cart"].value = cart;
  document.forms["cartForm"].submit();

}

 /**
  * clear the current cart
  */
function clearCart()
{
  deleteCookie("cart");
  setCartDiv();
}

function deleteCookie(name)
{
  document.cookie = name + '=; expires=Thu, 01 Jan 1970 00:00:01 GMT;';
}

/**
 *refresh the cart into the cartDiv <div> in the footer.jsp
 */
function setCartDiv()
{
  var cart = getObject("cart");
  if (cart === null || cart === "" || cart === "{}")
  {
    var cartDiv = document.getElementById("cartDiv");
    cartDiv.innerHTML = "There ain't no wares yet.";
    return false;
  }
  cart = JSON.parse(cart);
  var totalPrice = 0;
  var totalRefund = 0;
  var totalService = 0;
  var amountInL = 0;
  var floor = <%=session.getAttribute("floor")%>;
  var result = "<table id=\"tableCart\"class=\"striped hoverable\">\n  <thead>\n    <tr>\n";
  result += "      <th data-field=\"name\">Product</th>\n";
  result += "      <th data-field=\"firm\">Firm</th>\n";
  result += "      <th data-field=\"name\">refund</th>\n";
  result += "      <th data-field=\"price\">Price</th>\n";
  result += "      <th data-field=\"price\">Amount</th>\n";
  result += "      <th data-field=\"subtotal\">Subtotal</th>\n";
  result += "    </tr>\n";
  result += "  </thead>\n";
  result += "  <tbody>\n";
  for(var key in cart)
  {
    product = cart[key]
    var id = ("cartTable:"+product["firm"]+":"+product["name"]);
    result += "<tr id=\""+id+"\"><td>"+product["name"]+"</td><td>"+product["firm"]+"</td><td>"+product["refundPerUnit"]
    +"</td><td>"+product["pricePerUnit"]+"</td><td>"+product["amount"]+"</td><td><a href=\"#!\" onclick=\"clearProduct(&quot;"
    +id+"&quot;)\"><i class=\"mdi-content-clear red-text\"></a></td><td>"
    +(parseFloat(product["price"])+parseFloat(product["refund"]))+"</td></tr>\n";

    totalPrice += (parseFloat(product["price"])+parseFloat(product["refund"]));
    totalRefund += parseFloat(product["refund"]);
    amountInL += parseFloat(product["amountPerUnit"]);
  }
  totalService = getService(amountInL,floor,0.05);
  result += "  </tbody>\n </table>";
  result += "<p> Total: "+Math.floor(totalPrice*100)/100+"€ " + Math.floor(totalRefund*100)/100+"€ Total Service: "+totalService+"€</p>";
  result += "<p> Total: "+Math.floor((totalPrice+totalService)*100)/100+"€ </p>";
  var cartDiv = document.getElementById("cartDiv");
  cartDiv.innerHTML = result;
} 

/**
 * clears the row of the cart with the given id 
 */
function clearProduct(id)
{
  console.log(id);
  var cart = getObject("cart");
  if (cart === null)
  {
    window.alert("clearProduct(): Something went wrong! There's no cart")
    return false;
  }
  cart = JSON.parse(cart);
  var keyParts = id.split(":");
  var key = "form:"+keyParts[1]+":"+keyParts[2];
  console.log(key+"----");
  delete cart[key];
  for (var key in cart)console.log(key);
  deleteCookie("cart");
  setObject("cart",cart);
  setCartDiv();

}

/**
 * Get the service cost of carrying everything upstairs
 **/
function getService(amount,floor,service_cost)
{
  return Math.floor((amount*floor*service_cost)*100)/100;
}
