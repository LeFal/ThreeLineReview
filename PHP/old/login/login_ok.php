<?php
require ("config/config.php");
require ("lib/db.php");
$conn = db_init($config["host"],$config["duser"],$config["psw"],$config["dname"]);

if(!isset($_POST['user_id']) || !isset($_POST['user_pw'])) exit;
$user_id = mysqli_real_escape_string($conn, $_POST['user_id']);
$user_pw = mysqli_real_escape_string($conn, $_POST['user_pw']);

$sql = "SELECT name,id,nickname FROM user";
$result = mysqli_query($conn, $sql);
$row = mysqli_fetch_assoc($result);

$members = $row;

if(!isset($members[$user_id])) {
        echo "<script>alert('아이디 또는 패스워드가 잘못되었습니다.');history.back();</script>";
        exit;
}
if($members[$user_id]['pw'] != $user_pw) {
        echo "<script>alert('아이디 또는 패스워드가 잘못되었습니다.');history.back();</script>";
        exit;
}
session_start();
$_SESSION['user_id'] = $user_id;
$_SESSION['user_name'] = $members[$user_id]['name'];
?>
<meta http-equiv='refresh' content='0;url=index.php'>

