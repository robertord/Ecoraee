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
      
      <div class="span10">
        <h3>
          Entrada de datos
        </h3>
        <p>

          <?php
           if( $_SESSION['rol'] == "USER" )
            echo "<h4>".energylabDemostrativo::getName("demostrativo_".$_SESSION['demostrativo_id'], "ES")."</h4>";
          ?>
          Para importar hoja de cálculo de datos diarios del demostrativo seleccione el documento pulsando el bot&oacute;n "Examinar" y a continuación pulse el bot&oacute;n "Importar fichero".
        </p>
        <br>

<div id="excel">    
  <form action="../ajax/get_xslx.php" id="formUploadFile" name="formUploadFile" method="post" enctype="multipart/form-data">
      <div class="input-append">
      <input id="xlsFile" name ="xlsFile" type="file" style="display:block;float:left;clear:none;">
      
      <!--<input id="xlsFileName" class="input-large" type="text">
      <a class="btn" onclick="$('#xlsFile').click(); return false;">Examinar</a>-->
      <button type="submit" id="btnUploadFile" class="btn" disabled="disabled">Importar fichero</button>
      <?php // <button id="btnUploadFile-" class="btn" type="submit">SUBMIT</button> 
      ?>
    </div>
  </form> 
	
    <div id="progress" class="progress" style="display:none;">
        <div class="bar"></div >
        <div class="percent">0%</div >
    </div>        

    <div id="result"></div>
</div>
</div>

	<div class="span10" style="margin:0;padding:0;color:darkgrey;font-size:85%">
			El documento debe ser una hoja de c&aacute;lculo con extens&oacute;n XLSX y formato v&aacute;lido. Descargar plantilla de:
			<?php 
			if($_SESSION['rol']=='ADMIN'){
				echo "<br>- <a href='../files/plantillas/demostrativo_1.xlsx'> demostrativo 1</a><br>- <a href='../files/plantillas/demostrativo_2.xlsx'> demostrativo 2</a><br>- <a href='../files/plantillas/demostrativo_3.xlsx'> demostrativo 3</a><br>- <a href='../files/plantillas/demostrativo_4.xlsx'> demostrativo 4</a>";
			}
			else{
				echo "<a href='../files/plantillas/demostrativo_".$_SESSION['demostrativo_id'].".xlsx'> demostrativo ".$_SESSION['demostrativo_id']."</a>";
			}
		  ?>
	</div>
</div>
</div>
</div>

<?php
include_once "_js_footer.php";
?>
<script type="text/javascript" src="../js/jquery.form.js"></script>

  <script>

    $(document).ready(function() {   
      $('#progress').hide();
      $('#result').html("");

      $("#xlsFile").change(function(e){
          checkFileType();
      });

      var bar = $('.bar');
      var percent = $('.percent');
      var status = $('#status');
      var file;
      var extension;

      function checkFileType(){
        file = $("#xlsFile").val();
        extension = file.substr( (file.lastIndexOf('.') +1) ).toLowerCase();
        switch(extension){
          case "xlsx":
          case "xls":
            //$("#xlsFile").val();
           // $("#xlsFileName").val($("#xlsFile").val());
            $("#btnUploadFile").attr("disabled", "");
            $("#btnUploadFile").removeAttr("disabled");
            return 1;
          default:
            alert ("El formato debe ser: xls o xlsx");
            $("#btnUploadFile").attr("disabled", "disabled");
            //$(this).val("");
            return 0;
        }
      }


      
        $('#formUploadFile').ajaxForm({
            url: '../ajax/get_xslx.php', 
            type: 'post',
            dataType: 'json',
            beforeSend: function() {
                $('#progress').show();
                status.empty();
                var percentVal = '0%';
                bar.width(percentVal);
                percent.html(percentVal);
            },
            uploadProgress: function(event, position, total, percentComplete) {
                var percentVal = percentComplete + '%';
                bar.width(percentVal);
                percent.html(percentVal);
            },
            success: function(data) {              
                var percentVal = '100%';
                bar.width(percentVal);
                percent.html(percentVal);
                $('#result').html('<div class="alert alert-success"><button class="close" data-dismiss="alert" type="button">×</button><strong>Demostrativo '+data.table+' </strong>: los datos del  ' + data.date + '  se han guardado correctamente.</div>');
                // OK
                $('#progress').hide();
                status.empty();
                var percentVal = '0%';
                bar.width(percentVal)
                percent.html(percentVal);
                $(".btn").blur();
                $('#formUploadFile').each (function(){
                  this.reset();
                });
                
              $("#btnUploadFile").attr("disabled", "disabled");
            },
            complete: function(xhr) {
              status.html(xhr.responseText);  return false;              
            },
            error: function(request, settings){
                var percentVal = '100%';
                bar.width(percentVal);
                percent.html(percentVal);
                // OK
                $('#progress').hide();
                status.empty();
                var percentVal = '0%';
                bar.width(percentVal);
                percent.html(percentVal);

                //var dataDecode = $.parseJSON(request);
                //alert(request.responseText);
                $(".btn").blur();
                $('#formUploadFile').each (function(){
                  this.reset();
                });
                $("#btnUploadFile").attr("disabled", "disabled");
                
                $('#result').html('<div class="alert alert-error"><button class="close" data-dismiss="alert" type="button">×</button><strong>Error al intentar subir el fichero: </strong> ' + request.responseText + '</div>');

               
                return false;
            }
        });
     
         
    });      

  </script>
<?php
include_once "_footer.php";
