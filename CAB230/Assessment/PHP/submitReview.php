<?php
session_start();
$name=$_SESSION['name'];
$rating=$_GET['score'];
$date = date("d.m.Y");
$review = $_GET['review'];
$parkcode = $_SESSION['parkID'];

try {
  $pdo = new PDO('mysql:host=localhost;dbname=parks', 'root', 'test');
  $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
  if($_SESSION['LoggedIn']){
    $stmt = $pdo->prepare("INSERT INTO reviews (name, rating, date, review, parkCode)
    VALUES (:name, :rating, :date, :review, :parkCode)");
    $stmt->bindValue(':name',$name);
    $stmt->bindValue(':rating',$rating);
    $stmt->bindValue(':date',$date);
    $stmt->bindValue(':review',$review);
    $stmt->bindValue(':parkCode',$parkcode);
    $stmt->execute();
    header('Location: ' . $_SERVER['HTTP_REFERER']);
    $parkcode=$_GET['parkcode'];
    $pdo = new PDO('mysql:host=localhost;dbname=parks', 'root', 'test');
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    try {
      $result = $pdo->query("SELECT * FROM parks.reviews");
    } catch (PDOException $e) {
      echo $e->getMessage();
    }
    $average=0;
    $numberOfReviews=0;
    foreach ($result as $review) {
      if($review['parkCode']==$parkcode){
        $average=$average+$review['rating']
        $numberOfReviews=$numberOfReviews+1;
      }
    }
    $average=$average/$numberOfReviews;
    $newAverage = "UPDATE parks SET rating = '. $average . ' WHERE parkCode = '. $parkcode . '";
    $stmt = $conn -> prepare($sql);
    $stmt->execute();
  }else{
    header('Location: fail.html');
  }
}
catch(PDOException $e)
{
  echo $sql . "<br>" . $e->getMessage();
}

?>
