<%@page contentType="text/javascript" %>

	/**
	 * validate each input, such that it's not empty or wrong in case of password. zipcode, email,..
	 **/
	function validate()
	{
		var valid = true;
		var form = document.getElementById("form");
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
	  		message += "You live on the "+hash["floor"]+" floor?!\n";
	  		hash["floor"] = "";
			valid = false;
	  	}
	  	if(!hash["email"].match(/^([a-zA-z0-9\-\.]+@[a-zA-z\-\+]+\.[a-z]+)$/))
	  	{
	  		message += "no valid email address.\n";
	  		hash["email"] = "";
			valid = false;
	  	}
	  	if(valid)
	  	{
	  		//document.getElementById('form').submit()
	  		return true;
	  	} else
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

	function deleteFormInput(hash)
	{
		localStorage.removeItem("hash");
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
		} else if (sqlError > 0)
		{
			window.alert("Another sql error "+sqlError+", have a look at https://dev.mysql.com/doc/refman/5.5/en/error-messages-server.html");
			<% session.removeAttribute("sqlErrorCode"); %>
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
