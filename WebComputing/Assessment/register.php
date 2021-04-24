<?php
session_start();
?>

<!--HTML for the register page of the website-->
<!DOCTYPE html>
<html>
<head>
  <title>Registar ParkView</title><!--Tab name-->
  <meta charset = "UTF-8">
  <meta name="description" content="Park Register Page">
  <meta name="keywords" content="Search,Parks,Brisbane,Review,LogIn,Register,Results">
  <meta name="author" content="Tom Bowyer and Thanh Dang">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="CSS/registercss.css" rel="stylesheet" type="text/css"/> <!--CSS that contains the styling for the page-->
  <script type="text/javascript" src="JS/registerjs.js"></script> <!--Javascript that contains functions for the checking of the forms-->
  <link rel="icon" type="image/png" href="Images/icon.ico" sizes="16x16"> <!--Icon for tab-->
  <link rel="icon" type="image/png" href="Images/icon.ico" sizes="32x32">
</head>
<body>
  <div id = "main"> <!--Main div ontop of the background-->
    <div id = "breadcrumb"><!--Breadcrumb trail that shows suggested previous pages they have been-->
      <a href="frontpage.php">Search</a>&nbsp;
      ->
      <a href="register.php">Register</a>&nbsp;
    </div>
    <h1>Register</h1>
    <form id=mainForm onsubmit="return checkFirstName() && checkLastName() && checkUsername() && checkPassword() && checkPasswordMatch() && checkEmail() && checkPostcode() && checkDOB();" action="register.php" method="POST"><!--On submit it runs the functions from the called javascript-->
      <?php
      $errors = array();
      if ((isset($_POST['username']))&&(isset($_POST['password']))&&(isset($_POST['fName']))&&(isset($_POST['lName']))&&(isset($_POST['email']))&&(isset($_POST['postcode']))&&(isset($_POST['DOB'])))
      {
        require 'validateLogIn.php';
        validateFirstName($errors, $_POST, 'fName');
        validateLastName($errors, $_POST, 'lName');
        validateUsername($errors, $_POST, 'username');
        validatePassword($errors, $_POST, 'password');
        validateEmail($errors, $_POST, 'email');
        validatePostcode($errors, $_POST, 'postcode');
        validateDOB($errors, $_POST, 'DOB');
        if ($errors) {
          $var=3;
          $var2=40;
          foreach ($errors as $field => $error) {
            echo "<div style='top:$var%;left:$var2%;position:absolute;color:red;'> $field $error.</div>";
            $var+=2;
            if($var>9){
              $var=3;
              $var2=50;
            }
          }
          // redisplay the form
          include 'PHP/registerForm.php';
        } else {
          try {
            $salt=uniqid();
            $pdo = new PDO('mysql:host=localhost;dbname=parks', 'root', 'test');
            $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $stmt = $pdo->prepare("INSERT INTO users (firstName, lastName, username, password, email, postcode, dateOfBirth)
            VALUES (:firstName, :lastName, :username, :password, :email, :postcode, :dateOfBirth)");
            $stmt->bindValue(':firstName',$_POST['fName']);
            $stmt->bindValue(':lastName',$_POST['lName']);
            $stmt->bindValue(':username',$_POST['username']);
            $stmt->bindValue(':password',$_POST['password']);
            $stmt->bindValue(':email',$_POST['email']);
            $stmt->bindValue(':postcode',$_POST['postcode']);
            $stmt->bindValue(':dateOfBirth',$_POST['DOB']);
            $stmt->execute();
            header("Location: logIn.php");
            session_destroy();
            session_start();
            $_SESSION['LoggedIn'] = true;
            header("location: frontpage.php");
          }
          catch(PDOException $e)
          {
            echo $sql . "<br>" . $e->getMessage();
          }
        }
      } else {
        include 'PHP/registerForm.php';
      }
      ?>
    </form>
  </div>
  <?php
  include'PHP/headerAndFooter.php';
  ?>
</body>
</html>
