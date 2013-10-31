<?php
include_once "../conf/configuration.php";
//define('EOL',(PHP_SAPI == 'cli') ? PHP_EOL : '<br />');
include_once 'PHPExcel.php';
try{
	set_time_limit(0);
}catch(Exception $e){

}

$aParams = $_REQUEST;
/*$a = explode ("ajaxurl=", urldecode($_SERVER["REQUEST_URI"]));
$aVars = explode("&", $a[1]);*/
$aVars = explode("&", $_POST['ajaxurl']);


foreach ($aVars as $k =>$v){
	$a2 = explode("=",$v);
	if(!isset($_REQUEST[$k]))
		if(isset($a2[1]))
			$aParams[$a2[0]] = $a2[1];
}
$aParams['no_limit'] = 1;

$sTable = $aParams['table'];

function to_mysql_date($fecha){
    ereg( "([0-9]{1,2})/([0-9]{1,2})/([0-9]{2,4})", $fecha, $mifecha);
    $lafecha=$mifecha[3]."-".$mifecha[2]."-".$mifecha[1];
    return $lafecha;
} 

function getNameFromNumber($num) {
    $numeric = $num % 26;
    $letter = chr(65 + $numeric);
    $num2 = intval($num / 26);
    if ($num2 > 0) {
        return getNameFromNumber($num2 - 1) . $letter;
    } else {
        return $letter;
    }
}
$a = explode("_", $aParams['table']);
$demostrativo_id = end($a);

$demostrativo = ORM::for_table('demostrativo')->find_one($demostrativo_id);

$aTableParams = parametrosDemostrativo::getAll($demostrativo_id);

$aResCols = ORM::for_table($aParams['table'])->getColumns();

foreach($aResCols as $col)
{
	$aColumns[] = $col['Field'];
	if($col['Key'] == "PRI")
	{
		$sIndexColumn = $col['Field'];
	}
}

$queryOrm = ORM::for_table($aParams['table'])->select_expr('SQL_CALC_FOUND_ROWS '.str_replace(" , ", " ", implode(", ", $aColumns)));
$queryOrm->where_raw("`date` BETWEEN '".to_mysql_date($aParams['dtFrom'])."' AND '".to_mysql_date($aParams['dtTo'])."' ");
$queryOrm->order_by_asc('date');
$resOrm = $queryOrm->find_array();
	
$rowInfo 	= array();
$aDataFull 	= array();



if(count($resOrm) > 0){
	foreach($resOrm as $reg){
		$rowFull 	= array();
		foreach($reg as $k=>$v){
			if($k != 'id' && $k != "h_gestor_name" && $k != "h_gestor_email" && $k != "h_nombre_demostrativo")
				$rowFull[$k] = $v;
			else
				$rowInfo[$k] = $v;
		}	
		$aDataFull[] = $rowFull;
	}
}

$nRegistros = count($aDataFull);

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

$objPHPExcel->setActiveSheetIndex(0);


if($nRegistros > $_XLSX_MAX_STYLED_ROWS){ // definido en configuration.php
	$bApplyStyle = false;
}else{
	$bApplyStyle = true;
	$default_border = array(
	    'style' => PHPExcel_Style_Border::BORDER_THIN,
	    'color' => array('rgb'=>'000000')
	);
	$style_header = array(
	    'borders' => array(
	        'bottom' => $default_border,
	        'left' => $default_border,
	        'top' => $default_border,
	        'right' => $default_border,
	    ),
	    'fill' => array(
	        'type' => PHPExcel_Style_Fill::FILL_SOLID,
	        'color' => array('rgb'=>'DBE5F1'),
	    ),
	    'font' => array(
	        'bold' => true,
	        'size' => 9,
	    )
	);
	$style_normal = array( 
		'borders' => array(
	        'bottom' => $default_border,
	        'left' => $default_border,
	        'top' => $default_border,
	        'right' => $default_border,
	    ),
	    'font' => array(
	        'bold' => false,
	        'size' => 9,
	    )
	);
}

