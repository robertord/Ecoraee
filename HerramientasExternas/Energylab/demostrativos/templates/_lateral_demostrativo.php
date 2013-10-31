<?php
require_once '../conf/configuration.php';
$isValidSession = is_valid_session();
?>
<div class="span12">
	<div class="span3 bs-docs-sidebar">
		<ul class="nav nav-list bs-docs-sidenav <?php echo $class_affix; ?>" id="menu_lat" style="margin-top:50px;">
			<?php
			echo '<li id="li_estadisticas"><a href="estadisticas.php"><i class="icon-chevron-right"></i>&nbsp;&nbsp;&nbsp;'. ucfirst($_breadcrumb_root_name) . '</a></li>';			
			switch ( $_SESSION['rol']) {
				case 'ADMIN':
					echo '<li id="li_gestion_usuarios"><a href="../es/gestion_usuarios.php"><i class="icon-user"></i>&nbsp;&nbsp;&nbsp;Gesti&oacute;n de usuarios</a></li>';					
					
					echo '<li id="li_listado_demostrativos"><a href="../es/listado_demostrativos.php"><i class="icon-calendar"></i>&nbsp;&nbsp;&nbsp;Demostrativos subidos</a></li>';
					echo '<li id="li_entrada_de_datos"><a href="../es/entrada_de_datos.php"><i class="icon-plus-sign"></i>&nbsp;&nbsp;&nbsp;Importar demostrativo</a></li>';
					echo '<li id="li_datos_demostrativo1"><a href="../es/datos_demostrativo.php?demo=1" title="Datos de salida del demostrativo 1: '.energylabDemostrativo::getName("demostrativo_1", "ES").'"><i class="icon-list"></i>&nbsp;&nbsp;&nbsp;Demostrativo 1</a></li>';
					echo '<li id="li_datos_demostrativo2"><a href="../es/datos_demostrativo.php?demo=2" title="Datos de salida del demostrativo 2: '.energylabDemostrativo::getName("demostrativo_2", "ES").'"><i class="icon-list"></i>&nbsp;&nbsp;&nbsp;Demostrativo 2</a></li>';
					echo '<li id="li_datos_demostrativo3"><a href="../es/datos_demostrativo.php?demo=3" title="Datos de salida del demostrativo 3: '.energylabDemostrativo::getName("demostrativo_3", "ES").'"><i class="icon-list"></i>&nbsp;&nbsp;&nbsp;Demostrativo 3</a></li>';
					echo '<li id="li_datos_demostrativo4"><a href="../es/datos_demostrativo.php?demo=4" title="Datos de salida del demostrativo 4: '.energylabDemostrativo::getName("demostrativo_4", "ES").'"><i class="icon-list"></i>&nbsp;&nbsp;&nbsp;Demostrativo 4</label></a></li>';					
					echo '<li id="li_check"><a href="../es/check.php"><i class="icon-wrench"></i>&nbsp;&nbsp;&nbsp;Analizar resumen de datos</a></li>';				
						
					echo '<li id="li_logs"><a href="../es/logs.php"><i class="icon-eye-open"></i>&nbsp;&nbsp;&nbsp;Logs de la aplicación</a></li>';					
					echo '<li id="li_logout"><a onclick="if(!confirm(\'¿Seguro que desea cerrar sesión?\')) return false;" href="logout.php"><i class=" icon-off"></i>&nbsp;&nbsp;&nbsp;Logout</a></li>';
					break;
				case 'USER':				
					echo '<li id="li_gestion_usuarios"><a href="../es/editar_usuario.php"><i class="icon-user"></i>&nbsp;&nbsp;&nbsp;Cambiar contrase&ntilde;a</a></li>';					
					echo '<li id="li_listado_demostrativos"><a href="listado_demostrativos.php"><i class="icon-calendar"></i>&nbsp;&nbsp;&nbsp;Demostrativos subidos</a></li>';
					echo '<li id="li_entrada_de_datos"><a href="entrada_de_datos.php"><i class="icon-plus-sign"></i>&nbsp;&nbsp;&nbsp;Importar demostrativo</a></li>';
					echo '<li id="li_datos_demostrativo"><a href="datos_demostrativo.php"><i class="icon-download-alt"></i>&nbsp;&nbsp;&nbsp;Datos de salida</a></li>';
					echo '<li id="li_logout"><a onclick="if(!confirm(\'¿Seguro que desea cerrar sesión?\')) return false;" href="logout.php"><i class=" icon-off"></i>&nbsp;&nbsp;&nbsp;Logout</a></li>';
					break;
				default:
					echo '<li id="li_login"><a href="login.php"><i class="icon-chevron-right"></i>&nbsp;&nbsp;&nbsp;Login...</a></li>';
					break;
			}
			?>
		</ul>
	</div>
</div>
<div class="span11">
	<p style="font-size:95%;margin-top:2em;opacity:0.8;"><i class="icon-info-sign"></i> <?php echo $_info_bajo_menu_lateral; ?></p>
</div>
