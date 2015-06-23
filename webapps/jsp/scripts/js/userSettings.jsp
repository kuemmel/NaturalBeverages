<%@page contentType="text/javascript" %>
	/**
	 * validate each input, such that it's not empty or wrong in case of password. zipcode, email,..
	 **/
	function validate(form)
	{
		var valid = true;
		var message = "";
		var hash = {};
		hash["email"] 			= form["email"].value;
		hash["repeatEmail"]		= form["repeatEmail"].value;
		hash["nick"] 			= form["nick"].value;
		hash["oldPassword"]     = form["oldPassword"].value;
		hash["password"] 		= form["password"].value;
		hash["repeatPassword"]	= form["repeatPassword"].value;		
		hash["name"] 			= form["name"].value;
		hash["surname"] 		= form["surname"].value;
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

	  	if(hash["password"] === "new password" && hash["repeatPassword"] === "repeat password")
	  	{
	  		form["password"].type = "password";
	  		form["repeatPassword"].type = "password";
	  		hash["password"] = form["password"].value = form["oldPassword"].value;
	  		hash["repeatPassword"] = form["repeatPassword"].value = form["oldPassword"].value;
	  	}

	  	if(!(hash["password"] === hash["repeatPassword"]))
	  	{
	  		message += "Passwords do not match!\n";
	  		hash["password"] = "";
	  		hash["repeatPassword"] = "";
			valid = false;
	  	}

	  	if(!(hash["email"] === hash["repeatEmail"]))
	  	{
	  		message += "Emails do not match!\n";
	  		hash["email"] = "";
	  		hash["repeatEmail"] = "" ;
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
	  	if(!hash["email"].match(/^([a-zA-z\-\.0-9]+@[a-zA-z\-\+]+\.[a-z]+)$/))
	  	{
	  		message += "no valid email address.\n";
	  		hash["email"] = "";
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
			window.alert("Email already in use (MySQL Err 1062)");
			<% session.removeAttribute("sqlErrorCode"); %>
		}

	}

	Storage.prototype.setObject = function(key, value)
	{
	    this.setItem(key, JSON.stringify(value));
	}
