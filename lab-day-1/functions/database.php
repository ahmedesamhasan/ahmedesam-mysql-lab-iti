<?php
require_once '../config/db.php';
session_start();
function getDatabases()
{
  global $pdo;
  $stmt = $pdo->query('SHOW DATABASES');
  return $stmt->fetchAll(PDO::FETCH_COLUMN);
}

function getUsers()
{
  global $pdo;
  $stmt = $pdo->query('SELECT user, host FROM mysql.user');
  return $stmt->fetchAll();
}

function createDatabase($dbname)
{
  global $pdo;
  try {
    $pdo->exec("CREATE DATABASE `" . $pdo->quote($dbname) . "`");
    return true;
  } catch (PDOException $e) {
    return false;
  }
}

function createUser($username, $password, $database)
{
  global $pdo;
  try {
    // Create user
    $pdo->exec("CREATE USER '" . $pdo->quote($username) . "'@'localhost' IDENTIFIED BY '" . $pdo->quote($password) . "'");

    // Grant privileges
    $pdo->exec("GRANT ALL PRIVILEGES ON `" . $pdo->quote($database) . "`.* TO '" . $pdo->quote($username) . "'@'localhost'");

    $pdo->exec("FLUSH PRIVILEGES");
    return true;
  } catch (PDOException $e) {
    return false;
  }
}

function createTable($database, $tableName, $columns)
{
  global $pdo;
  try {
    $pdo->exec("USE `" . $pdo->quote($database) . "`");
    $sql = "CREATE TABLE `" . $pdo->quote($tableName) . "` (";
    $columnDefinitions = [];

    foreach ($columns as $column) {
      $columnDefinitions[] = "`{$column['name']}` {$column['type']} {$column['extra']}";
    }

    $sql .= implode(', ', $columnDefinitions) . ")";
    $pdo->exec($sql);
    return true;
  } catch (PDOException $e) {
    return false;
  }
}

// Handle POST requests
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  $action = $_POST['action'] ?? '';

  switch ($action) {
    case 'create_database':
      if (createDatabase($_POST['dbname'])) {
        header('Location: ../dashboard.php?message=Database created successfully');
      } else {
        header('Location: ../dashboard.php?message=Failed to create database');
      }
      break;

    case 'create_user':
      if (createUser($_POST['username'], $_POST['password'], $_POST['database'])) {
        header('Location: ../dashboard.php?message=User created successfully');
      } else {
        header('Location: ../dashboard.php?message=Failed to create user');
      }
      break;
  }
  exit;
}

// Handle GET requests
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
  $action = $_GET['action'] ?? '';

  switch ($action) {
    case 'manage_tables':
      $db = $_GET['db'] ?? '';
      if ($db) {
        header('Location: ../tables.php?db=' . urlencode($db));
      } else {
        header('Location: ../dashboard.php');
      }
      break;
  }
  exit;
}
