<!DOCTYPE html>
<html>
  <head>
    <link href="index.css" rel="stylesheet" type="text/css"/>
  </head>
  <body>
    <?php
    include 'functions.php';
    for ($month = 1; $month <= 12; $month++) {
      display_month($month, 2017);
    }
    ?>
  </body>
</html
