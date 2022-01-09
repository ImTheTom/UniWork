<?php
$parkcode=$_GET['parkcode'];
session_start();
$_SESSION['parkID']=$parkcode;
?>

<!--HTML for the park page of the website-->
<!DOCTYPE html>
<html>
<head>
  <title>ParkOne ParkView</title><!--Tab name-->
  <meta charset = "UTF-8">
  <meta name="description" content="Park Result specific Page">
  <meta name="keywords" content="Search,Parks,Brisbane,Review,LogIn,Register,Results">
  <meta name="author" content="Tom Bowyer and Thanh Dang">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="CSS/park1css.css" rel="stylesheet" type="text/css"/><!--CSS that contains the styling for the page-->
  <script type="text/javascript" src="JS/searchjs.js"></script><!--Javascript that contains functions for the checking of the forms-->
  <link rel="icon" type="image/png" href="Images/icon.ico" sizes="16x16"><!--Icon for tab-->
  <link rel="icon" type="image/png" href="Images/icon.ico" sizes="32x32">
</head>
<body>
  <div id = "main"> <!--Main div ontop of the background-->
    <div id = "breadcrumb"><!--Breadcrumb trail that shows suggested previous pages they have been-->
      <a href="frontpage.php">Search</a>&nbsp;
      ->
      <a href="">Results</a>&nbsp;
      ->
      <a href="">Park One</a>&nbsp;
    </div>
    <?php
    $pdo = new PDO('mysql:host=localhost;dbname=parks', 'root', 'test');
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    try {
      $result = $pdo->query("SELECT * FROM parks.parks");

    } catch (PDOException $e) {
      echo $e->getMessage();
    }
    foreach ($result as $park) {
      if($parkcode==$park['parkCode']){
        echo '<h1>'. $park['name'] . '</h1>';
        echo '<div class = "Starsss">';
        echo '<img src ="Images/'. $park['rating'] . '.png" width ="100%" height="100%" alt="img">';//<!--Stars that shows rating of the park-->
        echo '</div>';
        echo '<h2>Street:'. $park['street'] . '<br><br>Suburb:'. $park['suburb'] . '</h2> <!-- main information about the park-->';
      }
    }
    ?>
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
          foreach ($result as $park) {
            if($parkcode==$park['parkCode']){
                echo 'var myLatLng = {lat:'.$park['latitude'] .', lng: '.$park['longitude'].'};';
            }
          }
          ?>
          var map = new google.maps.Map(document.getElementById('map'), {
            zoom: 15,
            center: myLatLng
          });

          var marker = new google.maps.Marker({
            position: myLatLng,
            map: map
          });
        }
      </script>
      <script async defer
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCbtgYa4TpH6fVWRx_o2GN9PZgRDakerqg&callback=initMap">
      </script>
    </div>
    <form id="secondForm" action = "PHP/submitReview.php">
      <div id ="WriteReview">
        <label class="top">Write your own review</label>
        <textarea placeholder="Write your own review"  maxlength="265" class="reviewWrite" method="get" name="review"></textarea><!--Review textarea form-->
      </div>

      <div id = "Score">
        <label class="top">Score</label>
        <select id ="score"name="score"method="get"><!--Score select form-->
          <option value = "1">1</option>
          <option value = "2">2</option>
          <option value = "3">3</option>
          <option value = "4">4</option>
          <option value = "5">5</option>
        </select>
      </div>
      <input type="submit" id="submit" value="Submit">
    </form>
    <form id="mainForm" onsubmit="return check()" action="results.php"><!--On submit it runs the function from the called javascript-->
      <div id="ratingStyle">
        <label class="top">Rating</label>
        <select id ="rating"name="rating"><!--Rating select form-->
          <option value = ""></option>
          <option value = "1"> 1</option>
          <option value = "2"> 2 </option>
          <option value = "3"> 3 </option>
          <option value = "4"> 4 </option>
          <option value = "5"> 5 </option>
        </select>
      </div>
      <div id = "nameStyle">
        <label class="top">Park name</label>
        <input type="text" id="name" name="name" placeholder="Enter a park name..."> <!--Name text form-->
      </div>
      <div id="searchStye">
        <label class="top" id = "suburbLabel">Select a suburb</label>
        <select id="suburb" name="suburb"><!--Suburb select form-->
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
      <input type="submit" id="search" value="Search">
    </form>
    <!-- TODO insert table of reviews -->
  </div>
  <table bgcolor="#FFF";> <!--Table which contains the parks that were found from the search contains links to the park itself-->
    <col width ="12.5%">
    <col width ="32.5%">
    <col width ="5%">
    <col width ="7.5%">
    <tr>
      <th>Name</th>
      <th>Review</th>
      <th>Rating</th>
      <th>Date</th>
    </tr>
    <?php
    $parkcode=$_GET['parkcode'];
    $pdo = new PDO('mysql:host=localhost;dbname=parks', 'root', 'test');
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    try {
      $result = $pdo->query("SELECT * FROM parks.reviews");
    } catch (PDOException $e) {
      echo $e->getMessage();
    }
    foreach ($result as $review) {
      if($review['parkCode']==$parkcode){
        echo '<tr>';
        echo '<td> '. $review['name'] . '</td>';
        echo '<td> '. $review['review'] . '</td>';
        echo '<td> '. $review['rating'] . '</td>';
        echo '<td> '. $review['date'] . '</td>';
        echo '</tr>';
      }
    }
    ?>
  </table>
</div>
<?php
include'PHP/headerAndFooter.php';
?>
</body>
</html>
