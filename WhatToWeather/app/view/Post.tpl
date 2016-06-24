<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Post Clothes</title>
<link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/WhatToWeather.css">
<script src="<?= BASE_URL ?>/public/js/jquery-2.2.0.min.js"></script>
<script src="<?= BASE_URL ?>/public/js/weatherScripts.js"></script>
</head>
<body>
<ul>
	<li><a href="<?= BASE_URL ?>/addclothes/">Add More Clothes</a></li>
	<li><a href="<?= BASE_URL ?>/logout/">Log Out</a></li>
	<li><a href="<?= BASE_URL ?>">Home	</a></li>
	<li><a href="<?= BASE_URL ?>/settings/"><?= $userName ?></a></li>
	<li hidden id="weather" ><img id="wicon"><a id="wtext"></a></li>
</ul>
<img class="Umbrella" src="<?= BASE_URL ?>/public/img/weatherVein.jpg" alt="A Weather Vein" height="100" width="100">

<h1>Post Clothes</h1>
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

<form id="postClothing" method="POST" action="<?= BASE_URL ?>/posts/submit">
<select class="dropDown" id="Shirts" name="newClothingType">
	<option>Shirt</option>
	<?php
	if (sizeof($clothes) >= 1) {

	foreach($clothes as $clothing) {
			$clothingName = $clothing->get('clothingname');
			$clothingType = $clothing->get('clothingtype');
			if ($clothingType == 'Shirt')
			{
				echo '<option>'.$clothingName.'</option>';
			}
	}
	}
	?>
</select>
<select class="dropDown" id="Jackets" name="newClothingType">
	<option>Jacket</option>
	<?php
	if (sizeof($clothes) >= 1) {

	foreach($clothes as $clothing) {
			$clothingID = $clothing->get('id');
			$clothingName = $clothing->get('clothingname');
			$clothingType = $clothing->get('clothingtype');
			if ($clothingType == 'Jacket')
			{
				echo '<option>'.$clothingName.'</option>';
			}
	}
	}
	?>
</select>
<select class="dropDown" id="Pants" name="newClothingType">
	<option>Pants</option>
	<?php
	if (sizeof($clothes) >= 1) {

	foreach($clothes as $clothing) {
			$clothingName = $clothing->get('clothingname');
			$clothingType = $clothing->get('clothingtype');
			if ($clothingType == 'Pants')
			{
				echo '<option>'.$clothingName.'</option>';
			}
	}
	}
	?>
</select>
<select class="dropDown" id="Shoes" name="newClothingType">
	<option>Shoes</option>
	<?php
	if (sizeof($clothes) >= 1) {

	foreach($clothes as $clothing) {
			$clothingName = $clothing->get('clothingname');
			$clothingType = $clothing->get('clothingtype');
			if ($clothingType == 'Shoe')
			{
				echo '<option>'.$clothingName.'</option>';
			}
	}
	}
	?>
</select>
<select class="dropDown" id="Hats" name="newClothingType">
	<option>Hat</option>
	<?php
	if (sizeof($clothes) >= 1) {

	foreach($clothes as $clothing) {
			$clothingName = $clothing->get('clothingname');
			$clothingType = $clothing->get('clothingtype');
			if ($clothingType == 'Hat')
			{
				echo '<option>'.$clothingName.'</option>';
			}
	}
	}
	?>
</select>
<!-- <input id="tempMin" class="settingsBox" type="text" placeholder="Min Temp F"/>
<input id="tempMax" class="settingsBox" type="text" placeholder="Max Temp F"/>
<input id="nameClothing" class="settingsBox" type="text" placeholder="Name of Clothing" name="newClothingName"/> -->
	<div class="but">
	<input id="postClothingButton" class="buttons" type="submit" value="Post Clothing"/>
	</div>
</div>
</form>



</body>
</html>
