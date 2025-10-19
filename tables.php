<?php
session_start();
if (!isset($_SESSION['logged_in']) || $_SESSION['logged_in'] !== true) {
  header('Location: index.php');
  exit;
}

require_once 'config/db.php';
require_once 'functions/database.php';

$database = $_GET['db'] ?? '';
if (!$database) {
  header('Location: dashboard.php');
  exit;
}
?>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Manage Tables - <?php echo htmlspecialchars($database); ?></title>
  <link rel="stylesheet" href="css/style.css">
</head>

<body>
  <div class="tables-container">
    <header>
      <h1>Manage Tables - <?php echo htmlspecialchars($database); ?></h1>
      <a href="dashboard.php" class="back-btn">Back to Dashboard</a>
    </header>

    <form action="functions/database.php" method="POST" class="create-table-form">
      <h2>Create New Table</h2>
      <input type="text" name="tableName" required placeholder="Table Name">

      <div id="columns">
        <div class="column-input">
          <input type="text" name="columns[0][name]" required placeholder="Column Name">
          <select name="columns[0][type]" required>
            <option value="INT">INT</option>
            <option value="VARCHAR(255)">VARCHAR(255)</option>
            <option value="TEXT">TEXT</option>
            <option value="DATE">DATE</option>
            <option value="TIMESTAMP">TIMESTAMP</option>
          </select>
          <input type="text" name="columns[0][extra]" placeholder="Extra (e.g., AUTO_INCREMENT)">
        </div>
      </div>

      <button type="button" onclick="addColumn()">Add Column</button>
      <input type="hidden" name="database" value="<?php echo htmlspecialchars($database); ?>">
      <input type="hidden" name="action" value="create_table">
      <button type="submit">Create Table</button>
    </form>

    <?php if (isset($_GET['message'])): ?>
      <div class="message">
        <?php echo htmlspecialchars($_GET['message']); ?>
      </div>
    <?php endif; ?>
  </div>

  <script>
    let columnCount = 1;

    function addColumn() {
      const columnsDiv = document.getElementById('columns');
      const newColumn = document.createElement('div');
      newColumn.className = 'column-input';
      newColumn.innerHTML = `
            <input type="text" name="columns[${columnCount}][name]" required placeholder="Column Name">
            <select name="columns[${columnCount}][type]" required>
                <option value="INT">INT</option>
                <option value="VARCHAR(255)">VARCHAR(255)</option>
                <option value="TEXT">TEXT</option>
                <option value="DATE">DATE</option>
                <option value="TIMESTAMP">TIMESTAMP</option>
            </select>
            <input type="text" name="columns[${columnCount}][extra]" placeholder="Extra (e.g., AUTO_INCREMENT)">
        `;
      columnsDiv.appendChild(newColumn);
      columnCount++;
    }
  </script>
</body>

</html>
