<?php
include_once('db_mod.php');
class Test1 extends DbModel {
	public static $_table = 'test1';
	public static $_id_column = 'id';

	public function getFuuu(){
		//return ORM::for_table($_table)->order_by_asc('nombre')->order_by_desc('nombre')->find_many();	
		return "FUUU";
	}

	public function getGrid(){		
 		$itemDiv = '<div class="item">'.
			'<div class="item_img">'.
				'<img src="img/test.png" height="80" width="80" title="Dr. Wan" alt="test"/>'.
			'</div>'.
			'<div class="item_info">'.
				'<a href="#">'.
					'<span class="eng_name">--</span>'.
					'<span class="chi_name">--</span>'.
				'</a>'.
				'<p>'.
					'<span class="title">--</span>'.
					'<span class="date_joined">--</span>'.
				'</p>'.
			'</div>'.
		'</div>';
		return $itemDiv;
	}
}