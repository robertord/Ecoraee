<?php
require_once('../conf/configuration.php');
require_once 'PHPExcel.php';

error_reporting(E_ALL);


$aTableParams = parametrosDemostrativo::getAll();

$contents = ORM::for_table('demostrativo_diario')->distinct()->select('id')->where_raw('id > 0')->order_by_asc('id')->find_array();
//$contents = ORM::for_table('demostrativo_diario')->distinct()->select('id')->where_raw('demostrativo_id = 1')->where_raw('id > 1257')->order_by_asc('id')->find_array();

$n = 1;


function cambiaf_a_ES($fecha){
    ereg( "([0-9]{2,4})-([0-9]{1,2})-([0-9]{1,2})", $fecha, $mifecha);
    $lafecha=$mifecha[3]."/".$mifecha[2]."/".$mifecha[1];
    return $lafecha;
} 

foreach($contents as $demo){
	$demostrativo = ORM::for_table('demostrativo_diario')->find_one($demo['id']);

	$user = ORM::for_table('members')->find_one($demostrativo['user_id']);


		$objPHPExcel = new PHPExcel();
		$objPHPExcel->getProperties()->setCreator("Energylab")
									 ->setLastModifiedBy("Energylab")
									 ->setTitle("Energylab - Demostrativo")
									 ->setSubject("Demostrativo - Datos de entrada")
									 ->setDescription("Demostrativo - Datos de entrada")
									 ->setKeywords("Demostrativo - Datos de entrada")
									 ->setCategory("entrada");


		$objPHPExcel->setActiveSheetIndex(0);

		$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');

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
		        'size' => 11,
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
		        'size' => 11,
		    )
		);

		$style_normal_blue= array( 
			'borders' => array(
		        'bottom' => $default_border,
		        'left' => $default_border,
		        'top' => $default_border,
		        'right' => $default_border,
		    ),
		    'font' => array(
		        'bold' => false,
		        'size' => 11,
		    ),
		    'fill' => array(
		        'type' => PHPExcel_Style_Fill::FILL_SOLID,
		        'color' => array('rgb'=>'DBE5F1'),
		    )
		);

		$style_normal_fff = array( 
			'borders' => array(
		        'bottom' => $default_border,
		        'left' => $default_border,
		        'top' => $default_border,
		        'right' => $default_border,
		    ),
		    'font' => array(
		        'bold' => false,
		        'size' => 11,
		    )
		);



		$style_normal_fff_45 = array( 
		    'font' => array(
		        'bold' => false,
		        'size' => 12,
		    ),
		    'alignment' => array(
		    	'rotation' => 30,		    	
				'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
				'vertical' => PHPExcel_Style_Alignment::VERTICAL_CENTER,
		    )
		);

	
		$style_normal_f00 = array( 
			'borders' => array(
		        'bottom' => $default_border,
		        'left' => $default_border,
		        'top' => $default_border,
		        'right' => $default_border,
		    ),
		    'font' => array(
		        'bold' => false,
		        'size' => 10,
		        'color' => array('rgb'=>'FF0000'),
		    ),
		);



		$style_normal_ff0 = array( 
			'borders' => array(
		        'bottom' => $default_border,
		        'left' => $default_border,
		        'top' => $default_border,
		        'right' => $default_border,
		    ),
		    'font' => array(
		        'bold' => false,
		        'size' => 10,
		    ),
		    'fill' => array(
		        'type' => PHPExcel_Style_Fill::FILL_SOLID,
		        'color' => array('rgb'=>'FFFF00'),
		    ),
		);

		$worksheet = $objPHPExcel->getActiveSheet();


		$worksheet->setCellValue('C2', "Demostrativo ".$demostrativo['demostrativo_id']);
		$worksheet->mergeCells('C2:G2');
		$worksheet->getStyle('C2:G2')->applyFromArray( $style_header );
		$worksheet->getStyle('C2:G2')->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);


		$worksheet->getColumnDimension('A')->setWidth(14);
		$worksheet->getColumnDimension('B')->setWidth(21);
		$worksheet->getColumnDimension('C')->setWidth(48);
		$worksheet->getColumnDimension('D')->setWidth(20);
		$worksheet->getColumnDimension('E')->setWidth(20);
		$worksheet->getColumnDimension('F')->setWidth(25);
		$worksheet->getColumnDimension('G')->setWidth(15);

		$worksheet->setCellValue('C3', "Gestor");
		$worksheet->getStyle('C3')->applyFromArray( $style_header );


		$worksheet->setCellValue('C4', "Fecha");
		$worksheet->getStyle('C4')->applyFromArray( $style_header );



		$worksheet->setCellValue('E5', "Unidades/día");
		$worksheet->getStyle('E5')->applyFromArray( $style_normal_fff );

		$worksheet->setCellValue('F4', "Equipos procesados");
		$worksheet->getStyle('F4')->applyFromArray( $style_header );
		$worksheet->setCellValue('C10', $aTableParams['parametro_5']['lang_ES']);
		$worksheet->setCellValue('C11', $aTableParams['parametro_6']['lang_ES']);
		$worksheet->setCellValue('C12', $aTableParams['parametro_7']['lang_ES']);
		$worksheet->setCellValue('C13', $aTableParams['parametro_8']['lang_ES']);
		$worksheet->setCellValue('C14', $aTableParams['parametro_9']['lang_ES']);
		$worksheet->setCellValue('C15', $aTableParams['parametro_10']['lang_ES']);
		$worksheet->setCellValue('C16', $aTableParams['parametro_11']['lang_ES']);
		$worksheet->setCellValue('C17', $aTableParams['parametro_12']['lang_ES']);
		$worksheet->setCellValue('C18', $aTableParams['parametro_13']['lang_ES']);
		$worksheet->setCellValue('C19', $aTableParams['parametro_14']['lang_ES']);
		$worksheet->setCellValue('C20', $aTableParams['parametro_15']['lang_ES']);
		$worksheet->setCellValue('C21', $aTableParams['parametro_16']['lang_ES']);
		$worksheet->setCellValue('C22', $aTableParams['parametro_17']['lang_ES']);
		$worksheet->setCellValue('C23', $aTableParams['parametro_18']['lang_ES']);
		$worksheet->setCellValue('C24', $aTableParams['parametro_19']['lang_ES']);
		$worksheet->setCellValue('C25', $aTableParams['parametro_20']['lang_ES']);
		$worksheet->setCellValue('C26', $aTableParams['parametro_21']['lang_ES']);
		$worksheet->setCellValue('C27', $aTableParams['parametro_22']['lang_ES']);
		$worksheet->setCellValue('C28', $aTableParams['parametro_23']['lang_ES']);
		$worksheet->setCellValue('C29', $aTableParams['parametro_24']['lang_ES']);
		$worksheet->setCellValue('C30', $aTableParams['parametro_25']['lang_ES']);
		$worksheet->setCellValue('C31', $aTableParams['parametro_26']['lang_ES']);
		$worksheet->setCellValue('C32', $aTableParams['parametro_27']['lang_ES']);
		$worksheet->setCellValue('C33', $aTableParams['parametro_28']['lang_ES']);
		$worksheet->setCellValue('C36', $aTableParams['categoria_1']['lang_ES']);
		$worksheet->setCellValue('C37', $aTableParams['categoria_2']['lang_ES']);
		$worksheet->setCellValue('C38', $aTableParams['categoria_3']['lang_ES']);
		$worksheet->setCellValue('C39', $aTableParams['categoria_4']['lang_ES']);
		$worksheet->setCellValue('C4', $aTableParams['date']['lang_ES']);
		$worksheet->setCellValue('C40', $aTableParams['categoria_5']['lang_ES']);
		$worksheet->setCellValue('C41', $aTableParams['categoria_6']['lang_ES']);
		$worksheet->setCellValue('C6', $aTableParams['parametro_1']['lang_ES']);
		$worksheet->setCellValue('C7', $aTableParams['parametro_2']['lang_ES']);
		$worksheet->setCellValue('C8', $aTableParams['parametro_3']['lang_ES']);
		$worksheet->setCellValue('C9', $aTableParams['parametro_4']['lang_ES']);
		

		$worksheet->setCellValue('D4', cambiaf_a_ES($demostrativo['date']) );
		//$worksheet->mergeCells('D4:E4');
		$worksheet->getStyle('D4')->applyFromArray( $style_normal_blue );
		$worksheet->getStyle('E4')->applyFromArray( $style_normal_blue );

		$worksheet->setCellValue('D3', $user['username']);
		$worksheet->mergeCells('D3:E3');
		$worksheet->getStyle('D3:E3')->applyFromArray( $style_normal_blue );

		$worksheet->setCellValue('F3', $user['email']);
		$worksheet->mergeCells('F3:G3');
		$worksheet->getStyle('F3:G3')->applyFromArray( $style_normal_blue );

		$worksheet->setCellValue('F4', "Equipos procesados (ud)");
		$worksheet->getStyle('F4')->applyFromArray( $style_header );

		$worksheet->setCellValue('G4', $demostrativo['equipos_procesados']);
		$worksheet->getStyle('G4')->applyFromArray( $style_normal_blue );


