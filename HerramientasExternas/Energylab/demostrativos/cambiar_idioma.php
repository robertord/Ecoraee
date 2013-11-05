<?php
include_once "../conf/configuration.php";
$aLang = array("es", "en");
print_r($aLang);
print_r($_REQUEST);
if(!isset($_REQUEST["i"]) ||!in_array($_REQUEST["i"], $aLang ) ){
	$_REQUEST["i"] = "es";
}
$_SESSION['lang'] = strtoupper($_REQUEST["i"]);
header("location: ".$_REQUEST["i"]."/index.php");
/*
?>
<script>
	var aParametros = new Array();
	<?
		parametrosDemostrativo::printArrayJs("aParametros", strtoupper($_REQUEST["i"]));
	?>
</script>*/