<?php
// TODO : capturar errores si no existe tabla etc ... 
// TODO : verificar permisos
// TODO : verificar request params de búsqueda

require_once '../conf/configuration.php';

$aColumns = ORM::for_table('vw_demostrativo_bubble_vars')->find_array();
$aResDatabase = ORM::for_table($_REQUEST['table'])->find_array();
$aResDatabase  = reset($aResDatabase);
$aRes = array();
$i = 0;
//echo "<pre>"; print_r($aResDatabase);
foreach($aColumns as $column){
	$parametro = $column['COLUMN_NAME'];
	$aTemp = parametrosDemostrativo::get($parametro);
	$aRes[$i]['k'] = $i+1;
	$aRes[$i]['name'] = $parametro;
	$aRes[$i]['value'] = $aResDatabase[$parametro];
	$aRes[$i]['visible_value'] = $aResDatabase[$parametro];
	$aRes[$i]['valor_intuitivo'] = $aResDatabase[str_replace("_peso","_ui",$parametro)];	
	$aRes[$i]['valor_standard'] = $aResDatabase[str_replace("_peso","",$parametro)];
	$i++;
}
echo json_encode( $aRes );