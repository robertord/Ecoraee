<?php
	include_once '../lib/logger.php';
	include_once '../lib/idiorm.php';
	include_once '../lib/logger.php';
	include_once '../lib/sec.php';

	$_MAX_LOGIN_ATTEMPS = 5;
	session_set_cookie_params(3600);
	$aUrl = explode("/", $_SERVER['SCRIPT_FILENAME']);
	$aPublicFiles = array(
		"index",
		"estadisticas",
		"demostrativo_1",
		"login",
		"demostrativo_2",
		"demostrativo_3",
		"demostrativo_4",
		"test_bdd",
		"logs_conf"
	);
	$aAdminFiles = array(
		"gestion_usuarios",
		"crear_usuario",
		"editar_usuario",
		"logs"
	);
	$aUserFiles = array(
		"editar_usuario"
	);
	$script_name = reset(explode(".php", end($aUrl)));
	
	if( $script_name == "datos_demostrativo" && isset($_REQUEST['demo']) )
		$li_op = "li_".$script_name.$_REQUEST['demo'];
	else
		$li_op = "li_".$script_name;

	if( in_array('ajax', $aUrl) || in_array("logs", $aUrl) )
	{
		sec_session_start_ajax();
	}
	else
	{
		sec_session_start();
		if(!is_valid_session())
		{			
			if( !in_array( $script_name, $aPublicFiles) ){
				header('Location: ../index.php');
			}
		}
		else
		{
			if($_SESSION["rol"] == "USER" && in_array( $script_name, $aUserFiles) ){
				//header('Location: ../'.$script_name.'.php');
			}
			else if($_SESSION["rol"] != "ADMIN" && in_array( $script_name, $aAdminFiles) )
			{
				header('Location: ../index.php');
			}
		}
	}

	if ( ! defined( "PATH_SEPARATOR" ) ) {
	  if ( strpos( $_ENV[ "OS" ], "Win" ) !== false )
	    define( "PATH_SEPARATOR", ";" );
	  else define( "PATH_SEPARATOR", ":" );
	} 
	$iterator = new DirectoryIterator(dirname(__FILE__));
	$BASEDIR = str_replace("/conf", "", $iterator->getPath());

	$_XLSX_MAX_STYLED_ROWS = 1000; // al exportar salida, si el número de registros es muy elevado puede dar un timeout; para evitarlo en la medida de lo posible, si hay muchos registros no se aplicarán estilos al documento XLSX generado

	$aPath = array('lib', 'lib/Classes', 'lib/Classes/PHPExcel', "lib/Classes/DatabaseModels");

	foreach($aPath as $dir)
	{
		set_include_path(get_include_path() . PATH_SEPARATOR .  $BASEDIR . "/" . $dir);
	}


	class dbLogin
	{		
		public static $host = "localhost";
		public static $user = "energylab_demo";
		public static $pass = "discalis";
		public static $database = "energylab_demostrativos";
		public static $driver_options = "utf8";
		
		public static function getStrConn()
		{
			return "mysql:host=".self::$host.";dbname=".self::$database;
		}

		public static function getMysqli(){
			$mysqli = new mysqli(self::$host, self::$user, self::$pass, self::$database);
			return $mysqli;
		}
	}
