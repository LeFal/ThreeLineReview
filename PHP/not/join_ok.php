<?php
require ("config/config.php");
require ("lib/db.php");
$conn = db_init($config["host"],$config["duser"],$config["psw"],$config["dname"]);

if(!isset($_POST['user_id']) || !isset($_POST['user_pw']) || !isset($_POST['nickname'])) exit;
$user_id = mysqli_real_escape_string($conn, $_POST['user_id']);
$user_pw = mysqli_real_escape_string($conn, $_POST['user_pw']);
$nickname = mysqli_real_escape_string($conn, $_POST['nickname']);

$sql = "SELECT * FROM user WHERE user_id = '".$user_id."'"; //중복 아이디 확인
$result = mysqli_query($conn, $sql);
$count = mysqli_num_rows($result);


if ($count >= 1) {
    	echo "<script>alert('중복된 아이디가 있습니다.');history.back();</script>";
    	exit;
} 

$sql="SELECT * FROM user WHERE nickname = '".$nickname."'"; //중복 닉네임 확인
$result = mysqli_query($conn, $sql);
$count=mysqli_num_rows($result);

if ($count >= 1) {
    	echo "<script>alert('중복된 닉네임이 있습니다.');history.back();</script>";
    	exit;
} 

$sql = "SELECT * FROM user";
$result = mysqli_query($conn, $sql);
$count=mysqli_num_rows($result); // 회원가입 전 개수 확인


$sql="INSERT INTO `user` (`user_id`, `nickname`, `created`, `creator`,`review_count`,`good_count`,`soso_count`,`bad_count`,`average_score`,`point`,`password`) VALUES('".$user_id."', '".$nickname."' , now(), 'leo',0,0,0,0,0,0,'".$user_pw."')"; //중복 아이디 확인

//echo $sql;
//exit();

$result = mysqli_query($conn, $sql);

$sql="SELECT * FROM user";
$result = mysqli_query($conn, $sql);
$after_count=mysqli_num_rows($result); // 회원가입 후 개수 확인

if ($count + 1 == $after_count) {
	echo "<script>alert('Join Success.');</script>";
	
	session_start();
	$_SESSION['user_id'] = $user_id;
	$_SESSION['user_name'] = $nickname;
} else{
	echo "<script>alert('Join fail.');history.back();</script>";
}
?>
<meta http-equiv='refresh' content='0;url=index.php'>

