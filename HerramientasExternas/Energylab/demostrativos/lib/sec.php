<?php

function sec_session_start_ajax(){
        $session_name = 'sec_session_id'; // Set a custom session name
        $secure = false; // Set to true if using https.
        $httponly = false; // This stops javascript being able to access the session id. 
        ini_set('session.use_only_cookies', 1); // Forces sessions to only use cookies. 
        $cookieParams = session_get_cookie_params(); // Gets current cookies params.
        session_set_cookie_params($cookieParams["lifetime"], $cookieParams["path"], $cookieParams["domain"], $secure, $httponly); 
        session_name($session_name); // Sets the session name to the one set above.
        session_start(); // Start the php session
        session_regenerate_id(false); // regenerated the session, delete the old one.
}

function sec_session_start() {
        $session_name = 'sec_session_id'; // Set a custom session name
        $secure = false; // Set to true if using https.
        $httponly = true; // This stops javascript being able to access the session id. 
        ini_set('session.use_only_cookies', 1); // Forces sessions to only use cookies. 
        $cookieParams = session_get_cookie_params(); // Gets current cookies params.
        session_set_cookie_params($cookieParams["lifetime"], $cookieParams["path"], $cookieParams["domain"], $secure, $httponly); 
        session_name($session_name); // Sets the session name to the one set above.
        session_start(); // Start the php session
        session_regenerate_id(true); // regenerated the session, delete the old one.
}

function is_valid_session(){
  if($_SESSION['login_string'] == hash('sha512', $_SESSION['username'].$_SERVER['HTTP_USER_AGENT'].$_SERVER['REMOTE_ADDR'])){
    return true;
  }else{
    //echo $_SESSION['login_string'] ."==". hash('sha512', $_SESSION['username'].$_SERVER['HTTP_USER_AGENT'].$_SERVER['REMOTE_ADDR']);
    return false;
  }
}

function sec_session_destroy(){
  logger("CERRADA SESION", "El usuario ha ".$_SESSION['email']." ha cerrado sesi&oacute;n.");
  $_SESSION = array();
  // get session parameters 
  $params = session_get_cookie_params();
  // Delete the actual cookie.
  setcookie(session_name(), '', time() - 42000, $params["path"], $params["domain"], $params["secure"], $params["httponly"]);
  // Destroy session
  session_destroy();
}


function login($email, $password, $mysqli) {
   // Using prepared Statements means that SQL injection is not possible. 
   if ($stmt = $mysqli->prepare("SELECT m.id, username, password, salt, m.members_role_id, demostrativo_id, r.code, m.email  as rol  FROM members m JOIN members_role r ON m.members_role_id=r.id  WHERE email = ? LIMIT 1")) { 
      $stmt->bind_param('s', $email); // Bind "$email" to parameter.
      $stmt->execute(); // Execute the prepared query.
      $stmt->store_result();
      $stmt->bind_result($user_id, $username, $db_password, $salt, $members_role_id, $demostrativo_id, $rol, $email); // get variables from result.
      $stmt->fetch();

      $password = hash('sha512', $password.$salt); // hash the password with the unique salt.
 
      if($stmt->num_rows == 1) { // If the user exists
         // We check if the account is locked from too many login attempts
         if(checkbrute($user_id, $mysqli) == true) { 
            // Account is locked
            // Send an email to user saying their account is locked
             echo "Cuenta bloqueada. ";
            logger("CUENTA BLOQUEADA", "El usuario <strong>".$email."</strong> ha intentado acceder pero su cuenta est&aacute; bloqueada.", "WARNING");
              return false;
         } else {
         if($db_password == $password) { // Check if the password in the database matches the password the user submitted. 
            // Password is correct!
               $user_id = preg_replace("/[^0-9]+/", "", $user_id); // XSS protection as we might print this value
               $_SESSION['user_id'] = $user_id; 
               $username = preg_replace("/[^a-zA-Z0-9_\-]+/", "", $username); // XSS protection as we might print this value
               $_SESSION['username'] = $username;
               $_SESSION['email'] = $email;
               $_SESSION['rol'] = $rol;
               $_SESSION['demostrativo_id'] = $demostrativo_id;
               $user_browser = $_SERVER['HTTP_USER_AGENT']; // Get the user-agent string of the user.
               $user_ip = $_SERVER['REMOTE_ADDR'];
               $_SESSION['login_string'] = hash('sha512', $username.$user_browser.$user_ip);
              logger("INICIO DE SESION", "El usuario ha ".$email." ha iniciado sesi&oacute;n.");
              try{
                  $res = ORM::for_table('login_attempts')
                    ->where_equal('user_id', $user_id)
                    ->delete_many();
                  if( !$res )
                    logger("RESET USER LOGIN ATTEMPTS - KO", "Error al intentar resetear login_attempts del usuario: ". $email, "ERROR");
              }catch (Exception $e){

              }
               return true;    
         } else {
            // Password is not correct
            // We record this attempt in the database
            $now = time();
            $mysqli->query("INSERT INTO login_attempts (user_id, time) VALUES ('$user_id', '$now')");
            logger("PASSWORD INCORRECTO", "El usuario ha ".$email." ha intentado acceder pero su contrase&ntilde;a era incorrecta.");
            return false;
         }
      }
      } else {
         // No user exists. 
        echo "No se ha encontrado el usuario. ";
        logger("NO EXISTE USUARIO", "No se ha encontrado el usuario ".$email." en la base de datos de la aplicaci&oacute;n.");
         return false;
      }
   }
}

