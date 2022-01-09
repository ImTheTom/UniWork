function checkName() {
    if (main.surname.value == "") {
        window.alert("Name must be filled out");
		document.getElementById("surnameMissing").style.visibility = "visible";
        return false;
    }
	return true;
}

function checkPassword() {
	if(main.password.value!=""){
    if (main.password.value == main.passwordC.value) {
        return true;
    }
		return false;
		window.alert("password must be the same");
	}
	window.alert("Password cant be blank");
	return false;
}

function checkEmail(){
	 var emailID = main.email.value;
	 atpos = emailID.indexOf("@");
	 dotpos = emailID.lastIndexOf(".");

	 if (atpos < 1 || ( dotpos - atpos < 2 ))
	 {
			alert("Please enter correct email ID")
			return false;
	 }
	 return true;
}


function checkAddress(){
	if (main.address.value == "") {
       window.alert("address must be filled out");
        return false;
    }
	return true;
}


function change(){
	document.getElementById("surnameMissing").style.visibility = "hidden";
}
