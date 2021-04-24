<?php
// page1.php
session_start();
if($_SESSION['LoggedIn']){
  echo 'yes';
  echo $_SESSION['name'];
}else{
  echo 'no';
}
?>


<!--HTML for the front page of the website-->
<!DOCTYPE html>
<html>
<head>
  <title>Search ParkView</title> <!--Tab name-->
  <meta charset = "UTF-8">
  <meta name="description" content="Park Search Page">
  <meta name="keywords" content="Search,Parks,Brisbane,Review,LogIn,Register,Results">
  <meta name="author" content="Tom Bowyer and Thanh Dang">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="CSS/frontpagecss.css" rel="stylesheet" type="text/css"/> <!--CSS that contains the styling for the page-->
  <script type="text/javascript" src="JS/searchjs.js"></script> <!--Javascript that contains functions for the checking of the forms-->
  <script type="text/javascript" src="JS/frontpagejs.js"></script> <!--Javascript that contains functions for the checking of the forms-->
  <link rel="icon" type="image/png" href="Images/icon.ico" sizes="16x16"> <!--Icon for tab-->
  <link rel="icon" type="image/png" href="Images/icon.ico" sizes="32x32">
</head>
<body>
  <div id = "main"> <!--Main div ontop of the background-->
    <form id="mainForm" name="mainForm" onsubmit="return check()" action="results.php" method="get"> <!--On submit it runs the function from the called javascript-->
      <div id = "nameStyle">
        <label class="top">Park Name</label>
        <input type="text" id="name" name="name" placeholder="Enter a park name..."> <!--Name text form-->
      </div>
      <div id = "suburbStyle">
        <label class="top" id="suburbLabel">Enter a suburb</label>
        <select id="suburb"name="suburb"> <!--Suburb select form-->
          <option value = "">Not selected</option>
          <?php
          $pdo = new PDO('mysql:host=localhost;dbname=parks', 'root', 'test');
          $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
          try {
            $result = $pdo->query("SELECT DISTINCT(suburb) FROM parks.parks");
          } catch (PDOException $e) {
            echo $e->getMessage();
          }
          foreach ($result as $park) {
            echo '<option value="',$park['suburb'],'">',$park['suburb'],'</option>';
          }
          ?>
        </select>
      </div>
      <div id = "ratingStyle">
        <label class="top">Rating</label>
        <select id ="rating"name="rating"> <!--Rating select form-->
          <option value = ""></option>
          <option value = "1"> 1</option>
          <option value = "2"> 2 </option>
          <option value = "3"> 3 </option>
          <option value = "4"> 4 </option>
          <option value = "5"> 5 </option>
        </select>
      </div>
      <input type="text" id="latitude" name="latitude">
      <input type="text" id="longitude" name="longitude">
      <button  type="button" id="location" value="Near Me" onclick="myLocation();">Near me</button>
      <input type="submit" id="submit" value="Search"> <!--Submit button to submit all the forms inside the mainForm-->
    </form>
  </div>
  <?php
  include'PHP/headerAndFooter.php';
  ?>
</body>
</html>
