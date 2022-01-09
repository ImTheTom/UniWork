<!DOCTYPE HTML>
<html>
  <header>
    <title> Part A php</title>
  </header>
  <body>
    <?php
    $errors = array();
    if ((isset($_POST['email']))&&(isset($_POST['email']))) {
      require 'validate.php';
      validateEmail($errors, $_POST, 'email');
      validatePassword($errors, $_POST, 'password');
      if ($errors) {
        echo '<h1>Invalid, correct the following errors:</h1>';
        foreach ($errors as $field => $error) {
          echo "$field $error<br>";
        }
    // redisplay the form
    include 'form.php';
    } else {
    echo 'form submitted successfully with no errors';
    }
    } else {
    include 'form.php';
    }
    ?>

  </body>
</html>
