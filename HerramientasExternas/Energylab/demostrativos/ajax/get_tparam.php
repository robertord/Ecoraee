<?php
// TODO : capturar errores si no existe tabla etc ... 
// TODO : verificar permisos
// TODO : verificar request params de búsqueda
require_once '../conf/configuration.php';

$aResDB = ORM::for_table($_REQUEST['table'])->find_array();
$aRes = array();
foreach ($aResDB as $k=>$parametro){
	$aRes[] = parametrosDemostrativo::get($parametro['COLUMN_NAME']);
}

echo json_encode( $aRes );