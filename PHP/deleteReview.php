<?php
require ("config/config.php");
require ("lib/db.php");
$conn = db_init($config["host"],$config["duser"],$config["psw"],$config["dname"]);
//echo "string";
if(!isset($_POST['target_id'])) exit;

$target_id = mysqli_real_escape_string($conn, $_POST['target_id']);

$sql = "DELETE FROM review where target_id = ".$target_id;
$result = mysqli_query($conn, $sql);

$sql = "DELETE FROM review_target where id = ".$target_id;
$result = mysqli_query($conn, $sql);

echo "success";
exit();