//$mysqli = new mysqli(dbLogin::$host, dbLogin::$user, dbLogin::$pass, dbLogin::$database);
// Application
	class dbConf
	{		
		public static $host = "localhost";
		public static $user = "energylab_demo";
		public static $pass = "discalis";
		public static $database = "energylab_demostrativos";
		public static $driver_options = "utf8";
		
		public static function getStrConn()
		{
			return "mysql:host=".self::$host.";dbname=".self::$database;
		}
		
		public static function getMysqli(){
			$mysqli = new mysqli(self::$host, self::$user, self::$pass, self::$database);
			return $mysqli;
		}
	}
	ORM::configure(dbConf::getStrConn());
	ORM::configure('username', dbConf::$user);
	ORM::configure('password', dbConf::$pass);
	ORM::configure('driver_options', array(PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES '.dbConf::$driver_options));
	ORM::configure('error_mode', PDO::ERRMODE_EXCEPTION);	

	define('DISCA_FILES_DIR', dirname(__FILE__) . "/../files/");

	class filesDir
	{		
            public static $directory = DISCA_FILES_DIR;
		public static $user = "www-data";
		public static $group = "www-data";
		public static $mod = "0777";
	}

class parametrosDemostrativo
{
	public static $aParametros;

	private static function setArrayParametros(){
		self::$aParametros['date'] = array(key => 'date' , 'lang_ES' => 'Fecha', 'lang_EN' => 'Date');
		self::$aParametros['id'] = array(key => 'id' , 'lang_ES' => 'Id', 'lang_EN' => 'Id');


		self::$aParametros['parametro_1'] = array(key => 'parametro_1' ,  'lang_ES' => "Equipos para procesar", 'lang_EN' => "Equipment to process", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_2'] = array(key => 'parametro_2' ,  'lang_ES' => "Equipos listos para reutilizar", 'lang_EN' => "Equipment ready for reuse", 'unidades_ES' => "Ud.", 'unidades_EN' => "Ud.");
		self::$aParametros['parametro_3'] = array(key => 'parametro_3' ,  'lang_ES' => "Energía consumida", 'lang_EN' => "Consumed energy", 'unidades_ES' => "kWh", 'unidades_EN' => "kWh");
		self::$aParametros['parametro_4'] = array(key => 'parametro_4' ,  'lang_ES' => "Embalaje", 'lang_EN' => "Packaging", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_5'] = array(key => 'parametro_5' ,  'lang_ES' => "Etiquetas", 'lang_EN' => "Labels", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_6'] = array(key => 'parametro_6' ,  'lang_ES' => "Transporte mercancía", 'lang_EN' => "Transport of goods", 'unidades_ES' => "km recorridos", 'unidades_EN' => "km");
		self::$aParametros['parametro_7'] = array(key => 'parametro_7' ,  'lang_ES' => "Periféricos tratados", 'lang_EN' => "Peripherals treated", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_8'] = array(key => 'parametro_8' ,  'lang_ES' => "Componentes recuperados", 'lang_EN' => "Recovered components", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_9'] = array(key => 'parametro_9' ,  'lang_ES' => "Equipos listos", 'lang_EN' => "Equipment ready", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_10'] = array(key => 'parametro_10' ,  'lang_ES' => "Equipamiento trasladado a GRFA", 'lang_EN' => "Equipment moved to GRFA", 'unidades_ES' => "kg", 'unidades_EN' => "kg");

		self::$aParametros['parametro_11'] = array(key => 'parametro_11' ,  'lang_ES' => "Equipamiento NG", 'lang_EN' => "Equipment NG", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_12'] = array(key => 'parametro_12' ,  'lang_ES' => "Equipamiento NR", 'lang_EN' => "Equipment NR", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_13'] = array(key => 'parametro_13' ,  'lang_ES' => "Periféricos a reciclar", 'lang_EN' => "Peripherals to recycle", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_14'] = array(key => 'parametro_14' ,  'lang_ES' => "Periféricos comprobados y averiados", 'lang_EN' => "Peripherals checked and damaged", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_15'] = array(key => 'parametro_15' ,  'lang_ES' => "Componentes a reciclar", 'lang_EN' => "Components to recycle", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_16'] = array(key => 'parametro_16' ,  'lang_ES' => "Equipos obsoletos", 'lang_EN' => "Obsolete equipment", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_17'] = array(key => 'parametro_17' ,  'lang_ES' => "Equipos que no superan el POST", 'lang_EN' => "Equipment that do not pass the POST", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_18'] = array(key => 'parametro_18' ,  'lang_ES' => "Equipos obsoletos en desensamblaje de equipos", 'lang_EN' => "Obsolete Equipment equipment disassembly", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_19'] = array(key => 'parametro_19' ,  'lang_ES' => "Equipos a despiezar", 'lang_EN' => "Butchering Equipment", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		

		// Varian textos en base a numero de demostrativo, lo defino como array
		/*self::$aParametros['parametro_20'] = array(key => 'parametro_20' ,  'lang_ES' => "HDD hacia zona reciclaje", 'lang_EN' => "HDD to recycling area", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_21'] = array(key => 'parametro_21' ,  'lang_ES' => "CD-ROM/DVD-ROM reutilizables", 'lang_EN' => "CD-ROM/DVD-ROM reusable", 'unidades_ES' => "kg", 'unidades_EN' => "kgkg");
		self::$aParametros['parametro_22'] = array(key => 'parametro_22' ,  'lang_ES' => "HDD reutilizable", 'lang_EN' => "HDD reusable", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_23'] = array(key => 'parametro_23' ,  'lang_ES' => "Placas reutilizables", 'lang_EN' => "Reusable boards", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_24'] = array(key => 'parametro_24' ,  'lang_ES' => "Resto CPU reutilizable", 'lang_EN' => "Rest CPU reusable", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_25'] = array(key => 'parametro_25' ,  'lang_ES' => "Pantallas reutilizables", 'lang_EN' => "Reusable screens", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_26'] = array(key => 'parametro_26' ,  'lang_ES' => "Teclados reutilizables", 'lang_EN' => "Reusable keyboards", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_27'] = array(key => 'parametro_27' ,  'lang_ES' => "Ratones reutilizables", 'lang_EN' => "Reusable mice", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_28'] = array(key => 'parametro_28' ,  'lang_ES' => "Cableado reutilizable", 'lang_EN' => "Reusable cabling", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		*/

		self::$aParametros['parametro_20'][1] = array(key => 'parametro_20' ,  'lang_ES' => "Parametro 20 demostrativo 1", 'lang_EN' => "Parameter 20 demo 1", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_21'][1] = array(key => 'parametro_21' ,  'lang_ES' => "Parametro 21 demostrativo 1", 'lang_EN' => "Parameter 21 demo 1", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_22'][1] = array(key => 'parametro_22' ,  'lang_ES' => "Parametro 22 demostrativo 1", 'lang_EN' => "Parameter 22 demo 1", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_23'][1] = array(key => 'parametro_23' ,  'lang_ES' => "Parametro 23 demostrativo 1", 'lang_EN' => "Parameter 23 demo 1", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_24'][1] = array(key => 'parametro_24' ,  'lang_ES' => "Parametro 24 demostrativo 1", 'lang_EN' => "Parameter 24 demo 1", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_25'][1] = array(key => 'parametro_25' ,  'lang_ES' => "Parametro 25 demostrativo 1", 'lang_EN' => "Parameter 25 demo 1", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_26'][1] = array(key => 'parametro_26' ,  'lang_ES' => "Parametro 26 demostrativo 1", 'lang_EN' => "Parameter 26 demo 1", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_27'][1] = array(key => 'parametro_27' ,  'lang_ES' => "Parametro 27 demostrativo 1", 'lang_EN' => "Parameter 27 demo 1", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_28'][1] = array(key => 'parametro_28' ,  'lang_ES' => "Parametro 28 demostrativo 1", 'lang_EN' => "Parameter 28 demo 1", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_29'][1] = array(key => 'parametro_29' ,  'lang_ES' => "Parametro 29 demostrativo 1", 'lang_EN' => "Parameter 29 demo 1", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_30'][1] = array(key => 'parametro_30' ,  'lang_ES' => "Parametro 30 demostrativo 1", 'lang_EN' => "Parameter 30 demo 1", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_31'][1] = array(key => 'parametro_31' ,  'lang_ES' => "Parametro 31 demostrativo 1", 'lang_EN' => "Parameter 31 demo 1", 'unidades_ES' => "kg", 'unidades_EN' => "kg");

		
		self::$aParametros['parametro_20'][2] = array(key => 'parametro_20' ,  'lang_ES' => "Parametro 20 demostrativo 2", 'lang_EN' => "Parameter 20 demo 2", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_21'][2] = array(key => 'parametro_21' ,  'lang_ES' => "Parametro 21 demostrativo 2", 'lang_EN' => "Parameter 21 demo 2", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_22'][2] = array(key => 'parametro_22' ,  'lang_ES' => "Parametro 22 demostrativo 2", 'lang_EN' => "Parameter 22 demo 2", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_23'][2] = array(key => 'parametro_23' ,  'lang_ES' => "Parametro 23 demostrativo 2", 'lang_EN' => "Parameter 23 demo 2", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_24'][2] = array(key => 'parametro_24' ,  'lang_ES' => "Parametro 24 demostrativo 2", 'lang_EN' => "Parameter 24 demo 2", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_25'][2] = array(key => 'parametro_25' ,  'lang_ES' => "Parametro 25 demostrativo 2", 'lang_EN' => "Parameter 25 demo 2", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_26'][2] = array(key => 'parametro_26' ,  'lang_ES' => "Parametro 26 demostrativo 2", 'lang_EN' => "Parameter 26 demo 2", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_27'][2] = array(key => 'parametro_27' ,  'lang_ES' => "Parametro 27 demostrativo 2", 'lang_EN' => "Parameter 27 demo 2", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_28'][2] = array(key => 'parametro_28' ,  'lang_ES' => "Parametro 28 demostrativo 2", 'lang_EN' => "Parameter 28 demo 2", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_29'][2] = array(key => 'parametro_29' ,  'lang_ES' => "Parametro 29 demostrativo 2", 'lang_EN' => "Parameter 29 demo 2", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_30'][2] = array(key => 'parametro_30' ,  'lang_ES' => "Parametro 30 demostrativo 2", 'lang_EN' => "Parameter 30 demo 2", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_31'][2] = array(key => 'parametro_31' ,  'lang_ES' => "Parametro 31 demostrativo 2", 'lang_EN' => "Parameter 31 demo 2", 'unidades_ES' => "kg", 'unidades_EN' => "kg");

		self::$aParametros['parametro_20'][3] = array(key => 'parametro_20' ,  'lang_ES' => "Parametro 20 demostrativo 3", 'lang_EN' => "Parameter 20 demo 3", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_21'][3] = array(key => 'parametro_21' ,  'lang_ES' => "Parametro 21 demostrativo 3", 'lang_EN' => "Parameter 21 demo 3", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_22'][3] = array(key => 'parametro_22' ,  'lang_ES' => "Parametro 22 demostrativo 3", 'lang_EN' => "Parameter 22 demo 3", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_23'][3] = array(key => 'parametro_23' ,  'lang_ES' => "Parametro 23 demostrativo 3", 'lang_EN' => "Parameter 23 demo 3", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_24'][3] = array(key => 'parametro_24' ,  'lang_ES' => "Parametro 24 demostrativo 3", 'lang_EN' => "Parameter 24 demo 3", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_25'][3] = array(key => 'parametro_25' ,  'lang_ES' => "Parametro 25 demostrativo 3", 'lang_EN' => "Parameter 25 demo 3", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_26'][3] = array(key => 'parametro_26' ,  'lang_ES' => "Parametro 26 demostrativo 3", 'lang_EN' => "Parameter 26 demo 3", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_27'][3] = array(key => 'parametro_27' ,  'lang_ES' => "Parametro 27 demostrativo 3", 'lang_EN' => "Parameter 27 demo 3", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_28'][3] = array(key => 'parametro_28' ,  'lang_ES' => "Parametro 28 demostrativo 3", 'lang_EN' => "Parameter 28 demo 3", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_29'][3] = array(key => 'parametro_29' ,  'lang_ES' => "Parametro 29 demostrativo 3", 'lang_EN' => "Parameter 29 demo 3", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_30'][3] = array(key => 'parametro_30' ,  'lang_ES' => "Parametro 30 demostrativo 3", 'lang_EN' => "Parameter 30 demo 3", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_31'][3] = array(key => 'parametro_31' ,  'lang_ES' => "Parametro 31 demostrativo 3", 'lang_EN' => "Parameter 31 demo 3", 'unidades_ES' => "kg", 'unidades_EN' => "kg");

		
		
		self::$aParametros['parametro_20'][4] = array(key => 'parametro_20' ,  'lang_ES' => "HDD hacia zona reciclaje", 'lang_EN' => "HDD to recycling area", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
	// 20130809 
	// > añadidos, desplazadas posiciones		
	self::$aParametros['parametro_21'][4] = array(key => 'parametro_21' ,  'lang_ES' => "Equipos obsoletos zona recambios", 'lang_EN' => "Obsolete computers spares area", 'unidades_ES' => "kg", 'unidades_EN' => "kgkg");
	self::$aParametros['parametro_22'][4] = array(key => 'parametro_22' ,  'lang_ES' => "HDD hacia zona recambios", 'lang_EN' => "HDD to spares area", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
	self::$aParametros['parametro_23'][4] = array(key => 'parametro_23' ,  'lang_ES' => "Equipos a despiezar zona recambios", 'lang_EN' => "Computers to disassemble parts area", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
	// <///////
		
		self::$aParametros['parametro_24'][4] = array(key => 'parametro_24' ,  'lang_ES' => "CD-ROM/DVD-ROM reutilizables", 'lang_EN' => "CD-ROM/DVD-ROM reusable", 'unidades_ES' => "kg", 'unidades_EN' => "kgkg");
		self::$aParametros['parametro_25'][4] = array(key => 'parametro_25' ,  'lang_ES' => "HDD reutilizable", 'lang_EN' => "HDD reusable", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_26'][4] = array(key => 'parametro_26' ,  'lang_ES' => "Placas reutilizables", 'lang_EN' => "Reusable boards", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_27'][4] = array(key => 'parametro_27' ,  'lang_ES' => "Resto CPU reutilizable", 'lang_EN' => "Rest CPU reusable", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_28'][4] = array(key => 'parametro_28' ,  'lang_ES' => "Pantallas reutilizables", 'lang_EN' => "Reusable screens", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_29'][4] = array(key => 'parametro_29' ,  'lang_ES' => "Teclados reutilizables", 'lang_EN' => "Reusable keyboards", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_30'][4] = array(key => 'parametro_30' ,  'lang_ES' => "Ratones reutilizables", 'lang_EN' => "Reusable mice", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['parametro_31'][4] = array(key => 'parametro_31' ,  'lang_ES' => "Cableado reutilizable", 'lang_EN' => "Reusable cabling", 'unidades_ES' => "kg", 'unidades_EN' => "kg");
	


		self::$aParametros['categoria_1'] 		= array(key => 'categoria_1' , 'lang_ES' => 'Agotamiento de los combustibles fósiles', 'lang_EN' => 'Fossil fuel depletion', 'unidades_ES' => "kg oil eq", 'unidades_EN' => "kg oil eq");
		self::$aParametros['categoria_2'] 		= array(key => 'categoria_2' , 'lang_ES' => 'Toxicidad humana', 'lang_EN' => 'Human toxicity', 'unidades_ES' => "kg 1,4-DB eq", 'unidades_EN' => "kg 1,4-DB eq");
		self::$aParametros['categoria_3'] 		= array(key => 'categoria_3' , 'lang_ES' => 'Cambio climático', 'lang_EN' => 'Climate change', 'unidades_ES' => "kg CO2 eq", 'unidades_EN' => "kg CO2 eq", );
		self::$aParametros['categoria_4'] 		= array(key => 'categoria_4' , 'lang_ES' => 'Formación de partículas', 'lang_EN' => 'Particulate matter formation', 'unidades_ES' => "kg PM10 eq", 'unidades_EN' => "kg PM10 eq");
		self::$aParametros['categoria_5'] 		= array(key => 'categoria_5' , 'lang_ES' => 'Agotamiento de minerales', 'lang_EN' => 'Metal depletion', 'unidades_ES' => "kg Fe eq", 'unidades_EN' => "kg Fe eq");
		self::$aParametros['categoria_6'] 		= array(key => 'categoria_6' , 'lang_ES' => 'Radiaciones ionizantes', 'lang_EN' => 'Ionising radiation', 'unidades_ES' => "kg U235 eq", 'unidades_EN' => "kg U235 eq");

		self::$aParametros['categoria_1_peso']  = array(key => 'categoria_1_peso' , 'lang_ES' => 'Agotamiento de los combustibles fósiles', 'lang_EN' => 'Fossil fuel depletion', 'unidades_ES' => "Pt", 'unidades_EN' => "Pt");
		self::$aParametros['categoria_2_peso']  = array(key => 'categoria_2_peso' , 'lang_ES' => 'Toxicidad humana', 'lang_EN' => 'Human toxicity', 'unidades_ES' => "Pt", 'unidades_EN' => "Pt");
		self::$aParametros['categoria_3_peso']  = array(key => 'categoria_3_peso' , 'lang_ES' => 'Cambio climático', 'lang_EN' => 'Climate change', 'unidades_ES' => "Pt", 'unidades_EN' => "Pt");
		self::$aParametros['categoria_4_peso']  = array(key => 'categoria_4_peso' , 'lang_ES' => 'Formación de partículas', 'lang_EN' => 'Particulate matter formation', 'unidades_ES' => "Pt", 'unidades_EN' => "Pt");
		self::$aParametros['categoria_5_peso']  = array(key => 'categoria_5_peso' , 'lang_ES' => 'Agotamiento de minerales', 'lang_EN' => 'Metal depletion', 'unidades_ES' => "Pt", 'unidades_EN' => "Pt");
		self::$aParametros['categoria_6_peso']  = array(key => 'categoria_6_peso' , 'lang_ES' => 'Radiaciones ionizantes', 'lang_EN' => 'Ionising radiation', 'unidades_ES' => "Pt", 'unidades_EN' => "Pt");

		self::$aParametros['categoria_1_ui'] 	= array(key => 'categoria_1_ui' , 'lang_ES' => 'Agotamiento de los combustibles fósiles', 'lang_EN' => 'Fossil fuel depletion', 'unidades_ES' => "km en coche", 'unidades_EN' => "km driven");
		self::$aParametros['categoria_2_ui'] 	= array(key => 'categoria_2_ui' , 'lang_ES' => 'Toxicidad humana', 'lang_EN' => 'Human toxicity', 'unidades_ES' => "km en coche", 'unidades_EN' => "km driven");
		self::$aParametros['categoria_3_ui'] 	= array(key => 'categoria_3_ui' , 'lang_ES' => 'Cambio climático', 'lang_EN' => 'Climate change', 'unidades_ES' => "km en coche", 'unidades_EN' => "km driven");
		self::$aParametros['categoria_4_ui'] 	= array(key => 'categoria_4_ui' , 'lang_ES' => 'Formación de partículas', 'lang_EN' => 'Particulate matter formation (intuitive units)', 'unidades_ES' => "km en coche", 'unidades_EN' => "km driven");
		self::$aParametros['categoria_5_ui'] 	= array(key => 'categoria_5_ui' , 'lang_ES' => 'Agotamiento de minerales', 'lang_EN' => 'Metal depletion', 'unidades_ES' => "km en coche", 'unidades_EN' => "km driven");
		self::$aParametros['categoria_6_ui'] 	= array(key => 'categoria_6_ui' , 'lang_ES' => 'Radiaciones ionizante', 'lang_EN' => 'Ionising radiation', 'unidades_ES' => "km en coche", 'unidades_EN' => "km driven");

		self::$aParametros['equipos_procesados'] 	= array(key => 'equipos_procesados' , 'lang_ES' => 'Equipos procesados', 'lang_EN' => 'Items processed', 'unidades_ES' => "Ud.", 'unidades_EN' => "Ud.");
		self::$aParametros['total_enviado_gestor_residuos'] 	= array(key => 'total_enviado_gestor_residuos' , 'lang_ES' => 'Material enviado a Gestor de Residuos', 'lang_EN' => 'Material sent to Waste Manager', 'unidades_ES' => "kg", 'unidades_EN' => "kg");
		self::$aParametros['embalajes_y_etiquetas'] 	= array(key => 'embalajes_y_etiquetas' , 'lang_ES' => 'Embalajes y etiquetas', 'lang_EN' => 'Packaging and Labels', 'unidades_ES' => "kg", 'unidades_EN' => "kg");


		self::$aParametros['h_gestor_name'] 	= array(key => 'h_gestor_name' , 'lang_ES' => 'Gestor', 'lang_EN' => 'Gestor', 'unidades_ES' => "", 'unidades_EN' => "");
		self::$aParametros['h_gestor_email'] 	= array(key => 'h_gestor_email' , 'lang_ES' => 'Email Gestor', 'lang_EN' => 'Email Gestor', 'unidades_ES' => "", 'unidades_EN' => "");
		self::$aParametros['h_nombre_demostrativo'] 	= array(key => 'h_nombre_demostrativo' , 'lang_ES' => 'Demostrativo', 'lang_EN' => 'Demostrativo', 'unidades_ES' => "", 'unidades_EN' => "");


	}
	public function getAll($demostrativo_id = null){
		self::setArrayParametros();
		$a = self::$aParametros;
		$aRes = array();
		foreach ($a as $k => $aParam){ 
			if( is_array($aParam[$demostrativo_id]) ){
				$aRes[$k] = $aParam[$demostrativo_id];
			}
			else 
			{
				$aRes[$k] = $aParam;
			}
		}
		return $aRes;
	}
	public static function get($parametro){
		self::setArrayParametros();
		return self::$aParametros[$parametro];
	}
	public static function printArrayNombresJs($varName, $lang){
		self::setArrayParametros();
		echo " var ".$varName." = new Array(); ";
		$a = self::$aParametros;
		foreach ($a as $k => $aParam){ 
			echo " 
			".$varName."['".$k."'] = '".$aParam['lang_'.$lang]."'; ";
		}
	}
	public static function printArrayJsCategoriasPeso($varName, $lang, $demostrativo_id = null){
		self::setArrayParametros();
		echo " var ".$varName." = new Array(); ";
		$a = self::$aParametros;
		foreach ($a as $k => $aParam){ 
			if( !isset($aParam['lang_'.$lang]) && $demostrativo_id != null){
				$aParam = $aParam[$demostrativo_id];
			}
			if( strstr($k, "_peso") ){
				echo " 
				".$varName."['".$k."'] = new Array();
				".$varName."['".$k."']['nombre'] = '".$aParam['lang_'.$lang]."'; 
				".$varName."['".$k."']['unidades'] = '".$aParam['unidades_'.$lang]."'; 
				";
				$tmp = str_replace("_peso", "_ui", $k);
				echo " 
				".$varName."['".$k."']['unidades_intuitivas'] = '".$a[$tmp]['unidades_'.$lang]."' ;  ";
				$tmp = str_replace("_peso", "", $k);
				echo " 
				".$varName."['".$k."']['unidades_standard'] = '".$a[$tmp]['unidades_'.$lang]."' ;  ";
				
			}
		}
	}

	public static function printArrayJs($varName, $lang, $demostrativo_id = null){
		self::setArrayParametros();
		echo " var ".$varName." = new Array(); ";
		$a = self::$aParametros;
		foreach ($a as $k => $aParam){ 
			if( !isset($aParam['lang_'.$lang]) && $demostrativo_id != null){
				$aParam = $aParam[$demostrativo_id];
			}
			echo " 
			".$varName."['".$k."'] = new Array();
			".$varName."['".$k."']['lang'] = '".$lang."'; 
			".$varName."['".$k."']['nombre'] = '".$aParam['lang_'.$lang]."'; 
			".$varName."['".$k."']['unidades'] = '".$aParam['unidades_'.$lang]."'; 
			";
		}
	}
}


class energylabDemostrativo
{
	public static $aParametros;

	private static function setArrayDemostrativo(){
		self::$aParametros['demostrativo_1'] = array('key' => 'demostrativo_1', 'lang_ES' => 'Sistema de control de aire acondicionado e iluminación', 'lang_EN' => 'Control system air conditioning and lighting');
		self::$aParametros['demostrativo_2'] = array('key' => 'demostrativo_2', 'lang_ES' => 'Cluster de ordenadores para procesamiento en grid ', 'lang_EN' => 'Cluster of computers for grid processing ');
		self::$aParametros['demostrativo_3'] = array('key' => 'demostrativo_3', 'lang_ES' => 'Dispositivos de seguridad perimetral para intranet ', 'lang_EN' => 'Perimeter security devices intranet');
		self::$aParametros['demostrativo_4'] = array('key' => 'demostrativo_4', 'lang_ES' => 'Ordenadores de propósito genérico', 'lang_EN' => 'Generic purpose computers');
	}
	public static function getArray($parametro){		
		self::setArrayDemostrativo();
		return self::$aParametros;
	}

	public static function get($parametro){		
		self::setArrayDemostrativo();
		return self::$aParametros[$parametro];
	}
	public static function getName($parametro, $lang){
		self::setArrayDemostrativo();
		if(!isset(self::$aParametros[$parametro]["lang_".$lang]))
			$lang = "ES";
		return self::$aParametros[$parametro]["lang_".$lang];
	}
}


if( (date("n") - 3) >= 1 ) 
	$_date_default_from = "01/".(date("n") - 3)."/".date("Y");
else
	$_date_default_from = "01/".(date("n") - 3 + 12)."/".(date("Y")-1);

$_date_default_to =  date("d/m/Y");

$_grafica_default_line1 = "categoria_3";  
$_grafica_default_line2 = "categoria_3_ui"; 