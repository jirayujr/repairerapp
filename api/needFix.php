<?php
// pattadon nutes author
//send All Data to mysql

$servername = "localhost";
$username = "jirayu";
$password = "A4145";
$dbname = "repairerapp";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}else{
    echo "sucess connection";
}

// input to php
 // Getting the received JSON into $json variable.
 $json = file_get_contents('php://input');
 
 // Decoding the received JSON and store into $obj variable.
    $obj = json_decode($json,true);

    $dateText = $obj['date1'];
    $timeText = $obj['time1'];
    $typeRepairerText = $obj['typeRepairer'];
    $identifySymptomsText = $obj['identifySymptoms'];
    $addressText = $obj['address1'];

    $image1Text = $obj['image0'];
    $image2Text = $obj['image1'];
    $image3Text = $obj['image2'];
    $image4Text = $obj['image3'];
    $latText = $obj['lat'];

    $lngText = $obj['lng'];
    $idText = $obj['id'];

    echo $dateText;
    echo $timeText;
    echo $typeRepairerText;
    echo $identifySymptomsText;
    echo $addressText;

    echo $image1Text;
    echo $image2Text;
    echo $image3Text;
    echo $image4Text;
    echo $latText;

    echo $lngText;
    echo $idText;

    $sql = "INSERT INTO give_fix2 (id,date1, time1, typeRepairer,identifySymptoms,address1,image,lat,lng)
    VALUES ('$idText','$dateText','$timeText','$typeRepairerText','$identifySymptomsText','$addressText','[$image1Text,$image2Text,$image3Text,$image4Text]','$latText','$lngText')";

    if ($conn->query($sql) === TRUE) {
      echo "New record created successfully";
    } else {
      echo "Error: " . $sql . "<br>" . $conn->error;
    }

    //INSERT INTO `givefix` (`date1`, `time1`, `typeRepairer`, `identifySymptoms`, `address1`, `image1`, `image2`, `image3`, `image4`, `lat`, `lng`) VALUES ('1', '11', '1', '1', '1', '1', '1', '1', '2', '1', '1');
    /*
    $sql = "INSERT INTO givefix (date1, time1, typeRepairer,identifySymptoms,address1,image1,image2,image3,image4,lat,lng)
    VALUES ('$dateText','$timeText','$typeRepairerText','$identifySymptomsText','$addressText','$image1Text','$image2Text','$image3Text','$image4Text','$latText','$lngText')";
    
    if ($conn->query($sql) === TRUE) {
    echo "New record created successfully";
    } else {
    echo "Error: " . $sql . "<br>" . $conn->error;
    }
    */

?>