$worksheet->setCellValue('B6', "Entrada RE1");
$worksheet->setCellValue('B7', "Salida EX1");
$worksheet->setCellValue('B9', "RE1; EX1; EX2");
$worksheet->setCellValue('B10', "RE1;RE2; TR9; EX1; EX2");
$worksheet->setCellValue('B12', "Salida TR9.1");
$worksheet->setCellValue('B13', "Salida TR10");
$worksheet->setCellValue('B14', "Salida TR7.4");
$worksheet->setCellValue('B15', "Salida RE1.6");
$worksheet->setCellValue('B16', "Salida TR1");
$worksheet->setCellValue('B17', "Salida TR2");
$worksheet->setCellValue('B18', "Salida TR4");
$worksheet->setCellValue('B19', "Salida TR6");
$worksheet->setCellValue('B20', "Salida TR10");
$worksheet->setCellValue('B21', "Salida TR3.1");
$worksheet->setCellValue('B22', "Salida TR3.2");
$worksheet->setCellValue('B23', "Salida TR3.3");
$worksheet->setCellValue('B24', "Salida TR3.5");
$worksheet->setCellValue('B25', "Salida TR8.1");

$worksheet->setCellValue('A12', "Reutilización");
$worksheet->mergeCells('A12:A14');
$worksheet->getStyle('A12:A14')->applyFromArray( $style_normal_fff_45);

