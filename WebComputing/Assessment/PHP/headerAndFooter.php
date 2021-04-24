<div id = "header"> <!--Header that spans the page which contains links to the search, log in and register pages-->
  ParkView &nbsp;
  <a href="frontpage.php">Search</a>&nbsp;
  <?php
  // page1.php
  session_start();
  if($_SESSION['LoggedIn']){
    echo '<a href="logIn.php">Log Out</a>&nbsp;';
  }else{
    echo '<a href="logIn.php">Log In</a>&nbsp;';
  }
  ?>
  <a href="register.php">Register</a>&nbsp;
</div>
<div id ="footer"> <!--Footer that spans the page which explains the website-->
  ParkView is an interactive website that allows users to review and find reviews of nearby parks on the location they search for.
</div>
