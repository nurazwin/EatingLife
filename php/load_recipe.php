<?php
error_reporting(0);
include_once("dbconnect.php");
$foodid = $_POST['foodid'];

$sql = "SELECT * FROM RECIPE ";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $response["recipe"] = array();
    while ($row = $result ->fetch_assoc()){
        $recipelist = array();
        $recipelist[foodid] = $row["FOODID"];
        $recipelist[foodname] = $row["FOODNAME"];
        $recipelist[foodimage] = $row["FOODIMAGE"];
        $recipelist[description] = $row["DESCRIPTION"];
        $recipelist[price] = $row["PRICE"];
        array_push($response["recipe"], $recipelist);
        
        
    } 
    echo json_encode($response);
    
}else{
    echo "nodata";
}
?>
