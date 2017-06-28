<?php
require ("config/config.php");
require ("lib/db.php");
$conn = db_init($config["host"],$config["duser"],$config["psw"],$config["dname"]);
//echo "string";
if(!isset($_POST['login_email']) || !isset($_POST['user_pw']) ) exit;
$login_email = mysqli_real_escape_string($conn, $_POST['login_email']);
$user_pw = mysqli_real_escape_string($conn, $_POST['user_pw']);

//echo "string";
//echo $login_email;


$sql = "SELECT * FROM user WHERE login_email = '".$login_email."'"; //중복 아이디 확인
$result = mysqli_query($conn, $sql);
$count = mysqli_num_rows($result);


if ($count < 1) {
    	echo "NoEmail";
    	exit;
   		mysqli_close($con);
} 

$sql = "SELECT * FROM user WHERE login_email = '".$login_email."' AND password = '".$user_pw."'"; //중복 아이디 확인
$result = mysqli_query($conn, $sql);
$count = mysqli_num_rows($result);

if ($count < 1) {
    	echo "IncorrectPassword";
    	exit;
   		mysqli_close($con);
} 




echo "success";
exit();
/*
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
*/
