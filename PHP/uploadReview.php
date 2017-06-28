<?php
require ("config/config.php");
require ("lib/db.php");
$conn = db_init($config["host"],$config["duser"],$config["psw"],$config["dname"]);
//echo "string";
if(!isset($_POST['content']) || !isset($_POST['score']) || !isset($_POST['user'])|| !isset($_POST['target_id'])) exit;

$content = mysqli_real_escape_string($conn, $_POST['content']);
$score = mysqli_real_escape_string($conn, $_POST['score']);
$user = mysqli_real_escape_string($conn, $_POST['user']);
$target_id = mysqli_real_escape_string($conn, $_POST['target_id']);

$sql = "SELECT id FROM user WHERE login_email = '".$user."'";
$result = mysqli_query($conn, $sql);
$user_id = mysqli_fetch_row($result)[0];

echo "success";
$sql = "INSERT into review (target_id, user_id, input_date, content, score) 
				values (".$target_id.",".$user_id.",now(),'".$content."',".$score.")";
//echo($sql);
$result = mysqli_query($conn, $sql);


if ($score <= 3) {
 	$sql = "UPDATE review_target SET bad_value = bad_value + 1 where id = ".$target_id;
 	$result = mysqli_query($conn, $sql);
} elseif ($score <= 7) {
 	$sql = "UPDATE review_target SET soso_value = soso_value + 1 where id = ".$target_id;
 	$result = mysqli_query($conn, $sql);
}else{
	$sql = "UPDATE review_target SET good_value = good_value + 1 where id = ".$target_id;
 	$result = mysqli_query($conn, $sql);
}
	$sql = "UPDATE review_target SET review_count = review_count + 1 where id = ".$target_id;
 	$result = mysqli_query($conn, $sql);

 	$sql = "UPDATE review_target 
 			SET score  = (((score * (review_count - 1)) + ".$score.") / (review_count)) 
 			where id = ".$target_id;
 	$result = mysqli_query($conn, $sql);

exit();
?>