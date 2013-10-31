<?php 
  include_once "_header.php";
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
        <li><a href="Estadisticas.php">Estad&iacute;sticas</a> <span class="divider">/</span></li>
        <li class="active">Login acceso restringido</li>
      </ul>

      <div class="span10">

      <form id="frmLogin" class="form-horizontal" action="../ajax/check_user_login.php">
		<legend>Login</legend>	
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
	        <label class="control-label">Password</label>
			<div class="controls">
			    <div class="input-prepend">
				<span class="add-on"><i class="icon-lock"></i></span>
					<input type="Password" id="passwd" class="input-xlarge passwd" name="passwd" placeholder="Password">
				</div>
			</div>
		</div>
		

		<div class="control-group">
			<label class="control-label" for="input01"></label>
	    	<div class="controls">
	       		<button id="btnLogin" class="btn btn-success" rel="tooltip" title="first tooltip">Login</button>	      
	   	 	</div>
		</div>
	  </form>
   </div>

   </div>
</div>

  <?php 
  include_once "_js_footer.php";
  ?>
	<script type="text/javascript" src="../js/jquery.min.js"></script>
	<script type="text/javascript" src="../js/jquery.form.js"></script>
	<script type="text/javascript" src="../js/jquery.validate.js"></script>
	<script type="text/javascript" src="../js/sha.js"></script>


	<script type="text/javascript">
	  $(document).ready(function(){
	  	$.fn.selectRange = function(start, end) {
		    return this.each(function() {
		        if(this.setSelectionRange) {
		            this.focus();
		            this.setSelectionRange(start, end);
		        } else if(this.createTextRange) {
		            var range = this.createTextRange();
		            range.collapse(true);
		            range.moveEnd('character', end);
		            range.moveStart('character', start);
		            range.select();
		        }
		    });
		};

	  		$("#email").focus();	 

	  		
	  		if( BrowserDetect.browser != "Explorer" ){
			$("#frmLogin").validate({
				rules:{
					email:{
								required:true
								//email: true
						},
					passwd:{
						required:true,
						minlength: 8
					}
				},				
				errorClass: "help-inline"				
			});
			}

            var opciones= {
				beforeSubmit: mostrarLoader,
				success: mostrarRespuesta
            };

            $("#btnLogin").click(function(){
            	formhash('frmLogin', $('#passwd').val());
            	$('.passwd').attr('disabled', 'disabled');
            	$('#frmLogin').ajaxForm(opciones);
			});
 
             function mostrarLoader(){
				//$(#loader_gif).fadeIn("slow"); //muestro el loader de ajax
				$('.passwd').removeAttr("disabled");
             };

	         function mostrarRespuesta (response){
				if(response=="1")
				{					
					//window.location.reload();
					location.href = "estadisticas.php";
					$("#li_estadisticas a:first-child").click;
				}
				else
				{
					alert(response);  
				}
	         };
		});
	  </script>  


<?php 
  include_once "_footer.php";