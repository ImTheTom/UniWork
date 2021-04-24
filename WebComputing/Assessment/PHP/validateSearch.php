<?php
$name=$_GET['name'];
$suburb=$_GET['suburb'];
$rating=$_GET['rating'];

if (empty($name) && empty($suburb) && empty($rating)) {
  header("Location: frontpage.php");
}
?>
