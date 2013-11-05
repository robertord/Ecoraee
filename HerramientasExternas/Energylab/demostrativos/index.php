<?php 
$aTemp = explode("/", $_SERVER['HTTP_REFERER']);
if(in_array("en", $aTemp))
	header("location: en/index.php");
else
	header("location: es/index.php");