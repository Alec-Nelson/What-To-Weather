<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Add Clothes</title>
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

<h1>Add Clothes</h1>
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
<table id='clothesTable'>
	<tr>
		<th>Type</th>
		<th>Temp Min</th>
		<th>Temp Max</th>
		<th>Name</th>
	</tr>
<?php
if (sizeof($clothes) >= 1) {

foreach($clothes as $clothing) {
		$clothingID = $clothing->get('id');
		$clothingName = $clothing->get('clothingname');
		$clothingType = $clothing->get('clothingtype');
		$clothingMin = $clothing->get('tempmin');
		$clothingMax = $clothing->get('tempmax');
		echo '<tr><td>'.$clothingType.'</td><td>'.$clothingMin.'</td><td>'.$clothingMax.'</td><td>'.$clothingName.'</td></tr>';
}
}
?>
</table>
<div id="addClothes">

<select class="dropDown" id="typeClothing" name="newClothingType">
	<option>Shirt</option>
	<option>Jacket</option>
	<option>Pants</option>
	<option>Shoes</option>
	<option>Hat</option>
</select>
<input id="tempMin" class="settingsBox" type="text" placeholder="Min Temp F"/>
<input id="tempMax" class="settingsBox" type="text" placeholder="Max Temp F"/>
<input id="nameClothing" class="settingsBox" type="text" placeholder="Name of Clothing" name="newClothingName"/>
	<div class="but">
	<input id="submitClothingButton" class="buttons" type="submit" value="Enter Clothing"/>
	</div>
</div>



</body>
</html>
