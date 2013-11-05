<?php
require_once '../conf/configuration.php';
try{
$mysqli = dbLogin::getMysqli();
$fname = trim($_REQUEST['fname']);
$password = $_REQUEST['p'];
$random_salt = get_salt();
$password = hash('sha512', $password.$random_salt);
$user_id = $_REQUEST['id'];

	$aUser = ORM::for_table('members')->find_one($user_id);

	if ($update_stmt = $mysqli->prepare(" UPDATE members SET username = ?, password = ?, salt = ? WHERE id = ? ")) {
	   $update_stmt->bind_param('sssi', $fname, $password, $random_salt, $user_id); 
	   // Execute the prepared query.
	   $res = $update_stmt->execute();	   
	   // TODO : capturar errores
		if($res){
			logger("USUARIO MODIFICADO - OK", "Modificados los datos del usuario: ". $aUser['email']. ". ", "ADMIN");
			die ( "1" );
		}else 
			throw new Exception('error al modificar los datos del usuario');
	}
}catch(Exception $e){
	logger("USUARIO MODIFICADO - KO", "Error al intentar modificar los datos del usuario: ". $aUser['email']. ". ", "ERROR");
	die ("error: ".$e->getMessage());
}
