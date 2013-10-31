<?php
include_once "../conf/configuration.php";

class LogicaBdd
{
	public function __construct()
	{
	}

	public function insert_test_data($var_n){
		$mysqli = dbConf::getMysqli();
		if ($insert_stmt = $mysqli->prepare("CALL insert_test_data(?)")) {
		   $insert_stmt->bind_param('i', $var_n); 
		   $res = $insert_stmt->execute();	  
			if($res)
				return ( "1" );
			else 
				return($mysqli->error);
		}
	}

	public function set_dacumulativo_fecha($v_demostrativo_diario_id){
		$mysqli = dbConf::getMysqli();
		if ($query = $mysqli->prepare("CALL set_dacumulativo_fecha(?) ")) {
		   $query->bind_param('i',  $v_demostrativo_diario_id); 
		   $res = $query->execute();	  
			if($res)
				return ( "1" );
			else 
				return($mysqli->error);
		}
	}
	
	public function check_data_demostrativo_diario($v_demostrativo_diario_id){
		$mysqli = dbConf::getMysqli();
		if ($insert_stmt = $mysqli->prepare("CALL check_data_demostrativo_diario(?)")) {
		   $insert_stmt->bind_param('i', $v_demostrativo_diario_id); 
		   $res = $insert_stmt->execute();	  
			if($res)
				return ( "1" );
			else 
				return($mysqli->error);
		}
	}

	public function update_acumulativos_from_date($var_demostrativo_id, $var_date){
		$var_date = $var_date;
		$mysqli = dbConf::getMysqli();
		$aDemostrativosDiarios = ORM::for_table('demostrativo_diario')
			->select_expr('id, date')
			->where_equal("demostrativo_id", $var_demostrativo_id)
			->where_raw("date >= '".$var_date."' ")
			->order_by_asc("date")
			->find_array();

		$deleteAcum = ORM::for_table('demostrativo_acumulativo')
		    ->where_equal('demostrativo_id', $var_demostrativo_id)
			->where_raw("date >= '".$var_date."' ")
		    ->delete_many();

		$mysqli = dbConf::getMysqli();
		if ( $mysqli->query("CALL update_acumulativos_from_date(".$var_demostrativo_id.", '".$var_date."') ") === true)		   
			return ( "1" );
		else 
			return($mysqli->error);
	}


	public function get_missing_dates($demostrativo_id){
		$mysqli = dbConf::getMysqli();
		$query = "
		select 

  ( select count(*) from demostrativo_diario dd0 where dd0.demostrativo_id = ".$demostrativo_id."  ) 
      AS n_registros,
	( SELECT DATEDIFF(  ( select max(date) from demostrativo_diario  where demostrativo_id = ".$demostrativo_id." ), ( select min(date) from demostrativo_diario  where demostrativo_id = ".$demostrativo_id." )) ) +1 
      AS dias_transcurridos_todos,
		  (
				select count(*) from 
				(select adddate('1970-01-01',t4*10000 + t3*1000 + t2*100 + t1*10 + t0) selected_date from
				 (select 0 t0 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t0,
				 (select 0 t1 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t1,
				 (select 0 t2 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t2,
				 (select 0 t3 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t3,
				 (select 0 t4 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t4) v
				where selected_date
				  between (select min(d1.date) from demostrativo_diario d1 where d1.demostrativo_id = ".$demostrativo_id.")
				  and (select max(d1.date) from demostrativo_diario d1 where d1.demostrativo_id = ".$demostrativo_id.")
				  and  dayofweek (selected_date)  IN (1, 7)

		  	) as sabados_domingos,     

		count(a.Date)  as n_fechas_faltantes, replace(group_concat( DISTINCT(a.Date2 ) ),',',', ' ) as fechas_faltantes
		from (
      select 
          
          DISTINCT(DATE(selected_date)) as Date,  CONCAT(DAY(selected_date),'/',MONTH(selected_date),'/',YEAR(selected_date)) as Date2  from
    				(select adddate('1970-01-01', t4*10000 + t3*1000 + t2*100 + t1*10 + t0) selected_date from
    				 (select 0 t0 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t0,
    				 (select 0 t1 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t1,
    				 (select 0 t2 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t2,
    				 (select 0 t3 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t3,
    				 (select 0 t4 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t4) v
    				where selected_date
    				  between (select min(d1.date) from demostrativo_diario d1 where d1.demostrativo_id = ".$demostrativo_id.")
    				  and (select max(d1.date) from demostrativo_diario d1 where d1.demostrativo_id = ".$demostrativo_id.")
    				  and  dayofweek (selected_date) NOT IN (1, 7)
  ) a where a.Date between ( select min(date) from demostrativo_diario  where demostrativo_id = ".$demostrativo_id." ) 
		  and ( select max(date) from demostrativo_diario  where demostrativo_id = ".$demostrativo_id." ) 
		  and a.Date not in (select distinct(date) from demostrativo_diario where demostrativo_id= ".$demostrativo_id." ) 
		  ";
		//echo 	"<pre>".$query."</pre>";
		try{
			$result = $mysqli->query($query);
			$row = $result->fetch_array(MYSQLI_ASSOC);
			$row['dias_transcurridos'] = $row['dias_transcurridos_todos'];
				$row['dias_habiles'] = $row['dias_transcurridos'] - $row['sabados_domingos'];
			
			return $row;
		}catch(Exception $e){
			return($mysqli->error);
		}
	}

}