<?php
require ("config/config.php");
require ("lib/db.php");
$conn = db_init($config["host"],$config["duser"],$config["psw"],$config["dname"]);
//echo "string";
if(!isset($_POST['target_id']) || !isset($_POST['basic_info'])) exit;

$target_id = mysqli_real_escape_string($conn, $_POST['target_id']);
$basic_info = mysqli_real_escape_string($conn, $_POST['basic_info']);



$sql = "UPDATE review_target SET basic_info = '".$basic_info."'
			where id = ".$target_id;
$result = mysqli_query($conn, $sql);

echo "success";
exit();
?>