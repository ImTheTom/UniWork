//--Functions for the log in page of the website--//

//Function that checks if the username is greater than 4 letters and shorter than 20.
//Also checks if any special characters are used if any of those fails, it return false and
//changes the label to red and the inner HTML to "Must enter a valid username".
function checkUsername(){
  var usernameRegex=/^[A-Za-z0-9 ]{4,20}$/;
  var username = mainForm.username.value;
  if(!usernameRegex.test(username)){
    document.getElementById("usernameLabel").innerHTML="Must enter a valid username";
    document.getElementById("usernameLabel").style.color="red";
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
function checkPassword(){
  var passwordRegex=/^[A-Za-z0-9!@#$%^&*()_]{6,20}$/;
  var password=mainForm.password.value;
  if(!passwordRegex.test(password)){
    document.getElementById("passwordLabel").innerHTML="Must enter a valid password";
    document.getElementById("passwordLabel").style.color="red";
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
