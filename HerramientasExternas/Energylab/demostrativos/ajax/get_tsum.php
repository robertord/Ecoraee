<?php
// TODO : capturar errores si no existe tabla etc ... 
// TODO : verificar permisos
// TODO : verificar request params de búsqueda<?php
require_once '../conf/configuration.php';
$sTable = $_REQUEST['table'];
$aColumns = ORM::for_table($sTable)->getColumns();
foreach ($aColumns as $key => $aColumn) {
	if(strstr($aColumn["Field"], "categoria") && strlen($aColumn["Field"])==11 )
		$aParametros[] = $aColumn["Field"];
}
unset($aColumns);
$aRes = array();
$i = 0;
foreach($aParametros as $parametro){
	// Añadir where fecha...
	$aRes[$i]['k'] = $i+1;
	$aRes[$i]['name'] = $parametro;
	// TODO : APLICAR FACTOR DE EQUIVALENCIA?
	$aRes[$i]['value'] = ORM::for_table($sTable)->sum($parametro);
	$i++;
}
echo json_encode( $aRes );