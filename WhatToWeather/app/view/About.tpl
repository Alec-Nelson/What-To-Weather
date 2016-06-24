<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>About</title>
<link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/WhatToWeather.css">
<script src="<?= BASE_URL ?>/public/js/jquery-2.2.0.js"></script>
<script type="text/javascript" src="<?= BASE_URL ?>/public/js/weatherScripts.js"></script>
</head>
<body>

<ul id="breadCrumbs">
    <li><a href="<?= BASE_URL ?>/about/">About  </a></li>
    <li><a href="<?= BASE_URL ?>/settings/">Settings</a></li>
    <li><a href="<?= BASE_URL ?>/addclothes/">Add Clothes</a></li>
    <li><a href="<?= BASE_URL ?>/">Home </a></li>
    <li hidden id="weather" ><img id="wicon"><a id="wtext"></a></li>
</ul>
<img class="Umbrella" src="<?= BASE_URL ?>/public/img/weatherVein.jpg" alt="A weather Vein" height="100" width="100">
<h1>What to Wea-the-r</h1>
<h2>What can What to Weather do </h2>
<img id="duckPondImage" src="<?= BASE_URL ?>/public/img/rain.jpg" alt="Rain" height="300" width="500">
<p id="aboutDesc">
What to Weather will process the weather for you current location, and then let you know what is the most appropriate thing to wear outside. If it's going to rain at some point What to weather will let you know to wear the right shoes and the right jacket. If the next day it is t-shirt weather what to weather will let you know that too. You can choose to be texted or emailed, to make the process even more convenient. And if you want you can enter in your very own clothes, with the weather that you want to wear them and have an even more personalized message. Effectivly taking out all of the dreary weather checking, then outfit planning. Make an Account today!
</p>
<form method="POST" action="<?= BASE_URL ?>/signup">
	<div class="but">
		<input class="buttons" type="submit" value="Get Started"/>
	</div>
</form>
</body>
</html>
