<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<HEAD>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<TITLE>Register</TITLE>
	<SCRIPT TYPE="text/javascript">
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
		if (form.name == "password" ||form.name == "repeatPassword")
		{
			form.type = "password";
		}

		if(form.value === form.defaultValue)
		{
			form.value = '';
		}
	}
	/**
	 * validate each input, such that it's not empty or wrong in case of password. zipcode, email,..
	 **/
	function validate(form)
	{
		var valid = true;
		var message = "";
		var hash = {};
		hash["email"] 			= form["email"].value;
		hash["nick"] 			= form["nick"].value;
		hash["password"] 		= form["password"].value;
		hash["repeatPassword"]	= form["repeatPassword"].value;		
		hash["name"] 			= form["name"].value;
		hash["surname"] 		= form["surname"].value;
		hash["dateOfBirth"]		= form["dateOfBirth"].value;
		hash["address"] 		= form["address"].value;
		hash["floor"] 			= form["floor"].value;
		hash["zipCode"] 		= form["zipCode"].value;

	 	for (var value in hash)	
	 	{
			if (hash[value] == null || hash[value] == "" || hash[value] === value)
			{
				message += value+" must be set!\n";
				valid = false;
			}
	  	}

	  	if(!(hash["password"] == hash["repeatPassword"]))
	  	{
	  		message += "Passwords do not match!\n";
	  		hash["password"] = "";
	  		hash["repeatPassword"] = "";
			valid = false;
	  	}

		if(!hash["password"].match(/((?=.*\d)(?=.*[a-zA-Z])(?=.*[!"§$%&\/()=?\.\,-<>]).{6,20})/) )
		{
			message += "Password needs to have at least 6 characters, a number and a special character!\n";
			hash["password"] = "";
			valid = false;
		}	
	  	if(!hash["zipCode"].match(/\d+/))
	  	{
	  		message += "zipCode must consist of numbers. \n";
	  		hash["zipCode"] = "";
			valid = false;
	  	}
	  	if(!hash["floor"].match(/\d{1,2}/))
	  	{
	  		message += "You live on the "+hash["floor"]+"floor?!\n";
	  		hash["floor"] = "";
			valid = false;
	  	}
	  	if(!hash["email"].match(/^([a-zA-z\-]+@[a-zA-z\-\+]+\.[a-z]+)$/))
	  	{
	  		message += "no valid email address.\n";
	  		hash["email"] = "";
			valid = false;
	  	}
	  	if(!hash["dateOfBirth"].match(/^\d\d\.\d\d\.\d{4}/))
	  	{
	  		message += "Date must be dd.mm.yyyy. eg: 06.06.1945 \n";
	  		valid = false;
	  	}

	  	if(!valid)
	  	{
	  		window.alert(message);
	  		rememberFormInput(hash);
	  		return false;
	  	}
	}

	function rememberFormInput(hash)
	{
		localStorage.setObject("hash",hash);
	}
	/**
	 * If registering failed due to wrong input, remember the values
	 * and if there's a sql error message, print it.
	 **/
	function loadFormInput()
	{
		var sqlError = <%=session.getAttribute("sqlErrorCode") %>;
		if (sqlError === 1062)
		{
			window.alert("Email already in use (MySQL Err 1062)")
		}

		var hash = localStorage.getItem("hash");
		hash = JSON.parse(hash);
		if(hash != null)
		{
			var form = document.forms["form"];
			if(hash["email"]) form["email"].value = hash["email"];
			if(hash["nick"]) form["nick"].value = hash["nick"];
			if(hash["name"]) form["name"].value = hash["name"];
			if(hash["password"])
			{
				form["password"].value = hash["password"];
				form["password"].type = "password";
			}
			if(hash["repeatPassword"])
			{
				form["repeatPassword"].value = hash["repeatPassword"];
				form["repeatPassword"].type = "password";
			}
			if(hash["surname"]) form["surname"].value = hash["surname"];
			if(hash["dateOfBirth"]) form["dateOfBirth"].value = hash["dateOfBirth"];
			if(hash["address"]) form["address"].value = hash["address"];
			if(hash["floor"]) form["floor"].value = hash["floor"];
			if(hash["zipCode"]) form["zipCode"].value = hash["zipCode"];
		}
	}

	Storage.prototype.setObject = function(key, value)
	{
	    this.setItem(key, JSON.stringify(value));
	}

	</SCRIPT>
</HEAD>
<BODY onload="loadFormInput()">
	Register here. <a href="index.jsp">Home</a>
	<hr>
	<form method="post" name="form" action="registration.jsp" onsubmit="return(validate(this));">
		Email:
		<input type="text" name="email" value="email" onblur="onBlur(this)" onfocus="onFocus(this)" /> <br />
		Nick:
		<input type="text" name="nick" value="nick" onblur="onBlur(this)" onfocus="onFocus(this)" /> <br />
		Password:
		<input type="text" name="password" value="password" onblur="onBlur(this)" onfocus="onFocus(this)" /> 
		<input type="text" name="repeatPassword" value="repeat password" onblur="onBlur(this)" onfocus="onFocus(this)" /> <br />
		<hr>
		Name:
		<input type="text" name="name" value="name" onblur="onBlur(this)" onfocus="onFocus(this)" /> <br />
		Surname:
		<input type="text" name="surname" value="surname" onblur="onBlur(this)" onfocus="onFocus(this)" /> <br />
		Date Of Birth:
		<input type="text" name="dateOfBirth" value="dateOfBirth" onblur="onBlur(this)" onfocus="onFocus(this)" /> <br />
		Address:
		<input type="text" name="address" value="address" onblur="onBlur(this)" onfocus="onFocus(this)" /> <br />
		Floor:
		<input type="text" name="floor" value="floor" onblur="onBlur(this)" onfocus="onFocus(this)" /> <br />
		ZipCode:
		<input type="text" name="zipCode" value="zipCode" onblur="onBlur(this)" onfocus="onFocus(this)" /> <hr>
		<input type="submit" name="submit" value="register"/>
	</form>
</BODY>
</HTML>