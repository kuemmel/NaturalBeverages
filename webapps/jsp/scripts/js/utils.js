
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
