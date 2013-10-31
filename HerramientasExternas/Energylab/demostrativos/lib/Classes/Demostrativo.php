<?php
include_once '../../conf/configuration.php';

class Demostrativo
{

	private $_demostrativo_id;

	public function __construct($id)
	{
		$this->_demostrativo_id = $id;
	}


	public function getMinDate(){
		$res = ORM::for_table('demostrativo_diario')->select_many("date")->where("demostrativo_id", $this->_demostrativo_id)->order_by_asc('date')->limit(1)->find_array();
		$res = reset($res);
		return strtotime($res['date']);
	}



	public function getMaxDate(){
		$res = ORM::for_table('demostrativo_diario')->select_many("date")->where("demostrativo_id", $this->_demostrativo_id)->order_by_desc('date')->limit(1)->find_array();
		$res = reset($res);
		return strtotime($res['date']);
	}
}