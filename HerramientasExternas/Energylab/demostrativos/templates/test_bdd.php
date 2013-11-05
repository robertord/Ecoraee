<?php
include_once "../conf/configuration.php";
include_once 'LogicaBdd.php';
require_once 'PHPExcel.php';

try{
	echo LogicaBdd::insert_test_data(1825);
	//echo LogicaBdd::update_acumulativos_from_date(1, "2013-06-08");

}catch(Exception $e){
	echo "error: ".$e->getMessage();
}
