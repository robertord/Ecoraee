<?php
require_once '../conf/configuration.php';
$sTable = $_REQUEST['table'];

$aParams = $_REQUEST;
$a = explode ("get_dt_tdata.php?", urldecode($_SERVER["REQUEST_URI"]));
$aVars = explode("&", $a[1]);
foreach ($aVars as $k =>$v){
	$a2 = explode("=",$v);
	if(!isset($_REQUEST[$k]))
		if(isset($a2[1]))
			$aParams[$a2[0]] = $a2[1];
}

function to_mysql_date($fecha){
    ereg( "([0-9]{1,2})/([0-9]{1,2})/([0-9]{2,4})", $fecha, $mifecha);
    $lafecha=$mifecha[3]."-".$mifecha[2]."-".$mifecha[1];
    return $lafecha;
} 
//sEcho=1&iColumns=54&sColumns=&iDisplayStart=0&iDisplayLength=10&mDataProp_0=0&mDataProp_1=1&mDataProp_2=2&mDataProp_3=3&mDataProp_4=4&mDataProp_5=5&mDataProp_6=6&mDataProp_7=7&mDataProp_8=8&mDataProp_9=9&mDataProp_10=10&mDataProp_11=11&mDataProp_12=12&mDataProp_13=13&mDataProp_14=14&mDataProp_15=15&mDataProp_16=16&mDataProp_17=17&mDataProp_18=18&mDataProp_19=19&mDataProp_20=20&mDataProp_21=21&mDataProp_22=22&mDataProp_23=23&mDataProp_24=24&mDataProp_25=25&mDataProp_26=26&mDataProp_27=27&mDataProp_28=28&mDataProp_29=29&mDataProp_30=30&mDataProp_31=31&mDataProp_32=32&mDataProp_33=33&mDataProp_34=34&mDataProp_35=35&mDataProp_36=36&mDataProp_37=37&mDataProp_38=38&mDataProp_39=39&mDataProp_40=40&mDataProp_41=41&mDataProp_42=42&mDataProp_43=43&mDataProp_44=44&mDataProp_45=45&mDataProp_46=46&mDataProp_47=47&mDataProp_48=48&mDataProp_49=49&mDataProp_50=50&mDataProp_51=51&mDataProp_52=52&mDataProp_53=53&sSearch=&bRegex=false&sSearch_0=&bRegex_0=false&bSearchable_0=true&sSearch_1=&bRegex_1=false&bSearchable_1=true&sSearch_2=&bRegex_2=false&bSearchable_2=true&sSearch_3=&bRegex_3=false&bSearchable_3=true&sSearch_4=&bRegex_4=false&bSearchable_4=true&sSearch_5=&bRegex_5=false&bSearchable_5=true&sSearch_6=&bRegex_6=false&bSearchable_6=true&sSearch_7=&bRegex_7=false&bSearchable_7=true&sSearch_8=&bRegex_8=false&bSearchable_8=true&sSearch_9=&bRegex_9=false&bSearchable_9=true&sSearch_10=&bRegex_10=false&bSearchable_10=true&sSearch_11=&bRegex_11=false&bSearchable_11=true&sSearch_12=&bRegex_12=false&bSearchable_12=true&sSearch_13=&bRegex_13=false&bSearchable_13=true&sSearch_14=&bRegex_14=false&bSearchable_14=true&sSearch_15=&bRegex_15=false&bSearchable_15=true&sSearch_16=&bRegex_16=false&bSearchable_16=true&sSearch_17=&bRegex_17=false&bSearchable_17=true&sSearch_18=&bRegex_18=false&bSearchable_18=true&sSearch_19=&bRegex_19=false&bSearchable_19=true&sSearch_20=&bRegex_20=false&bSearchable_20=true&sSearch_21=&bRegex_21=false&bSearchable_21=true&sSearch_22=&bRegex_22=false&bSearchable_22=true&sSearch_23=&bRegex_23=false&bSearchable_23=true&sSearch_24=&bRegex_24=false&bSearchable_24=true&sSearch_25=&bRegex_25=false&bSearchable_25=true&sSearch_26=&bRegex_26=false&bSearchable_26=true&sSearch_27=&bRegex_27=false&bSearchable_27=true&sSearch_28=&bRegex_28=false&bSearchable_28=true&sSearch_29=&bRegex_29=false&bSearchable_29=true&sSearch_30=&bRegex_30=false&bSearchable_30=true&sSearch_31=&bRegex_31=false&bSearchable_31=true&sSearch_32=&bRegex_32=false&bSearchable_32=true&sSearch_33=&bRegex_33=false&bSearchable_33=true&sSearch_34=&bRegex_34=false&bSearchable_34=true&sSearch_35=&bRegex_35=false&bSearchable_35=true&sSearch_36=&bRegex_36=false&bSearchable_36=true&sSearch_37=&bRegex_37=false&bSearchable_37=true&sSearch_38=&bRegex_38=false&bSearchable_38=true&sSearch_39=&bRegex_39=false&bSearchable_39=true&sSearch_40=&bRegex_40=false&bSearchable_40=true&sSearch_41=&bRegex_41=false&bSearchable_41=true&sSearch_42=&bRegex_42=false&bSearchable_42=true&sSearch_43=&bRegex_43=false&bSearchable_43=true&sSearch_44=&bRegex_44=false&bSearchable_44=true&sSearch_45=&bRegex_45=false&bSearchable_45=true&sSearch_46=&bRegex_46=false&bSearchable_46=true&sSearch_47=&bRegex_47=false&bSearchable_47=true&sSearch_48=&bRegex_48=false&bSearchable_48=true&sSearch_49=&bRegex_49=false&bSearchable_49=true&sSearch_50=&bRegex_50=false&bSearchable_50=true&sSearch_51=&bRegex_51=false&bSearchable_51=true&sSearch_52=&bRegex_52=false&bSearchable_52=true&sSearch_53=&bRegex_53=false&bSearchable_53=true&iSortCol_0=0&sSortDir_0=asc&iSortingCols=1&bSortable_0=true&bSortable_1=true&bSortable_2=true&bSortable_3=true&bSortable_4=true&bSortable_5=true&bSortable_6=true&bSortable_7=true&bSortable_8=true&bSortable_9=true&bSortable_10=true&bSortable_11=true&bSortable_12=true&bSortable_13=true&bSortable_14=true&bSortable_15=true&bSortable_16=true&bSortable_17=true&bSortable_18=true&bSortable_19=true&bSortable_20=true&bSortable_21=true&bSortable_22=true&bSortable_23=true&bSortable_24=true&bSortable_25=true&bSortable_26=true&bSortable_27=true&bSortable_28=true&bSortable_29=true&bSortable_30=true&bSortable_31=true&bSortable_32=true&bSortable_33=true&bSortable_34=true&bSortable_35=true&bSortable_36=true&bSortable_37=true&bSortable_38=true&bSortable_39=true&bSortable_40=true&bSortable_41=true&bSortable_42=true&bSortable_43=true&bSortable_44=true&bSortable_45=true&bSortable_46=true&bSortable_47=true&bSortable_48=true&bSortable_49=true&bSortable_50=true&bSortable_51=true&bSortable_52=true&bSortable_53=true&table=demostrativo_1_diario

