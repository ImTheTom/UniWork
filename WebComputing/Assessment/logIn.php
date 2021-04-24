<?php
session_start();
session_destroy(); ?>

<!--HTML for the log in page of the website-->
<!DOCTYPE html>
<html>
<head>
  <title>Log In ParkView</title><!--Tab name-->
  <meta charset = "UTF-8">
  <meta name="description" content="Park LogIn Page">
  <meta name="keywords" content="Search,Parks,Brisbane,Review,LogIn,Register,Results">
  <meta name="author" content="Tom Bowyer and Thanh Dang">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="CSS/logincss.css" rel="stylesheet" type="text/css"/> <!--CSS that contains the styling for the page-->
  <script type="text/javascript" src="JS/loginjs.js"></script> <!--Javascript that contains functions for the checking of the forms-->
  <link rel="icon" type="image/png" href="Images/icon.ico" sizes="16x16"> <!--Icon for tab-->
  <link rel="icon" type="image/png" href="Images/icon.ico" sizes="32x32">
</head>
<body>
  <div id = "main"> <!--Main div ontop of the background-->
    <?php
    include'PHP/headerAndFooter.php';
    ?>
  </body>
  <div id = "breadcrumb"><!--Breadcrumb trail that shows suggested previous pages they have been-->
    <a href="frontpage.php">Search</a>&nbsp;
    ->
    <a href="login.php">Log In</a>&nbsp;
  </div>
  <h1>Log In</h1>
  <form id=mainForm onsubmit="return !! (checkUsername() & checkPassword())" action="logIn.php" method="POST">
    <?php
    $errors = array();
    if ((isset($_POST['username']))&&(isset($_POST['password']))) {
      require "PHP/validateLogIn.php";
      validateUsername($errors, $_POST, 'username');
      validatePassword($errors, $_POST, 'password');
      if ($errors) {
        $var=3;
        foreach ($errors as $field => $error) {
          echo "<div style='top:$var%;left:40%;position:absolute;color:red;'> $field $error.</div>";
          $var+=2;
        }
        // redisplay the form
        include 'PHP/logInForm.php';
      } else {
        $pdo = new PDO('mysql:host=localhost;dbname=parks', 'root', 'test');
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $username = $_POST['username'];
        $password = $_POST['password'];
        try {
          $result = $pdo->query("SELECT * FROM parks.users");
        } catch (PDOException $e) {
          echo $e->getMessage();
        }
        foreach ($result as $users) {
          if($username==$users['username']&&$password==$users['password']){
            session_start();
            $_SESSION['LoggedIn'] = true;
            $_SESSION['name'] = $username;
            header("location: frontpage.php");
          }else{
            echo "<div style='top:5%;left:40%;position:absolute;color:red;'> Log In credentials invalid</br> Please press back to try again.</div>";
          }
        }
      }
    } else {
      include 'PHP/logInForm.php';
    }
    ?>
  </form>
</div>
</html>
