
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
 **/

function submitProductForm(formName)
{

  var dialog = 'Added to Cart! <a class=\"btn white-text\" onclick=\"revertAdd(&quot;'+formName+'&quot;)\">revert</a>';
  Materialize.toast(dialog, 3000,"",function() {addToCart(formName)});
}

/**
 * Does not work right now, gets called too soon
 **/
function revertAdd(formName)
{
  var form = document.getElementById(formName);
  form["amount"].value = 0;
}

/**
 * Add the current product to the cart
 **/
function addToCart(formName)
{
  var form = document.getElementById(formName);
  window.alert(form["amount"].value);
  
  if(form["amount"].value > 0)
  {
    var cart = localStorage.getItem("cart");
    if(cart === "") var cart = {};
    else cart = JSON.parse(cart);
    productHash = {};
    productHash["firm"] = form["firm"].value;
    productHash["price"] = form["price"].value;
    productHash["refund"] = form["refund"].value;
    productHash["amount"] = form["amount"].value;
    productHash["name"] = form["name"].value;

    cart[formName] = productHash;
    localStorage.setObject("cart",cart);
    //setCart();
  } else
  {
    return;
  }
}

/**
 * submit cart as a requestparameter for the jsp program and clear the cart
 **/
function submitCart()
{
  //load cart
  var cart = localStorage.getItem("cart");
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


  // send a post to cart.jsp
  /*$.ajax({
    type: "POST",
    url: "modules/cart.jsp",
    dataType: 'html',
    data: data,
    success: function(response)
    {
        console.log("response: "+response);
    }
  });*/
  //console.log("test");

  //clearCart();
}
 
 /**
  * clear the current cart
  **/ 
function clearCart()
{
  localStorage.setItem("cart","");
  //setCart();
}

/**
 *refresh the cart into the cartDiv <div> in the footer.jsp
 **/
function setCartDiv()
{
  var cart = localStorage.getItem("cart");
  if (cart === null || cart === "" || cart === "{}")
  {
    var cartDiv = document.getElementById("cartDiv");
    cartDiv.innerHTML = "There ain't no wares yet.";
    return false;
  }
  cart = JSON.parse(cart);
  var totalPrice = 0;
  var result = "<table id=\"tableCart\"class=\"striped hoverable\">\n  <thead>\n    <tr>\n";
  result += "      <th data-field=\"name\">Product</th>\n";
  result += "      <th data-field=\"firm\">Firm</th>\n";
  result += "      <th data-field=\"name\">refund</th>\n";
  result += "      <th data-field=\"price\">Price</th>\n";
  result += "      <th data-field=\"price\">Amount</th>\n";
  result += "    </tr>\n";
  result += "  </thead>\n";
  result += "  <tbody>\n";
  for(var key in cart)
  {
    product = cart[key]
    var id = ("cartTable:"+product["firm"]+":"+product["name"]);
    result += "<tr id=\""+id+"\"><td>"+product["name"]+"</td><td>"+product["firm"]+"</td><td>"+product["refund"]
    +"</td><td>"+product["price"]+"</td><td>"+product["amount"]+"</td><td><a href=\"#!\" onclick=\"clearProduct(&quot;"+id+"&quot;)\"><i class=\"mdi-content-clear red-text\"></a></td></tr>\n";
    totalPrice += (parseFloat(product["price"])+parseFloat(product["refund"]))*parseInt(product["amount"]);

  }
  result += "  </tbody>\n </table>";
  result += "<p> total: "+totalPrice+"€";
  var cartDiv = document.getElementById("cartDiv");
  cartDiv.innerHTML = result;
}

/**
 * clears the row of the cart with the given id 
 **/
function clearProduct(id)
{
  console.log(id);
  var cart = localStorage.getItem("cart");
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
  localStorage.setObject("cart",cart);


  //var table = document.getElementById("tableCart");
  //var tableRow = document.getElementById(id);
  //tableRow.parentNode.removeChild(tableRow);

  //table.removeChild(tableRow);
  setCart();

}

Storage.prototype.setObject = function(key, value)
{
    this.setItem(key, JSON.stringify(value));
}
/**
 * Remember values
 *

function saveHash(name,hash)
{
  localStorage.setObject(name,hash);
}

function loadhash(name)
{
  var hash = localStorage.getItem(name);
  return JSON.parse(hash);
}
*/
