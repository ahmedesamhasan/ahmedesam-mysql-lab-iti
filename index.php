<?php
session_start();
if (isset($_SESSION['logged_in']) && $_SESSION['logged_in'] === true) {
  header('Location: dashboard.php');
  exit;
}
?>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>MySQL Admin - Login</title>
  <link rel="stylesheet" href="css/style.css">
</head>

<body>
  <div class="login-container">
    <h2>MySQL Admin Login</h2>
    <form action="functions/auth.php" method="POST">
      <div class="form-group">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required placeholder="root">
      </div>
      <div class="form-group">
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>
      </div>
      <button type="submit" name="login">Login</button>
    </form>
    <?php if (isset($_GET['error'])): ?>
      <div class="error">
        <?php echo htmlspecialchars($_GET['error']); ?>
      </div>
    <?php endif; ?>
  </div>
</body>

</html>
