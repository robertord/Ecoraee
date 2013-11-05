<?php
require_once '../conf/configuration.php';
try{
	if($_SESSION["rol"] != "ADMIN")
		throw new Exception('No tiene permiso para realizar la acción solicitada');
	$mysqli = dbLogin::getMysqli();
	$email = strtolower(trim($_REQUEST['email']));
	$fname = trim($_REQUEST['fname']);
	$members_role_id = trim($_REQUEST['members_role']);
	$demostrativo_id = trim($_REQUEST['demostrativo']);
	$password = $_REQUEST['p'];
	$random_salt = get_salt();
	$password = hash('sha512', $password.$random_salt);
	if ($insert_stmt = $mysqli->prepare("INSERT INTO members (username, email, password, salt, members_role_id, demostrativo_id) VALUES (?, ?, ?, ?, ?, ?)")) {
	   $insert_stmt->bind_param('ssssii', $fname, $email, $password, $random_salt, $members_role_id, $demostrativo_id); 
	   // Execute the prepared query.
	   $res = $insert_stmt->execute();	   
	   // TODO : capturar errores
		if($res){
			logger("USUARIO CREADO - OK", "Creado nuevo usuario: ". $email, "ADMIN");
			die ( "1" );
		}else 
			throw new Exception($mysqli->error);
	}
}catch(Exception $e){
	logger("USUARIO CREADO - KO", "Error al crear el usuario: ". $e->getMessage(), "ERROR");
	if( strstr($e -> getMessage(), "Duplicate") )	
		echo "El e-mail del usuario que intenta crear ya existe (no se admiten e-mails duplicados)";
	else
		echo "error: ".$e->getMessage();
	exit(1);
}
