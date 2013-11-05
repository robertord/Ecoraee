<?php
require_once '_include.php';
?>

<div class="well">    
      <form id="frmRememberPasswd" class="form-horizontal" action="ajax/send_new_password.php">
		<legend>Remember password</legend>	
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
		<label class="control-label" for="input01"></label>
	      <div class="controls">
	       <button id="btnRememberPasswd" class="btn btn-success" rel="tooltip" title="first tooltip">Send new password</button>
	       
	    </div>
	    <div>
	    		<br><br><br>
				<a href="#!login">< back to login</a> 
		</div>
	</div>
	  </form>

   </div>

	<script type="text/javascript" src="js/jquery.validate.js"></script>
	<script type="text/javascript" src="js/sha.js"></script>
	  <script type="text/javascript">
	  $(document).ready(function(){	
	  		$("#email").focus();
	  		$("#email").val("dos@discalis.com");

			$("#frmLogin").validate({
				rules:{
					email:{
							required:true,
							email: true
						}
				},				
				errorClass: "help-inline"
				
			});

            var opciones= {
				beforeSubmit: mostrarLoader,
				success: mostrarRespuesta
            };

            $("#btnRememberPasswd").click(function(){
            	$('#frmRememberPasswd').ajaxForm(opciones);
			});
 
             function mostrarLoader(){
				//$(#loader_gif).fadeIn("slow"); //muestro el loader de ajax
             };

	         function mostrarRespuesta (response){
	         	alert(response);/*
				if(response=="1")
				{
					//window.location.reload();
				}
				else
				{
					alert("Error login: "+response);  
				}*/
	         };
		});
	  </script>  


