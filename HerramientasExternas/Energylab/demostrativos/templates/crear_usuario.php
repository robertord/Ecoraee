<?php 
include_once "_header.php";
$aDemostrativos = ORM::for_table('demostrativo')->find_array();
$aPerfilesUsario = ORM::for_table('members_role')->find_array();
?>

  <div class="container">

    <div class="row-fluid margin-top-xl">
      <div class="span3">
        <?php
           include_once "_lateral_demostrativo.php";
        ?>
      </div>

    <div class="span9">
      <ul class="breadcrumb">
        <li><a href="gestion_usuarios.php">Gesti&oacute;n de usuarios</a> <span class="divider">/</span></li>
        <li class="active">Crear nuevo usuario</li>
      </ul>

      <div class="span11">

<div class="well">    
      <form id="frmSignup" class="form-horizontal" method="post" action="../ajax/user_register.php">
		<legend>Crear nuevo usuario</legend>		
		<div class="control-group">
	        <label class="control-label">Nombre</label>
			<div class="controls">
			    <div class="input-prepend">
				<span class="add-on"><i class="icon-user"></i></span>
					<input type="text" class="input-xxlarge" id="fname" name="fname" placeholder="Nombre completo">
				</div>
			</div>
		</div>
		<div class="control-group">
	        <label class="control-label">Email</label>
			<div class="controls">
			    <div class="input-prepend">
				<span class="add-on"><i class="icon-envelope"></i></span>
					<input type="text" class="input-xlarge" id="email" name="email" placeholder="Email">
				</div>
			</div>	
		</div>

		<div class="control-group">
			<label class="control-label">Perfil</label>
			<div class="controls">
			    <div class="input-prepend">
				<span class="add-on"><i class="icon-wrench"></i></span>
				<select class="input-xlarge" id="members_role" name="members_role" placeholder="Perfil">
						<?php
						foreach ($aPerfilesUsario as $item)
							echo "<option value='".$item['id']."'>".$item['name']."</option>";
						?>
				</select>
				</div>
			</div>	
		</div>

		<div class="control-group">
	        <label class="control-label">Demostrativo</label>
			<div class="controls">
			    <div class="input-prepend">
				<span class="add-on"><i class="icon-signal"></i></span>
				<select class="input-xxlarge" id="demostrativo" name="demostrativo" placeholder="Demostrativo">
						<?php
						foreach ($aDemostrativos as $item)
							echo "<option value='".$item['id']."'>".$item['name']."</option>";
						?>
				</select>
				</div>
			</div>	
		</div>

		<div class="control-group">
	        <label class="control-label">Contrase&ntilde;a</label>
			<div class="controls">
			    <div class="input-prepend">
				<span class="add-on"><i class="icon-lock"></i></span>
					<input type="Password" id="passwd" class="input-xlarge passwd" name="passwd" placeholder="contraseña">
				</div>
			</div>
		</div>
		<div class="control-group">
	        <label class="control-label">Repetir contrase&ntilde;a</label>
			<div class="controls">
			    <div class="input-prepend">
				<span class="add-on"><i class="icon-lock"></i></span>
					<input type="Password" id="conpasswd" class="input-xlarge passwd" name="conpasswd" placeholder="repetir contraseña">
				</div>
			</div>
		</div>
		
		<div class="control-group">
		<label class="control-label" for="input01"></label>
	      <div class="controls">
     		 <a class="btn" href="gestion_usuarios.php"><i class="icon-chevron-left"></i> Volver</a>
	       		<button id="signup" type="submit" class="btn btn-success" rel="tooltip" title="first tooltip"><i class="icon-ok"></i> Crear usuario</button>	       
	      </div>
	
	</div>
	
	  </form>

   </div>
</div>
</div>
</div>

</div>


  <?php 
  include_once "_js_footer.php";
  ?>
	<script type="text/javascript" src="../js/jquery.validate.js"></script>
	<script type="text/javascript" src="../js/jquery.form.js"></script>
	<script type="text/javascript" src="../js/sha.js"></script>
	  <script type="text/javascript">
	  $(document).ready(function(){
			
			if( BrowserDetect.browser != "Explorer" ){
			$("#frmSignup").validate({
				rules:{
					fname:"required",
					email:{
						required:true,
						email: true
					},
					members_role:{
						required:true
					},
					demostrativo:{
						required:true
					},
					passwd:{
						required:true,
						minlength: 8
					},
					conpasswd:{
						required:true,
						equalTo: "#passwd"
						}
				},
				errorClass: "help-inline"
			});
			}

            var opciones= {
				beforeSubmit: mostrarLoader, 
				success: mostrarRespuesta 

            };

             $("#signup").click(function(){
            	formhash('frmSignup', $('#passwd').val());
            	$('.passwd').attr('disabled', 'disabled');
            	$('#frmSignup').ajaxForm(opciones);
			});

 
             function mostrarLoader(){
				$('.passwd').removeAttr("disabled");
             };

 			function mostrarRespuesta (response){
				if(response=="1")
				{
					document.location.href='gestion_usuarios.php';  
				}
				else
				{
					alert("Error al crear usuario: "+response);  
				}
	         };

		});
	  </script>  

<?php 
  include_once "_footer.php";
?>