$worksheet = $objPHPExcel->getActiveSheet();


$worksheet->setCellValue('B2', $demostrativo['name']. "  (".strtolower($rowInfo['h_nombre_demostrativo']).")");
$worksheet->mergeCells('B2:F2');


$worksheet->setCellValue('B3','Gestor');

$worksheet->setCellValue('C3', $rowInfo['h_gestor_name']);
$worksheet->mergeCells('C3:D3');


$worksheet->setCellValue('E3',$rowInfo['h_gestor_email']);
$worksheet->mergeCells('E3:F3');


if($bApplyStyle){
	$worksheet->getStyle('B2:F2')->applyFromArray( $style_header );
	$worksheet->getStyle('B2:F2')->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
	$worksheet->getStyle('B3')->applyFromArray( $style_header );
	$worksheet->getStyle('C3:D3')->applyFromArray( $style_header );
	$worksheet->getStyle('E3:F3')->applyFromArray( $style_header );
}


$i = 1;
$j = 0;
$j2 = 1;
foreach($aDataFull as $row => $columns) {
	if($i == 1){
		$column = 1;
		foreach($columns as $rowname => $data) {
			if($j<21){		
				$name =  $aTableParams[$rowname]["lang_ES"];
				if( isset( $aTableParams[$rowname]["unidades_ES"] ) && strlen( $aTableParams[$rowname]["unidades_ES"]) )
					$name =  $name."  (".$aTableParams[$rowname]["unidades_ES"].")";
				if($name=="date")
					$name="";
				$worksheet->setCellValueByColumnAndRow($column, $row + 7, $name);	
				$colum_letter = getNameFromNumber($column);		
				$C1 = $colum_letter."".($row + 7);
				$C2 = $colum_letter."".($row + 8);
				$worksheet->mergeCells("$C1:$C2");
				if( $rowname != 'date' && $bApplyStyle ) {
					$worksheet->getStyle("$C1:$C2")->applyFromArray( $style_header );					
					$worksheet->getStyle("$C1:$C2")->getAlignment()->setWrapText(true);
					$worksheet->getStyle("$C1:$C2")->getAlignment()->setVertical(PHPExcel_Style_Alignment::VERTICAL_TOP);
					$worksheet->getStyle("$C1:$C2")->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
				}
				else
					$worksheet->setCellValueByColumnAndRow($column, $row + 7, "");	
			}
			else{
				if($j2 == 1){
					$colum_letter1 = getNameFromNumber($column);	
					$colum_letter2 = getNameFromNumber($column+2);		
					$C1 = $colum_letter1."".($row + 7);
					$C2 = $colum_letter2."".($row + 7);
					$worksheet->mergeCells("$C1:$C2");
					$worksheet->setCellValueByColumnAndRow($column, $row + 7, $aTableParams[$rowname]["lang_ES"]);	
					if( $bApplyStyle ){
						$worksheet->getStyle("$C1:$C2")->applyFromArray( $style_header );
						$worksheet->getStyle("$C1:$C2")->getAlignment()->setVertical(PHPExcel_Style_Alignment::VERTICAL_CENTER);
						$worksheet->getStyle("$C1:$C2")->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
					}

				}
				$worksheet->setCellValueByColumnAndRow($column, $row + 8, $aTableParams[$rowname]["unidades_ES"]);	
				if( $bApplyStyle ){
					$worksheet->getStyleByColumnAndRow($column, $row + 8)->applyFromArray( $style_header );
					$worksheet->getStyleByColumnAndRow($column, $row + 8)->getAlignment()->setVertical(PHPExcel_Style_Alignment::VERTICAL_CENTER);
					$worksheet->getStyleByColumnAndRow($column, $row + 8)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
				}

				$j2++;
				if($j2>3)
					$j2 = 1;
			}
			$j ++;
			$column ++;
		}
	}
	$column = 1;
    foreach($columns as $rowname => $data) {
        $worksheet->setCellValueByColumnAndRow($column, $row + 9, $data);
        if($rowname == 'date' && $bApplyStyle){
			$worksheet->getStyleByColumnAndRow($column, $row + 9)->applyFromArray( $style_header );			
			$worksheet->getStyleByColumnAndRow($column, $row + 9)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
		}
		$column ++;
    }
	$i++;
}

