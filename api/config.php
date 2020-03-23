<?php
/**
 * Created by PhpStorm.
 * User: CristianRonaldo
 * Date: 11/14/2018
 * Time: 12:14 AM
 */
$servername = "localhost";
$username = "oniangel";
$password = "oni12345";
$dbname = "devmyweb_phonemoney";

$conn = new mysqli($servername, $username, $password,$dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}



