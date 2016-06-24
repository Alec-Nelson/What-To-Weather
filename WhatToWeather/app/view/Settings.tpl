<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Settings</title>
<link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/WhatToWeather.css">
<script src="<?= BASE_URL ?>/public/js/jquery-2.2.0.min.js"></script>
<script src="<?= BASE_URL ?>/public/js/weatherScripts.js"></script>
</head>
</head>
<body>
<ul id="breadCrumbs">
	<li><a href="<?= BASE_URL ?>/about/">About	</a></li>
	<li><a href="<?= BASE_URL ?>/settings/">Settings</a></li>
	<li><a href="<?= BASE_URL ?>/addclothes/">Add Clothes</a></li>
	<li><a href="<?= BASE_URL ?>/">Home	</a></li>
	<li hidden id="weather" ><img id="wicon"><a id="wtext"></a></li>
</ul>
<img class="Umbrella" src="<?= BASE_URL ?>/public/img/weatherVein.jpg" alt="A Weather Vein" height="100" width="100">

<h1>Settings</h1>
<h2>What to Weather</h2>

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

<form method="POST" action="<?= BASE_URL ?>/settings/change">
<div id="settingsWrapper">
	<div class="changeSettings">
		<input class="settingsBox" type="text" placeholder="Change Email" name="newEmail"/>
				<p class="setDesc"><?= $email ?></p>

			<!-- <input class="setButtons" type="submit" value="Change"/> -->
		<h2 id="checkHeading">Daily Notifications</h2>
	</div>
	<div class="changeSettings">
		<input class="settingsBox" type="text" placeholder="Change UserName" name="newUser"/>
		<p class="setDesc"><?= $userName ?></p>
			<!-- <input class="setButtons" type="submit" value="Change"/> -->
		<input id="textCheck" class="checkBoxes" type="checkbox"/>
		<p class="checkLabel">Text me my daily outfit</p>
	</div>
	<div class="changeSettings">
		<input class="settingsBox" type="text" placeholder="Change First Name" name="newFirst"/>
				<p class="setDesc"><?= $firstName ?></p>

			<!-- <input class="setButtons" type="submit" value="Change"/> -->
		<input id="emailCheck" class="checkBoxes" type="checkBox"/>
		<p class="checkLabel">Email me my daily outfit</p>
	</div>
	<div class="changeSettings">
		<input class="settingsBox" type="text" placeholder="Change Last Name" name="newLast"/>
				<p class="setDesc"><?= $lastName ?></p>

			<!-- <input class="setButtons" type="submit" value="Change"/> -->
	</div>
</div>
<div class="but">
	<input id="acceptSettings" class="buttons" type="submit" value="Accept"/>
</div>
</form>

<?php
	if( !isset($_SESSION['confirm']) || $_SESSION['confirm'] == null) {
?>
<form method="POST" action="<?= BASE_URL ?>/settings/confirm">
	<div class="but">
		<input id="deleteAccountButton" class="buttons" type="submit" value="Delete Account"/>
	</div>
</form>

<?php
}
	else  {
?>

<form method="POST" action="<?= BASE_URL ?>/settings/delete">
	<div class="but">
		<input id="deleteAccountButton" class="buttons" type="submit" value="Yes Delete Account"/>
	</div>
</form>
<?php
	}
?>


</body>
</html>