function checkbrute($user_id, $mysqli) {
  global $_MAX_LOGIN_ATTEMPS;
   // Get timestamp of current time
   $now = time();
   // All login attempts are counted from the past 2 hours. 
   $valid_attempts = $now - (2 * 60 * 60); 
 
   if ($stmt = $mysqli->prepare("SELECT time FROM login_attempts WHERE user_id = ? AND time > '$valid_attempts'")) { 
      $stmt->bind_param('i', $user_id); 
      // Execute the prepared query.
      $stmt->execute();
      $stmt->store_result();
      // If there has been more than 5 failed logins
      if($stmt->num_rows > $_MAX_LOGIN_ATTEMPS) {
        logger("USUARIO BLOQUEADO", "El usuario ".$email." ha sido bloqueado, ha excedido el n&uacute;mero m&aacute;ximo de intentos de login.", "WARNING");
         return true;
      } else {
         return false;
      }
   }
}

function login_check($mysqli) {
   // Check if all session variables are set
   if(isset($_SESSION['user_id'], $_SESSION['username'], $_SESSION['login_string'])) {
     $user_id = $_SESSION['user_id'];
     $login_string = $_SESSION['login_string'];
     $username = $_SESSION['username'];
 
     $user_browser = $_SERVER['HTTP_USER_AGENT']; // Get the user-agent string of the user.
 
     if ($stmt = $mysqli->prepare("SELECT password FROM members WHERE id = ? LIMIT 1")) { 
        $stmt->bind_param('i', $user_id); // Bind "$user_id" to parameter.
        $stmt->execute(); // Execute the prepared query.
        $stmt->store_result();
 
        if($stmt->num_rows == 1) { // If the user exists
           $stmt->bind_result($password); // get variables from result.
           $stmt->fetch();
           $login_check = hash('sha512', $password.$user_browser);
           if($login_check == $login_string) {
              // Logged In!!!!
              return true;
           } else {
              // Not logged in
              return false;
           }
        } else {
            // Not logged in
            return false;
        }
     } else {
        // Not logged in
        return false;
     }
   } else {
     // Not logged in
     return false;
   }
}

function get_salt(){
  // return substr(str_replace('+', '.', base64_encode(pack('N4', mt_rand(), mt_rand(), mt_rand(), mt_rand()))), 0, 22);
  return hash('sha512', uniqid(mt_rand(1, mt_getrandmax()), true));
}