$worksheet->setCellValue('A15', "Reciclaje");
$worksheet->mergeCells('A15:A25');
$worksheet->getStyle('A15:A25')->applyFromArray( $style_normal_fff_45);


$D6 = $demostrativo['parametro_1'];
$D7 = $demostrativo['parametro_2'];
$D8 = $demostrativo['parametro_3'];
$D9 = $demostrativo['parametro_4'];
$D10 = $demostrativo['parametro_5'];
$D11 = $demostrativo['parametro_6'];
$D12 = $demostrativo['parametro_7'];
$D13 = $demostrativo['parametro_8'];
$D14 = $demostrativo['parametro_9'];
$D15 = $demostrativo['parametro_10'];
$D16 = $demostrativo['parametro_11'];
$D17 = $demostrativo['parametro_12'];
$D18 = $demostrativo['parametro_13'];
$D19 = $demostrativo['parametro_14'];
$D20 = $demostrativo['parametro_15'];
$D21 = $demostrativo['parametro_16'];
$D22 = $demostrativo['parametro_17'];
$D23 = $demostrativo['parametro_18'];
$D24 = $demostrativo['parametro_19'];
$D25 = $demostrativo['parametro_20'];
$D26 = $demostrativo['parametro_21'];
$D27 = $demostrativo['parametro_22'];
$D28 = $demostrativo['parametro_23'];
$D29 = $demostrativo['parametro_24'];
$D30 = $demostrativo['parametro_25'];
$D31 = $demostrativo['parametro_26'];
$D32 = $demostrativo['parametro_27'];
$D33 = $demostrativo['parametro_28'];

$D36 = $demostrativo['categoria_1'];
$D37 = $demostrativo['categoria_2'];
$D38 = $demostrativo['categoria_3'];
$D39 = $demostrativo['categoria_4'];
$D40 = $demostrativo['categoria_5'];
$D41 = $demostrativo['categoria_6'];

$F36 = $demostrativo['categoria_1_ia'];
$F37 = $demostrativo['categoria_2_ia'];
$F38 = $demostrativo['categoria_3_ia'];
$F39 = $demostrativo['categoria_4_ia'];
$F40 = $demostrativo['categoria_5_ia'];
$F41 = $demostrativo['categoria_6_ia'];

$G36 = $demostrativo['categoria_1_ie'];
$G37 = $demostrativo['categoria_2_ie'];
$G38 = $demostrativo['categoria_3_ie'];
$G39 = $demostrativo['categoria_4_ie'];
$G40 = $demostrativo['categoria_5_ie'];
$G41 = $demostrativo['categoria_6_ie'];

$SUMA_D15_D25 = $D15 + $D16 + $D17 + $D18 + $D19 + $D20 + $D21 + $D22 + $D23 + $D24 + $D25;


