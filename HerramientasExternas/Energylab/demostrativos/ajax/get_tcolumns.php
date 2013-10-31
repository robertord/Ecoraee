<?php
require_once '../conf/configuration.php';
$aRes = ORM::for_table($_REQUEST['table'])->getColumns();

echo json_encode( $aRes );