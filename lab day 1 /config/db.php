<?php
$host = 'localhost';
$port = 3306;
$charset = 'utf8mb4';

try {
  $pdo = new PDO(
    "mysql:host=$host;port=$port;charset=$charset",
    'ahmed',
    '',
    [
      PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
      PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ]
  );
} catch (PDOException $e) {
  die('Connection failed: ' . $e->getMessage());
}
