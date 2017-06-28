<?php
require ("config/config.php");
require ("lib/db.php");
$conn = db_init($config["host"],$config["duser"],$config["psw"],$config["dname"]);
//echo "string";
if(!isset($_POST['name']) || !isset($_POST['score']) || !isset($_POST['category'])|| !isset($_POST['basic_info'])|| !isset($_POST['create_user_id'])|| !isset($_POST['review'])) exit;

$name = mysqli_real_escape_string($conn, $_POST['name']);
$score = mysqli_real_escape_string($conn, $_POST['score']);
$category = mysqli_real_escape_string($conn, $_POST['category']);
$basic_info = mysqli_real_escape_string($conn, $_POST['basic_info']);
$create_user_id = mysqli_real_escape_string($conn, $_POST['create_user_id']);
$review = mysqli_real_escape_string($conn, $_POST['review']);

//echo "string";
//echo $login_email;
//echo($category);


$sql = "SELECT id FROM category WHERE name = '".$category."'";
$result = mysqli_query($conn, $sql);
$category_id = mysqli_fetch_row($result)[0];
//echo($sql);
//echo($category_id);

$sql = "SELECT id FROM user WHERE login_email = '".$create_user_id."'";
$result = mysqli_query($conn, $sql);
$user_id = mysqli_fetch_row($result)[0];

/*
$sql = "SELECT * FROM user";
$result = mysqli_query($conn, $sql);
$count=mysqli_num_rows($result); // 회원가입 전 개수 확인
*/
echo "success";
$sql = "INSERT into review_target (category_id, name, input_date, create_user_id,score,basic_info) 
				values ('".$category_id."','".$name."',now(),'".$user_id."',".$score.",'".$basic_info."')";
//echo($sql);
$result = mysqli_query($conn, $sql);

$sql = "SELECT id FROM review_target WHERE name = '".$name."' AND basic_info = '".$basic_info."'";
$result = mysqli_query($conn, $sql);
$review_target_id = mysqli_fetch_row($result)[0];

$sql = "INSERT into review (target_id, user_id,score, input_date, content) 
				values ('".$review_target_id."','".$user_id."',".$score.",now(),'".$review."')";
//echo($sql);
$result = mysqli_query($conn, $sql);


if ($score <= 3) {
 	$sql = "UPDATE review_target SET bad_value = bad_value + 1 where id = ".$review_target_id;
 	$result = mysqli_query($conn, $sql);
} elseif ($score <= 7) {
 	$sql = "UPDATE review_target SET soso_value = soso_value + 1 where id = ".$review_target_id;
 	$result = mysqli_query($conn, $sql);
}else{
	$sql = "UPDATE review_target SET good_value = good_value + 1 where id = ".$review_target_id;
 	$result = mysqli_query($conn, $sql);
}
	$sql = "UPDATE review_target SET review_count = review_count + 1 where id = ".$review_target_id;
 	$result = mysqli_query($conn, $sql);

exit();
?>