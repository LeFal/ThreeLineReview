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
				echo '<li><a href = "http://localhost:8080/index.php?id='.$row['id'].'">'.htmlspecialchars($row['title']) .'</a></li>'."\n";
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
		<?php  
		if (empty($_GET['id']) === false) {
		 	$sql = 'SELECT topic.id,title, description, name, author FROM topic LEFT JOIN user ON topic.author = user.id WHERE topic.id ='.$_GET['id']; 
			$result = mysqli_query($conn, $sql);
			$row = mysqli_fetch_assoc($result);
			echo '<p><h2>'.htmlspecialchars($row['title']).'</h2></p>';
			echo '<p><h5>'.htmlspecialchars($row['name']).'</h5></p>';
			echo strip_tags($row['description'],'<a><h1><h2><h3><h4><h5><ul><ol><li>');
		}
		?>
	</article>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="http://localhost:8080/bootstrap-3.3.4-dist/js/bootstrap.min.js"></script>
  </body>
</html>