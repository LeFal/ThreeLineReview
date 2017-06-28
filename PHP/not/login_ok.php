<?php
require ("config/config.php");
require ("lib/db.php");
$conn = db_init($config["host"],$config["duser"],$config["psw"],$config["dname"]);

if(!isset($_POST['user_id']) || !isset($_POST['user_pw'])) exit;
$user_id = mysqli_real_escape_string($conn, $_POST['user_id']);
$password = mysqli_real_escape_string($conn, $_POST['user_pw']);

$sql="SELECT * FROM user WHERE user_id = '".$user_id."' AND password = '".$password."'"; //아뒤랑 비번값 대조

$result = mysqli_query($conn, $sql);
$count=mysqli_num_rows($result);
$user_info = mysqli_fetch_assoc($result);



if ($count != 1) {
    	echo "<script>alert('아이디 또는 패스워드가 잘못되었습니다.');history.back();</script>";
    	exit;
} 
else {
session_start();
$nickname = $user_info['nickname'];

$_SESSION['user_id'] = $user_id;
$_SESSION['user_name'] = $nickname;
}
?>

<meta http-equiv='refresh' content='0;url=index.php'>

