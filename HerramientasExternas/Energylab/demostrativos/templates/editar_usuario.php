<?php 
include_once "_header.php";
if($_SESSION["rol"] == "USER")
	$_REQUEST['id'] = $_SESSION['user_id'];
$aUsuario = ORM::for_table('td_members')->find_one($_REQUEST['id']);
$aPerfil = ORM::for_table('members_role')->find_one($aUsuario['members_role_id']);
$aDemostrativo = ORM::for_table('demostrativo')->find_one($aUsuario['demostrativo_id']);
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
        <li class="active">Editar usuario</li>
      </ul>

      <div class="span10">

<div class="well">    
      <form id="frmSignup" class="form-horizontal" method="post" action="../ajax/user_update.php">
      	<input type="hidden" class="input-xlarge" id="id" name="id" value="<?php echo $aUsuario['id']; ?>" >
		<legend>Editar usuario</legend>		
		<div class="control-group">
	        <label class="control-label">Nombre</label>
			<div class="controls">
			    <div class="input-prepend">
				<span class="add-on"><i class="icon-user"></i></span>
					<input type="text" class="input-xlarge" id="fname" name="fname" placeholder="Nombre completo" value="<?php echo $aUsuario['username']; ?>" >
				</div>
			</div>
		</div>
		<div class="control-group">
	        <label class="control-label">Email</label>
			<div class="controls">
			    <div class="input-prepend">
				<span class="add-on"><i class="icon-envelope"></i></span>
					<input type="text" class="input-xlarge" id="email" name="email" placeholder="Email" value="<?php echo $aUsuario['email']; ?>" disabled="disabled">
				</div>
			</div>	
		</div>

		<div class="control-group">
			<label class="control-label">Perfil</label>
			<div class="controls">
			    <div class="input-prepend">
				<span class="add-on"><i class="icon-wrench"></i></span>
				<input type="text" class="input-xlarge" id="members_role" name="members_role" placeholder="Perfil" value="<?php echo $aPerfil['name']; ?>" disabled="disabled">				
				</div>
			</div>	
		</div>

		<div class="control-group">
	        <label class="control-label">Demostrativo</label>
			<div class="controls">
			    <div class="input-prepend">
				<span class="add-on"><i class="icon-signal"></i></span>
				<input type="text" class="input-xlarge" id="demostrativo" name="demostrativo" placeholder="Demostrativo" value="<?php echo $aDemostrativo['name']; ?>" disabled="disabled">	
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
     			<?php
				if($_SESSION["rol"] == "ADMIN"){
     			 	echo ' <a class="btn" href="gestion_usuarios.php"><i class="icon-chevron-left"></i> Volver</a>';
     			}     			
				if($_SESSION["rol"] == "ADMIN"){
					if($aUsuario['login_attempts'] > $_MAX_LOGIN_ATTEMPS){
						$class_name= "btn-danger lock locked";
						$btn_name =" Desbloquear";
					}
					else{
						$class_name= "btn-warning lock unlocked";
						$btn_name =" Bloquear";
					}
     			 	echo ' <button class="btn '.$class_name.'" id="btn_unlock"><i class="icon-lock"></i> '.$btn_name.'</button>';
     			 }
     			?>

	       		<button id="signup" type="submit" class="btn btn-success" rel="tooltip" title="Guardar cambios"><i class="icon-ok"></i> Guardar cambios</button>	       
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
					passwd:{
						required:true,
						minlength: 8
					},
					conpasswd:{
						required:true,
						equalTo: "#passwd"
					}/*,
					gender:"required"*/
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
             	if( ($("#passwd").val() != $("#conpasswd").val()) ){
             		alert("Las contraseñas no coinciden, por favor, introduzca una contraseña válida. ");
					$('.passwd').removeAttr("disabled");
             		return false;
             	}
             	if( $("#passwd").val()=="" || $("#passwd").val().length < 8 ){
             		alert("Introduzca una contraseña de al menos 8 caracteres. ");
					$('.passwd').removeAttr("disabled");
             		return false;
             	}

				$('.passwd').removeAttr("disabled");
             };

 			function mostrarRespuesta (response){
				if(response=="1")
				{
					//document.location.href='gestion_usuarios.php';  
					alert("la contraseña ha sido cambiada correctamente");
					$('.passwd').val("");
					$('#passwd').focus();
					 $('#frmSignup').each (function(){
	                  this.reset();
	                });
				}
				else
				{
					alert("error: "+response);  
				}
	         };

		});
		$('#passwd').focus();

		$("button.lock").click(function(){
			var lock = 1;
			var user_id = '<?php echo $aUsuario["id"]; ?>';
			if( $(this).hasClass('locked') )
				lock = 0;

			$.ajax({
		        type: "UPDATE",
		        url: '../ajax/lock_user.php?id='+user_id+"&lock="+lock,
		        success: function(data){
		            window.location.reload();
		        },
		        error: function(request, settings){
		          alert( request.responseText );
		        }
		    });
		$(this).blur();
		return false;
		});
	  </script>  

<?php 
  include_once "_footer.php";
?>
