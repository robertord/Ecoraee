<?php
require_once '../conf/configuration.php';
sec_session_destroy();
header('Location: ./estadisticas.php');