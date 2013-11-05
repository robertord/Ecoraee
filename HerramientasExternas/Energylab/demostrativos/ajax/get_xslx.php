<?php
require_once '../conf/configuration.php';
require_once 'IOFactory.php';
require_once 'Cell/AdvancedValueBinder.php';
require_once 'Cell/DataType.php';
include_once 'LogicaBdd.php';
try{
        if($_SESSION["rol"] != "ADMIN" && $_SESSION["rol"] != "USER")
            throw new Exception('No tiene permiso para realizar la acción solicitada');


    function uploadfile($origin, $uploads_dir, $tmp_name, $demostrativo, $UNIX_DATE)
        {
       		if( !is_dir( $uploads_dir."".$demostrativo."/".date(Y,$UNIX_DATE)) )
       			mkdir( $uploads_dir."".$demostrativo."/".date(Y,$UNIX_DATE), 0777, true);
       		
       		$dir = $uploads_dir."".$demostrativo."/".date(Y,$UNIX_DATE)."/".date(m,$UNIX_DATE);

            if ( !is_dir ($dir) )
                mkdir($dir, 0777, true);

        $filename = $demostrativo."_".date(Ymd,$UNIX_DATE).".".end(explode(".", $origin));;

            $fulldest = $dir."/".$filename;

            if (move_uploaded_file($tmp_name, $fulldest)){
                chmod($fulldest, filesDir::$mod);
                /*chown($fulldest, filesDir::$user);
                chgrp($fulldest, filesDir::$group);*/
                return $tmp_name." (".$fulldest.")";
            }
             throw new Exception( " ERROR al copiar documento ".$tmp_name." en ".$fulldest );
        }

    $inputFileName = "";
    if( is_array($_FILES['xlsFile']) && isset($_FILES['xlsFile']['tmp_name']) )
    {
        $inputFileName = $_FILES['xlsFile']['tmp_name'];
    }
    else if( isset($_REQUEST['xlsFile']) && strlen($_REQUEST['xlsFile'])>0 ){ // ie...
        $inputFileName = $_REQUEST['xlsFile'];
    }
    else
    {
        $str = "";
        foreach ($_FILES as $key => $value) {
            $str = ",  ".$key. " = ".$value;
        }
         foreach ($_REQUEST as $key => $value) {
            $str = ",  ".$key. " = ".$value;
        }
        throw new Exception('Error en el formato de llamada a la página. '. $str);
    }

    if( strlen($inputFileName) == 0 ){
        throw new Exception('No se ha encontrado el fichero temporal a subir...');
        }


            $inputFileType = PHPExcel_IOFactory::identify($inputFileName);
            $objReader = PHPExcel_IOFactory::createReader($inputFileType);    
            $objReader->setReadDataOnly(true); 
            $objPHPExcel = $objReader->load($inputFileName);




    $objWorksheet = $objPHPExcel->setActiveSheetIndex(0);
    PHPExcel_Cell::setValueBinder( new PHPExcel_Cell_AdvancedValueBinder() );

    $aData = array();
    $aUser = array();
    $aData = array();


    $usuario_email = $objWorksheet->getCell('F3')->getValue();  
    $aUser = ORM::for_table("members")->where_equal('email', $usuario_email)->find_one();
    $aData['user_id'] = $aUser['id']; 

    switch ($_SESSION["rol"]) {
       case 'ADMIN':
            $aData['demostrativo_id'] = $aUser['demostrativo_id'];
            break;       
       case "USER":     
            if( $aUser['demostrativo_id'] != $_SESSION['demostrativo_id'] ) 
                throw new Exception('No tiene los permisos necesarios para subir el demostrativo seleccionado.');            
            $aData['demostrativo_id'] = $_SESSION['demostrativo_id'];  
            break;
        default:
            throw new Exception('No tiene permiso para realizar la acción solicitada');
    }        

    $tableName = "demostrativo_".$aData['demostrativo_id'];


        if( $_SESSION["rol"] == "USER" && ( $aData['demostrativo_id']!= $_SESSION['demostrativo_id']  )) 
            throw new Exception('No tiene los permisos necesarios para subir el demostrativo seleccionado.');

        $aParametrosApp = parametrosDemostrativo::getAll($aData['demostrativo_id']);




        if($aUser['demostrativo_id'] != $aData['demostrativo_id'])
        throw new Exception ('El usuario del documento no es válido');


    $type = PHPExcel_Cell_DataType::dataTypeForValue( $objWorksheet->getCell('D4')->getValue() );
    if($type != "n"){
        throw new Exception("La fecha del documento no es correcta. El formato de fecha debe ser DD/MM/YYYY. Revise el valor de la celda D4. ");
    }


        $EXCEL_DATE = $objWorksheet->getCell('D4')->getValue();
        $UNIX_DATE = ($EXCEL_DATE - 25569) * 86400;
    $fecha = gmdate("Y-m-d", $UNIX_DATE);

    if( date("Y", $UNIX_DATE) < 2012 ){
        throw new Exception("La fecha del documento no es correcta. La fecha debe ser posterior al año 2012. ");
    }

		
        $aData['date'] = gmdate("Y-m-d", $UNIX_DATE);
    $aData['equipos_procesados'] = $objWorksheet->getCell('G4')->getValue();  // equipos_procesados 

    $aData['parametro_1'] = $objWorksheet->getCell('D6')->getValue();     // parametro_1 
    $aData['parametro_2'] = $objWorksheet->getCell('D7')->getValue();     // parametro_2 
    $aData['parametro_3'] = $objWorksheet->getCell('D8')->getValue();     // parametro_3 
    $aData['parametro_4'] = $objWorksheet->getCell('D9')->getValue();     // parametro_4 
    $aData['parametro_5'] = $objWorksheet->getCell('D10')->getValue();     // parametro_5 
    $aData['parametro_6'] = $objWorksheet->getCell('D11')->getValue();     // parametro_6 
    $aData['parametro_7'] = $objWorksheet->getCell('D12')->getValue();     // parametro_7 
    $aData['parametro_8'] = $objWorksheet->getCell('D13')->getValue();     // parametro_8 
    $aData['parametro_9'] = $objWorksheet->getCell('D14')->getValue();     // parametro_9 
    $aData['parametro_10'] = $objWorksheet->getCell('D15')->getValue();     // parametro_10 
    $aData['parametro_11'] = $objWorksheet->getCell('D16')->getValue();     // parametro_11 
    $aData['parametro_12'] = $objWorksheet->getCell('D17')->getValue();     // parametro_12 
    $aData['parametro_13'] = $objWorksheet->getCell('D18')->getValue();     // parametro_13 
    $aData['parametro_14'] = $objWorksheet->getCell('D19')->getValue();     // parametro_14 
    $aData['parametro_15'] = $objWorksheet->getCell('D20')->getValue();     // parametro_15 
    $aData['parametro_16'] = $objWorksheet->getCell('D21')->getValue();     // parametro_16 
    $aData['parametro_17'] = $objWorksheet->getCell('D22')->getValue();     // parametro_17 
    $aData['parametro_18'] = $objWorksheet->getCell('D23')->getValue();     // parametro_18 
    $aData['parametro_19'] = $objWorksheet->getCell('D24')->getValue();     // parametro_19 
    $aData['parametro_20'] = $objWorksheet->getCell('D25')->getValue();     // parametro_20 
    
    
    // 20130809 >
        
    $aData['parametro_21'] = $objWorksheet->getCell('D26')->getValue();     // parametro_21 
    $aData['parametro_22'] = $objWorksheet->getCell('D27')->getValue();     // parametro_22 
    $aData['parametro_23'] = $objWorksheet->getCell('D28')->getValue();     // parametro_23 
    $aData['parametro_24'] = $objWorksheet->getCell('D29')->getValue();     // parametro_24 
    $aData['parametro_25'] = $objWorksheet->getCell('D30')->getValue();     // parametro_25     
    $aData['parametro_26'] = $objWorksheet->getCell('D31')->getValue();     // parametro_26 
    $aData['parametro_27'] = $objWorksheet->getCell('D32')->getValue();     // parametro_27 
    $aData['parametro_28'] = $objWorksheet->getCell('D33')->getValue();     // parametro_28    
    $aData['parametro_29'] = $objWorksheet->getCell('D34')->getValue();     // parametro_29
    $aData['parametro_30'] = $objWorksheet->getCell('D34')->getValue();     // parametro_30
    $aData['parametro_31'] = $objWorksheet->getCell('D36')->getValue();     // parametro_31
    

    $aData['categoria_1'] = $objWorksheet->getCell('D39')->getCalculatedValue();     // categoria_1 
    $aData['categoria_2'] = $objWorksheet->getCell('D40')->getCalculatedValue();     // categoria_2 
    $aData['categoria_3'] = $objWorksheet->getCell('D41')->getCalculatedValue();     // categoria_3 
    $aData['categoria_4'] = $objWorksheet->getCell('D42')->getCalculatedValue();     // categoria_4 
    $aData['categoria_5'] = $objWorksheet->getCell('D43')->getCalculatedValue();    // categoria_5 
    $aData['categoria_6'] = $objWorksheet->getCell('D44')->getCalculatedValue();    // categoria_6 

    $aData['categoria_1_ia'] = $objWorksheet->getCell('F39')->getCalculatedValue();     // categoria_1_ia 
    $aData['categoria_2_ia'] = $objWorksheet->getCell('F40')->getCalculatedValue();     // categoria_2_ia 
    $aData['categoria_3_ia'] = $objWorksheet->getCell('F41')->getCalculatedValue();     // categoria_3_ia 
    $aData['categoria_4_ia'] = $objWorksheet->getCell('F42')->getCalculatedValue();     // categoria_4_ia 
    $aData['categoria_5_ia'] = $objWorksheet->getCell('F43')->getCalculatedValue();     // categoria_5_ia 
    $aData['categoria_6_ia'] = $objWorksheet->getCell('F44')->getCalculatedValue();     // categoria_6_ia 

    $aData['categoria_1_ie'] = $objWorksheet->getCell('G39')->getCalculatedValue();     // categoria_1_ie 
    $aData['categoria_2_ie'] = $objWorksheet->getCell('G40')->getCalculatedValue();     // categoria_2_ie 
    $aData['categoria_3_ie'] = $objWorksheet->getCell('G41')->getCalculatedValue();     // categoria_3_ie 
    $aData['categoria_4_ie'] = $objWorksheet->getCell('G42')->getCalculatedValue();     // categoria_4_ie 
    $aData['categoria_5_ie'] = $objWorksheet->getCell('G43')->getCalculatedValue();     // categoria_5_ie 
    $aData['categoria_6_ie'] = $objWorksheet->getCell('G44')->getCalculatedValue();     // categoria_6_ie 


        // TODO : verificar que no existe PK, si es así realizar update o cancelar tarea, dependiendo de preferencias configuración
        $tableColumns = ORM::for_table('demostrativo_diario')->getColumns();
        // TODO : verificar si existe ...->find_one(), set update or cancel
        $newDatabaseDataRow = ORM::for_table('demostrativo_diario')->create();
        $aErrors = array();
        $strignVars = array('date', 'observaciones');


        foreach($aData as $field=>$value)
        { 
        $field =htmlentities($field);
        if( strlen($aParametrosApp[$field]['lang_ES']) )
            $name = htmlentities($aParametrosApp[$field]['lang_ES']);
        else
            $name = $field;

            if(strlen($value) == 0)
            $aErrors[$field] = "  &bull; <strong>".$name. "</strong>: no puede ser nulo" ;
            else if ( !in_array( $field, $strignVars ) && !is_numeric($value)  && strlen ($aParametrosApp[$field]['lang_ES']) > 0 ) 
            $aErrors[$field] =  "  &bull; <strong>".$name. "</strong>: debe ser un n&uacute;mero v&aacute;lido" ;
        
        if( is_numeric($value) && $value < 0 )
            $value = $value * (-1);
        $newDatabaseDataRow[$field] = $value; 
        }

        if(count($aErrors) > 0){
            $sErrors = implode("<br>", $aErrors);
       throw new Exception('Error de datos en el fichero: faltan par&aacute;metros, revise el contenido del fichero y su formato:<br></strong>'.$sErrors.'<strong>');
        }

        $newDatabaseDataRow->save();
    $new_id = $newDatabaseDataRow->id();
    LogicaBdd::check_data_demostrativo_diario($new_id);

    LogicaBdd::update_acumulativos_from_date($aData['demostrativo_id'], $aData['date']);



    $new_filename = uploadfile($_FILES["xlsFile"]["name"], filesDir::$directory, $_FILES["xlsFile"]["tmp_name"], "demostrativo_".$aData['demostrativo_id'], $UNIX_DATE);  


    logger("UPLOAD XLSX DEMOSTRATIVO - OK", "Subido nuevo XLSX de demostrativo ".$aData['demostrativo_id']." (".$aData['date'].")", "ADMIN");

    //header('Content-Type: application/json; charset=utf-8');
    die( json_encode( array('table' => $aData['demostrativo_id'], 'date' => $fecha )) );
}catch(Exception $e){
    //header("Status: 400 Bad Request", true, 400);  
    logger("UPLOAD XLSX DEMOSTRATIVO - KO", "Error al intentar subir nuevo XLSX de demostrativo ".$aData['demostrativo_id']." (".$aData['date']."): ". $e->getMessage(), "ERROR");
    if(strstr($e->getMessage(), "Duplicate"))
        echo 'Ya existe un documento de  Demostrativo '.$aData['demostrativo_id'].' para esa fecha ('.$aData['date'].').<br>Si quiere importar un nuevo documento elimine la entrada previa desde el apartado "datos de salida" y a continuaci&oacute;n importe el nuevo documento.';
    else if( strstr($e -> getMessage(), "FOREIGN KEY") )
        echo "El usuario no se puede eliminar porque existen datos asociados.";
    else
        echo $e -> getMessage();  
    exit(1);  
}