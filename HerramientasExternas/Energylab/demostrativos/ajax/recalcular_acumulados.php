<?php
require_once '../conf/configuration.php';
include_once 'LogicaBdd.php';
require_once 'PHPExcel.php';

try{
	if(! isset($_REQUEST['demostrativo_id'])  || !isset($_REQUEST['date_from']) )
		throw new Exception("Error en el formato de llamada a la página.");

	$res = LogicaBdd::update_acumulativos_from_date($_REQUEST['demostrativo_id'], $_REQUEST['date_from']);
	if( $res ==  "1")
		exit("1");
	else
		throw new Exception($res);

}catch(Exception $e){
	header("Status: 400 Bad Request", true, 400);  
	echo $e->getMessage();
}
