<?php 
include_once "../../../../lib/sec.php";
sec_session_start_ajax();
if($_SESSION["rol"] != "ADMIN")
	die('No tiene permiso para realizar la acci&oacute;n solicitada');