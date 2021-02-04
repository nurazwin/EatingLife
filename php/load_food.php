<?php
error_reporting(0);
include_once("dbconnect.php");
$bookid = $_POST['bookid'];

$sql = "SELECT * FROM RECIPE WHERE BOOKID = '$bookid'";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $response["foods"] = array();
    while ($row = $result ->fetch_assoc()){
        $foodlist = array();
        $foodlist[foodid] = $row["FOODID"];
        $foodlist[foodname] = $row["FOODNAME"];
        $foodlist[foodimage] = $row["FOODIMAGE"];
        $foodlist[description] = $row["DESCRIPTION"];
        $foodlist[price] = $row["PRICE"];
        array_push($response["foods"], $foodlist);
        
        
    } 
    echo json_encode($response);
    
}else{
    echo "nodata";
}
?>
