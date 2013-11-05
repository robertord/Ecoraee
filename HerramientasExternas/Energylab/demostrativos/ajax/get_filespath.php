<?php
require_once '../conf/configuration.php';
$dateStart = getdate($_REQUEST['start']);
$id = 1;
$y_tmp = $dateStart['year'];
$m_tmp = $dateStart['mon'];
$n_demostrativo = $_REQUEST['demostrativo'];

for($i = 0; $i <= 3; $i++){
	if( strlen($m_tmp) == 1 )
		$m_tmp = "0".$m_tmp;
	$directorio_tmp = filesDir::$directory."demostrativo_".$n_demostrativo."/".$y_tmp."/".$m_tmp;
	if(is_dir($directorio_tmp)){
		$ficheros_dir_tmp  = scandir($directorio_tmp);
		foreach($ficheros_dir_tmp as $xlsxFile){
			if($xlsxFile !="." && $xlsxFile !=".."){
				$a =  explode(".", str_replace("demostrativo_".$n_demostrativo."_".$y_tmp.$m_tmp, "", $xlsxFile) );
				$aTemp['id'] = $id;
				$aTemp['title'] = " ";
				$aTemp['start'] = $y_tmp."-".$m_tmp."-".$a[0];
				$aTemp['allDay'] = "true";			
				$aTemp['url'] = "../files/demostrativo_".$n_demostrativo."/".$y_tmp."/".$m_tmp."/".$xlsxFile;
				$aFiles[] = $aTemp; 
				$id++;
			}
		}
	}
	$m_tmp ++;
	if($m_tmp > 12){
		$m_tmp = 1;
		$y_tmp = $y_tmp+1;
	}
}
echo json_encode($aFiles);