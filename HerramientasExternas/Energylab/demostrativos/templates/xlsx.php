<?php
// TODO: capturar errores si no existe tabla ...
//header('Content-Type: application/json');
require_once('../conf/configuration.php');
define('EOL',(PHP_SAPI == 'cli') ? PHP_EOL : '<br />');
require_once '../lib/Classes/PHPExcel.php';

die (__LINE__);

$aParams = $_REQUEST;
$a = explode ("get_dt_tdata.php?", urldecode($_SERVER["REQUEST_URI"]));
$aVars = explode("&", $a[1]);
foreach ($aVars as $k =>$v){
	$a2 = explode("=",$v);
	if(!isset($_REQUEST[$k]))
		if(isset($a2[1]))
			$aParams[$a2[0]] = $a2[1];
}

// Create new PHPExcel object
$objPHPExcel = new PHPExcel();
// Set document properties
$objPHPExcel->getProperties()->setCreator("Energylab")
							 ->setLastModifiedBy("Energylab")
							 ->setTitle("Energylab - Demostrativo")
							 ->setSubject("Demostrativo - Datos de salida")
							 ->setDescription("Demostrativo - Datos de salida")
							 ->setKeywords("Demostrativo - Datos de salida")
							 ->setCategory("salida");


// Add some data
$objPHPExcel->setActiveSheetIndex(0);
$contents = file_get_contents("../ajax/get_dt_tdata.php?".$aParams['ajaxurl']);
$contents = utf8_encode($contents);
$rows = json_decode($contents); 


$worksheet = $objPHPExcel->getActiveSheet();
$i = 0;
foreach($rows as $row => $columns) {
	if($i == 0){
		$column = 0;
		foreach($columns as $rowname => $data) {
			$worksheet->setCellValueByColumnAndRow($column, $row + 1, $rowname);
			$column ++;
		}
	}
	$column = 0;
    foreach($columns as $rowname => $data) {
        $worksheet->setCellValueByColumnAndRow($column, $row + 2, $data);
		$column ++;
    }
	$i++;
}
		
// Rename worksheet
$objPHPExcel->getActiveSheet()->setTitle('Testing results ');

// Set active sheet index to the first sheet, so Excel opens this as the first sheet
$objPHPExcel->setActiveSheetIndex(0);

// Redirect output to a client’s web browser (Excel2007)
header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
header('Content-Disposition: attachment;filename="'.$aParams['table'].'_'.date("YmdHi").'.xlsx"');
header('Cache-Control: max-age=0');

$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
$objWriter->save('php://output');
exit;