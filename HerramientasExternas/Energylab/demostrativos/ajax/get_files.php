<?php
require_once '../conf/configuration.php';
function dirToArray($dir) {  
   $result = array();

   $cdir = scandir($dir);
   foreach ($cdir as $key => $value)
   {
      if (!in_array($value,array(".","..")))
      {
         if (is_dir($dir . DIRECTORY_SEPARATOR . $value))
         {
            $result["DIR_".$value] = dirToArray($dir . DIRECTORY_SEPARATOR . $value);
         }
         else
         {
            $result[] = $value;
         }
      }
   }
  
   return $result;
} 

$aRes = dirToArray(filesDir::$directory.$_REQUEST['demostrativo']);
echo "<pre>";print_r($aRes);
die;
echo json_encode( $aRes );