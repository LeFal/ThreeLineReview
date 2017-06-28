<?php
	require ("config/config.php");
	require ("lib/db.php");
	$con = db_init($config["host"],$config["duser"],$config["psw"],$config["dname"]);

	if (mysqli_connect_errno())
  {
    echo "Failed to connect to MySQL: " . mysqli_connect_error();
  }
	$sql =  "SELECT review_target.id, category.name as category_id , review_target.name, score, basic_info, 	review_target.input_date, like_count, review_count, create_user_id, good_value, soso_value, 	bad_value, review_target.status, img
			FROM review_target left Join category
			on review_target.category_id = category.id
			ORDER BY review_target.id DESC;";
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
