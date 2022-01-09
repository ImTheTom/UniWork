
<!--On submit it runs the functions from the called javascript-->

<div id="usernameStyle">
  <label class="top" id="usernameLabel">Username</label>
  <input type="text" id="username" placeholder="Username" onkeypress="usernameKeyPress()"name="username" value="<?php
  if(isset($_POST['username'])) {
    echo htmlspecialchars($_POST['username']);
  }
  ?>"/><br> <!--Username text form and calls a function on a key press inside the form-->
</div>
<div id="passwordStyle">
  <label class="top" id=passwordLabel>Password</label>
  <input type="password" id="password" placeholder="Password" onkeypress="passwordKeyPress()" name="password" value="<?php
  if(isset($_POST['password'])) {
    echo htmlspecialchars($_POST['password']);
  }
  ?>"/><br>  <!--Password text form and calls a function on a key press inside the form-->
</div>
<input type="submit" id="submit" value="Submit"> <!--Submit button to submit all the forms inside the mainForm-->
