<?php
$name=$_GET['name'];
$suburb=$_GET['suburb'];
$rating=$_GET['rating'];
$latitude = $_GET['latitude'];
$latitudelow = $latitude-0.005;
$latitudehigh = $latitude+0.005;
$longitude = $_GET['longitude'];
$longitudelow = $longitude-0.005;
$longitudehigh = $longitude+0.005;


session_start();

if (empty($name) && empty($suburb) && empty($rating)&& empty($latitude)&& empty($longitude)) {
  header("Location: frontpage.php");
}
?>

<!--HTML for the results page of the website-->
<!DOCTYPE html>
<html>
<head>
  <title>Results ParkView</title> <!--Tab name-->
  <meta charset = "UTF-8">
  <meta name="description" content="Park Results Page">
  <meta name="keywords" content="Search,Parks,Brisbane,Review,LogIn,Register,Results">
  <meta name="author" content="Tom Bowyer and Thanh Dang">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="CSS/resultscss.css" rel="stylesheet" type="text/css"/> <!--CSS that contains the styling for the page-->
  <script type="text/javascript" src="JS/searchjs.js"></script><!--Javascript that contains functions for the checking of the forms-->
  <link rel="icon" type="image/png" href="Images/icon.ico" sizes="16x16"><!--Icon for tab-->
  <link rel="icon" type="image/png" href="Images/icon.ico" sizes="32x32">
</head>
<body>
  <div id = "main"><!--Main div ontop of the background-->
    <div id = "breadcrumb"><!--Breadcrumb trail that shows suggested previous pages they have been-->
      <a href="frontpage.php">Search</a>&nbsp;
      ->
      <a href="results.php">Results</a>&nbsp;
    </div>
    <h1>Search Results</h1>
    <div class ="Map" id="map">
      <script>

        function initMap() {
          <?php
          $pdo = new PDO('mysql:host=localhost;dbname=parks', 'root', 'test');
          $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
          try {
            $result = $pdo->query("SELECT * FROM parks.parks");

          } catch (PDOException $e) {
            echo $e->getMessage();
          }
          echo 'var accounts =[];';
          echo ' var i=0;';
          foreach ($result as $park) {
            if($park['suburb']==$suburb){
              echo 'accounts[i] = {lat:'.$park['latitude'] .', lng: '.$park['longitude'].'};';
              echo ' var i=i+1;';
            }else if($park['name']==strtoupper($name)){
              echo 'accounts[i] = {lat:'.$park['latitude'] .', lng: '.$park['longitude'].'};';
              echo ' var i=i+1;';
            }else if($park['rating']==$rating){
              echo 'accounts[i] = {lat:'.$park['latitude'] .', lng: '.$park['longitude'].'};';
              echo ' var i=i+1;';
            }else if ($latitudelow<$park['latitude'] && $park['latitude']<$latitudehigh && $longitudelow<$park['longitude'] && $park['longitude']<$longitudehigh){
              echo 'accounts[i] = {lat:'.$park['latitude'] .', lng: '.$park['longitude'].'};';
              echo ' var i=i+1;';
            }
          }
          ?>
          var map = new google.maps.Map(document.getElementById('map'), {
            zoom: 12,
            center: accounts[0]
          });
          for(var x = 0; x<=i;x++){
          var marker = new google.maps.Marker({
            position: accounts[x],
            map: map
          });
        }
      }
      </script>
      <script async defer
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCbtgYa4TpH6fVWRx_o2GN9PZgRDakerqg&callback=initMap">
      </script>
    </div>
    <table bgcolor="#FFF";> <!--Table which contains the parks that were found from the search contains links to the park itself-->
      <col width ="15%">
      <col width ="25%">
      <col width ="10%">
      <tr>
        <th>Name</th>
        <th>Street</th>
        <th>Rating</th>
      </tr>
      <?php
      $pdo = new PDO('mysql:host=localhost;dbname=parks', 'root', 'test');
      $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
      try {
        $result = $pdo->query("SELECT * FROM parks.parks");
      } catch (PDOException $e) {
        echo $e->getMessage();
      }
      foreach ($result as $park) {
        if($park['suburb']==$suburb){
          echo '<tr>';
          echo '<td><a href="park1.php?parkcode='. $park['parkCode'] . '"> '. $park['name'] . '</a></td>';
          echo '<td><a href="park1.php?parkcode='. $park['parkCode'] . '"> '. $park['street'] . '</a></td>';
          echo '<td><a href="park1.php?parkcode='. $park['parkCode'] . '"> '. $park['rating'] . '</a></td>';
          echo '</tr>';
        }else if($park['name']==strtoupper($name)){
          echo '<tr>';
          echo '<td><a href="park1.php?parkcode='. $park['parkCode'] . '"> '. $park['name'] . '</a></td>';
          echo '<td><a href="park1.php?parkcode='. $park['parkCode'] . '"> '. $park['street'] . '</a></td>';
          echo '<td><a href="park1.php?parkcode='. $park['parkCode'] . '"> '. $park['rating'] . '</a></td>';
          echo '</tr>';
        }else if($park['rating']==$rating){
          echo '<tr>';
          echo '<td><a href="park1.php?parkcode='. $park['parkCode'] . '"> '. $park['name'] . '</a></td>';
          echo '<td><a href="park1.php?parkcode='. $park['parkCode'] . '"> '. $park['street'] . '</a></td>';
          echo '<td><a href="park1.php?parkcode='. $park['parkCode'] . '"> '. $park['rating'] . '</a></td>';
          echo '</tr>';
        }else if ($latitudelow<$park['latitude'] && $park['latitude']<$latitudehigh && $longitudelow<$park['longitude'] && $park['longitude']<$longitudehigh){
          echo '<tr>';
          echo '<td><a href="park1.php?parkcode='. $park['parkCode'] . '"> '. $park['name'] . '</a></td>';
          echo '<td><a href="park1.php?parkcode='. $park['parkCode'] . '"> '. $park['street'] . '</a></td>';
          echo '<td><a href="park1.php?parkcode='. $park['parkCode'] . '"> '. $park['rating'] . '</a></td>';
          echo '</tr>';
        }
      }
      ?>
    </table>
    <form id="mainForm" onsubmit="return check()" action="results.php"> <!--On submit it runs the functions from the called javascript-->
      <div id = nameStyle>
        <label class="top">Park Name</label>
        <input type="text" id="name" name="name" placeholder="Enter a park name..."><!--Name text form-->
      </div>
      <div id = suburbStyle>
        <label class="top" id = "suburbLabel">Select a suburb</label><!--Suburb select form-->
        <select id="suburb"name="suburb">
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
      <div id = ratingStyle>
        <label class="top">Rating</label>
        <select id ="rating" name="rating"><!--Rating select form-->
          <option value = ""></option>
          <option value = "1"> 1</option>
          <option value = "2"> 2 </option>
          <option value = "3"> 3 </option>
          <option value = "4"> 4 </option>
          <option value = "5"> 5 </option>
        </select>
      </div>
      <input type="submit" id="submit" value="Search"><!--Submit button to submit all the forms inside the mainForm-->
    </form>
    <?php
    include'PHP/headerAndFooter.php';
    ?>
  </body>
  </html>
