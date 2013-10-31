<?php
// TODO : capturar errores si no existe tabla etc ... 
// TODO : verificar permisos
// TODO : verificar request params de búsqueda
require_once '../conf/configuration.php';
$queryOrm = ORM::for_table($_REQUEST['table']);

if( isset($_REQUEST['dtFrom']) ){
	$dateFrom = date("Y-m-d H:i:s",strtotime(str_replace('/','-',$_REQUEST['dtFrom'] )));
	$queryOrm->where_raw(" date >= '".$dateFrom."' ");
}
if( isset($_REQUEST['dtTo']) ){
	$dateTo = date("Y-m-d H:i:s",strtotime(str_replace('/','-',$_REQUEST['dtTo'] )));
	$queryOrm->where_raw(" date <= '".$dateTo."' ");
}


$aRes = $queryOrm->find_array();

echo json_encode( $aRes );