$worksheet->setCellValue('D10', $D10);
$worksheet->setCellValue('D11', $D11);
$worksheet->setCellValue('D12', $D12);
$worksheet->setCellValue('D13', $D13);
$worksheet->setCellValue('D14', $D14);
$worksheet->setCellValue('D15', $D15);
$worksheet->setCellValue('D16', $D16);
$worksheet->setCellValue('D17', $D17);
$worksheet->setCellValue('D18', $D18);
$worksheet->setCellValue('D19', $D19);
$worksheet->setCellValue('D20', $D20);
$worksheet->setCellValue('D21', $D21);
$worksheet->setCellValue('D22', $D22);
$worksheet->setCellValue('D23', $D23);
$worksheet->setCellValue('D24', $D24);
$worksheet->setCellValue('D25', $D25);
$worksheet->setCellValue('D26', $D26);
$worksheet->setCellValue('D27', $D27);
$worksheet->setCellValue('D28', $D28);
$worksheet->setCellValue('D29', $D29);
$worksheet->setCellValue('D30', $D30);
$worksheet->setCellValue('D31', $D31);
$worksheet->setCellValue('D32', $D32);
$worksheet->setCellValue('D33', $D33);
$worksheet->setCellValue('D36', $D36);
$worksheet->setCellValue('D37', $D37);
$worksheet->setCellValue('D38', $D38);
$worksheet->setCellValue('D39', $D39);
//$worksheet->setCellValue('D4', $D4);
$worksheet->setCellValue('D40', $D40);
$worksheet->setCellValue('D41', $D41);
$worksheet->setCellValue('D6', $D6);
$worksheet->setCellValue('D7', $D7);
$worksheet->setCellValue('D8', $D8);
$worksheet->setCellValue('D9', $D9);



		$worksheet->setCellValue('D35', "Impacto final");
		$worksheet->setCellValue('D36', $demostrativo['categoria_1']);
		$worksheet->setCellValue('D37', $demostrativo['categoria_2']);
		$worksheet->setCellValue('D38', $demostrativo['categoria_3']);
		$worksheet->setCellValue('D39', $demostrativo['categoria_4']);
		$worksheet->setCellValue('D40', $demostrativo['categoria_5']);
		$worksheet->setCellValue('D41', $demostrativo['categoria_6']);

		$worksheet->setCellValue('E10', $aTableParams['parametro_5']['unidades_ES']);
		$worksheet->setCellValue('E11', $aTableParams['parametro_6']['unidades_ES']);
		$worksheet->setCellValue('E12', $aTableParams['parametro_7']['unidades_ES']);
		$worksheet->setCellValue('E13', $aTableParams['parametro_8']['unidades_ES']);
		$worksheet->setCellValue('E14', $aTableParams['parametro_9']['unidades_ES']);
		$worksheet->setCellValue('E15', $aTableParams['parametro_10']['unidades_ES']);
		$worksheet->setCellValue('E16', $aTableParams['parametro_11']['unidades_ES']);
		$worksheet->setCellValue('E17', $aTableParams['parametro_12']['unidades_ES']);
		$worksheet->setCellValue('E18', $aTableParams['parametro_13']['unidades_ES']);
		$worksheet->setCellValue('E19', $aTableParams['parametro_14']['unidades_ES']);
		$worksheet->setCellValue('E20', $aTableParams['parametro_15']['unidades_ES']);
		$worksheet->setCellValue('E21', $aTableParams['parametro_16']['unidades_ES']);
		$worksheet->setCellValue('E22', $aTableParams['parametro_17']['unidades_ES']);
		$worksheet->setCellValue('E23', $aTableParams['parametro_18']['unidades_ES']);
		$worksheet->setCellValue('E24', $aTableParams['parametro_19']['unidades_ES']);
		$worksheet->setCellValue('E25', $aTableParams['parametro_20']['unidades_ES']);
		$worksheet->setCellValue('E26', $aTableParams['parametro_21']['unidades_ES']);
		$worksheet->setCellValue('E27', $aTableParams['parametro_22']['unidades_ES']);
		$worksheet->setCellValue('E28', $aTableParams['parametro_23']['unidades_ES']);
		$worksheet->setCellValue('E29', $aTableParams['parametro_24']['unidades_ES']);
		$worksheet->setCellValue('E30', $aTableParams['parametro_25']['unidades_ES']);
		$worksheet->setCellValue('E31', $aTableParams['parametro_26']['unidades_ES']);
		$worksheet->setCellValue('E32', $aTableParams['parametro_27']['unidades_ES']);
		$worksheet->setCellValue('E33', $aTableParams['parametro_28']['unidades_ES']);


		$worksheet->setCellValue('E36', $aTableParams['categoria_1']['unidades_ES']);
		$worksheet->setCellValue('E37', $aTableParams['categoria_2']['unidades_ES']);
		$worksheet->setCellValue('E38', $aTableParams['categoria_3']['unidades_ES']);
		$worksheet->setCellValue('E39', $aTableParams['categoria_4']['unidades_ES']);
		$worksheet->setCellValue('E40', $aTableParams['categoria_5']['unidades_ES']);
		$worksheet->setCellValue('E41', $aTableParams['categoria_6']['unidades_ES']);



		for($i=6; $i<=33; $i++){
			$worksheet->getStyle('C'.$i)->applyFromArray( $style_header );
			$worksheet->getStyle('D'.$i)->applyFromArray( $style_normal_fff );
		}
		for($i=36; $i<=41; $i++){
			$worksheet->getStyle('C'.$i)->applyFromArray( $style_header );
			$worksheet->getStyle('D'.$i)->applyFromArray( $style_normal_ff0 );
			$worksheet->getStyle('F'.$i)->applyFromArray( $style_normal_fff );
			$worksheet->getStyle('G'.$i)->applyFromArray( $style_normal_fff );
		}




