//--Functions for the register page of the website--//

//Function that checks the first name form. If it has any numbers or special
//characters inside the form it fails or if it has no value at all it fails.
//if it fails then the label changes it's colour to red and the innerHTML to
//"Must enter a valid first name."
function checkFirstName(){
  var firstNameRegex=/^[A-Za-z]{1,20}$/;
  var firstName = mainForm.fName.value;
  if(!firstNameRegex.test(firstName)){
    document.getElementById("firstNLabel").innerHTML="Must enter a valid first name";
    document.getElementById("firstNLabel").style.color="red";
    return false;
  }
  return true;
}

//Function that returns the label to black and the innerHTML of the label
//to "First Name" if any key is pressed inside the first name form.
function firstNameKeyPress(){
  document.getElementById("firstNLabel").style.color="black";
  document.getElementById("firstNLabel").innerHTML="First Name";
}

//Function that checks the last name form. If it has any numbers or special
//characters inside the form it fails or if it has no value at all it fails.
//if it fails then the label changes it's colour to red and the innerHTML to
//"Must enter a valid last name."
function checkLastName(){
  var lastNameRegex=/^[A-Za-z]{1,20}$/;
  var lastName = mainForm.lName.value;
  if(!lastNameRegex.test(lastName)){
    document.getElementById("lastNLabel").innerHTML="Must enter a valid last name";
    document.getElementById("lastNLabel").style.color="red";
    return false;
  }
  return true;
}

//Function that returns the label to black and the innerHTML of the label
//to "Last Name" if any key is pressed inside the first name form.
function lastNameKeyPress(){
  document.getElementById("lastNLabel").style.color="black";
  document.getElementById("lastNLabel").innerHTML="Last Name";
}

//Function that checks if the username is greater than 4 letters and shorter than 20.
//Also checks if any special characters are used if any of those fails, it return false and
//changes the label to red and the inner HTML to "Must enter a valid username".
//Also creates a window alert to say "Username must be at least 4 characters long and must not contain any special characters such as !@#$%^&**()""
function checkUsername(){
  var usernameRegex=/^[A-Za-z0-9 ]{4,20}$/;
  var username = mainForm.username.value;
  if(!usernameRegex.test(username)){
    document.getElementById("usernameLabel").innerHTML="Must enter a valid username";
    document.getElementById("usernameLabel").style.color="red";
    window.alert("Username must be at least 4 characters long and must not contain any special characters such as !@#$%^&**()");
    return false;
  }
  return true;
}

//Function that resets the label back to black and the label value
//to "Username" if any key is pressed inside the form.
function usernameKeyPress(){
  document.getElementById("usernameLabel").style.color="black";
  document.getElementById("usernameLabel").innerHTML="Username";
}

//Function that checks if the password is greater than 6 chacters long and shorter than 20
//Can enter special charcters if any are used. Fails if it doesn't meet those standards
//and changes the label to colour to red and the label itself to "Must enter a valid password"
//Also creates a window alert to say "Password must be at least 6 characters long can contain special characters"
function checkPassword(){
  var passwordRegex=/^[A-Za-z0-9!@#$%^&*()_]{6,20}$/;
  var password=mainForm.password.value;
  if(!passwordRegex.test(password)){
    document.getElementById("passwordLabel").innerHTML="Must enter a valid password";
    document.getElementById("passwordLabel").style.color="red";
    window.alert("Password must be at least 6 characters long can contain special characters");
    return false;
  }
  return true;
}

//Function that resets the label back to black and the label value
//to "Password" if any key is pressed inside the form.
function passwordKeyPress(){
  document.getElementById("passwordLabel").style.color="black";
  document.getElementById("passwordLabel").innerHTML="Password";
}

//Function that checks if the two password forms have equal value.
//If not it fails and changes the innerHTML of the password confirm form
//to "Passwords must match" and the style to red
function checkPasswordMatch(){
  var password1=mainForm.password.value;
  var password2=mainForm.passwordc.value;
  if(password1!=password2){
    document.getElementById("passwordLabelC").innerHTML="Passwords must match";
    document.getElementById("passwordLabelC").style.color="red";
    return false;
  }
  return true;
}

//Function that resets the label back to black and the label value
//to "Password Confirm" if any key is pressed inside the form.
function passwordcKeyPress(){
  document.getElementById("passwordLabelC").style.color="black";
  document.getElementById("passwordLabelC").innerHTML="Password Confirm";
}

//Function to check if the entered email is valid. That is, it has an @ symbol and
//a . in the form and it isn't longer than 74 characters long. If fail occurs
// the style of the label changes to red and the label itself to "Must
//enter a valid email"
function checkEmail(){
  var emailRegex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
  var email = mainForm.email.value;
  if(!emailRegex.test(email)){
    document.getElementById("emailLabel").innerHTML="Must enter a valid email";
    document.getElementById("emailLabel").style.color="red";
    return false;
  }
  return true;
}

//Function that resets the label back to black and the label value
//to "Email" if any key is pressed inside the form.
function emailKeyPress(){
  document.getElementById("emailLabel").style.color="black";
  document.getElementById("emailLabel").innerHTML="Email";
}

//Function to check if the postcode is 4 characters long and does not
//contain any special characters or letters. If fails it changes the label
//to "Must enter a valid postcode" and the style to red.
function checkPostcode(){
  var postcodeRegex=/^[0-9]{4}$/;
  var postcode= mainForm.postcode.value;
  if(!postcodeRegex.test(postcode)){
    document.getElementById("postcodeLabel").innerHTML="Must enter a valid postcode";
    document.getElementById("postcodeLabel").style.color="red";
    return false;
  }
  return true;
}

//Function that resets the label back to black and the label value
//to "Postcode" if any key is pressed inside the form.
function postcodeKeyPress(){
  document.getElementById("postcodeLabel").style.color="black";
  document.getElementById("postcodeLabel").innerHTML="Postcode";
}

//Function to check if the DOB is entered in a correct manner
//if fail it changes the label to "Must enter a valid Date of Birth"
//and creates a window alert to show how it must be entered and sets the
//style to red.
function checkDOB(){
  var timestamp=Date.parse('foo')
  var DoBRegex=/^[0-9]{2}\/[0-9]{2}\/[0-9]{4}$/;
  var DoB= mainForm.DOB.value;
  if(!DoBRegex.test(DoB)){
    document.getElementById("DOBLabel").innerHTML="Must enter a valid Date of Birth";
    window.alert("Date of birth must be in style 27/03/1997")
    document.getElementById("DOBLabel").style.color="red";
    return false;
  }else if(isNaN(timestamp)==false)
  return true;
}

//Function that resets the label back to black and the label value
//to "Date of Birth" if any key is pressed inside the form.
function DoBKeyPress(){
  document.getElementById("DOBLabel").style.color="black";
  document.getElementById("DOBLabel").innerHTML="Date of Birth";
}
