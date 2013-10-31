<?php
require_once '../conf/configuration.php';
$directorio_logs = filesDir::$directory."logs";	
if(is_dir($directorio_logs)){
	$logs_dir  = scandir($directorio_logs);
	foreach($logs_dir as $y_tmp){ // años
		if($y_tmp !="." && $y_tmp !=".."){
			$logs_dir_year  = scandir($directorio_logs."/".$y_tmp);
			foreach($logs_dir_year as $m_tmp){ // meses
				if($m_tmp !="." && $m_tmp !=".."){
					$logs_dir_month  = scandir($directorio_logs."/".$y_tmp."/".$m_tmp);
					foreach($logs_dir_month as $log_file){ // dias
						if($log_file !="." && $log_file !=".."){
							$a =  explode("_", $log_file);
							$aTemp['id'] = $id;
							$aTemp['title'] = " ";
							$aTemp['start'] = $y_tmp."-".$m_tmp."-".$a[2];
							$aTemp['allDay'] = "true";			
							$aTemp['url'] = "../files/logs/".$y_tmp."/".$m_tmp."/".$log_file;
							$aFiles[] = $aTemp; 
							$id++;
						}
					}
				}
			}
		}			
	}
}
$m_tmp ++;
if($m_tmp > 12){
	$m_tmp = 1;
	$y_tmp = $y_tmp+1;
}
echo json_encode($aFiles);