// IMPACTO AMBIENTAL, SI NO SE HA DEFINIDO APLICO FORMULAS

	$F36 = $demostrativo['categoria_1_ia'];
	$F37 = $demostrativo['categoria_2_ia'];
	$F38 = $demostrativo['categoria_3_ia'];
	$F39 = $demostrativo['categoria_4_ia'];
	$F40 = $demostrativo['categoria_5_ia'];
	$F41 = $demostrativo['categoria_6_ia'];

	if($F36*1 <= 0){
		$F36 = (0.613*$D12+0.0873*$D13+0.153*$D14+($D12+$D13+$D14)/3*0.0602)+(0.0847*$D15+0.0873*$D16+0.0873*$D17+0.0939*$D18+0.0939*$D19+0.0873*$D20+0.0915*$D21+0.0966*$D22+0.0104*$D23+0.0165*$D24+0.0106*$D25+($SUMA_D15_D25)/11*0.184);
		$worksheet->getStyle('F36')->applyFromArray( $style_normal_f00 );
		$worksheet->getComment('F36')->setAuthor('Energylab');
		$objCommentRichText = $worksheet->getComment('F36')->getText()->createTextRun('Valor calculado:');
		$objCommentRichText->getFont()->setBold(true);
		$worksheet->getComment('F36')->getText()->createTextRun("\r\n");
		$worksheet->getComment('F36')->setWidth(350);
		$worksheet->getComment('F36')->setHeight(180);
		$worksheet->getComment('F36')->getText()->createTextRun("El valor ha sido calculado en base a la formula establecida en la aplicación:\n0.613*\$D12+0.0873*\$D13+0.153*\$D14+(\$D12+\$D13+\$D14)/3*0.0602)+(0.0847*\$D15+0.0873*\$D16+0.0873*\$D17+0.0939*\$D18+0.0939*\$D19+0.0873*\$D20+0.0915*\$D21+0.0966*\$D22+0.0104*\$D23+0.0165*\$D24+0.0106*\$D25+(\$SUMA_D15_D25)/11*0.184");
	}
	if($F37*1 <= 0){
		$F37 = (1.06*$D12+0.0547*$D13+0.766*$D14+($D12+$D13+$D14)/3*0.0456)+(0.0342*$D15+0.0547*$D16+0.0547*$D17+0.0819*$D18+0.0819*$D19+0.0547*$D20+0.064*$D21+0.0755*$D22+0.0894*$D23+0.949*$D24+0.0995*$D25+($SUMA_D15_D25)/11*0.139);
		$worksheet->getStyle('F37')->applyFromArray( $style_normal_f00 );
		$worksheet->getComment('F37')->setAuthor('Energylab');
		$objCommentRichText = $worksheet->getComment('F37')->getText()->createTextRun('Valor calculado:');
		$objCommentRichText->getFont()->setBold(true);
		$worksheet->getComment('F37')->getText()->createTextRun("\r\n");
		$worksheet->getComment('F37')->setWidth(350);
		$worksheet->getComment('F37')->setHeight(180);
		$worksheet->getComment('F37')->getText()->createTextRun("El valor ha sido calculado en base a la formula establecida en la aplicación:\n1.06*\$D12+0.0547*\$D13+0.766*\$D14+(\$D12+\$D13+\$D14)/3*0.0456)+(0.0342*\$D15+0.0547*\$D16+0.0547*\$D17+0.0819*\$D18+0.0819*\$D19+0.0547*\$D20+0.064*\$D21+0.0755*\$D22+0.0894*\$D23+0.949*\$D24+0.0995*\$D25+(\$SUMA_D15_D25)/11*0.139");
	}
	if($F38*1 <= 0){
		$F38 = (0.613*$D12+0.0873*$D13+0.153*$D14+($D12+$D13+$D14)/3*0.0602)+(0.168*$D15+0.277*$D16+0.277*$D17+0.3*$D18+0.3*$D19+0.277*$D20+0.291*$D21+0.309*$D22+0.332*$D23+0.552*$D24+0.341*$D25+($SUMA_D15_D25)/11*0.521);
		$worksheet->getStyle('F38')->applyFromArray( $style_normal_f00 );
		$worksheet->getComment('F38')->setAuthor('Energylab');
		$objCommentRichText = $worksheet->getComment('F38')->getText()->createTextRun('Valor calculado:');
		$objCommentRichText->getFont()->setBold(true);
		$worksheet->getComment('F38')->getText()->createTextRun("\r\n");
		$worksheet->getComment('F38')->setWidth(350);
		$worksheet->getComment('F38')->setHeight(180);
		$worksheet->getComment('F38')->getText()->createTextRun("El valor ha sido calculado en base a la formula establecida en la aplicación:\n0.613*\$D12+0.0873*\$D13+0.153*\$D14+(\$D12+\$D13+\$D14)/3*0.0602)+(0.168*\$D15+0.277*\$D16+0.277*\$D17+0.3*\$D18+0.3*\$D19+0.277*\$D20+0.291*\$D21+0.309*\$D22+0.332*\$D23+0.552*\$D24+0.341*\$D25+(\$SUMA_D15_D25)/11*0.521");
	}
	if($F39*1 <= 0){
		$F39 = (0.00499*$D12+0.000247*$D13+0.00294*$D14+($D12+$D13+$D14)/3*0.000306)+(0.000228*$D15+0.000247*$D16+0.000247*$D17+0.000309*$D18+0.000309*$D19+0.000247*$D20+0.000288*$D21+0.000338*$D22+0.000406*$D23+0.00487*$D24+0.000429*$D25+($SUMA_D15_D25)/11*0.000935);
		$worksheet->getStyle('F39')->applyFromArray( $style_normal_f00 );
		$worksheet->getComment('F39')->setAuthor('Energylab');
		$objCommentRichText = $worksheet->getComment('F39')->getText()->createTextRun('Valor calculado:');
		$objCommentRichText->getFont()->setBold(true);
		$worksheet->getComment('F39')->getText()->createTextRun("\r\n");
		$worksheet->getComment('F39')->setWidth(350);
		$worksheet->getComment('F39')->setHeight(180);
		$worksheet->getComment('F39')->getText()->createTextRun("El valor ha sido calculado en base a la formula establecida en la aplicación:\n0.00499*\$D12+0.000247*\$D13+0.00294*\$D14+(\$D12+\$D13+\$D14)/3*0.000306)+(0.000228*\$D15+0.000247*\$D16+0.000247*\$D17+0.000309*\$D18+0.000309*\$D19+0.000247*\$D20+0.000288*\$D21+0.000338*\$D22+0.000406*\$D23+0.00487*\$D24+0.000429*\$D25+(\$SUMA_D15_D25)/11*0.000935");
	}
	if($F40*1 <= 0){
		$F40 = (0.1*$D12+0.00777*$D13+0.429*$D14+($D12+$D13+$D14)/3*0.0158)+(0.0719*$D15+0.00777*$D16+0.00777*$D17+0.013*$D18+0.013*$D19+0.00777*$D20+0.00881*$D21+0.0101*$D22+0.0114*$D23+0.46*$D24+0.0133*$D25+($SUMA_D15_D25)/11*0.0483);
		$worksheet->getStyle('F40')->applyFromArray( $style_normal_f00 );
		$worksheet->getComment('F40')->setAuthor('Energylab');
		$objCommentRichText = $worksheet->getComment('F40')->getText()->createTextRun('Valor calculado:');
		$objCommentRichText->getFont()->setBold(true);
		$worksheet->getComment('F40')->getText()->createTextRun("\r\n");
		$worksheet->getComment('F40')->setWidth(350);
		$worksheet->getComment('F40')->setHeight(180);
		$worksheet->getComment('F40')->getText()->createTextRun("El valor ha sido calculado en base a la formula establecida en la aplicación:\n0.1*\$D12+0.00777*\$D13+0.429*\$D14+(\$D12+\$D13+\$D14)/3*0.0158)+(0.0719*\$D15+0.00777*\$D16+0.00777*\$D17+0.013*\$D18+0.013*\$D19+0.00777*\$D20+0.00881*\$D21+0.0101*\$D22+0.0114*\$D23+0.46*\$D24+0.0133*\$D25+(\$SUMA_D15_D25)/11*0.0483");
	}
	if($F41*1 <= 0){
		$F41 = (2.25*$D12+0.03*$D13+0.188*$D14+($D12+$D13+$D14)/3*0.0364)+(0.0266*$D15+0.03*$D16+0.03*$D17+0.0567*$D18+0.0567*$D19+0.03*$D20+0.0496*$D21+0.0741*$D22+0.108*$D23+0.229*$D24+0.118*$D25+($SUMA_D15_D25)/11*0.111);
		$worksheet->getStyle('F41')->applyFromArray( $style_normal_f00 );
		$worksheet->getComment('F41')->setAuthor('Energylab');
		$objCommentRichText = $worksheet->getComment('F41')->getText()->createTextRun('Valor calculado:');
		$objCommentRichText->getFont()->setBold(true);
		$worksheet->getComment('F41')->getText()->createTextRun("\r\n");
		$worksheet->getComment('F41')->setWidth(350);
		$worksheet->getComment('F41')->setHeight(180);
		$worksheet->getComment('F41')->getText()->createTextRun("El valor ha sido calculado en base a la formula establecida en la aplicación:\n2.25*\$D12+0.03*\$D13+0.188*\$D14+(\$D12+\$D13+\$D14)/3*0.0364)+(0.0266*\$D15+0.03*\$D16+0.03*\$D17+0.0567*\$D18+0.0567*\$D19+0.03*\$D20+0.0496*\$D21+0.0741*\$D22+0.108*\$D23+0.229*\$D24+0.118*\$D25+(\$SUMA_D15_D25)/11*0.111");
	}
	$worksheet->setCellValue('F35', "Impacto ambiental");
	$worksheet->setCellValue('F36', $F36);
	$worksheet->setCellValue('F37', $F37);
	$worksheet->setCellValue('F38', $F38);
	$worksheet->setCellValue('F39', $F39);
	$worksheet->setCellValue('F40', $F40);
	$worksheet->setCellValue('F41', $F41);




