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
