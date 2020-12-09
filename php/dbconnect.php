<?php
$servername = "localhost";
$username   = "amonguss_eatinglife1admin";
$password   = "0HyslkTwk27r";
$dbname     = "amonguss_eatinglife1";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
   die("Connection failed: " . $conn->connect_error);
}
?>