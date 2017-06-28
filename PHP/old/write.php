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
    
    <title>생활코딩</title>
	<link rel="stylesheet" type="text/css" href="http://localhost:8080/style.css">
    <link href="http://localhost:8080/bootstrap-3.3.4-dist/css/bootstrap.min.css" rel="stylesheet">


  
  </head>

  <body id="target">
	<header>
	  	<a href="http://localhost:8080/index.php"> <img src="/img/bitnami.png"> </a>
  	</header>
  	<nav>  
	  	<ol>
	  	<?php 
			while ($row = mysqli_fetch_assoc($result)){
				echo '<li><a href = "http://localhost:8080/index.php?id='.$row['id'].'">'.$row['title'].'</a></li>'."\n";
			}
	  	 ?>	 
	  	</ol>
	</nav>
	<div id="control">
		<input type="button" value="white" onclick="document.getElementById('target').className='white'" />
		<input type="button" value="black" onclick="document.getElementById('target').className='black'" />
		<a href="http://localhost:8080/write.php">쓰기</a>

	</div>
	<article>
		<form action="process.php" method="post">
			<p>
				제목 : <input type="text" name="title">
			</p>
			<p>
				작성자 : <input type="text" name="author">
			</p>
			<p>
				본문 : <textarea name="description" id="description"></textarea>
			</p>
			<input type="hidden" role="uploadcare-uploader" />
			<input type="submit" name="name">
		</form>
	</article>
	<script>
  		UPLOADCARE_PUBLIC_KEY = "ba322d7daba2aff0c9b2";
	</script>
	<script charset="utf-8" src="//ucarecdn.com/widget/2.10.1/uploadcare/uploadcare.full.min.js"></script>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="http://localhost:8080/bootstrap-3.3.4-dist/js/bootstrap.min.js"></script>
  </body>
</html>