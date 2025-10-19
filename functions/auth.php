<?php
session_start();
require_once '../config/db.php';

if (isset($_POST['login'])) {
  $username = $_POST['username'];
  $password = $_POST['password'];

  try {
    $pdo = new PDO(
      "mysql:host=localhost",
      $username,
      $password,
      [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]
    );

    $_SESSION['logged_in'] = true;
    $_SESSION['username'] = $username;
    header('Location: ../dashboard.php');
    exit;
  } catch (PDOException $e) {
    header('Location: ../index.php?error=Invalid credentials');
    exit;
  }
}

if (isset($_GET['logout'])) {
  session_destroy();
  header('Location: ../index.php');
  exit;
}
