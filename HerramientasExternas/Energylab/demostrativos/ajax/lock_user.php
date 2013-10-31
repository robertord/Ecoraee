<?php
require_once '../conf/configuration.php';
try{
	if( !isset($_REQUEST['id']) || !isset($_REQUEST['lock']) )
		throw new Exception('Error en el formato de llamada a la página');

	if($_SESSION["rol"] != "ADMIN")
		throw new Exception('No tiene permiso para realizar la acción solicitada');

	$aUser = ORM::for_table('members')->find_one($_REQUEST['id']);

	if( !$aUser )
		throw new Exception('El usuario no existe');

	if( $_REQUEST['id'] == $_SESSION['user_id'] )
		throw new Exception('No se pueden bloquear/desbloquear usuarios con los que se ha iniciado sesión en la aplicación. Si su cuenta ha sido bloqueada y no dispone de ningún usuario administrador activo, póngase en contacto con los administradores de la aplicación.');

	$attempts = ORM::for_table('login_attempts')->where('user_id', $aUser['id'])->count();

	if( $attempts > $_MAX_LOGIN_ATTEMPS && $_REQUEST['lock'] )
		throw new Exception('El usuario ya está bloqueado');



	if( $_REQUEST['lock'] == 0 ){
		$res = ORM::for_table('login_attempts')
		    ->where_equal('user_id', $aUser['id'])
		    ->delete_many();

		if( !$res )
			throw new Exception('error al modificar el estado de bloqueo del usuario');
		logger("USUARIO DESBLOQUEADO - OK", "Desbloqueada la cuenta de usuario: ". $aUser['email'], "ADMIN");
	}else{
		for($i=0; $i <= $_MAX_LOGIN_ATTEMPS; $i++ ){
			$login_attempt = ORM::for_table('login_attempts')->create();
			$login_attempt->set('user_id', $aUser['id']);
			$login_attempt->set_expr('time', time());
			$login_attempt->save();
		}
		logger("USUARIO BLOQUEADO - OK", "Bloqueada la cuenta de usuario: ". $aUser['email']. " por administrador del sistema ", "ADMIN");
	}
	echo $attempts;
	exit(1);

}catch(Exception $e){
	header("Status: 400 Bad Request", true, 400);  
	logger("USUARIO BLOQUEO/DESBLOQUEO - KO", "Error al intentar cambiar el estado de bloqueo de la cuenta de usuario: ". $aUser['email']. ". ", "ERROR");
    echo $e -> getMessage();  
    exit(1);  
}