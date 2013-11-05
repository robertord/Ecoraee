<?php
require_once '../conf/configuration.php';
try{
	if(!isset($_REQUEST['id']))
		throw new Exception('Error en el formato de llamada a la página');

	if($_SESSION["rol"] != "ADMIN")
		throw new Exception('No tiene permiso para realizar la acción solicitada');

	$demostrativo_diario = ORM::for_table('members')->find_one($_REQUEST['id']);
	if(!$demostrativo_diario)
		throw new Exception('El usuario no existe');

	if($_REQUEST['id'] == $_SESSION['user_id'])
		throw new Exception('No se pueden eliminar usuarios con los que se ha iniciado sesión en la aplicación');

	$demostrativo = ORM::for_table('demostrativo')->find_one($demostrativo_diario['demostrativo_id']);

	if( $demostrativo['is_loading'] == "1" )
		throw new Exception('en este momento se está actualizando, inténtelo más tarde');

	if( $demostrativo_diario->delete() ){		
        logger("USUARIO ELIMANDO - OK", "El usuario ".$demostrativo_diario['email'].", del demostrativo ".$demostrativo_diario['demostrativo_id']." ha sido eliminado.", "ADMIN");
		die ("1");
	}
}catch(Exception $e){
	header("Status: 400 Bad Request", true, 400);  
    logger("USUARIO ELIMANDO - KO", "Error al eliminar el usuario: ". $e->getMessage(), "ERROR");
	if( strstr($e -> getMessage(), "FOREIGN KEY") )
		echo "El usuario no se puede eliminar porque existen datos asociados.";
    else
    	echo $e -> getMessage();  
    exit(1);  
}