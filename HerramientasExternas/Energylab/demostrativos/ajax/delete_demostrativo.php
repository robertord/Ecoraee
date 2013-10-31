<?php
require_once '../conf/configuration.php';
include_once 'LogicaBdd.php';
try{
    function removeEmptyDirectory($dirname) {	    
		$number_of_files_inside_dir = scandir($dirname);
    	if ( count($number_of_files_inside_dir) == 2 )
			if(!rmdir($dirname))
				return ("El directorio   ".$dirname."   está vacío pero se produjo un error al intentar eliminarlo.");
		return true;
    }

	if(!isset($_REQUEST['id']))
		throw new Exception('Error en el formato de llamada a la página');

	if( !isset($_SESSION["rol"]) )
		throw new Exception('No tiene permiso para realizar la acción solicitada');

	$demostrativo_diario = ORM::for_table('demostrativo_diario')->find_one($_REQUEST['id']);

	if($_SESSION["rol"] != "ADMIN" &&  ($demostrativo_diario['demostrativo_id'] != $_SESSION['demostrativo_id']) )
		throw new Exception('No tiene permiso para realizar la acción solicitada');
	
	if(!$demostrativo_diario)
		throw new Exception("No se ha encontrado el registro que intentaba eliminar");

	$demostrativo = ORM::for_table('demostrativo')->find_one($demostrativo_diario['demostrativo_id']);
	if( $demostrativo['is_loading'] == "1" )
		throw new Exception("En este momento se están actualizando los datos del demostrativo y no se puede realizar la acción solicitada, inténtelo más tarde");

	$v_demostrativo_id = $demostrativo_diario['demostrativo_id'];
	$v_date = $demostrativo_diario['date'];

	$demostrativo_diario->delete();
	LogicaBdd::update_acumulativos_from_date($v_demostrativo_id, $v_date);

	// eliminar fichero de entrada asociado
	$aFecha = explode("-",$demostrativo_diario['date'] ); // YYYY-mm-dd 
	$dir =  filesDir::$directory."demostrativo_".$demostrativo_diario["demostrativo_id"]."/".$aFecha[0]."/".$aFecha[1];
	$file_name = "demostrativo_".$demostrativo_diario["demostrativo_id"]."_".$aFecha[0].$aFecha[1].$aFecha[2].".xlsx";
	$dir_file = $dir."/".$file_name;
	
	if(!unlink($dir_file)){
		logger("DEMOSTRATIVO ELIMINADO - OK", "Eliminados datos del demostrativo ". $v_demostrativo_id. " del d&iacute;a ".$v_date .", pero se ha producido un error al intentar eliminar el fichero asociado (el documento asociado ".$dir_file." no exist&iacute;a). ", "WARNING");
		//die("los datos del demostrativo han sido eliminados pero se ha producido un error al intentar eliminar el fichero asociado");
	}

	$s = removeEmptyDirectory($dir);
	if($s !== true)
		throw new Exception("Error al comprobar si el directorio est&aacute; vac&iacute;o  ".$dir);
	$s = removeEmptyDirectory(filesDir::$directory."demostrativo_".$demostrativo_diario["demostrativo_id"]."/".$aFecha[0]);
	if($s !== true)
		throw new Exception("Error al comprobar si el directorio est&aacute; vac&iacute;o ".filesDir::$directory."demostrativo_".$demostrativo_diario["demostrativo_id"]."/".$aFecha[0]);


	logger("DEMOSTRATIVO ELIMINADO - OK", "Eliminados datos del demostrativo ". $v_demostrativo_id. " del d&iacute;a ".$v_date .". ", "ADMIN");
	exit ("1");

}catch(Exception $e){
	header("Status: 400 Bad Request", true, 400);  
	logger("DEMOSTRATIVO ELIMINADO - KO", "Error al eliminar los datos del ". $v_demostrativo_id. " del d&iacute;a ".$v_date .": ". $e->getMessage(), "ERROR");
	echo $e -> getMessage();  
	exit(1);
}