// IMPACTO EVITADO, SI NO SE HA DEFINIDO APLICO FORMULAS

	$worksheet->setCellValue('G35', "Impacto evitado");

	$G36 = $demostrativo['categoria_1_ie'];
	$G37 = $demostrativo['categoria_2_ie'];
	$G38 = $demostrativo['categoria_3_ie'];
	$G39 = $demostrativo['categoria_4_ie'];
	$G40 = $demostrativo['categoria_5_ie'];
	$G41 = $demostrativo['categoria_6_ie'];

	if($G36*1 <= 0){
		$G36 = 3.54*$D33+2.5*$D26+1.65*$D27+40.6*$D28+28.2*$D29+43.7*$D30+3.76*$D31+0.712*$D32;
		$worksheet->getStyle('G36')->applyFromArray( $style_normal_f00 );
		$worksheet->getComment('G36')->setAuthor('Energylab');
		$objCommentRichText = $worksheet->getComment('G36')->getText()->createTextRun('Valor calculado:');
		$objCommentRichText->getFont()->setBold(true);
		$worksheet->getComment('G36')->getText()->createTextRun("\r\n");
		$worksheet->getComment('G36')->setWidth(300);
		$worksheet->getComment('G36')->setHeight(150);
		$worksheet->getComment('G36')->getText()->createTextRun("El valor ha sido calculado en base a la formula establecida en la aplicación:\n\n3.54*\$D33+2.5*\$D26+1.65*\$D27+40.6*\$D28+28.2*\$D29+43.7*\$D30+3.76*\$D31+0.712*\$D32");

	}
	if($G37*1 <= 0){
		$G37 = 21.2*$D33+37.5*$D26+18.1*$D27+266*$D28+469*$D29+340*$D30+49*$D31+11.3*$D32;
		$worksheet->getStyle('G37')->applyFromArray( $style_normal_f00 );
		$worksheet->getComment('G37')->setAuthor('Energylab');
		$objCommentRichText = $worksheet->getComment('G37')->getText()->createTextRun('Valor calculado:');
		$objCommentRichText->getFont()->setBold(true);
		$worksheet->getComment('G37')->getText()->createTextRun("\r\n");
		$worksheet->getComment('G37')->setWidth(300);
		$worksheet->getComment('G37')->setHeight(150);
		$worksheet->getComment('G37')->getText()->createTextRun("El valor ha sido calculado en base a la formula establecida en la aplicación:\n\n21.2*\$D33+37.5*\$D26+18.1*\$D27+266*\$D28+469*\$D29+340*\$D30+49*\$D31+11.3*\$D32");
	}
	if($G38*1 <= 0){
		$G38 = 11.6*$D33+8.57*$D26+6.13*$D27+142*$D28+103*$D29+168*$D30+12.9*$D31+2.53*$D32;
		$worksheet->getStyle('G38')->applyFromArray( $style_normal_f00 );
		$worksheet->getComment('G38')->setAuthor('Energylab');
		$objCommentRichText = $worksheet->getComment('G38')->getText()->createTextRun('Valor calculado:');
		$objCommentRichText->getFont()->setBold(true);
		$worksheet->getComment('G38')->getText()->createTextRun("\r\n");
		$worksheet->getComment('G38')->setWidth(300);
		$worksheet->getComment('G38')->setHeight(150);
		$worksheet->getComment('G38')->getText()->createTextRun("El valor ha sido calculado en base a la formula establecida en la aplicación:\n\n11.6*\$D33+8.57*\$D26+6.13*\$D27+142*\$D28+103*\$D29+168*\$D30+12.9*\$D31+2.53*\$D3");
	}
	if($G39*1 <= 0){
		$G39 = 0.0279*$D33+0.0186*$D26+0.0122*$D27+0.228*$D28+0.224*$D29+0.325*$D30+0.0267*$D31+0.00533*$D32;
		$worksheet->getStyle('G39')->applyFromArray( $style_normal_f00 );
		$worksheet->getComment('G39')->setAuthor('Energylab');
		$objCommentRichText = $worksheet->getComment('G39')->getText()->createTextRun('Valor calculado:');
		$objCommentRichText->getFont()->setBold(true);
		$worksheet->getComment('G39')->getText()->createTextRun("\r\n");
		$worksheet->getComment('G39')->setWidth(300);
		$worksheet->getComment('G39')->setHeight(150);
		$worksheet->getComment('G39')->getText()->createTextRun("El valor ha sido calculado en base a la formula establecida en la aplicación:\n\n0.0279*\$D33+0.0186*\$D26+0.0122*\$D27+0.228*\$D28+0.224*\$D29+0.325*\$D30+0.0267*\$D31+0.00533*\$D32");
	}
	if($G40*1 <= 0){
		$G40 = 25.8*$D33+9.51*$D26+4.13*$D27+59.1*$D28+103*$D29+72.7*$D30+10.9*$D31+2.14*$D32;
		$worksheet->getStyle('G40')->applyFromArray( $style_normal_f00 );
		$worksheet->getComment('G40')->setAuthor('Energylab');
		$objCommentRichText = $worksheet->getComment('G40')->getText()->createTextRun('Valor calculado:');
		$objCommentRichText->getFont()->setBold(true);
		$worksheet->getComment('G40')->getText()->createTextRun("\r\n");
		$worksheet->getComment('G40')->setWidth(300);
		$worksheet->getComment('G40')->setHeight(150);
		$worksheet->getComment('G40')->getText()->createTextRun("El valor ha sido calculado en base a la formula establecida en la aplicación:\n\n25.8*\$D33+9.51*\$D26+4.13*\$D27+59.1*\$D28+103*\$D29+72.7*\$D30+10.9*\$D31+2.14*\$D32");
	}
	if($G41*1 <= 0){
		$G41 = 5.52*$D33+3.72*$D26+2.52*$D27+80.2*$D28+43.7*$D29+45.7*$D30+4.34*$D31+1.09*$D32;
		$worksheet->getStyle('G41')->applyFromArray( $style_normal_f00 );
		$worksheet->getComment('G41')->setAuthor('Energylab');
		$objCommentRichText = $worksheet->getComment('G41')->getText()->createTextRun('Valor calculado:');
		$objCommentRichText->getFont()->setBold(true);
		$worksheet->getComment('G41')->getText()->createTextRun("\r\n");
		$worksheet->getComment('G41')->setWidth(300);
		$worksheet->getComment('G41')->setHeight(150);
		$worksheet->getComment('G41')->getText()->createTextRun("El valor ha sido calculado en base a la formula establecida en la aplicación:\n\n5.52*\$D33+3.72*\$D26+2.52*\$D27+80.2*\$D28+43.7*\$D29+45.7*\$D30+4.34*\$D31+1.09*\$D32");
	}

		$worksheet->setCellValue('G36', $G36);
		$worksheet->setCellValue('G37', $G37);
		$worksheet->setCellValue('G38', $G38);
		$worksheet->setCellValue('G39', $G39);
		$worksheet->setCellValue('G40', $G40);
		$worksheet->setCellValue('G41', $G41);





