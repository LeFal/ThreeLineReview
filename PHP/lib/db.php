<?php
	function db_init($host, $duser, $psw, $dname)
	{
		$conn = mysqli_connect($host,$duser,$psw);
		mysqli_select_db($conn,$dname);
		return $conn;
	}
 ?>
 