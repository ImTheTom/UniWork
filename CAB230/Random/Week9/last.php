<!DOCTYPE HTML>
<html>
  <header>
    <title> Last Part php</title>
  </header>
  <body>
    <form method="POST">
      <fieldset>
    <?php
    include "form1.php";
    input_field($errors, 'fname', 'First Name');
    input_field($errors, 'email', 'Email');
    $months = array('None' => 'Select...', 1 => 'Jan', 2 => 'Feb', 3 => 'Mar',
    4 =>'Apr', 5 => 'May', 6 => 'Jun', 7 => 'Jul', 8 => 'Aug',
    9 => 'Sep', 10 => 'Oct', 11 => 'Nov', 12 => 'Dec');
    select('month', $months);
    ?>
  </fieldset>
  </form>
  </body>
</html>
