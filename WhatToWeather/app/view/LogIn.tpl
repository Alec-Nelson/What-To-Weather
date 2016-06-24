<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Log In Page</title>
<link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/WhatToWeather.css">
<script src="<?= BASE_URL ?>/public/js/jquery-2.2.0.js"></script>
<script type="text/javascript" src="<?= BASE_URL ?>/public/js/weatherScripts.js"></script>
</head>
<body>

<ul id="breadCrumbs">
	<li><a href="<?= BASE_URL ?>/about/">About	</a></li>
	<li><a href="<?= BASE_URL ?>/settings/">Settings</a></li>
	<li><a href="<?= BASE_URL ?>/addclothes/">Add Clothes</a></li>
	<li><a href="<?= BASE_URL ?>/">Home	</a></li>
	<li hidden id="weather" ><img id="wicon"><a id="wtext"></a></li>
</ul>
<h1>What to Weather</h1>

		<span id="error">
			<?php
				if(isset($_SESSION['error']))
				{
					if($_SESSION['error'] != '')
					{
						echo $_SESSION['error'];
						$_SESSION['error'] = '';
					}
				}
			?>
		</span>

				<?php
			if( !isset($_SESSION['username']) || $_SESSION['username'] == '') {
		?>


	<form method="POST" action="<?= BASE_URL ?>/login">
	<div class="textBox">
		<input id="logInUserName" type="text" placeholder=" User Name" name="uname" />
		<input id="logInPassword" type="password" placeholder=" Password" name="pass"	/>
	</div>

	<div class="but">
		<input id="logInButton" class ="buttons" type="submit" value="Log In" name="submit"/>
	</div>
	</form>

	<form method="POST" action="<?= BASE_URL ?>/signup">
	<div class="but">
		<input id="signUpButton" class ="buttons" type="submit" value="Sign Up"/>
	</div>
	</form>

		<?php
			} else {
		?>

			<p>Logged in as <strong><?= $_SESSION['username'] ?></strong>. <a href="<?= BASE_URL ?>/logout">Log out?</a></p>

		<?php
			}
		?>




<p class="description">
	Tired of checking the weather every morning? Want to be able to just  get dressed and leave without worrying about the rain, or the wind? What to Weather will send you a message dictating exactly what you should wear today.
</p>

<p id="linkToAbout">
	<a href="<?= BASE_URL ?>/about">What is What to Weather About?</a>
</p>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>

<?php
	if( isset($_SESSION['username']) && $_SESSION['username'] != '') {
		echo '<h2 id=feed>My Feed</h2>';
		echo '<div class="feed">';
		for($i = 0; $i < 3; ++$i) {
			echo '<div class="post"><span>'.$clothingString[$i].' </span>';
    		echo '<p class="post">'.$posts[$i]->get('message').'</p>';
    		echo '<span>Posted By: </span>';
    		echo '<a href="'.BASE_URL.'/about/">'.$authors[$i]->get('username').'</a>';
    		echo '<span>  On: '.date("F j, Y", strtotime($posts[$i]->get('date_created'))).'</span></div>';
		}
		echo '</div>';
	}
?>
</body>
</html>
