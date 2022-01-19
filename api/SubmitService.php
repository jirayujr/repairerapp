<?php
	include 'connected.php';
	header("Access-Control-Allow-Origin: *");

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    
    exit;
}

if (!$link->set_charset("utf8")) {
    printf("Error loading character set utf8: %s\n", $link->error);
    exit();
	}

if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {
				
		$firstname = $_GET['firstname'];
		$lastname = $_GET['lastname'];
		$phone = $_GET['phone'];
		$select_time_date = $_GET['select_time_date'];
		$type_technician = $_GET['type_technician'];
		$detail = $_GET['detail'];
		$images = $_GET['images'];
		$address = $_GET['address'];
		$lat = $_GET['lat'];
		$lng = $_GET['lng'];
		
		
				
		$sql = "INSERT INTO `submitservice_customer`(`id`, `firstname`, `lastname`, `phone`, `select_time_date`, `type_technician`, `detail`, `images`, `address`, `lat`, `lng`) VALUES (Null,'$firstname','$lastname','$phone','$select_time_date','$type_technician','$detail','$images','$address','$lat','$lng')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "TEST";
   
}
	mysqli_close($link);
?>