if($bApplyStyle){
	$worksheet->getRowDimension('7')->setRowHeight(21);
	$worksheet->getRowDimension('8')->setRowHeight(18);
	$width = 16;
	$worksheet->getColumnDimension('B')->setWidth($width-4);
	$worksheet->getColumnDimension('C')->setWidth($width);
	$worksheet->getColumnDimension('D')->setWidth($width);
	$worksheet->getColumnDimension('E')->setWidth($width);
	$worksheet->getColumnDimension('F')->setWidth($width);
	$worksheet->getColumnDimension('G')->setWidth($width);
	$worksheet->getColumnDimension('H')->setWidth($width);
	$worksheet->getColumnDimension('I')->setWidth($width);
	$worksheet->getColumnDimension('J')->setWidth($width);
	$worksheet->getColumnDimension('K')->setWidth($width);
	$worksheet->getColumnDimension('L')->setWidth($width);
	$worksheet->getColumnDimension('M')->setWidth($width);
	$worksheet->getColumnDimension('N')->setWidth($width);
	$worksheet->getColumnDimension('O')->setWidth($width);
	$worksheet->getColumnDimension('P')->setWidth($width);
	$worksheet->getColumnDimension('Q')->setWidth($width);
	$worksheet->getColumnDimension('R')->setWidth($width);
	$worksheet->getColumnDimension('S')->setWidth($width);
	$worksheet->getColumnDimension('T')->setWidth($width);
	$worksheet->getColumnDimension('U')->setWidth($width);
	$worksheet->getColumnDimension('V')->setWidth($width);
	$worksheet->getColumnDimension('W')->setWidth($width);
	$worksheet->getColumnDimension('X')->setWidth($width);
	$worksheet->getColumnDimension('Y')->setWidth($width);
	$worksheet->getColumnDimension('Z')->setWidth($width);
	$worksheet->getColumnDimension('AA')->setWidth($width);
	$worksheet->getColumnDimension('AB')->setWidth($width);
	$worksheet->getColumnDimension('AC')->setWidth($width);
	$worksheet->getColumnDimension('AD')->setWidth($width);
	$worksheet->getColumnDimension('AE')->setWidth($width);
	$worksheet->getColumnDimension('AF')->setWidth($width);
	$worksheet->getColumnDimension('AG')->setWidth($width);
	$worksheet->getColumnDimension('AH')->setWidth($width);
	$worksheet->getColumnDimension('AI')->setWidth($width);
	$worksheet->getColumnDimension('AJ')->setWidth($width);
	$worksheet->getColumnDimension('AK')->setWidth($width);
	$worksheet->getColumnDimension('AL')->setWidth($width);
	$worksheet->getColumnDimension('AM')->setWidth($width);
	$worksheet->getColumnDimension('AN')->setWidth($width);
}
		


$filename = str_replace(" ", "_", strtolower($demostrativo['name'])).'_'.$demostrativo_id.date("ymdHi").'.xlsx';

// Rename worksheet
$objPHPExcel->getActiveSheet()->setTitle('Demostrativo - datos de salida');

// Set active sheet index to the first sheet, so Excel opens this as the first sheet
$objPHPExcel->setActiveSheetIndex(0);

// Redirect output to a client’s web browser (Excel2007)
header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
header('Content-Disposition: attachment;filename="'.$filename.'"');
header('Cache-Control: max-age=0');

$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
$objWriter->save('php://output');
exit;