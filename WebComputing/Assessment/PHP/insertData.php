<?php
try {
  $pdo = new PDO('mysql:host=localhost;dbname=users', 'root', 'test');
  $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
  $stmt = $pdo->prepare("INSERT INTO users (firstName, lastName, username, password, email, postcode, dateOfBirth)
  VALUES (:firstName, :lastName, :username,:password, :email, :postcode, :dateOfBirth)");
  // use exec() because no results are returned
  $stmt->bindValue(':firstName',$_POST['fName']);
  $stmt->bindValue(':lastName',$_POST['lName']);
  $stmt->bindValue(':username',$_POST['username']);
  $stmt->bindValue(':password',$_POST['password']);
  $stmt->bindValue(':email',$_POST['email']);
  $stmt->bindValue(':postcode',$_POST['postcode']);
  $stmt->bindValue(':dateOfBirth',$_POST['DOB']);
  $stmt->execute();
  echo "New record created successfully";
}
catch(PDOException $e)
{
  echo $sql . "<br>" . $e->getMessage();
}

?>
