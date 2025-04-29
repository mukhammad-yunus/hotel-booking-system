<?php
// Define database connection variables (host, database name, username, password)
$host = 'localhost';
$username = 'root';
$password = '';
$db = 'hotel_booking_system';

// Create connection using mysqli
$conn = mysqli_connect($host, $username, $password, $db);

// Check if connection failed, if so, stop script with error message
if (!$conn) {
  die ("Connection failed: " . mysqli_connect_error());
}