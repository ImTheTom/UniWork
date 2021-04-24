
<div id ="firstN">
  <label class="top" id="firstNLabel">First Name</label>
  <input type="text" id="fName" name="fName"placeholder="John" onkeypress="firstNameKeyPress()"value="<?php
  if(isset($_POST['fName'])) {
    echo htmlspecialchars($_POST['fName']);
  }
  ?>"/><br><!--First name text form and calls a function on a key press inside the form-->
</div>
<div id="lastN">
  <label class="top" id="lastNLabel">Last Name</label>
  <input type="text" id="lName" name="lName"placeholder="Smith" onkeypress="lastNameKeyPress()"value="<?php
  if(isset($_POST['lName'])) {
    echo htmlspecialchars($_POST['lName']);
  }
  ?>"/><br><!--Last name text form and calls a function on a key press inside the form-->
</div>
<div id = "usernameStyle">
  <label class="top" id="usernameLabel">Username</label>
  <input type="text" id="username" name="username"placeholder="JohnSmith1" onkeypress="usernameKeyPress()"value="<?php
  if(isset($_POST['username'])) {
    echo htmlspecialchars($_POST['username']);
  }
  ?>"/><br><!--Username text form and calls a function on a key press inside the form-->
</div>
<div id = "passwordStyle">
  <label class="top" id ="passwordLabel">Password</label>
  <input type="password" id="password" name="password"placeholder="Secure password1" onkeypress="passwordKeyPress()"value="<?php
  if(isset($_POST['password'])) {
    echo htmlspecialchars($_POST['password']);
  }
  ?>"/><br><!--Password text form and calls a function on a key press inside the form-->
</div>
<div id = "passwordCStyle">
  <label class="top" id="passwordLabelC">Password Confirm</label>
  <input type="password" id="passwordc" name="passwordc"placeholder="Secure password1" onkeypress="passwordcKeyPress()"><!--Password confirm text form and calls a function on a key press inside the form-->
</div>
<div id = "emailStlye">
  <label class="top" id="emailLabel">Email</label>
  <input type="email" id="email" name="email"placeholder="John@gmail.com" onkeypress="emailKeyPress()"value="<?php
  if(isset($_POST['email'])) {
    echo htmlspecialchars($_POST['email']);
  }
  ?>"/><br><!--email text form and calls a function on a key press inside the form-->
</div>
<div id = "postcodeSyle">
  <label class="top" id="postcodeLabel">Postcode</label>
  <input type="text" id="postcode" name="postcode"placeholder="4021" onkeypress="postcodeKeyPress()"value="<?php
  if(isset($_POST['postcode'])) {
    echo htmlspecialchars($_POST['postcode']);
  }
  ?>"/><br> <!--Postcode text form and calls a function on a key press inside the form-->
</div>
<div id = "DOBStyle">
  <label class="top" id="DOBLabel">Date of Birth</label>
  <input type="text" id="DOB" name="DOB"placeholder="21/10/1995" onkeypress="DoBKeyPress()"value="<?php
  if(isset($_POST['DOB'])) {
    echo htmlspecialchars($_POST['DOB']);
  }
  ?>"/><br> <!--DOB text form and calls a function on a key press inside the form-->
</div>
<div id = "checkboxStyle">
  <input type="checkbox" id="check"name="checkbox" value="Accept Terms and Conditions" required> Accept Terms<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; and Conditions<br> <!--required checkbox form that fails if not pressed-->
</div>
<input type="submit" id="submit" value="Submit"><!--Submit button to submit all the forms inside the mainForm-->
