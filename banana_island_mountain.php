<?php
// Creating a connection to the database
$db_connection = mysqli_connect("localhost", "root", "", "db_name");

// check connection
if (mysqli_connect_errno()) {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

// end connection
mysqli_close($db_connection);

// Create table
$create_table = "CREATE TABLE table_name (
 id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 firstname VARCHAR(30) NOT NULL,
 lastname VARCHAR(30) NOT NULL,
 email VARCHAR(50),
 reg_date TIMESTAMP
)";

if ($db_connection->query($create_table) === TRUE) {
 echo "Table table_name created successfully";
} else {
 echo "Error creating table: " . $db_connection->error;
}
$db_connection->close();

// Insert Data in table
$insert_data = "INSERT INTO table_name (firstname, lastname, email)
 VALUES ('John', 'Doe', 'john@example.com')";

if ($db_connection->query($insert_data) === TRUE) {
 echo "New record created successfully";
} else {
 echo "Error: " . $insert_data . "<br>" . $db_connection->error;
}

$db_connection->close();

// Select Data from table
$select_data = "SELECT id, firstname, lastname FROM table_name";
$result = $db_connection->query($select_data);

if ($result->num_rows > 0) {
 // output data of each row
 while($row = $result->fetch_assoc()) {
  echo "id: " . $row["id"]. " - Name: " . $row["firstname"]. " " . $row["lastname"]. "<br>";
 }
} else {
 echo "0 results";
}

$db_connection->close();

// Update Data in table
$id = 4;
$update_data = "UPDATE table_name
 SET firstname='Mark' WHERE id=$id";

if ($db_connection->query($update_data) === TRUE) {
 echo "Record updated successfully";
} else {
 echo "Error updating record: " . $db_connection->error;
}

$db_connection->close();

// Delete Data from table
$id = 3;
$delete_data = "DELETE FROM table_name WHERE id=$id";

if ($db_connection->query($delete_data) === TRUE) {
 echo "Record deleted successfully";
} else {
 echo "Error deleting record: " . $db_connection->error;
}

$db_connection->close();