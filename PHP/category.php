<?php
	require ("config/config.php");
	require ("lib/db.php");
	$con = db_init($config["host"],$config["duser"],$config["psw"],$config["dname"]);

	if (mysqli_connect_errno())
  {
    echo "Failed to connect to MySQL: " . mysqli_connect_error();
  }

	$finalArray = array();
  $i = 1;
  while (1) {
  	$j = 1;
	$sql =  "SELECT name FROM category where id = $i * 10000";
	$result = mysqli_query($con, $sql);
	$row = mysqli_fetch_assoc($result);
	if ($row["name"] == "") {
		break;
	}
	$resultArray = array();
	while (1) {
		$sql =  "SELECT name FROM category where id = $i * 10000 + $j * 100";
		$result = mysqli_query($con, $sql);
		$row2 = mysqli_fetch_assoc($result);
		
		if ($row2["name"] == "") {
			break;
		}
		$tempArray = array();
		array_push($resultArray, $row2["name"]);
		$j = $j + 1;
	}
	$finalArray[$row["name"]] = $resultArray;
	$i = $i + 1;
  }

	echo json_encode($finalArray,JSON_NUMERIC_CHECK);
  /*
	if ($result = mysqli_query($con, $sql))
	{
		$resultArray = array();
		$tempArray = array();

		// Loop through each row in the result set
		while($row = mysqli_fetch_assoc($result))
		{
			// Add each row into our results array
			
			$tempArray = $row;
		    array_push($resultArray, $tempArray);
		}


	}
		// Finally, encode the array to JSON and output the results
		echo "\"";
		echo 
		echo "\" : ";
		
	echo "}";


		echo json_encode($resultArray,JSON_NUMERIC_CHECK);
		echo "}";
		mysqli_close($con);*/
?>
