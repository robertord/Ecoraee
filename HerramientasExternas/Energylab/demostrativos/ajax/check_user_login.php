<?php
require_once('../conf/configuration.php'); 

if(isset($_REQUEST['email'], $_REQUEST['p'])) {
   $email = $_REQUEST['email'];
   $passwd = $_REQUEST['p']; // The hashed password.

   if(login($email, $passwd, dbLogin::getMysqli())) {
      // Login success
      //echo 'Success: You have been logged in!';
		echo 1;
   } else {
      // Login failed
      echo 'Login failed!';
     // header('Location: ./login.php?error=1');
   }
} else { 
   // The correct POST variables were not sent to this page.
   print_r($_REQUEST);
   echo 'Invalid Request';
}