/* Total data set length */
	$aResCols = ORM::for_table($aParams['table'])->getColumns();
	foreach($aResCols as $col)
	{
		$aColumns[] = $col['Field'];
		if($col['Key'] == "PRI")
		{
			$sIndexColumn = $col['Field'];
		}
	}
	$iTotal = ORM::for_table($aParams['table'])->count();

/* Paging */
	$aLimitOrm = array();
	if ( isset( $aParams['iDisplayStart'] ) && $aParams['iDisplayLength'] != '-1' )
	{
		$aLimitOrm['limit'] = intval( $aParams['iDisplayLength'] );
		$aLimitOrm['offset'] = intval( $aParams['iDisplayStart'] );
	}
	
/* Ordering */
	$aOrderOrm = array();
	if ( isset( $aParams['iSortCol_0'] ) )
	{
		for ( $i=0 ; $i<intval( $aParams['iSortingCols'] ) ; $i++ )
		{
			if ( $aParams[ 'bSortable_'.intval($aParams['iSortCol_'.$i]) ] == "true" )
			{					
				$aOrderOrm[$i][$aParams['sSortDir_'.$i]] = $aColumns[ intval( $aParams['iSortCol_'.$i] ) ];
			}
		}
	}

/* Global Filtering */
	$aWhereOrm = array();
	$sWhereRaw = "";
	if ( isset($aParams['sSearch']) && $aParams['sSearch'] != "" )
	{
		for ( $i=0 ; $i<count($aColumns) ; $i++ )
		{
			$sWhereRaw .= "`".$aColumns[$i]."` LIKE '%". $aParams['sSearch'] ."%' OR ";
		}
		$sWhereRaw = substr_replace( $sWhereRaw, "", -3 );
	}

	if(isset($aParams['dtFrom']) && isset($aParams['dtTo'])) {
			$sWhereRaw .= "`date` BETWEEN '".to_mysql_date($aParams['dtFrom'])."' AND '".to_mysql_date($aParams['dtTo'])."' ";			
	}



