<html>
<?php
require 'validate.php';
$errors = array();
validateEmail($errors, $_POST, 'email');
if ($errors) {
  echo 'Errors:<br/>';
  foreach ($errors as $field => $error){
    echo "$field $error</br>";
  }
  } else {
    echo 'Data OK!';
}
?>
</html>
