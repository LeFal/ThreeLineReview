<?php
	require ("config/config.php");
	require ("lib/db.php");
	$con = db_init($config["host"],$config["duser"],$config["psw"],$config["dname"]);

	if (mysqli_connect_errno())
  {
    echo "Failed to connect to MySQL: " . mysqli_connect_error();
  }
	$sql =  "SELECT * FROM user WHERE id =".$_GET['id'];
	if ($result = mysqli_query($con, $sql))
	{
		$resultArray = array();
		$tempArray = array();

		// Loop through each row in the result set
		while($row = $result->fetch_object())
		{
			// Add each row into our results array
			$tempArray = $row;
		    array_push($resultArray, $tempArray);
		}
	}
		// Finally, encode the array to JSON and output the results
		echo json_encode($resultArray);
		mysqli_close($con);
?>