$aFecha = explode("-",$demostrativo['date'] ); // YYYY-mm-dd 
$dir =  filesDir::$directory."demostrativo_".$demostrativo["demostrativo_id"]."/".$aFecha[0]."/".$aFecha[1];
$file_name = "demostrativo_".$demostrativo["demostrativo_id"]."_".$aFecha[0].$aFecha[1].$aFecha[2].".xlsx";
$dir_file = $dir."/".$file_name;

$worksheet->getComment('C2')->setAuthor('Energylab');
$objCommentRichText = $worksheet->getComment('C2')->getText()->createTextRun('Demostrativo '. $demostrativo["demostrativo_id"] .':');
$objCommentRichText->getFont()->setBold(true);
$worksheet->getComment('C2')->getText()->createTextRun("\r\n");
$worksheet->getComment('C2')->setWidth(350);
$worksheet->getComment('C2')->setHeight(140);
$worksheet->getComment('C2')->getText()->createTextRun("Fichero generado por la aplicación el ".date("d/m/Y").".\n\nRuta de destino: ".$dir_file);


// Rename worksheet
$objPHPExcel->getActiveSheet()->setTitle('Demostrativo - datos de entrada');

// Set active sheet index to the first sheet, so Excel opens this as the first sheet
$objPHPExcel->setActiveSheetIndex(0);

