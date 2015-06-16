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
