<?php
function validatePassword(&$errors, $field_list, $field_name){
  $field_name = trim($field_name);
  $field_name = stripslashes($field_name);
  $field_name = htmlspecialchars($field_name);
  $pattern ='/^[A-Za-z0-9!@#$%^&*()_]{6,20}$/';
  if (!isset($field_list[$field_name])|| empty($field_list[$field_name])) {
    $errors[$field_name] = 'required';
  } else if (!preg_match($pattern, $field_list[$field_name])) {
    $errors[$field_name] = 'invalid';
  }
}
function validateUsername(&$errors, $field_list, $field_name){
  $field_name = trim($field_name);
  $field_name = stripslashes($field_name);
  $field_name = htmlspecialchars($field_name);
  $pattern ='/^[A-Za-z0-9!@#$%^&*()_]{6,20}$/';
  if (!isset($field_list[$field_name])|| empty($field_list[$field_name])) {
    $errors[$field_name] = 'required';
  } else if (!preg_match($pattern, $field_list[$field_name])) {
    $errors[$field_name] = 'invalid';
  }
}
function validateEmail(&$errors, $field_list, $field_name){
  $field_name = trim($field_name);
  $field_name = stripslashes($field_name);
  $field_name = htmlspecialchars($field_name);
  $pattern ='/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i';
  if (!isset($field_list[$field_name])|| empty($field_list[$field_name])) {
    $errors[$field_name] = 'required';
  } else if (!preg_match($pattern, $field_list[$field_name])) {
    $errors[$field_name] = 'invalid';
  }
}

function validateFirstName(&$errors, $field_list, $field_name){
  $field_name = trim($field_name);
  $field_name = stripslashes($field_name);
  $field_name = htmlspecialchars($field_name);
  $pattern ='/^[A-Za-z]{1,20}$/';
  if (!isset($field_list[$field_name])|| empty($field_list[$field_name])) {
    $errors[$field_name] = 'required';
  } else if (!preg_match($pattern, $field_list[$field_name])) {
    $errors[$field_name] = 'invalid';
  }
}

function validateLastName(&$errors, $field_list, $field_name){
  $field_name = trim($field_name);
  $field_name = stripslashes($field_name);
  $field_name = htmlspecialchars($field_name);
  $pattern ='/^[A-Za-z]{1,20}$/';
  if (!isset($field_list[$field_name])|| empty($field_list[$field_name])) {
    $errors[$field_name] = 'required';
  } else if (!preg_match($pattern, $field_list[$field_name])) {
    $errors[$field_name] = 'invalid';
  }
}

function validatePostcode(&$errors, $field_list, $field_name){
  $field_name = trim($field_name);
  $field_name = stripslashes($field_name);
  $field_name = htmlspecialchars($field_name);
  $pattern ='/^[0-9]{4}$/';
  if (!isset($field_list[$field_name])|| empty($field_list[$field_name])) {
    $errors[$field_name] = 'required';
  } else if (!preg_match($pattern, $field_list[$field_name])) {
    $errors[$field_name] = 'invalid';
  }
}

function validateDOB(&$errors, $field_list, $field_name){
  $field_name = trim($field_name);
  $field_name = stripslashes($field_name);
  $field_name = htmlspecialchars($field_name);
  $pattern ='/^[0-9]{2}\/[0-9]{2}\/[0-9]{4}$/';
  if (!isset($field_list[$field_name])|| empty($field_list[$field_name])) {
    $errors[$field_name] = 'required';
  } else if (!preg_match($pattern, $field_list[$field_name])) {
    $errors[$field_name] = 'invalid';
  }
}
?>
