<?php
include_once("dbconnect.php");
$booktitle = $_POST['booktitle'];
$bookwritter = $_POST['bookwritter'];
$booktype = $_POST['booktype'];
$bookimage = $_POST['bookimage'];
$encoded_string = $_POST["encoded_string"];

$decoded_string = base64_decode($encoded_string);
$path = '../bookimage/'.$bookimage.'.jpg';
$is_written = file_put_contents($path, $decoded_string);

if ($is_written > 0) {
    $sqlinsert = "INSERT INTO BOOK(TITLE,WRITTER,TYPE,IMAGE) VALUES('$booktitle','$bookwritter','$booktype','$bookimage')";
    if ($conn->query($sqlinsert) === TRUE){
        echo "succes";
    }else{
        echo "failed";
    }
}else{
    echo "failed";
}

?>