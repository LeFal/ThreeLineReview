<?php
	require ("config/config.php");
	require ("lib/db.php");
	$conn = db_init($config["host"],$config["duser"],$config["psw"],$config["dname"]);
	$result = mysqli_query($conn, "SELECT * FROM topic"); 
 ?>


<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Oh Hyung Jun</title>
    <link href="http://localhost:8080/bootstrap-3.3.4-dist/css/bootstrap.min.css" rel="stylesheet">
   	<link rel="stylesheet" type="text/css" href="http://localhost:8080/style.css">


  </head>

  <body>
  	<nav class="navbar navbar-default ox">
  	  <div class="container">
  	    <!-- LOGO -->
  	    <div class="navbar-header">
	  	    <a class="navbar-brand" href="http://localhost:8080/index.php">
	  	           <img class="LOGO" alt="Brand" src="/img/bitnami.png">
	  	    </a>
  	    </div>
  	    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
  	      	
  	      <form class="navbar-form navbar-left searchbar">
  	        <div class="form-group">
  	          <input type="text" class="form-control" placeholder="Search">
  	        </div>
  	        <button type="submit" class="btn btn-default">Submit</button>
  	      </form>
  	      <ul class="nav navbar-nav navbar-right">
  	 	     <?php
				session_start();
			  	if(!isset($_SESSION['user_id']) || !isset($_SESSION['user_name'])) {
					echo "<li><a href='http://localhost:8080/login.php'>로그인</a></li>";
					echo "<li><a href='http://localhost:8080/join.php'>회원가입</a></li>";
				}  	
	  	        else if(isset($_SESSION['user_id']) && isset($_SESSION['user_name'])){
	  	        	$user_id = $_SESSION['user_id'];
	  	            $user_name = $_SESSION['user_name'];	
	  	            echo "<li><a>".$user_name."</a></li>";
	  	            echo "<li><a href='logout.php'>로그아웃</a></li>";
	  	          }	
			?>
  	      </ul>
  	    </div><!-- /.navbar-collapse -->
  	  </div><!-- /.container-fluid -->
  	</nav>
  	
  	<!-- 카테고리 네비 -->
	<?php
		$lsql = "SELECT id, name FROM l_category";
		$result = mysqli_query($conn, $lsql);
		$i = 1;
		while ($row = mysqli_fetch_assoc($result)) {
		echo
		'<div class="row catnavrow">
	  	  <div class="col-md-2"></div>
	  	  <div class="col-md-2 nav_table"><a href = "http://localhost:8080/index.php?id='.$row['id'].'">'.htmlspecialchars($row['name']) .'</a></div>
	  	  <div class="col-md-6"><table><tr>';
			$msql = "SELECT `id`, `name`,`L_category_id` FROM `M_category` WHERE `L_category_id` = $i * 10000";
			$sub_result = mysqli_query($conn, $msql);
			while ($sub_row = mysqli_fetch_assoc($sub_result)) {
	  	  	echo '<td width="70px"><a class="M_category" href = "http://localhost:8080/index.php?id='.$sub_row['id'].'">'.htmlspecialchars($sub_row['name']).'</a></td>';
	  	  }
	  	  echo
	  	  '</tr></table></div>
	  	  <div class="col-md-2"></div>
	  	</div>';
	  	$i = $i+1;
		}	
	?>









	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="http://localhost:8080/bootstrap-3.3.4-dist/js/bootstrap.min.js"></script>
  </body>
</html>