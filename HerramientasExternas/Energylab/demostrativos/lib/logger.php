<?php
require_once '../conf/configuration.php';
function logger($title, $message, $type = "INFO"){
  	$callers=debug_backtrace();
  	$functions = $callers[1]['function']."() ";
  	$filename = filesDir::$directory."/logs/".date("Y")."/".date("m")."/".date("Y_m_d")."_log.php";

  	$dirname = dirname($filename);
  	if (!is_dir($dirname))
  	{
        mkdir($dirname, 0777, true);
  	}  	
  	
    if(! file_exists($filename) ){
      $flog = fopen($filename, "a+");
      	chmod($filename, filesDir::$mod);
     	 fwrite($flog, "<?php include_once '../../../../conf/logs_conf.php';  ?> " );
     	 fclose($flog);
    }

    switch ($type) {
      case 'WARNING':
        $color="#E56717";
        break;
      case 'ERROR':
        $color="#9F000F";
        break;
      case 'ADMIN':
        $color="#7D0541";
        break;
      case 'INFO':
      default:
        $color="#15317E";
        break;
    }
  	chmod($filename, 0777);
  	$flog = fopen($filename, "a+");
    $str=  '
    <table style="font-family:verdana;font-size:10px;float:left;clear:both;margin-bottom:1.5em;width:100%;">
      <tr>        
        <th style="min-width:150px; width:150px;color:'.$color.';text-align:left;">'.date("Y-m-d H:i:s").'<br>&nbsp;&nbsp;&gt; '.$type.'</th>
        <td style="border-left:1px solid #eee;padding:1em;padding-left:1.5em;">'.$_SERVER['REMOTE_ADDR'].'&nbsp;&nbsp;&nbsp;&nbsp;'.$_SESSION['email'].'<br><br><strong>'.$title.':</strong><br><br>'.$message.'</td>
      </tr>
    </table>';
    fwrite($flog, $str);
  	fclose($flog);
}