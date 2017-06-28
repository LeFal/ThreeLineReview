<?php
	require ("config/config.php");
	require ("lib/db.php");
	$con = db_init($config["host"],$config["duser"],$config["psw"],$config["dname"]);
	if(!isset($_POST['target_id'])) exit;
	$target_id = mysqli_real_escape_string($con, $_POST['target_id']);

	if (mysqli_connect_errno())
	 {
    	echo "Failed to connect to MySQL: " . mysqli_connect_error();
  	}
	$sql =  "SELECT content, name as writer , score, target_id, input_date,review.id
			FROM user right Join review
			on user.id = review.user_id
            where target_id = ".$target_id."
			order by review.id desc;";
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
		echo "{\"data\" :";
		echo json_encode($resultArray,JSON_NUMERIC_CHECK);
		echo "}";
		mysqli_close($con);
?>
