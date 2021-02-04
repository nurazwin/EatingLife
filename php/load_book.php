<?php
error_reporting(0);
include_once("dbconnect.php");
$type = $_POST['type'];
$sql = "SELECT * FROM BOOK";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $response["book"] = array();
    $bookidarray = array();
    $i = 0;
    
    while ($row = $result ->fetch_assoc()){
        $booklist = array();
        $booklist[bookid] = $row["BOOKID"];
        $booklist[booktitle] = $row["TITLE"];
        $booklist[bookwritter] = $row["WRITTER"];
        $booklist[booktype] = $row["TYPE"];
        $booklist[bookimage] = $row["IMAGE"];
        $bookidarray[$i] = $row["ID"];
        $i++;
        array_push($response["book"], $booklist);
    }
    echo json_encode(array_unique($response));
}else{
    echo "nodata";
}
?>
