<?php
session_start();
if (!isset($_SESSION['logged_in']) || $_SESSION['logged_in'] !== true) {
  header('Location: index.php');
  exit;
}

require_once 'config/db.php';
require_once 'functions/database.php';

$databases = getDatabases();
$users = getUsers();
?>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>MySQL Admin - Dashboard</title>
  <link rel="stylesheet" href="css/style.css">
</head>

<body>
  <div class="dashboard-container">
    <header>
      <h1>MySQL Administration</h1>
      <a href="functions/auth.php?logout=1" class="logout-btn">Logout</a>
    </header>

    <div class="dashboard-grid">
      <section class="databases">
        <h2>Databases</h2>
        <div class="database-list">
          <?php foreach ($databases as $db): ?>
            <div class="database-item">
              <?php echo htmlspecialchars($db); ?>
              <a href="functions/database.php?action=manage_tables&db=<?php echo urlencode($db); ?>" class="btn">Manage Tables</a>
            </div>
          <?php endforeach; ?>
        </div>

        <form action="functions/database.php" method="POST" class="create-form">
          <h3>Create New Database</h3>
          <input type="text" name="dbname" required placeholder="Database Name">
          <input type="hidden" name="action" value="create_database">
          <button type="submit">Create Database</button>
        </form>
      </section>

      <section class="users">
        <h2>Users</h2>
        <div class="user-list">
          <?php foreach ($users as $user): ?>
            <div class="user-item">
              <?php echo htmlspecialchars($user['user']); ?>@<?php echo htmlspecialchars($user['host']); ?>
            </div>
          <?php endforeach; ?>
        </div>

        <form action="functions/database.php" method="POST" class="create-form">
          <h3>Create New User</h3>
          <input type="text" name="username" required placeholder="Username">
          <input type="password" name="password" required placeholder="Password">
          <select name="database" required>
            <option value="">Select Database</option>
            <?php foreach ($databases as $db): ?>
              <option value="<?php echo htmlspecialchars($db); ?>"><?php echo htmlspecialchars($db); ?></option>
            <?php endforeach; ?>
          </select>
          <input type="hidden" name="action" value="create_user">
          <button type="submit">Create User</button>
        </form>
      </section>
    </div>
  </div>

  <?php if (isset($_GET['message'])): ?>
    <div class="message">
      <?php echo htmlspecialchars($_GET['message']); ?>
    </div>
  <?php endif; ?>
</body>

</html>