// Redirect output to a client’s web browser (Excel2007)
/*header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
header('Content-Disposition: attachment;filename="'.$aParams['table'].'_'.date("YmdHi").'.xlsx"');
header('Cache-Control: max-age=0');*/


echo "<hr>";
echo "<h3>($n) $dir_file</h3>";
echo "<h4>ID: ".$demostrativo["id"]."</h4>";
if (file_exists($dir_file)){
	echo date('H:i:s') . " Ya existe el fichero ". $file_name."<br>";
	
	echo date('H:i:s') . " Ya existe el fichero ". $file_name.". Eliminandolo: ";
	if( unlink($dir_file) ){
		echo "OK";
	}else{
		echo "KO";
	}
	echo "<br>";
}else{
if (!is_dir($dir)) {
	echo date('H:i:s') . " El directorio no existe, creando dir ". $dir.": ";
    if( mkdir($dir, 0777, true) ){
    	echo "OK";
    }else{
    	echo "KO creating ".$dir;
    }

	echo "<br>";
}

    chmod($dir_file, filesDir::$mod);
    chmod($dir_file, filesDir::$user);
    chgrp($dir_file, filesDir::$group);

	$objWriter->save($dir_file);
	echo date('H:i:s') . " GUARDADO NUEVO EXCEL: ". $dir_file." !<br>";
}


// Echo memory peak usage
echo date('H:i:s') . " Peak memory usage: " . (memory_get_peak_usage(true) / 1024 / 1024) . " MB<br>";

// Echo done
echo date('H:i:s') . " Done writing file.<br>";
ob_flush();
flush();
sleep(1);
$n++;

//break;
}