/* Individual column filtering */
	for ( $i=0 ; $i<count($aColumns) ; $i++ )
	{
		if ( isset($aParams['bSearchable_'.$i]) && $aParams['bSearchable_'.$i] == "true" && $aParams['sSearch_'.$i] != '' )
		{
			$aWhereOrm[$i]['column'] = $aColumns[$i];
			$aWhereOrm[$i]['w_value'] ="%".$aParams['sSearch_'.$i]."%"; 
		}
	}

/**************************** QUERY ****************************/
// columns
$queryOrm = ORM::for_table($aParams['table'])->select_expr('SQL_CALC_FOUND_ROWS '.str_replace(" , ", " ", implode(", ", $aColumns)));

// where
if(count($aWhereOrm)>0)
{
	foreach($aWhereOrm as $i=>$w)
	{
		$queryOrm->where($w['column'], $w['w_value']);
	}
}
	
// where_raw
if(strlen($sWhereRaw) > 0)
{
	$queryOrm->where_raw($sWhereRaw);
}
	
$queryOrmAll = $queryOrm;
$resOrmAll = $queryOrmAll->find_array();
	
// order
if(count($aOrderOrm)>0)
{
	foreach($aOrderOrm as $column)
	{
		switch(key($column))
		{
			case "asc":
				$queryOrm->order_by_asc(current($column));
				break;
			case "desc":
				$queryOrm->order_by_desc(current($column));
				break;
		}
	}
}
	
// pagination
if(count($aLimitOrm)>0 && (!isset($aParams['no_limit']) || $aParams['no_limit'] != 1 ))
{
	if($aLimitOrm['limit'] == 0)
	{
		$queryOrm->limit($aLimitOrm['offset']);
	}
	else
	{
		$queryOrm->limit($aLimitOrm['limit'])->offset($aLimitOrm['offset']);
	}
}	
	
// results...
$resOrm = $queryOrm->find_array();
	

$iFilteredTotal = count($resOrmAll);
foreach ($aParams as $k=>$v)
	$url_vars[]=$k."=".urlencode($v);
$url_str = implode("&",$url_vars);
	
/* Output array */
$output = array(
	"sEcho" => intval($aParams['sEcho']),
	"iTotalRecords" => $iTotal,
	"iTotalDisplayRecords" => $iFilteredTotal,
	"aaData" => array(),	
	"url_str" => $url_str
);


$aDataFull 		= array();
if(count($resOrm) > 0){
	foreach($resOrm as $reg){
		$row 		= array();
		$rowFull 	= array();
		/*if($sTable != "td_members"){
			$row[] = null;
			$row[] = null;
		}	*/
		foreach($reg as $k=>$v){
			$row[] = $v;
			$rowFull[$k] = $v;
		}
		//if($sTable == "td_members"){
		$row[] = null;
		$row[] = null;
		//}
		$output['aaData'][] = $row;		
		$aDataFull[] = $rowFull;
	}
}

if(false){
echo"<pre>";
	echo "where:<br>";
	print_r($aWhereOrm);
	echo "<hr>order:<br>";
	print_r($aOrderOrm);
	echo "<hr>limit:<br>";
	print_r($aLimitOrm);
	echo "<hr>";
	echo"<pre>";
	print_r($_REQUEST);

print_r($output);
print_r($aDataFull);
die;
}	



//echo count($output['aaData'][0]);

/* Output json */

header('Content-Type: application/json; charset=utf-8');
if(isset($aParams['no_limit']) && $aParams['no_limit'] == 1)
{
	echo json_encode( $aDataFull );
}
else
{
	echo json_encode( $output );
}