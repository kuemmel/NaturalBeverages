
/**
 * Initialize modals(e.g the cart)
 **/
$(document).ready(function()
{
	// the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
	$('.modal-trigger').leanModal();
	$("[type=range]").change(function()
 	{
    	var amount=$(this).val()*document.getElementById("priceSpan").placeholder;
    	$("#priceSpan").text(amount);
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
 * Initialize dropdown
 **/
$('.dropdown-button').dropdown(
{
      inDuration: 300,
      outDuration: 225,
      constrain_width: false, // Does not change width of dropdown to that of the activator
      hover: true, // Activate on hover
      gutter: 0, // Spacing from edge
      belowOrigin: false // Displays dropdown below the button
});

/**
 * Initialize tabs
 **/
$(document).ready(function()
{
	$('ul.tabs').tabs();
});

/**
 * Cart functions
 **/

function submitProductForm(formName)
{
  Materialize.toast('Added to Cart! <a class=\"btn white-text\" onclick=\"revertAdd(&quot;'+formName+'&quot;)\">revert</a>', 3000,'',addToCart(formName));
}

function revertAdd(formName)
{
  var form = document.getElementById(formName);
  form["amount"].value = 0;
}

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
    localStorage.setObject("cart",cart)
    setCart();
  } else
  {
    return
  }
}
  
function clearCart()
{
  localStorage.setItem("cart","");
  setCart();
}

/**
 *refresh the cart
 **/
function setCart()
{
  var cart = localStorage.getItem("cart");
  if (cart === null)
  {
    cartDiv.innerHTML = "There ain't no wares yet.";
  }
  cart = JSON.parse(cart);
  var totalPrice = 0;
  var result = "<table class=\"striped\">\n  <thead>\n    <tr>\n";
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
    result += "<tr><td>"+product["name"]+"</td><td>"+product["firm"]+"</td><td>"+product["refund"]
    +"</td><td>"+product["price"]+"</td><td>"+product["amount"]+"</td></tr>\n";
    totalPrice += (parseFloat(product["price"])+parseFloat(product["refund"]))*parseInt(product["amount"]);

  }
  result += "  </tbody>\n </table>";
  result += "<p> total: "+totalPrice+"€";
  var cartDiv = document.getElementById("cartDiv");
  cartDiv.innerHTML = result;
}


/**
 * Delete and re-insert default values into fields
 * also change form type to password in the password field
 **/
function onBlur(form)
{
	if(form.value === '')
	{
		form.value = form.defaultValue;
	}
}
function onFocus(form)
{
	if (form.name.match(/.*(password).*/i)) //caseInsensitive
	{
		form.type = "password";
	}

	if(form.value === form.defaultValue)
	{
		form.value = '';
	}
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
